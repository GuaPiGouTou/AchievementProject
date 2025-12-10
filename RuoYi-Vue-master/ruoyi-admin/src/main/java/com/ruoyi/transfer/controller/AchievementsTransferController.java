package com.ruoyi.transfer.controller;

import java.util.List;
import javax.servlet.http.HttpServletResponse;

import com.ruoyi.ContestFeign.ContestFeignClient;
import com.ruoyi.ContestFeign.DeleteRequest;
import com.ruoyi.attachment.domain.ExportRequestDTO;
import com.ruoyi.common.utils.ServletUtils;
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
    @Autowired
    private ContestFeignClient contestFeignClient;
    /**
     * 查询成果转化列表
     */
    @PreAuthorize("@ss.hasPermi('transfer:transfer:list')")
    @GetMapping("/list")
    public AjaxResult list(AchievementsTransfer achievementsTransfer)
    {
        Integer pageNum = ServletUtils.getParameterToInt("pageNum");
        Integer pageSize = ServletUtils.getParameterToInt("pageSize");
        AjaxResult res = new AjaxResult();
        // 使用Feign客户端调用远程服务
        try {
            res = contestFeignClient.selectTransferList(getUserId(), getDeptId(), pageNum, pageSize);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return res;
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
        AjaxResult res = new AjaxResult();
        // 使用Feign客户端调用远程服务
        try {
            res = contestFeignClient.selectTransferById(getUserId(),getDeptId(),transferId);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return res;    }

    /**
     * 新增成果转化
     */
    @PreAuthorize("@ss.hasPermi('transfer:transfer:add')")
    @Log(title = "成果转化", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody AchievementsTransfer achievementsTransfer)
    {
        AjaxResult res = new AjaxResult();
        // 使用Feign客户端调用远程服务
        try {
            achievementsTransfer.setUserId(getUserId());
            achievementsTransfer.setDeptId(getDeptId());

            System.out.println(achievementsTransfer);
            res = contestFeignClient.insertTransfer(achievementsTransfer);

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return res;    }

    /**
     * 修改成果转化
     */
    @PreAuthorize("@ss.hasPermi('transfer:transfer:edit')")
    @Log(title = "成果转化", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody AchievementsTransfer achievementsTransfer)
    {
        AjaxResult res = new AjaxResult();
        // 使用Feign客户端调用远程服务
        try {
            achievementsTransfer.setUserId(getUserId());
            achievementsTransfer.setDeptId(getDeptId());

            res = contestFeignClient.updateTransfer(achievementsTransfer);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return res;    }

    /**
     * 删除成果转化
     */
    @PreAuthorize("@ss.hasPermi('transfer:transfer:remove')")
    @Log(title = "成果转化", businessType = BusinessType.DELETE)
	@DeleteMapping("/{transferIds}")
    public AjaxResult remove(@PathVariable Long[] transferIds)
    {
        AjaxResult res = new AjaxResult();
        // 使用Feign客户端调用远程服务
        DeleteRequest deleteRequest = new DeleteRequest(getUserId(),getDeptId(),transferIds);
        try {
            res = contestFeignClient.deleteTransfers(deleteRequest);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return res;    }
}
