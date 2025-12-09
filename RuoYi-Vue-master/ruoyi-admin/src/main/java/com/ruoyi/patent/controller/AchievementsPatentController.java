package com.ruoyi.patent.controller;

import java.util.List;
import javax.servlet.http.HttpServletResponse;

import com.ruoyi.attachment.domain.ExportRequestDTO;
import com.ruoyi.paper.domain.AchievementsPaper;
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
    @Autowired
    private IAchievementsPatentService achievementsPatentService;

    /**
     * 查询专利成果列表
     */
    @PreAuthorize("@ss.hasPermi('patent:patent:list')")
    @GetMapping("/list")
    public TableDataInfo list(AchievementsPatent achievementsPatent)
    {
        startPage();
        List<AchievementsPatent> list = achievementsPatentService.selectAchievementsPatentList(achievementsPatent);
        return getDataTable(list);
    }

    /**
     * 导出专利成果列表
     */
    @PreAuthorize("@ss.hasPermi('patent:patent:export')")
    @Log(title = "专利成果", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, @RequestBody ExportRequestDTO<AchievementsPatent> exportRequestDTO)
    {
        List<String> showColumns = exportRequestDTO.getShowColumns();
        AchievementsPatent achievementsPatent = exportRequestDTO.getData();
        achievementsPatent.setUserId(getUserId());
        achievementsPatent.setDeptId(getDeptId());
        List<AchievementsPatent> list =achievementsPatentService.selectAchievementsPatentList(achievementsPatent);
        ExcelUtil<AchievementsPatent> util = new ExcelUtil<AchievementsPatent>(AchievementsPatent.class);
        if(showColumns != null && !showColumns.isEmpty())
        {
            util.showColumn(showColumns.toArray(new String[0]));
        }
        util.exportExcel(response, list, "专利成果数据");
    }

    /**
     * 获取专利成果详细信息
     */
    @PreAuthorize("@ss.hasPermi('patent:patent:query')")
    @GetMapping(value = "/{patentId}")
    public AjaxResult getInfo(@PathVariable("patentId") Long patentId)
    {
        return success(achievementsPatentService.selectAchievementsPatentByPatentId(patentId));
    }

    /**
     * 新增专利成果
     */
    @PreAuthorize("@ss.hasPermi('patent:patent:add')")
    @Log(title = "专利成果", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody AchievementsPatent achievementsPatent)
    {
        return toAjax(achievementsPatentService.insertAchievementsPatent(achievementsPatent));
    }

    /**
     * 修改专利成果
     */
    @PreAuthorize("@ss.hasPermi('patent:patent:edit')")
    @Log(title = "专利成果", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody AchievementsPatent achievementsPatent)
    {
        return toAjax(achievementsPatentService.updateAchievementsPatent(achievementsPatent));
    }

    /**
     * 删除专利成果
     */
    @PreAuthorize("@ss.hasPermi('patent:patent:remove')")
    @Log(title = "专利成果", businessType = BusinessType.DELETE)
	@DeleteMapping("/{patentIds}")
    public AjaxResult remove(@PathVariable Long[] patentIds)
    {
        return toAjax(achievementsPatentService.deleteAchievementsPatentByPatentIds(patentIds));
    }
}
