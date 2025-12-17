package com.ruoyi.transfer.controller;

import java.util.List;
import javax.servlet.http.HttpServletResponse;

import com.ruoyi.ContestFeign.ContestFeignClient;
import com.ruoyi.ContestFeign.DeleteRequest;
import com.ruoyi.ContestFeign.IdsRequest;
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
    public AjaxResult export(HttpServletResponse response, @RequestBody ExportRequestDTO<AchievementsTransfer> exportRequestDTO)
    {
        // 1. 获取参数
        List<String> hiddenColumns = exportRequestDTO.getShowColumns();
        Long[] ids = exportRequestDTO.getIdList();

        // 2. 构造请求
        IdsRequest idsRequest = new IdsRequest(getUserId(), getDeptId(), ids);

        // 3. Feign 调用
        AjaxResult result = contestFeignClient.selectTransferByIds(idsRequest);

        // 4. 判断 total (处理 null 和 类型转换)
        Object totalObj = result.get("total");
        int total = (totalObj == null) ? 0 : Integer.parseInt(totalObj.toString());

        if (total == 0) {
            return AjaxResult.warn("未查询到数据");
        }

        // 5. 转换 List (从 LinkedHashMap 转为 实体对象)
        Object rows = result.get("rows");
        // 利用 FastJson 或 Jackson 进行 "序列化再反序列化" 来转换对象
        String jsonString = com.alibaba.fastjson2.JSON.toJSONString(rows);
        List<AchievementsTransfer> list = com.alibaba.fastjson2.JSON.parseArray(jsonString, AchievementsTransfer.class);

        // 6. 导出 Excel
        ExcelUtil<AchievementsTransfer> util = new ExcelUtil<>(AchievementsTransfer.class);
        if (hiddenColumns != null && !hiddenColumns.isEmpty()) {
            util.showColumn(hiddenColumns.toArray(new String[0]));
        }

        // 执行导出
        util.exportExcel(response, list, "转化成果数据");

        //返回 success
        return null;
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
