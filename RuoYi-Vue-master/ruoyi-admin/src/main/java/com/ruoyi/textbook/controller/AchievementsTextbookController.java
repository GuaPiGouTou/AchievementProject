package com.ruoyi.textbook.controller;

import java.util.List;
import javax.servlet.http.HttpServletResponse;

import com.ruoyi.ContestFeign.ContestFeignClient;
import com.ruoyi.ContestFeign.DeleteRequest;
import com.ruoyi.ContestFeign.IdsRequest;
import com.ruoyi.attachment.domain.AchievementsAttachment;
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
    public AjaxResult export(HttpServletResponse response, @RequestBody ExportRequestDTO<AchievementsTextbook> exportRequestDTO )
    {
        // 1. 获取参数
        List<String> hiddenColumns = exportRequestDTO.getShowColumns();
        Long[] ids = exportRequestDTO.getIdList();

        // 2. 构造请求 (使用上面修改后的 IdsRequest)
        IdsRequest idsRequest = new IdsRequest(getUserId(), getDeptId(), ids);

        // 3. Feign 调用
        AjaxResult result = contestFeignClient.selectContestByIds(idsRequest);

        // 4. 判断 total (处理 null 和 类型转换)
        Object totalObj = result.get("total");
        int total = (totalObj == null) ? 0 : Integer.parseInt(totalObj.toString());

        if (total == 0) {
            return AjaxResult.warn("未查询到数据");
        }

        // 5. 转换 List (从 LinkedHashMap 转为 实体对象)
        Object rows = result.get("rows");
        // 利用 FastJson 或 Jackson 进行 "序列化再反序列化" 来转换对象
        String jsonString = com.alibaba.fastjson2.JSON.toJSONString(rows);
        List<AchievementsTextbook> list = com.alibaba.fastjson2.JSON.parseArray(jsonString, AchievementsTextbook.class);

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
        AjaxResult res = new AjaxResult();
        achievementsTextbook.setUserId(getUserId());
        achievementsTextbook.setDeptId(getDeptId());
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
