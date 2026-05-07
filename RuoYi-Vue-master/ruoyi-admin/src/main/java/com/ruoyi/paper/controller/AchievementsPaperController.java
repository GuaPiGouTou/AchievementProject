package com.ruoyi.paper.controller;

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
import com.ruoyi.paper.domain.AchievementsPaper;
import com.ruoyi.paper.service.IAchievementsPaperService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;
import org.apache.commons.lang3.StringUtils;

/**
 * 论文成果Controller
 * 
 * @author xixia
 * @date 2025-11-26
 */
@RestController
@RequestMapping("/paper/paper")
public class AchievementsPaperController extends BaseController
{
    private static final String PAPER_STATUS_ACCEPTED = "已录用";
    private static final String PAPER_STATUS_PUBLISHED = "已发表";

    @Autowired
    private IAchievementsPaperService achievementsPaperService;
    @Autowired
    private ContestFeignClient contestFeignClient;
    /**
     * 查询论文成果列表
     */
    @PreAuthorize("@ss.hasPermi('paper:paper:list')")
    @GetMapping("/list")
    public AjaxResult list(AchievementsPaper achievementsPaper)
    {
        AchievementDataScopeUtils.applyAchievementListScope(achievementsPaper, "paper:paper");
        startPage();
        List<AchievementsPaper> list = achievementsPaperService.selectAchievementsPaperList(achievementsPaper);
        TableDataInfo tableData = getDataTable(list);
        AjaxResult res = AjaxResult.success();
        res.put("rows", tableData.getRows());
        res.put("total", tableData.getTotal());
        return res;
    }


    /**
     * 导出论文成果列表
     */
    @PreAuthorize("@ss.hasPermi('paper:paper:export')")
    @Log(title = "论文成果", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public AjaxResult export(HttpServletResponse response, @RequestBody ExportRequestDTO<AchievementsPaper> exportRequestDTO)
    {
        // 1. 获取参数
        List<String> hiddenColumns = exportRequestDTO.getShowColumns();
        Long[] ids = exportRequestDTO.getIdList();
        AchievementsPaper query = exportRequestDTO.getData() == null ? new AchievementsPaper() : exportRequestDTO.getData();
        AchievementDataScopeUtils.applyAchievementListScope(query, "paper:paper");
        List<AchievementsPaper> list = achievementsPaperService.selectAchievementsPaperList(query);
        list = AchievementDataScopeUtils.filterByIds(list, ids, "getPaperId");

        if (list == null || list.isEmpty()) {
            return AjaxResult.warn("未查询到数据");
        }

        // 6. 导出 Excel
        ExcelUtil<AchievementsPaper> util = new ExcelUtil<>(AchievementsPaper.class);
        if (hiddenColumns != null && !hiddenColumns.isEmpty()) {
            util.showColumn(hiddenColumns.toArray(new String[0]));
        }

        // 执行导出
        util.exportExcel(response, list, "论文成果数据");

        //返回 success
        return null;
    }

    /**
     * 获取论文成果详细信息
     */
    @PreAuthorize("@ss.hasPermi('paper:paper:query')")
    @GetMapping(value = "/{paperId}")
    public AjaxResult getInfo(@PathVariable("paperId") Long paperId)
    {
        AchievementsPaper achievementsPaper = achievementsPaperService.selectAchievementsPaperByPaperId(paperId);
        if (!AchievementDataScopeUtils.canAccessAchievementRecord(achievementsPaper, "paper:paper")) {
            return AjaxResult.error("无权限访问该数据");
        }
        return AjaxResult.success(achievementsPaper);
    }

    /**
     * 新增论文成果
     */
    @PreAuthorize("@ss.hasPermi('paper:paper:add')")
    @Log(title = "论文成果", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody AchievementsPaper achievementsPaper)
    {
        AjaxResult validationResult = validateAndNormalizePaperStatus(achievementsPaper);
        if (validationResult != null) {
            return validationResult;
        }
        achievementsPaper.setUserId(getUserId());
        achievementsPaper.setDeptId(getDeptId());
        achievementsPaperService.insertAchievementsPaper(achievementsPaper);
        AjaxResult res = AjaxResult.success();
        res.put("paperId", achievementsPaper.getPaperId());
        return res;
    }

    /**
     * 修改论文成果
     */
    @PreAuthorize("@ss.hasPermi('paper:paper:edit')")
    @Log(title = "论文成果", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody AchievementsPaper achievementsPaper)
    {
        AjaxResult validationResult = validateAndNormalizePaperStatusForUpdate(achievementsPaper);
        if (validationResult != null) {
            return validationResult;
        }
        achievementsPaper.setUserId(null);
        achievementsPaper.setDeptId(null);
        achievementsPaper.setCreatedAt(null);
        achievementsPaper.setUpdatedAt(null);
        int rows = achievementsPaperService.updateAchievementsPaper(achievementsPaper);
        if (rows > 0) {
            AjaxResult result = AjaxResult.success("修改成功");
            result.put("paperId", achievementsPaper.getPaperId());
            return result;
        }
        return AjaxResult.error("修改失败");
    }

    /**
     * 删除论文成果
     */
    @PreAuthorize("@ss.hasPermi('paper:paper:remove')")
    @Log(title = "论文成果", businessType = BusinessType.DELETE)
	@DeleteMapping("/{paperIds}")
    public AjaxResult remove(@PathVariable Long[] paperIds)
    {
        return toAjax(achievementsPaperService.deleteAchievementsPaperByPaperIds(paperIds));
    }

    private AjaxResult validateAndNormalizePaperStatusForUpdate(AchievementsPaper achievementsPaper)
    {
        if (StringUtils.isBlank(achievementsPaper.getPaperStatus())) {
            return null;
        }
        return validateAndNormalizePaperStatus(achievementsPaper);
    }

    private AjaxResult validateAndNormalizePaperStatus(AchievementsPaper achievementsPaper)
    {
        String paperStatus = achievementsPaper.getPaperStatus();
        if (StringUtils.isBlank(paperStatus)) {
            return AjaxResult.error("论文状态不能为空");
        }
        if (PAPER_STATUS_ACCEPTED.equals(paperStatus)) {
            if (achievementsPaper.getAcceptanceDate() == null) {
                return AjaxResult.error("已录用论文必须填写录用时间");
            }
            achievementsPaper.setPublishDate(null);
            return null;
        }
        if (PAPER_STATUS_PUBLISHED.equals(paperStatus)) {
            if (achievementsPaper.getPublishDate() == null) {
                return AjaxResult.error("已发表论文必须填写发表时间");
            }
            achievementsPaper.setAcceptanceDate(null);
            return null;
        }
        return AjaxResult.error("论文状态只能选择已录用或已发表");
    }
}
