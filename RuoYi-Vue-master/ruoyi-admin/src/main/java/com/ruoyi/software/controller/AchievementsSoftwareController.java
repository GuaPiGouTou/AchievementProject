package com.ruoyi.software.controller;

import java.util.List;
import javax.servlet.http.HttpServletResponse;

import com.ruoyi.ContestFeign.ContestFeignClient;
import com.ruoyi.ContestFeign.DeleteRequest;
import com.ruoyi.attachment.domain.ExportRequestDTO;
import com.ruoyi.common.utils.AchievementDataScopeUtils;
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
import com.ruoyi.software.domain.AchievementsSoftware;
import com.ruoyi.software.service.IAchievementsSoftwareService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 软著成果Controller
 * 
 * @author xixia
 * @date 2025-12-07
 */
@RestController
@RequestMapping("/software/software")
public class AchievementsSoftwareController extends BaseController
{
    @Autowired
    private IAchievementsSoftwareService achievementsSoftwareService;
    @Autowired private ContestFeignClient contestFeignClient;
    /**
     * 查询软著成果列表
     */
    @PreAuthorize("@ss.hasPermi('software:software:list')")
    @GetMapping("/list")
    public AjaxResult list(AchievementsSoftware achievementsSoftware)
    {
        AchievementDataScopeUtils.applyAchievementListScope(achievementsSoftware, "software:software");
        startPage();
        List<AchievementsSoftware> list = achievementsSoftwareService.selectAchievementsSoftwareList(achievementsSoftware);
        TableDataInfo tableData = getDataTable(list);
        AjaxResult res = AjaxResult.success();
        res.put("rows", tableData.getRows());
        res.put("total", tableData.getTotal());
        return res;
    }

    /**
     * 导出软著成果列表
     */
    @PreAuthorize("@ss.hasPermi('software:software:export')")
    @Log(title = "软著成果", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public AjaxResult export(HttpServletResponse response,@RequestBody ExportRequestDTO<AchievementsSoftware> exportRequestDTO )
    {
        // 1. 获取参数
        List<String> hiddenColumns = exportRequestDTO.getShowColumns();
        Long[] ids = exportRequestDTO.getIdList();
        AchievementsSoftware query = exportRequestDTO.getData() == null ? new AchievementsSoftware() : exportRequestDTO.getData();
        AchievementDataScopeUtils.applyAchievementListScope(query, "software:software");
        List<AchievementsSoftware> list = achievementsSoftwareService.selectAchievementsSoftwareList(query);
        list = AchievementDataScopeUtils.filterByIds(list, ids, "getSoftwareId");

        if (list == null || list.isEmpty()) {
            return AjaxResult.warn("未查询到数据");
        }

        // 6. 导出 Excel
        ExcelUtil<AchievementsSoftware> util = new ExcelUtil<>(AchievementsSoftware.class);
        if (hiddenColumns != null && !hiddenColumns.isEmpty()) {
            util.showColumn(hiddenColumns.toArray(new String[0]));
        }

        // 执行导出
        util.exportExcel(response, list, "软著成果数据");

        //返回 success
        return null;
    }

    /**
     * 获取软著成果详细信息
     */
    @PreAuthorize("@ss.hasPermi('software:software:query')")
    @GetMapping(value = "/{softwareId}")
    public AjaxResult getInfo(@PathVariable("softwareId") Long softwareId)
    {
        AchievementsSoftware achievementsSoftware = achievementsSoftwareService.selectAchievementsSoftwareBySoftwareId(softwareId);
        if (!AchievementDataScopeUtils.canAccessAchievementRecord(achievementsSoftware, "software:software")) {
            return AjaxResult.error("无权限访问该数据");
        }
        return AjaxResult.success(achievementsSoftware);
    }

    /**
     * 新增软著成果
     */
    @PreAuthorize("@ss.hasPermi('software:software:add')")
    @Log(title = "软著成果", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody AchievementsSoftware achievementsSoftware)
    {
        AjaxResult res = new AjaxResult();
        // 使用Feign客户端调用远程服务
        try {
            achievementsSoftware.setUserId(getUserId());
            achievementsSoftware.setDeptId(getDeptId());
            res = contestFeignClient.insertSoftware(achievementsSoftware);

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return res;    }

    /**
     * 修改软著成果
     */
    @PreAuthorize("@ss.hasPermi('software:software:edit')")
    @Log(title = "软著成果", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody AchievementsSoftware achievementsSoftware)
    {
        achievementsSoftware.setUserId(null);
        achievementsSoftware.setDeptId(null);
        achievementsSoftware.setCreatedAt(null);
        achievementsSoftware.setUpdatedAt(null);
        int rows = achievementsSoftwareService.updateAchievementsSoftware(achievementsSoftware);
        if (rows > 0) {
            AjaxResult result = AjaxResult.success("修改成功");
            result.put("softwareId", achievementsSoftware.getSoftwareId());
            return result;
        }
        return AjaxResult.error("修改失败");
    }

    /**
     * 删除软著成果
     */
    @PreAuthorize("@ss.hasPermi('software:software:remove')")
    @Log(title = "软著成果", businessType = BusinessType.DELETE)
	@DeleteMapping("/{softwareIds}")
    public AjaxResult remove(@PathVariable Long[] softwareIds)
    {
        AjaxResult res = new AjaxResult();
        // 使用Feign客户端调用远程服务
        DeleteRequest deleteRequest = new DeleteRequest(getUserId(),getDeptId(),softwareIds);
        try {
            res = contestFeignClient.deleteSoftwares(deleteRequest);
            System.out.println(res);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return res;    }
}
