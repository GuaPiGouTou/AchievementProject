package com.ruoyi.paper.controller;

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
import com.ruoyi.paper.domain.AchievementsPaper;
import com.ruoyi.paper.service.IAchievementsPaperService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 论文成果Controller
 * 
 * @author xixia
 * @date 2025-11-05
 */
@RestController
@RequestMapping("/paper/paper")
public class AchievementsPaperController extends BaseController
{
    @Autowired
    private IAchievementsPaperService achievementsPaperService;

    /**
     * 查询论文成果列表
     */

    @PreAuthorize("@ss.hasPermi('paper:paper:list')")
    @GetMapping("/list")
    public TableDataInfo list(AchievementsPaper achievementsPaper)
    {
        startPage();
        achievementsPaper.setUserId(getUserId());
        achievementsPaper.setDeptId(getDeptId());
        List<AchievementsPaper> list = achievementsPaperService.selectAchievementsPaperList(achievementsPaper);
        return getDataTable(list);
    }

    /**
     * 导出论文成果列表
     */
    @PreAuthorize("@ss.hasPermi('paper:paper:export')")
    @Log(title = "论文成果", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, AchievementsPaper achievementsPaper)
    {
        List<AchievementsPaper> list = achievementsPaperService.selectAchievementsPaperList(achievementsPaper);
        ExcelUtil<AchievementsPaper> util = new ExcelUtil<AchievementsPaper>(AchievementsPaper.class);
        util.exportExcel(response, list, "论文成果数据");
    }

    /**
     * 获取论文成果详细信息
     */
    @PreAuthorize("@ss.hasPermi('paper:paper:query')")
    @GetMapping(value = "/{paperId}")
    public AjaxResult getInfo(@PathVariable("paperId") Long paperId)
    {
        return success(achievementsPaperService.selectAchievementsPaperByPaperId(paperId));
    }

    /**
     * 新增论文成果
     */
    @PreAuthorize("@ss.hasPermi('paper:paper:add')")
    @Log(title = "论文成果", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody AchievementsPaper achievementsPaper)
    {
        int rows =achievementsPaperService.insertAchievementsPaper(achievementsPaper);
        return toAjax(rows).put("paperId",achievementsPaper.getPaperId());

    }

    /**
     * 修改论文成果
     */
    @PreAuthorize("@ss.hasPermi('paper:paper:edit')")
    @Log(title = "论文成果", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody AchievementsPaper achievementsPaper)
    {
        int rows = achievementsPaperService.updateAchievementsPaper(achievementsPaper);
        return toAjax(rows).put("paperId",achievementsPaper.getPaperId());
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
}
