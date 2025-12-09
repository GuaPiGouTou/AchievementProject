package com.ruoyi.software.controller;

import java.util.List;
import javax.servlet.http.HttpServletResponse;

import com.ruoyi.ContestFeign.ContestFeignClient;
import com.ruoyi.ContestFeign.DeleteRequest;
import com.ruoyi.attachment.domain.ExportRequestDTO;
import com.ruoyi.common.utils.ServletUtils;
import com.ruoyi.competition.domain.AchievementsCompetition;
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
        Integer pageNum = ServletUtils.getParameterToInt("pageNum");
        Integer pageSize = ServletUtils.getParameterToInt("pageSize");
        AjaxResult res = new AjaxResult();
        // 使用Feign客户端调用远程服务
        try {
            res = contestFeignClient.selectSoftwareList(getUserId(), getDeptId(), pageNum, pageSize);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return res;
    }

    /**
     * 导出软著成果列表
     */
    @PreAuthorize("@ss.hasPermi('software:software:export')")
    @Log(title = "软著成果", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response,@RequestBody ExportRequestDTO<AchievementsSoftware> exportRequestDTO )
    {
        List<String> hiddenColumns = exportRequestDTO.getShowColumns();
        AchievementsSoftware queryParams = exportRequestDTO.getData();
        System.out.println(queryParams);
        System.out.println(getUserId());
        System.out.println(getDeptId());

        queryParams.setUserId(getUserId());
        queryParams.setDeptId(getDeptId());
        List<AchievementsSoftware> list = achievementsSoftwareService.selectAchievementsSoftwareList(queryParams);
        ExcelUtil<AchievementsSoftware> util = new ExcelUtil<AchievementsSoftware>(AchievementsSoftware.class);
        if(hiddenColumns != null && !hiddenColumns.isEmpty())
        {
            util.showColumn(hiddenColumns.toArray(new String[0]));
        }
        util.exportExcel(response, list, "软著数据");
    }

    /**
     * 获取软著成果详细信息
     */
    @PreAuthorize("@ss.hasPermi('software:software:query')")
    @GetMapping(value = "/{softwareId}")
    public AjaxResult getInfo(@PathVariable("softwareId") Long softwareId)
    {
        AjaxResult res = new AjaxResult();
        // 使用Feign客户端调用远程服务
        try {
            res = contestFeignClient.selectSoftwareById(getUserId(),getDeptId(),softwareId);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return res;    }

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
        AjaxResult res = new AjaxResult();
        // 使用Feign客户端调用远程服务
        try {
            achievementsSoftware.setUserId(getUserId());
            achievementsSoftware.setDeptId(getDeptId());

            res = contestFeignClient.updateSoftware(achievementsSoftware);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return res;    }

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
            res = contestFeignClient.deleteContests(deleteRequest);
            System.out.println(res);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return res;    }
}
