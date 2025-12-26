package com.ruoyi.research.controller;

import java.util.List;
import javax.servlet.http.HttpServletResponse;

import com.ruoyi.ContestFeign.ContestFeignClient;
import com.ruoyi.ContestFeign.DeleteRequest;
import com.ruoyi.ContestFeign.IdsRequest;
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
import com.ruoyi.research.domain.AchievementsResearch;
import com.ruoyi.research.service.IAchievementsResearchService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 项目成果Controller
 * 
 * @author xixia
 * @date 2025-12-16
 */
@RestController
@RequestMapping("/research/research")
public class AchievementsResearchController extends BaseController
{
    @Autowired
    private IAchievementsResearchService achievementsResearchService;
    @Autowired
    private ContestFeignClient contestFeignClient;
    /**
     * 查询项目成果列表
     */
    @PreAuthorize("@ss.hasPermi('research:research:list')")
    @GetMapping("/list")
    public AjaxResult list(AchievementsResearch achievementsResearch)
    {
        Integer pageNum = ServletUtils.getParameterToInt("pageNum");
        Integer pageSize = ServletUtils.getParameterToInt("pageSize");
        AjaxResult res = new AjaxResult();
        // 使用Feign客户端调用远程服务
        try {
            res = contestFeignClient.selectResearchList(getUserId(), getDeptId(), pageNum, pageSize);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return res;
    }

    /**
     * 导出项目成果列表
     */
    @PreAuthorize("@ss.hasPermi('research:research:export')")
    @Log(title = "项目成果", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public AjaxResult export(HttpServletResponse response, @RequestBody ExportRequestDTO<AchievementsResearch> exportRequestDTO)
    {
        System.out.println("exportRequestDTO");
        System.out.println(exportRequestDTO);
        // 1. 获取参数
        List<String> hiddenColumns = exportRequestDTO.getShowColumns();
        Long[] ids = exportRequestDTO.getIdList();

        // 2. 构造请求 (使用上面修改后的 IdsRequest)
        IdsRequest idsRequest = new IdsRequest(getUserId(), getDeptId(), ids);

        // 3. Feign 调用
        AjaxResult result = contestFeignClient.selectResearchByIds(idsRequest);
        System.out.println(result);
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
        List<AchievementsResearch> list = com.alibaba.fastjson2.JSON.parseArray(jsonString, AchievementsResearch.class);

        // 6. 导出 Excel
        ExcelUtil<AchievementsResearch> util = new ExcelUtil<>(AchievementsResearch.class);
        if (hiddenColumns != null && !hiddenColumns.isEmpty()) {
            util.showColumn(hiddenColumns.toArray(new String[0]));
        }

        // 执行导出
        util.exportExcel(response, list, "研究成果数据");

        //返回 success
        return null;
    }

    /**
     * 获取项目成果详细信息
     */
    @PreAuthorize("@ss.hasPermi('research:research:query')")
    @GetMapping(value = "/{researchId}")
    public AjaxResult getInfo(@PathVariable("researchId") Long researchId)
    {
        AjaxResult res = new AjaxResult();
        // 使用Feign客户端调用远程服务
        try {
            res = contestFeignClient.selectResearchById(getUserId(),getDeptId(),researchId);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return res;
    }

    /**
     * 新增项目成果
     */
    @PreAuthorize("@ss.hasPermi('research:research:add')")
    @Log(title = "项目成果", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody AchievementsResearch achievementsResearch)
    {
        AjaxResult res = new AjaxResult();
        // 使用Feign客户端调用远程服务
        try {
            achievementsResearch.setUserId(getUserId());
            achievementsResearch.setDeptId(getDeptId());
            res = contestFeignClient.insertResearch(achievementsResearch);

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return res;
    }
    /**
     * 修改项目成果
     */
    @PreAuthorize("@ss.hasPermi('research:research:edit')")
    @Log(title = "项目成果", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody AchievementsResearch achievementsResearch)
    {
        AjaxResult res = new AjaxResult();
        // 使用Feign客户端调用远程服务
        try {
            achievementsResearch.setUserId(getUserId());
            achievementsResearch.setDeptId(getDeptId());

            res = contestFeignClient.updateResearch(achievementsResearch);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return res;
    }

    /**
     * 删除项目成果
     */
    @PreAuthorize("@ss.hasPermi('research:research:remove')")
    @Log(title = "项目成果", businessType = BusinessType.DELETE)
	@DeleteMapping("/{researchIds}")
    public AjaxResult remove(@PathVariable Long[] researchIds)
    {
        AjaxResult res = new AjaxResult();
        // 使用Feign客户端调用远程服务
        DeleteRequest deleteRequest = new DeleteRequest(getUserId(),getDeptId(),researchIds);
        try {
            res = contestFeignClient.deleteResearchId(deleteRequest);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return res;
    }
}
