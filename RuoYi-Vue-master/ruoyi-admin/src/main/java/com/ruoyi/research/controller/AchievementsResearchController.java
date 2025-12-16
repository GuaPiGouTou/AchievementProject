package com.ruoyi.research.controller;

import java.util.List;
import javax.servlet.http.HttpServletResponse;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.research.domain.AchievementsResearch;
import com.ruoyi.research.service.IAchievementsResearchService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 项目成果Controller
 * 
 * @author xixia
 * @date 2025-12-16
 */
@RestController
@RequestMapping("/research/research")
public class AchievementsResearchController extends BaseController
{
    @Autowired
    private IAchievementsResearchService achievementsResearchService;

    /**
     * 查询项目成果列表
     */
    @PreAuthorize("@ss.hasPermi('research:research:list')")
    @GetMapping("/list")
    public TableDataInfo list(AchievementsResearch achievementsResearch)
    {
        startPage();
        List<AchievementsResearch> list = achievementsResearchService.selectAchievementsResearchList(achievementsResearch);
        return getDataTable(list);
    }

    /**
     * 导出项目成果列表
     */
    @PreAuthorize("@ss.hasPermi('research:research:export')")
    @Log(title = "项目成果", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, AchievementsResearch achievementsResearch)
    {
        List<AchievementsResearch> list = achievementsResearchService.selectAchievementsResearchList(achievementsResearch);
        ExcelUtil<AchievementsResearch> util = new ExcelUtil<AchievementsResearch>(AchievementsResearch.class);
        util.exportExcel(response, list, "项目成果数据");
    }

    /**
     * 获取项目成果详细信息
     */
    @PreAuthorize("@ss.hasPermi('research:research:query')")
    @GetMapping(value = "/{researchId}")
    public AjaxResult getInfo(@PathVariable("researchId") Long researchId)
    {
        return success(achievementsResearchService.selectAchievementsResearchByResearchId(researchId));
    }

    /**
     * 新增项目成果
     */
    @PreAuthorize("@ss.hasPermi('research:research:add')")
    @Log(title = "项目成果", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody AchievementsResearch achievementsResearch)
    {
        return toAjax(achievementsResearchService.insertAchievementsResearch(achievementsResearch));
    }

    /**
     * 修改项目成果
     */
    @PreAuthorize("@ss.hasPermi('research:research:edit')")
    @Log(title = "项目成果", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody AchievementsResearch achievementsResearch)
    {
        return toAjax(achievementsResearchService.updateAchievementsResearch(achievementsResearch));
    }

    /**
     * 删除项目成果
     */
    @PreAuthorize("@ss.hasPermi('research:research:remove')")
    @Log(title = "项目成果", businessType = BusinessType.DELETE)
	@DeleteMapping("/{researchIds}")
    public AjaxResult remove(@PathVariable Long[] researchIds)
    {
        return toAjax(achievementsResearchService.deleteAchievementsResearchByResearchIds(researchIds));
    }
}
