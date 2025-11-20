package com.ruoyi.competition.controller;

import java.util.Collections;
import java.util.List;
import javax.servlet.http.HttpServletResponse;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.ruoyi.ContestFeign.ContestFeignClient;
import com.ruoyi.common.utils.ServletUtils;
import com.ruoyi.attachment.domain.ExportRequestDTO;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
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
    @Autowired
    private ContestFeignClient contestFeignClient;
    /**
     * 查询竞赛成果列表
     */
    @PreAuthorize("@ss.hasPermi('competition:competition:list')")
    @GetMapping("/list")
    public AjaxResult list(AchievementsCompetition achievementsCompetition) {
        Integer pageNum = ServletUtils.getParameterToInt("pageNum");
        Integer pageSize = ServletUtils.getParameterToInt("pageSize");
        AjaxResult res = new AjaxResult();
        // 使用Feign客户端调用远程服务
        try {
            res = contestFeignClient.getContestList(getUserId(), getDeptId(), pageNum, pageSize);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

        return res;
    }

    /**
     * 导出竞赛成果列表
     */
    @PreAuthorize("@ss.hasPermi('competition:competition:export')")
    @Log(title = "竞赛成果", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, @ModelAttribute ExportRequestDTO<AchievementsCompetition> exportRequestDTO )
    {
        System.out.println(exportRequestDTO.getShowColumns().toString());
        List<String> ShowColumns = exportRequestDTO.getShowColumns();
        AchievementsCompetition queryParams = exportRequestDTO.getData();
        List<AchievementsCompetition> list = achievementsCompetitionService.selectAchievementsCompetitionList(queryParams);
        ExcelUtil<AchievementsCompetition> util = new ExcelUtil<AchievementsCompetition>(AchievementsCompetition.class);
        if(ShowColumns != null && !ShowColumns.isEmpty())
        {
            util.showColumn(ShowColumns.toArray(new String[0]));
        }
        util.exportExcel(response, list, "竞赛成果数据");
    }

    /**
     * 获取竞赛成果详细信息
     */
    @PreAuthorize("@ss.hasPermi('competition:competition:query')")
    @GetMapping(value = "/{competitionId}")
    public AjaxResult getInfo(@PathVariable("competitionId") Long competitionId)
    {
//        return success(achievementsCompetitionService.selectAchievementsCompetitionByCompetitionId(competitionId));
        AjaxResult res = new AjaxResult();
        // 使用Feign客户端调用远程服务
        try {
            res = contestFeignClient.getContestById(getUserId(),getDeptId(),competitionId);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return res;
    }

    /**
     * 新增竞赛成果
     */
    @PreAuthorize("@ss.hasPermi('competition:competition:add')")
    @Log(title = "竞赛成果", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody AchievementsCompetition achievementsCompetition)
    {
//        int achievementsCompetition1 = achievementsCompetitionService.insertAchievementsCompetition(achievementsCompetition);
//        return toAjax(achievementsCompetition1).put("competitionId",achievementsCompetition.getCompetitionId());

        AjaxResult res = new AjaxResult();
        // 使用Feign客户端调用远程服务
        try {
            res = contestFeignClient.insertContest(achievementsCompetition);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return res;
    }

    /**
     * 修改竞赛成果
     */
    @PreAuthorize("@ss.hasPermi('competition:competition:edit')")
    @Log(title = "竞赛成果", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody AchievementsCompetition achievementsCompetition)
    {
//        int achievementsCompetition1 = achievementsCompetitionService.updateAchievementsCompetition(achievementsCompetition);
//        return toAjax(achievementsCompetition1).put("competitionId",achievementsCompetition.getCompetitionId());
        AjaxResult res = new AjaxResult();
        // 使用Feign客户端调用远程服务
        try {
            res = contestFeignClient.updateContest(achievementsCompetition);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return res;
    }

    /**
     * 删除竞赛成果
     */
    @PreAuthorize("@ss.hasPermi('competition:competition:remove')")
    @Log(title = "竞赛成果", businessType = BusinessType.DELETE)
	@DeleteMapping("/{competitionIds}")
    public AjaxResult remove(@PathVariable Long[] competitionIds)
    {
//        return toAjax(achievementsCompetitionService.deleteAchievementsCompetitionByCompetitionIds(competitionIds));
        AjaxResult res = new AjaxResult();
        // 使用Feign客户端调用远程服务
        try {
            res = contestFeignClient.deleteContests(getUserId(),getDeptId(),competitionIds);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return res;
    }
}
