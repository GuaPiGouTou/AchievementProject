package com.ruoyi.award.controller;

import java.util.List;
import javax.servlet.http.HttpServletResponse;

import com.ruoyi.ContestFeign.ContestFeignClient;
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
    @Autowired
    private ContestFeignClient contestFeignClient;
    /**
     * 查询获奖成果列表
     */
    @PreAuthorize("@ss.hasPermi('award:award:list')")
    @GetMapping("/list")
    public AjaxResult list(AchievementsAward achievementsAward)
    {
        Integer pageNum = ServletUtils.getParameterToInt("pageNum");
        Integer pageSize = ServletUtils.getParameterToInt("pageSize");
        AjaxResult res = new AjaxResult();
        // 使用Feign客户端调用远程服务
        try {
            res = contestFeignClient.getAwardList(getUserId(), getDeptId(), pageNum, pageSize);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

        return res;
    }

    /**
     * 导出获奖成果列表
     */
    @PreAuthorize("@ss.hasPermi('award:award:export')")
    @Log(title = "获奖成果", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, @ModelAttribute ExportRequestDTO<AchievementsAward> exportRequestDTO)
    {

        List<String> showColumns = exportRequestDTO.getShowColumns();
        System.out.println(showColumns);
        AchievementsAward achievementsAward = exportRequestDTO.getData();
        List<AchievementsAward> list = achievementsAwardService.selectAchievementsAwardList(achievementsAward);
        ExcelUtil<AchievementsAward> util = new ExcelUtil<AchievementsAward>(AchievementsAward.class);
        if(showColumns != null && !showColumns.isEmpty()){
            util.showColumn(showColumns.toArray(new String[0]));
        }
        util.exportExcel(response, list, "获奖成果数据");

    }

    /**
     * 获取获奖成果详细信息
     */
    @PreAuthorize("@ss.hasPermi('award:award:query')")
    @GetMapping(value = "/{awardId}")
    public AjaxResult getInfo(@PathVariable("awardId") Long awardId)
    {
        AjaxResult res = new AjaxResult();
        // 使用Feign客户端调用远程服务
        try {
            res = contestFeignClient.getAwardById(getUserId(),getDeptId(),awardId);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return res;
    }

    /**
     * 新增获奖成果
     */
    @PreAuthorize("@ss.hasPermi('award:award:add')")
    @Log(title = "获奖成果", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody AchievementsAward achievementsAward)
    {
        AjaxResult res = new AjaxResult();
        // 使用Feign客户端调用远程服务
        try {
            res = contestFeignClient.insertAward(achievementsAward);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return res;
    }

    /**
     * 修改获奖成果
     */
    @PreAuthorize("@ss.hasPermi('award:award:edit')")
    @Log(title = "获奖成果", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody AchievementsAward achievementsAward)
    {
        AjaxResult res = new AjaxResult();
        // 使用Feign客户端调用远程服务
        try {
            res = contestFeignClient.updateAward(achievementsAward);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return res;
    }

    /**
     * 删除获奖成果
     */
    @PreAuthorize("@ss.hasPermi('award:award:remove')")
    @Log(title = "获奖成果", businessType = BusinessType.DELETE)
	@DeleteMapping("/{awardIds}")
    public AjaxResult remove(@PathVariable Long[] awardIds)
    {
        AjaxResult res = new AjaxResult();
        // 使用Feign客户端调用远程服务
        try {
            res = contestFeignClient.deleteContests(getUserId(),getDeptId(),awardIds);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return res;
    }
}
