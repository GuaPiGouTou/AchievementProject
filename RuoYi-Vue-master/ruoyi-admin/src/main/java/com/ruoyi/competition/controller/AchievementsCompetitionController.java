package com.ruoyi.competition.controller;

import java.util.List;
import javax.servlet.http.HttpServletResponse;

import com.ruoyi.ContestFeign.ContestFeignClient;
import com.ruoyi.ContestFeign.DeleteRequest;
import com.ruoyi.common.utils.AchievementDataScopeUtils;
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
        AchievementDataScopeUtils.applyAchievementListScope(achievementsCompetition, "competition:competition");
        startPage();
        List<AchievementsCompetition> list = achievementsCompetitionService.selectAchievementsCompetitionList(achievementsCompetition);
        TableDataInfo tableData = getDataTable(list);
        AjaxResult res = AjaxResult.success();
        res.put("rows", tableData.getRows());
        res.put("total", tableData.getTotal());
        return res;
    }



    /**
     * 导出竞赛成果列表
     */
    @PreAuthorize("@ss.hasPermi('competition:competition:export')")
    @Log(title = "竞赛成果", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public AjaxResult export(HttpServletResponse response, @RequestBody ExportRequestDTO<AchievementsCompetition> exportRequestDTO)
    {
        // 1. 获取参数
        List<String> hiddenColumns = exportRequestDTO.getShowColumns();
        Long[] ids = exportRequestDTO.getIdList();
        AchievementsCompetition query = exportRequestDTO.getData() == null ? new AchievementsCompetition() : exportRequestDTO.getData();
        AchievementDataScopeUtils.applyAchievementListScope(query, "competition:competition");
        List<AchievementsCompetition> list = achievementsCompetitionService.selectAchievementsCompetitionList(query);
        list = AchievementDataScopeUtils.filterByIds(list, ids, "getCompetitionId");

        if (list == null || list.isEmpty()) {
            return AjaxResult.warn("未查询到数据");
        }

        // 6. 导出 Excel
        ExcelUtil<AchievementsCompetition> util = new ExcelUtil<>(AchievementsCompetition.class);
        if (hiddenColumns != null && !hiddenColumns.isEmpty()) {
            util.showColumn(hiddenColumns.toArray(new String[0]));
        }

        // 执行导出
        util.exportExcel(response, list, "竞赛成果数据");

        //返回 success
        return null;
    }

    /**
     * 获取竞赛成果详细信息
     */
    @PreAuthorize("@ss.hasPermi('competition:competition:query')")
    @GetMapping(value = "/{competitionId}")
    public AjaxResult getInfo(@PathVariable("competitionId") Long competitionId)
    {
        AchievementsCompetition achievementsCompetition = achievementsCompetitionService.selectAchievementsCompetitionByCompetitionId(competitionId);
        if (!AchievementDataScopeUtils.canAccessAchievementRecord(achievementsCompetition, "competition:competition")) {
            return AjaxResult.error("无权限访问该数据");
        }
        return AjaxResult.success(achievementsCompetition);
    }

    /**
     * 新增竞赛成果
     */
    @PreAuthorize("@ss.hasPermi('competition:competition:add')")
    @Log(title = "竞赛成果", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody AchievementsCompetition achievementsCompetition)
    {
        AjaxResult res = new AjaxResult();
        // 使用Feign客户端调用远程服务
        try {
            achievementsCompetition.setUserId(getUserId());
            achievementsCompetition.setDeptId(getDeptId());

            System.out.println(achievementsCompetition);
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
        achievementsCompetition.setUserId(null);
        achievementsCompetition.setDeptId(null);
        achievementsCompetition.setCreatedAt(null);
        achievementsCompetition.setUpdatedAt(null);
        int rows = achievementsCompetitionService.updateAchievementsCompetition(achievementsCompetition);
        if (rows > 0) {
            AjaxResult result = AjaxResult.success("修改成功");
            result.put("competitionId", achievementsCompetition.getCompetitionId());
            return result;
        }
        return AjaxResult.error("修改失败");
    }

    /**
     * 删除竞赛成果
     */
    @PreAuthorize("@ss.hasPermi('competition:competition:remove')")
    @Log(title = "竞赛成果", businessType = BusinessType.DELETE)
	@DeleteMapping("/{competitionIds}")
    public AjaxResult remove(@PathVariable Long[] competitionIds)
    {
        AjaxResult res = new AjaxResult();
        // 使用Feign客户端调用远程服务
        DeleteRequest deleteRequest = new DeleteRequest(getUserId(),getDeptId(),competitionIds);
        try {
            res = contestFeignClient.deleteContests(deleteRequest);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return res;
    }
}
