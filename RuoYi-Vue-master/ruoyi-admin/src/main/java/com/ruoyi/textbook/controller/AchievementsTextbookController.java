package com.ruoyi.textbook.controller;

import java.util.List;
import javax.servlet.http.HttpServletResponse;

import com.ruoyi.attachment.domain.ExportRequestDTO;
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

    /**
     * 查询教材著作列表
     */
    @PreAuthorize("@ss.hasPermi('textbook:textbook:list')")
    @GetMapping("/list")
    public TableDataInfo list(AchievementsTextbook achievementsTextbook)
    {
        startPage();
        List<AchievementsTextbook> list = achievementsTextbookService.selectAchievementsTextbookList(achievementsTextbook);
        return getDataTable(list);
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
        System.out.println("util");
        System.out.println(list);
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
        return success(achievementsTextbookService.selectAchievementsTextbookByTextbookId(textbookId));
    }

    /**
     * 新增教材著作
     */
    @PreAuthorize("@ss.hasPermi('textbook:textbook:add')")
    @Log(title = "教材著作", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody AchievementsTextbook achievementsTextbook)
    {
        int rows = achievementsTextbookService.insertAchievementsTextbook(achievementsTextbook);
        return toAjax(rows).put("textbookId",achievementsTextbook.getTextbookId());
    }

    /**
     * 修改教材著作
     */
    @PreAuthorize("@ss.hasPermi('textbook:textbook:edit')")
    @Log(title = "教材著作", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody AchievementsTextbook achievementsTextbook)
    {
        int ajax = achievementsTextbookService.updateAchievementsTextbook(achievementsTextbook);
        System.out.println(achievementsTextbook.toString());
        return toAjax(ajax).put("textbookId",achievementsTextbook.getTextbookId());
    }

    /**
     * 删除教材著作
     */
    @PreAuthorize("@ss.hasPermi('textbook:textbook:remove')")
    @Log(title = "教材著作", businessType = BusinessType.DELETE)
	@DeleteMapping("/{textbookIds}")
    public AjaxResult remove(@PathVariable Long[] textbookIds)
    {
        return toAjax(achievementsTextbookService.deleteAchievementsTextbookByTextbookIds(textbookIds));
    }
}
