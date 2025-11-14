package com.ruoyi.competition.controller;

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
import com.ruoyi.competition.domain.AchievementsCompetition;
import com.ruoyi.competition.service.IAchievementsCompetitionService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 竞赛成果Controller
 * 
 * @author ruoyi
 * @date 2025-11-12
 */
@RestController
@RequestMapping("/competition/competition")
public class AchievementsCompetitionController extends BaseController
{
    @Autowired
    private IAchievementsCompetitionService achievementsCompetitionService;

    /**
     * 查询竞赛成果列表
     */
    @PreAuthorize("@ss.hasPermi('competition:competition:list')")
    @GetMapping("/list")
    public TableDataInfo list(AchievementsCompetition achievementsCompetition)
    {
        startPage();
        List<AchievementsCompetition> list = achievementsCompetitionService.selectAchievementsCompetitionList(achievementsCompetition);
        return getDataTable(list);
    }

    /**
     * 导出竞赛成果列表
     */
    @PreAuthorize("@ss.hasPermi('competition:competition:export')")
    @Log(title = "竞赛成果", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, AchievementsCompetition achievementsCompetition)
    {
        List<AchievementsCompetition> list = achievementsCompetitionService.selectAchievementsCompetitionList(achievementsCompetition);
        ExcelUtil<AchievementsCompetition> util = new ExcelUtil<AchievementsCompetition>(AchievementsCompetition.class);
        util.exportExcel(response, list, "竞赛成果数据");
    }

    /**
     * 获取竞赛成果详细信息
     */
    @PreAuthorize("@ss.hasPermi('competition:competition:query')")
    @GetMapping(value = "/{competitionId}")
    public AjaxResult getInfo(@PathVariable("competitionId") Long competitionId)
    {
        return success(achievementsCompetitionService.selectAchievementsCompetitionByCompetitionId(competitionId));
    }

    /**
     * 新增竞赛成果
     */
    @PreAuthorize("@ss.hasPermi('competition:competition:add')")
    @Log(title = "竞赛成果", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody AchievementsCompetition achievementsCompetition)
    {
        return toAjax(achievementsCompetitionService.insertAchievementsCompetition(achievementsCompetition));
    }

    /**
     * 修改竞赛成果
     */
    @PreAuthorize("@ss.hasPermi('competition:competition:edit')")
    @Log(title = "竞赛成果", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody AchievementsCompetition achievementsCompetition)
    {
        return toAjax(achievementsCompetitionService.updateAchievementsCompetition(achievementsCompetition));
    }

    /**
     * 删除竞赛成果
     */
    @PreAuthorize("@ss.hasPermi('competition:competition:remove')")
    @Log(title = "竞赛成果", businessType = BusinessType.DELETE)
	@DeleteMapping("/{competitionIds}")
    public AjaxResult remove(@PathVariable Long[] competitionIds)
    {
        return toAjax(achievementsCompetitionService.deleteAchievementsCompetitionByCompetitionIds(competitionIds));
    }
}
