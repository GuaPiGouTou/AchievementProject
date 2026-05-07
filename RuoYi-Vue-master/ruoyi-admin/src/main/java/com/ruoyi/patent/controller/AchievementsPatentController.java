package com.ruoyi.patent.controller;

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
import com.ruoyi.patent.domain.AchievementsPatent;
import com.ruoyi.patent.service.IAchievementsPatentService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;
import org.apache.commons.lang3.StringUtils;

/**
 * 专利成果Controller
 * 
 * @author xixia
 * @date 2025-12-09
 */
@RestController
@RequestMapping("/patent/patent")
public class AchievementsPatentController extends BaseController
{
    private static final String[] VALID_PATENT_STATUSES = {"申请中", "公开状态", "实质审查", "已授权", "已转让", "已失效"};

    @Autowired
    private IAchievementsPatentService achievementsPatentService;
    @Autowired
    private ContestFeignClient contestFeignClient;
    /**
     * 查询专利成果列表
     */
    @PreAuthorize("@ss.hasPermi('patent:patent:list')")
    @GetMapping("/list")
    public AjaxResult list(AchievementsPatent achievementsPatent)
    {
        AchievementDataScopeUtils.applyAchievementListScope(achievementsPatent, "patent:patent");
        startPage();
        List<AchievementsPatent> list = achievementsPatentService.selectAchievementsPatentList(achievementsPatent);
        TableDataInfo tableData = getDataTable(list);
        AjaxResult res = AjaxResult.success();
        res.put("rows", tableData.getRows());
        res.put("total", tableData.getTotal());
        return res;
    }

    /**
     * 导出专利成果列表
     */
    @PreAuthorize("@ss.hasPermi('patent:patent:export')")
    @Log(title = "专利成果", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public AjaxResult export(HttpServletResponse response, @RequestBody ExportRequestDTO<AchievementsPatent> exportRequestDTO)
    {
        // 1. 获取参数
        List<String> hiddenColumns = exportRequestDTO.getShowColumns();
        Long[] ids = exportRequestDTO.getIdList();
        AchievementsPatent query = exportRequestDTO.getData() == null ? new AchievementsPatent() : exportRequestDTO.getData();
        AchievementDataScopeUtils.applyAchievementListScope(query, "patent:patent");
        List<AchievementsPatent> list = achievementsPatentService.selectAchievementsPatentList(query);
        list = AchievementDataScopeUtils.filterByIds(list, ids, "getPatentId");

        if (list == null || list.isEmpty()) {
            return AjaxResult.warn("未查询到数据");
        }

        // 6. 导出 Excel
        ExcelUtil<AchievementsPatent> util = new ExcelUtil<>(AchievementsPatent.class);
        if (hiddenColumns != null && !hiddenColumns.isEmpty()) {
            util.showColumn(hiddenColumns.toArray(new String[0]));
        }

        // 执行导出
        util.exportExcel(response, list, "专利成果数据");

        //返回 success
        return null;
    }

    /**
     * 获取专利成果详细信息
     */
    @PreAuthorize("@ss.hasPermi('patent:patent:query')")
    @GetMapping(value = "/{patentId}")
    public AjaxResult getInfo(@PathVariable("patentId") Long patentId)
    {
        AchievementsPatent achievementsPatent = achievementsPatentService.selectAchievementsPatentByPatentId(patentId);
        if (!AchievementDataScopeUtils.canAccessAchievementRecord(achievementsPatent, "patent:patent")) {
            return AjaxResult.error("无权限访问该数据");
        }
        return AjaxResult.success(achievementsPatent);
    }

    /**
     * 新增专利成果
     */
    @PreAuthorize("@ss.hasPermi('patent:patent:add')")
    @Log(title = "专利成果", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody AchievementsPatent achievementsPatent)
    {
        AjaxResult validationResult = validatePatentStatus(achievementsPatent, true);
        if (validationResult != null) {
            return validationResult;
        }
        AjaxResult res = new AjaxResult();
        // 使用Feign客户端调用远程服务
        try {
            achievementsPatent.setUserId(getUserId());
            achievementsPatent.setDeptId(getDeptId());
            achievementsPatent.setLegalStatus(null);

            System.out.println(achievementsPatent);
            res = contestFeignClient.insertPatent(achievementsPatent);

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return res;    }

    /**
     * 修改专利成果
     */
    @PreAuthorize("@ss.hasPermi('patent:patent:edit')")
    @Log(title = "专利成果", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody AchievementsPatent achievementsPatent)
    {
        AjaxResult validationResult = validatePatentStatus(achievementsPatent, false);
        if (validationResult != null) {
            return validationResult;
        }
        achievementsPatent.setUserId(null);
        achievementsPatent.setDeptId(null);
        achievementsPatent.setLegalStatus(null);
        achievementsPatent.setCreatedAt(null);
        achievementsPatent.setUpdatedAt(null);
        int rows = achievementsPatentService.updateAchievementsPatent(achievementsPatent);
        if (rows > 0) {
            AjaxResult result = AjaxResult.success("修改成功");
            result.put("patentId", achievementsPatent.getPatentId());
            return result;
        }
        return AjaxResult.error("修改失败");
    }

    /**
     * 删除专利成果
     */
    @PreAuthorize("@ss.hasPermi('patent:patent:remove')")
    @Log(title = "专利成果", businessType = BusinessType.DELETE)
	@DeleteMapping("/{patentIds}")
    public AjaxResult remove(@PathVariable Long[] patentIds)
    {
        AjaxResult res = new AjaxResult();
        // 使用Feign客户端调用远程服务
        DeleteRequest deleteRequest = new DeleteRequest(getUserId(),getDeptId(),patentIds);
        try {
            res = contestFeignClient.deletePatents(deleteRequest);
            System.out.println(res);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return res;    }

    private AjaxResult validatePatentStatus(AchievementsPatent achievementsPatent, boolean required)
    {
        String patentStatus = achievementsPatent.getPatentStatus();
        if (StringUtils.isBlank(patentStatus)) {
            return required ? AjaxResult.error("专利状态不能为空") : null;
        }
        for (String validPatentStatus : VALID_PATENT_STATUSES) {
            if (validPatentStatus.equals(patentStatus)) {
                return null;
            }
        }
        return AjaxResult.error("专利状态只能选择申请中、公开状态、实质审查、已授权、已转让或已失效");
    }
}
