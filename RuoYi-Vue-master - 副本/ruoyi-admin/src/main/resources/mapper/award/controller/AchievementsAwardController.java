package com.ruoyi.award.controller;

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
import com.ruoyi.award.domain.AchievementsAward;
import com.ruoyi.award.service.IAchievementsAwardService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 获奖成果Controller
 * 
 * @author ruoyi
 * @date 2025-11-20
 */
@RestController
@RequestMapping("/award/award")
public class AchievementsAwardController extends BaseController
{
    @Autowired
    private IAchievementsAwardService achievementsAwardService;

    /**
     * 查询获奖成果列表
     */
    @PreAuthorize("@ss.hasPermi('award:award:list')")
    @GetMapping("/list")
    public TableDataInfo list(AchievementsAward achievementsAward)
    {
        startPage();
        List<AchievementsAward> list = achievementsAwardService.selectAchievementsAwardList(achievementsAward);
        return getDataTable(list);
    }

    /**
     * 导出获奖成果列表
     */
    @PreAuthorize("@ss.hasPermi('award:award:export')")
    @Log(title = "获奖成果", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, AchievementsAward achievementsAward)
    {
        List<AchievementsAward> list = achievementsAwardService.selectAchievementsAwardList(achievementsAward);
        ExcelUtil<AchievementsAward> util = new ExcelUtil<AchievementsAward>(AchievementsAward.class);
        util.exportExcel(response, list, "获奖成果数据");
    }

    /**
     * 获取获奖成果详细信息
     */
    @PreAuthorize("@ss.hasPermi('award:award:query')")
    @GetMapping(value = "/{awardId}")
    public AjaxResult getInfo(@PathVariable("awardId") Long awardId)
    {
        return success(achievementsAwardService.selectAchievementsAwardByAwardId(awardId));
    }

    /**
     * 新增获奖成果
     */
    @PreAuthorize("@ss.hasPermi('award:award:add')")
    @Log(title = "获奖成果", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody AchievementsAward achievementsAward)
    {
        return toAjax(achievementsAwardService.insertAchievementsAward(achievementsAward));
    }

    /**
     * 修改获奖成果
     */
    @PreAuthorize("@ss.hasPermi('award:award:edit')")
    @Log(title = "获奖成果", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody AchievementsAward achievementsAward)
    {
        return toAjax(achievementsAwardService.updateAchievementsAward(achievementsAward));
    }

    /**
     * 删除获奖成果
     */
    @PreAuthorize("@ss.hasPermi('award:award:remove')")
    @Log(title = "获奖成果", businessType = BusinessType.DELETE)
	@DeleteMapping("/{awardIds}")
    public AjaxResult remove(@PathVariable Long[] awardIds)
    {
        return toAjax(achievementsAwardService.deleteAchievementsAwardByAwardIds(awardIds));
    }
}
