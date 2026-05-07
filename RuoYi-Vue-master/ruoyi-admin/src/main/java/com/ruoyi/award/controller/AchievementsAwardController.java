package com.ruoyi.award.controller;

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
        AchievementDataScopeUtils.applyAchievementListScope(achievementsAward, "award:award");
        startPage();
        List<AchievementsAward> list = achievementsAwardService.selectAchievementsAwardList(achievementsAward);
        TableDataInfo tableData = getDataTable(list);
        AjaxResult res = AjaxResult.success();
        res.put("rows", tableData.getRows());
        res.put("total", tableData.getTotal());
        return res;
    }

    /**
     * 导出获奖成果列表
     */
    @PreAuthorize("@ss.hasPermi('award:award:export')")
    @Log(title = "获奖成果", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public AjaxResult export(HttpServletResponse response, @RequestBody ExportRequestDTO<AchievementsAward> exportRequestDTO)
    {
        // 1. 获取参数
        List<String> hiddenColumns = exportRequestDTO.getShowColumns();
        Long[] ids = exportRequestDTO.getIdList();
        AchievementsAward query = exportRequestDTO.getData() == null ? new AchievementsAward() : exportRequestDTO.getData();
        AchievementDataScopeUtils.applyAchievementListScope(query, "award:award");
        List<AchievementsAward> list = achievementsAwardService.selectAchievementsAwardList(query);
        list = AchievementDataScopeUtils.filterByIds(list, ids, "getAwardId");

        if (list == null || list.isEmpty()) {
            return AjaxResult.warn("未查询到数据");
        }

        // 6. 导出 Excel
        ExcelUtil<AchievementsAward> util = new ExcelUtil<>(AchievementsAward.class);
        if (hiddenColumns != null && !hiddenColumns.isEmpty()) {
            util.showColumn(hiddenColumns.toArray(new String[0]));
        }

        // 执行导出
        util.exportExcel(response, list, "获奖成果数据");

        //返回 success
        return null;
    }

    /**
     * 获取获奖成果详细信息
     */
    @PreAuthorize("@ss.hasPermi('award:award:query')")
    @GetMapping(value = "/{awardId}")
    public AjaxResult getInfo(@PathVariable("awardId") Long awardId)
    {
        AchievementsAward achievementsAward = achievementsAwardService.selectAchievementsAwardByAwardId(awardId);
        if (!AchievementDataScopeUtils.canAccessAchievementRecord(achievementsAward, "award:award")) {
            return AjaxResult.error("无权限访问该数据");
        }
        return AjaxResult.success(achievementsAward);
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
            achievementsAward.setUserId(getUserId());
            achievementsAward.setDeptId(getDeptId());

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
        achievementsAward.setUserId(null);
        achievementsAward.setDeptId(null);
        achievementsAward.setCreatedAt(null);
        achievementsAward.setUpdatedAt(null);
        int rows = achievementsAwardService.updateAchievementsAward(achievementsAward);
        if (rows > 0) {
            AjaxResult result = AjaxResult.success("修改成功");
            result.put("awardId", achievementsAward.getAwardId());
            return result;
        }
        return AjaxResult.error("修改失败");
    }

    /**
     * 删除获奖成果
     */
    @PreAuthorize("@ss.hasPermi('award:award:remove')")
    @Log(title = "获奖成果", businessType = BusinessType.DELETE)
	@DeleteMapping("/{awardIds}")
    public AjaxResult remove(@PathVariable Long[] awardIds)
    {
        for (int i = 0; i < awardIds.length; i++) {
            System.out.println(awardIds[i]);
        }
        AjaxResult res = new AjaxResult();
        // 使用Feign客户端调用远程服务
        DeleteRequest deleteRequest = new DeleteRequest(getUserId(),getDeptId(),awardIds);
        try {
            res = contestFeignClient.deleteAward(deleteRequest);
            System.out.println(res);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return res;
    }
}
