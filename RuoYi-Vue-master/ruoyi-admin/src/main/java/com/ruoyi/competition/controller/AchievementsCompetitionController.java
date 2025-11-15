package com.ruoyi.competition.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import javax.servlet.http.HttpServletResponse;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.ruoyi.ContestFeign.ContestFeignClient;
import com.ruoyi.common.utils.PageUtils;
import com.ruoyi.common.utils.ServletUtils;
import com.ruoyi.competition.domain.ExportRequestDTO;

import com.ruoyi.competition.domain.demo;

import org.apache.http.client.utils.URIBuilder;
import org.apache.http.HttpEntity;
import org.apache.http.NameValuePair;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;
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
    @Autowired
    private ObjectMapper objectMapper;
    /**
     * 查询竞赛成果列表
     */
    @PreAuthorize("@ss.hasPermi('competition:competition:list')")
    @GetMapping("/list")
    public TableDataInfo list(AchievementsCompetition achievementsCompetition) {
        // pageNum 分页页码
        Integer pageNum = ServletUtils.getParameterToInt("pageNum");
        // pageSize 分页大小
        Integer pageSize = ServletUtils.getParameterToInt("pageSize");

        startPage();
        List<AchievementsCompetition> list = achievementsCompetitionService.selectAchievementsCompetitionList(achievementsCompetition);


        System.out.println("----------");
        System.out.println(list);
        TableDataInfo dataTable = getDataTable(list);
        System.out.println("----------");
        System.out.println(dataTable.toString());
        return dataTable;
    }

    /**
     * 导出竞赛成果列表
     */
    @PreAuthorize("@ss.hasPermi('competition:competition:export')")
    @Log(title = "竞赛成果", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, @ModelAttribute ExportRequestDTO exportRequestDTO )
    {
        System.out.println(exportRequestDTO.getHiddenColumns().toString());
        List<String> hiddenColumns = exportRequestDTO.getHiddenColumns();
        List<AchievementsCompetition> list = achievementsCompetitionService.selectAchievementsCompetitionList(exportRequestDTO.getAchievementsCompetition());
        ExcelUtil<AchievementsCompetition> util = new ExcelUtil<AchievementsCompetition>(AchievementsCompetition.class);
       // 显示指定列
        if(hiddenColumns != null && !hiddenColumns.isEmpty())
        {
            util.showColumn(hiddenColumns.toArray(new String[0]));
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
        int achievementsCompetition1 = achievementsCompetitionService.insertAchievementsCompetition(achievementsCompetition);
        return toAjax(achievementsCompetition1).put("competitionId",achievementsCompetition.getCompetitionId());
    }

    /**
     * 修改竞赛成果
     */
    @PreAuthorize("@ss.hasPermi('competition:competition:edit')")
    @Log(title = "竞赛成果", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody AchievementsCompetition achievementsCompetition)
    {
        int achievementsCompetition1 = achievementsCompetitionService.updateAchievementsCompetition(achievementsCompetition);
        return toAjax(achievementsCompetition1).put("competitionId",achievementsCompetition.getCompetitionId());
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
