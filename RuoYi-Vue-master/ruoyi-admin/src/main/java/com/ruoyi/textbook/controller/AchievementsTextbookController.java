package com.ruoyi.textbook.controller;

import java.util.List;
import javax.servlet.http.HttpServletResponse;

import com.ruoyi.ContestFeign.ContestFeignClient;
import com.ruoyi.ContestFeign.DeleteRequest;
import com.ruoyi.attachment.domain.ExportRequestDTO;
import com.ruoyi.common.utils.AchievementDataScopeUtils;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.textbook.domain.AchievementsTextbook;
import com.ruoyi.textbook.service.IAchievementsTextbookService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 教材著作Controller
 * 
 * @author xixia
 * @date 2025-11-16
 */
@RestController
@RequestMapping("/textbook/textbook")
public class AchievementsTextbookController extends BaseController
{
    @Autowired
    private IAchievementsTextbookService achievementsTextbookService;
    @Autowired
    private ContestFeignClient contestFeignClient;
    /**
     * 查询教材著作列表
     */
    @PreAuthorize("@ss.hasPermi('textbook:textbook:list')")
    @GetMapping("/list")
    public AjaxResult list(AchievementsTextbook achievementsTextbook)
    {
        AchievementDataScopeUtils.applyAchievementListScope(achievementsTextbook, "textbook:textbook");
        startPage();
        List<AchievementsTextbook> list = achievementsTextbookService.selectAchievementsTextbookList(achievementsTextbook);
        TableDataInfo tableData = getDataTable(list);
        AjaxResult res = AjaxResult.success();
        res.put("rows", tableData.getRows());
        res.put("total", tableData.getTotal());
        return res;
    }


    /**
     * 导出教材著作列表
     */
    @PreAuthorize("@ss.hasPermi('textbook:textbook:export')")
    @Log(title = "教材著作", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public AjaxResult export(HttpServletResponse response, @RequestBody ExportRequestDTO<AchievementsTextbook> exportRequestDTO )
    {
        // 1. 获取参数
        List<String> hiddenColumns = exportRequestDTO.getShowColumns();
        Long[] ids = exportRequestDTO.getIdList();
        AchievementsTextbook query = exportRequestDTO.getData() == null ? new AchievementsTextbook() : exportRequestDTO.getData();
        AchievementDataScopeUtils.applyAchievementListScope(query, "textbook:textbook");
        List<AchievementsTextbook> list = achievementsTextbookService.selectAchievementsTextbookList(query);
        list = AchievementDataScopeUtils.filterByIds(list, ids, "getTextbookId");

        if (list == null || list.isEmpty()) {
            return AjaxResult.warn("未查询到数据");
        }

        // 6. 导出 Excel
        ExcelUtil<AchievementsTextbook> util = new ExcelUtil<>(AchievementsTextbook.class);
        if (hiddenColumns != null && !hiddenColumns.isEmpty()) {
            util.showColumn(hiddenColumns.toArray(new String[0]));
        }

        // 执行导出
        util.exportExcel(response, list, "教材成果数据");

        //返回 success
        return null;
    }
    /**
     * 获取教材著作详细信息
     */
    @PreAuthorize("@ss.hasPermi('textbook:textbook:query')")
    @GetMapping(value = "/{textbookId}")
    public AjaxResult getInfo(@PathVariable("textbookId") Long textbookId)
    {
        AchievementsTextbook achievementsTextbook = achievementsTextbookService.selectAchievementsTextbookByTextbookId(textbookId);
        if (!AchievementDataScopeUtils.canAccessAchievementRecord(achievementsTextbook, "textbook:textbook")) {
            return AjaxResult.error("无权限访问该数据");
        }
        return AjaxResult.success(achievementsTextbook);
    }

    /**
     * 新增教材著作
     */
    @PreAuthorize("@ss.hasPermi('textbook:textbook:add')")
    @Log(title = "教材著作", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody AchievementsTextbook achievementsTextbook)
    {
        AjaxResult res = new AjaxResult();
        // 使用Feign客户端调用远程服务
        try {
            achievementsTextbook.setUserId(getUserId());
            achievementsTextbook.setDeptId(getDeptId());

            System.out.println(achievementsTextbook);
            res = contestFeignClient.insertTextbook(achievementsTextbook);

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return res;
    }

    /**
     * 修改教材著作
     */
    @PreAuthorize("@ss.hasPermi('textbook:textbook:edit')")
    @Log(title = "教材著作", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody AchievementsTextbook achievementsTextbook)
    {
        achievementsTextbook.setUserId(null);
        achievementsTextbook.setDeptId(null);
        achievementsTextbook.setCreatedAt(null);
        achievementsTextbook.setUpdatedAt(null);
        int rows = achievementsTextbookService.updateAchievementsTextbook(achievementsTextbook);
        if (rows > 0) {
            AjaxResult result = AjaxResult.success("修改成功");
            result.put("textbookId", achievementsTextbook.getTextbookId());
            return result;
        }
        return AjaxResult.error("修改失败");
    }

    /**
     * 删除教材著作
     */
    @PreAuthorize("@ss.hasPermi('textbook:textbook:remove')")
    @Log(title = "教材著作", businessType = BusinessType.DELETE)
	@DeleteMapping("/{textbookIds}")
    public AjaxResult remove(@PathVariable  Long[] textbookIds)
    {
        for (int i = 0; i < textbookIds.length; i++) {
            System.out.println(textbookIds[i]);
        }
        AjaxResult res = new AjaxResult();
        // 使用Feign客户端调用远程服务
        DeleteRequest deleteRequest = new DeleteRequest(getUserId(),getDeptId(),textbookIds);
        try {
            res = contestFeignClient.deleteTextbooks(deleteRequest);
            System.out.println(res);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return res;
    }
}
