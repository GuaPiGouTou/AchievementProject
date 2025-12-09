package com.ruoyi.monograph.controller;

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
import com.ruoyi.monograph.domain.AchievementsMonograph;
import com.ruoyi.monograph.service.IAchievementsMonographService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 成果专著Controller
 * 
 * @author xixia
 * @date 2025-12-07
 */
@RestController
@RequestMapping("/monograph/monograph")
public class AchievementsMonographController extends BaseController
{
    @Autowired
    private IAchievementsMonographService achievementsMonographService;

    @Autowired
    private ContestFeignClient contestFeignClient;

    /**
     * 查询成果专著列表
     */
    @PreAuthorize("@ss.hasPermi('monograph:monograph:list')")
    @GetMapping("/list")
    public AjaxResult list(AchievementsMonograph achievementsMonograph)
    {
        Integer pageNum = ServletUtils.getParameterToInt("pageNum");
        Integer pageSize = ServletUtils.getParameterToInt("pageSize");
        AjaxResult res = new AjaxResult();
        // 使用Feign客户端调用远程服务
        try {
            res = contestFeignClient.selectMonographList(getUserId(), getDeptId(), pageNum, pageSize);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return res;
    }

    /**
     * 导出成果专著列表
     */
    @PreAuthorize("@ss.hasPermi('monograph:monograph:export')")
    @Log(title = "成果专著", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response,@RequestBody ExportRequestDTO<AchievementsMonograph> exportRequestDTO)
    {
        List<String> hiddenColumns = exportRequestDTO.getShowColumns();
        AchievementsMonograph queryParams = exportRequestDTO.getData();
        queryParams.setUserId(getUserId());
        queryParams.setDeptId(getDeptId());
        List<AchievementsMonograph> list = achievementsMonographService.selectAchievementsMonographList(queryParams);
        ExcelUtil<AchievementsMonograph> util = new ExcelUtil<AchievementsMonograph>(AchievementsMonograph.class);
        if(hiddenColumns != null && !hiddenColumns.isEmpty())
        {
            util.showColumn(hiddenColumns.toArray(new String[0]));
        }
        util.exportExcel(response, list, "专著数据");
    }

    /**
     * 获取成果专著详细信息
     */
    @PreAuthorize("@ss.hasPermi('monograph:monograph:query')")
    @GetMapping(value = "/{monographId}")
    public AjaxResult getInfo(@PathVariable("monographId") Long monographId)
    {
        AjaxResult res = new AjaxResult();
        // 使用Feign客户端调用远程服务
        try {
            res = contestFeignClient.selectMonographById(getUserId(), getDeptId(), monographId);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return res;
    }

    /**
     * 新增成果专著
     */
    @PreAuthorize("@ss.hasPermi('monograph:monograph:add')")
    @Log(title = "成果专著", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody AchievementsMonograph achievementsMonograph)
    {
        AjaxResult res = new AjaxResult();
        // 使用Feign客户端调用远程服务
        try {
            achievementsMonograph.setUserId(getUserId());
            achievementsMonograph.setDeptId(getDeptId());

            // 注意：请确保 ContestFeignClient 中的 insertMonograph 参数类型已修正为 AchievementsMonograph
            // 原代码中可能是 AchievementsPaper，会导致编译错误或运行错误
            res = contestFeignClient.insertMonograph(achievementsMonograph);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return res;    }

    /**
     * 修改成果专著
     */
    @PreAuthorize("@ss.hasPermi('monograph:monograph:edit')")
    @Log(title = "成果专著", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody AchievementsMonograph achievementsMonograph)
    {
        AjaxResult res = new AjaxResult();
        // 使用Feign客户端调用远程服务
        try {
            achievementsMonograph.setUserId(getUserId());
            achievementsMonograph.setDeptId(getDeptId());

            res = contestFeignClient.updateMonograph(achievementsMonograph);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return res;    }

    /**
     * 删除成果专著
     */
    @PreAuthorize("@ss.hasPermi('monograph:monograph:remove')")
    @Log(title = "成果专著", businessType = BusinessType.DELETE)
	@DeleteMapping("/{monographIds}")
    public AjaxResult remove(@PathVariable Long[] monographIds)
    {
        AjaxResult res = new AjaxResult();
        // 使用Feign客户端调用远程服务
        DeleteRequest deleteRequest = new DeleteRequest(getUserId(), getDeptId(), monographIds);
        try {
            res = contestFeignClient.deleteMonographs(deleteRequest);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return res;    }
}
