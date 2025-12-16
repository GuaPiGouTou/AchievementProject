package com.ruoyi.patent.controller;

import java.util.List;
import javax.servlet.http.HttpServletResponse;

import com.ruoyi.ContestFeign.ContestFeignClient;
import com.ruoyi.ContestFeign.DeleteRequest;
import com.ruoyi.ContestFeign.IdsRequest;
import com.ruoyi.attachment.domain.ExportRequestDTO;
import com.ruoyi.common.utils.ServletUtils;
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
    @Autowired
    private ContestFeignClient contestFeignClient;
    /**
     * 查询专利成果列表
     */
    @PreAuthorize("@ss.hasPermi('patent:patent:list')")
    @GetMapping("/list")
    public AjaxResult list(AchievementsPatent achievementsPatent)
    {
        Integer pageNum = ServletUtils.getParameterToInt("pageNum");
        Integer pageSize = ServletUtils.getParameterToInt("pageSize");
        AjaxResult res = new AjaxResult();
        // 使用Feign客户端调用远程服务
        try {
            res = contestFeignClient.selectPatentList(getUserId(), getDeptId(), pageNum, pageSize);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
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

        // 2. 构造请求 (使用上面修改后的 IdsRequest)
        IdsRequest idsRequest = new IdsRequest(getUserId(), getDeptId(), ids);

        // 3. Feign 调用
        AjaxResult result = contestFeignClient.selectPatentByIds(idsRequest);

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
        List<AchievementsPatent> list = com.alibaba.fastjson2.JSON.parseArray(jsonString, AchievementsPatent.class);

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
        AjaxResult res = new AjaxResult();
        // 使用Feign客户端调用远程服务
        try {
            res = contestFeignClient.selectPatentById(getUserId(),getDeptId(),patentId);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return res;    }

    /**
     * 新增专利成果
     */
    @PreAuthorize("@ss.hasPermi('patent:patent:add')")
    @Log(title = "专利成果", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody AchievementsPatent achievementsPatent)
    {
        AjaxResult res = new AjaxResult();
        // 使用Feign客户端调用远程服务
        try {
            achievementsPatent.setUserId(getUserId());
            achievementsPatent.setDeptId(getDeptId());

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
        AjaxResult res = new AjaxResult();
        // 使用Feign客户端调用远程服务
        try {
            achievementsPatent.setUserId(getUserId());
            achievementsPatent.setDeptId(getDeptId());

            res = contestFeignClient.updatePatent(achievementsPatent);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return res;    }

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
}
