package com.ruoyi.textbook.controller;

import java.util.List;
import javax.servlet.http.HttpServletResponse;

import com.ruoyi.ContestFeign.ContestFeignClient;
import com.ruoyi.attachment.domain.ExportRequestDTO;
import com.ruoyi.common.utils.ServletUtils;
import com.ruoyi.competition.domain.AchievementsCompetition;
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
        Integer pageNum = ServletUtils.getParameterToInt("pageNum");
        Integer pageSize = ServletUtils.getParameterToInt("pageSize");
        AjaxResult res = new AjaxResult();
        // 使用Feign客户端调用远程服务
        try {
            res = contestFeignClient.getTextbookList(getUserId(), getDeptId(), pageNum, pageSize);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

        return res;
    }

    /**
     * 导出教材著作列表
     */
    @PreAuthorize("@ss.hasPermi('textbook:textbook:export')")
    @Log(title = "教材著作", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, @ModelAttribute ExportRequestDTO<AchievementsTextbook> exportRequestDTO )
    {
        List<String> hiddenColumns = exportRequestDTO.getHiddenColumns();
        AchievementsTextbook queryParams = exportRequestDTO.getData();
        List<AchievementsTextbook> list = achievementsTextbookService.selectAchievementsTextbookList(queryParams);
        ExcelUtil<AchievementsTextbook> util = new ExcelUtil<AchievementsTextbook>(AchievementsTextbook.class);
        if(hiddenColumns != null && !hiddenColumns.isEmpty())
        {
            util.showColumn(hiddenColumns.toArray(new String[0]));
        }
        util.exportExcel(response, list, "教材著作数据");
    }
    /**
     * 获取教材著作详细信息
     */
    @PreAuthorize("@ss.hasPermi('textbook:textbook:query')")
    @GetMapping(value = "/{textbookId}")
    public AjaxResult getInfo(@PathVariable("textbookId") Long textbookId)
    {
        AjaxResult res = new AjaxResult();
        // 使用Feign客户端调用远程服务
        try {
            res = contestFeignClient.getTextbookById(getUserId(), getDeptId(),textbookId);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

        return res;
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
        AjaxResult res = new AjaxResult();
        // 使用Feign客户端调用远程服务
        try {
            res = contestFeignClient.updateTextbook(achievementsTextbook);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

        return res;
    }

    /**
     * 删除教材著作
     */
    @PreAuthorize("@ss.hasPermi('textbook:textbook:remove')")
    @Log(title = "教材著作", businessType = BusinessType.DELETE)
	@DeleteMapping("/{textbookIds}")
    public AjaxResult remove(@PathVariable Long[] textbookIds)
    {
        AjaxResult res = new AjaxResult();
        // 使用Feign客户端调用远程服务
        try {
            res = contestFeignClient.deleteTextbooks(getUserId(),getDeptId(),textbookIds);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

        return res;
    }
}
