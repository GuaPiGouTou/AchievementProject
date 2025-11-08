package com.ruoyi.attachment.controller;

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
import com.ruoyi.attachment.domain.AchievementsAttachment;
import com.ruoyi.attachment.service.IAchievementsAttachmentService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 成果附件Controller
 * 
 * @author xixia
 * @date 2025-11-08
 */
@RestController
@RequestMapping("/attachment/attachment")
public class AchievementsAttachmentController extends BaseController
{
    @Autowired
    private IAchievementsAttachmentService achievementsAttachmentService;

    /**
     * 查询成果附件列表
     */
    @PreAuthorize("@ss.hasPermi('attachment:attachment:list')")
    @GetMapping("/list")
    public TableDataInfo list(AchievementsAttachment achievementsAttachment)
    {
        startPage();
        List<AchievementsAttachment> list = achievementsAttachmentService.selectAchievementsAttachmentList(achievementsAttachment);
        return getDataTable(list);
    }

    /**
     * 导出成果附件列表
     */
    @PreAuthorize("@ss.hasPermi('attachment:attachment:export')")
    @Log(title = "成果附件", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, AchievementsAttachment achievementsAttachment)
    {
        List<AchievementsAttachment> list = achievementsAttachmentService.selectAchievementsAttachmentList(achievementsAttachment);
        ExcelUtil<AchievementsAttachment> util = new ExcelUtil<AchievementsAttachment>(AchievementsAttachment.class);
        util.exportExcel(response, list, "成果附件数据");
    }

    /**
     * 获取成果附件详细信息
     */
    @PreAuthorize("@ss.hasPermi('attachment:attachment:query')")
    @GetMapping(value = "/{attachmentId}")
    public AjaxResult getInfo(@PathVariable("attachmentId") Long attachmentId)
    {
        return success(achievementsAttachmentService.selectAchievementsAttachmentByAttachmentId(attachmentId));
    }

    /**
     * 获取成果附件详细信息
     */
    @PreAuthorize("@ss.hasPermi('attachment:attachment:query')")
    @GetMapping(value = "/{user_id}/{attachment_type}")
    public AjaxResult getInfoByIdandType(@PathVariable("user_id") Long user_id, @PathVariable("attachment_type") String attachment_type)
    {
        return success(achievementsAttachmentService.selectAchievementsAttachmentByAttachmentId(user_id));

    }

    /**
     * 新增成果附件
     */
    @PreAuthorize("@ss.hasPermi('attachment:attachment:add')")
    @Log(title = "成果附件", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody AchievementsAttachment achievementsAttachment)
    {
        return toAjax(achievementsAttachmentService.insertAchievementsAttachment(achievementsAttachment));
    }

    /**
     * 修改成果附件
     */
    @PreAuthorize("@ss.hasPermi('attachment:attachment:edit')")
    @Log(title = "成果附件", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody AchievementsAttachment achievementsAttachment)
    {
        return toAjax(achievementsAttachmentService.updateAchievementsAttachment(achievementsAttachment));
    }

    /**
     * 删除成果附件
     */
    @PreAuthorize("@ss.hasPermi('attachment:attachment:remove')")
    @Log(title = "成果附件", businessType = BusinessType.DELETE)
	@DeleteMapping("/{attachmentIds}")
    public AjaxResult remove(@PathVariable Long[] attachmentIds)
    {
        return toAjax(achievementsAttachmentService.deleteAchievementsAttachmentByAttachmentIds(attachmentIds));
    }
}
