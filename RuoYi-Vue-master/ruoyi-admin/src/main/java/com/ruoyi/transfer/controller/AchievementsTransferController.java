package com.ruoyi.transfer.controller;

import java.util.List;
import javax.servlet.http.HttpServletResponse;

import com.ruoyi.attachment.domain.ExportRequestDTO;
import com.ruoyi.patent.domain.AchievementsPatent;
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
import com.ruoyi.transfer.domain.AchievementsTransfer;
import com.ruoyi.transfer.service.IAchievementsTransferService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 成果转化Controller
 * 
 * @author xixia
 * @date 2025-12-09
 */
@RestController
@RequestMapping("/transfer/transfer")
public class AchievementsTransferController extends BaseController
{
    @Autowired
    private IAchievementsTransferService achievementsTransferService;

    /**
     * 查询成果转化列表
     */
    @PreAuthorize("@ss.hasPermi('transfer:transfer:list')")
    @GetMapping("/list")
    public TableDataInfo list(AchievementsTransfer achievementsTransfer)
    {
        startPage();
        List<AchievementsTransfer> list = achievementsTransferService.selectAchievementsTransferList(achievementsTransfer);
        return getDataTable(list);
    }

    /**
     * 导出成果转化列表
     */
    @PreAuthorize("@ss.hasPermi('transfer:transfer:export')")
    @Log(title = "成果转化", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, @RequestBody ExportRequestDTO<AchievementsTransfer> exportRequestDTO)
    {
        List<String> showColumns = exportRequestDTO.getShowColumns();
        AchievementsTransfer achievementsTransfer = exportRequestDTO.getData();
        achievementsTransfer.setUserId(getUserId());
        achievementsTransfer.setDeptId(getDeptId());
        List<AchievementsTransfer> list =achievementsTransferService.selectAchievementsTransferList(achievementsTransfer);
        ExcelUtil<AchievementsTransfer> util = new ExcelUtil<AchievementsTransfer>(AchievementsTransfer.class);
        if(showColumns != null && !showColumns.isEmpty())
        {
            util.showColumn(showColumns.toArray(new String[0]));
        }
        util.exportExcel(response, list, "成果转化数据");
    }

    /**
     * 获取成果转化详细信息
     */
    @PreAuthorize("@ss.hasPermi('transfer:transfer:query')")
    @GetMapping(value = "/{transferId}")
    public AjaxResult getInfo(@PathVariable("transferId") Long transferId)
    {
        return success(achievementsTransferService.selectAchievementsTransferByTransferId(transferId));
    }

    /**
     * 新增成果转化
     */
    @PreAuthorize("@ss.hasPermi('transfer:transfer:add')")
    @Log(title = "成果转化", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody AchievementsTransfer achievementsTransfer)
    {
        return toAjax(achievementsTransferService.insertAchievementsTransfer(achievementsTransfer));
    }

    /**
     * 修改成果转化
     */
    @PreAuthorize("@ss.hasPermi('transfer:transfer:edit')")
    @Log(title = "成果转化", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody AchievementsTransfer achievementsTransfer)
    {
        return toAjax(achievementsTransferService.updateAchievementsTransfer(achievementsTransfer));
    }

    /**
     * 删除成果转化
     */
    @PreAuthorize("@ss.hasPermi('transfer:transfer:remove')")
    @Log(title = "成果转化", businessType = BusinessType.DELETE)
	@DeleteMapping("/{transferIds}")
    public AjaxResult remove(@PathVariable Long[] transferIds)
    {
        return toAjax(achievementsTransferService.deleteAchievementsTransferByTransferIds(transferIds));
    }
}
