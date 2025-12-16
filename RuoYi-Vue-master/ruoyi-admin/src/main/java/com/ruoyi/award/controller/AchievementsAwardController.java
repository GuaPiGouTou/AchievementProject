package com.ruoyi.award.controller;

import java.util.List;
import javax.servlet.http.HttpServletResponse;

import com.ruoyi.ContestFeign.ContestFeignClient;
import com.ruoyi.ContestFeign.DeleteRequest;
import com.ruoyi.ContestFeign.IdsRequest;
import com.ruoyi.attachment.domain.ExportRequestDTO;
import com.ruoyi.common.utils.ServletUtils;
import com.ruoyi.competition.domain.AchievementsCompetition;
import com.ruoyi.textbook.domain.AchievementsTextbook;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.award.domain.AchievementsAward;
import com.ruoyi.award.service.IAchievementsAwardService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 获奖成果Controller
 * 
 * @author ruoyi
 * @date 2025-11-20
 */
@RestController
@RequestMapping("/award/award")
public class AchievementsAwardController extends BaseController
{
    @Autowired
    private IAchievementsAwardService achievementsAwardService;
    @Autowired
    private ContestFeignClient contestFeignClient;
    /**
     * 查询获奖成果列表
     */
    @PreAuthorize("@ss.hasPermi('award:award:list')")
    @GetMapping("/list")
    public AjaxResult list(AchievementsAward achievementsAward)
    {
        Integer pageNum = ServletUtils.getParameterToInt("pageNum");
        Integer pageSize = ServletUtils.getParameterToInt("pageSize");
        AjaxResult res = new AjaxResult();
        // 使用Feign客户端调用远程服务
        try {
            achievementsAward.setUserId(getUserId());
            achievementsAward.setDeptId(getDeptId());

            res = contestFeignClient.getAwardList(getUserId(), getDeptId(), pageNum, pageSize);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

        return res;
    }

    /**
     * 导出获奖成果列表
     */
    @PreAuthorize("@ss.hasPermi('award:award:export')")
    @Log(title = "获奖成果", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public AjaxResult export(HttpServletResponse response, @RequestBody ExportRequestDTO<AchievementsAward> exportRequestDTO)
    {
        // 1. 获取参数
        List<String> hiddenColumns = exportRequestDTO.getShowColumns();
        Long[] ids = exportRequestDTO.getIdList();

        // 2. 构造请求 (使用上面修改后的 IdsRequest)
        IdsRequest idsRequest = new IdsRequest(getUserId(), getDeptId(), ids);

        // 3. Feign 调用
        AjaxResult result = contestFeignClient.selectAwardByIds(idsRequest);

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
        List<AchievementsAward> list = com.alibaba.fastjson2.JSON.parseArray(jsonString, AchievementsAward.class);

        // 6. 导出 Excel
        ExcelUtil<AchievementsAward> util = new ExcelUtil<>(AchievementsAward.class);
        if (hiddenColumns != null && !hiddenColumns.isEmpty()) {
            util.showColumn(hiddenColumns.toArray(new String[0]));
        }

        // 执行导出
        util.exportExcel(response, list, "获奖成果数据");

        //返回 success
        return null;
    }

    /**
     * 获取获奖成果详细信息
     */
    @PreAuthorize("@ss.hasPermi('award:award:query')")
    @GetMapping(value = "/{awardId}")
    public AjaxResult getInfo(@PathVariable("awardId") Long awardId)
    {
        AjaxResult res = new AjaxResult();
        // 使用Feign客户端调用远程服务
        try {
            res = contestFeignClient.getAwardById(getUserId(),getDeptId(),awardId);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return res;
    }

    /**
     * 新增获奖成果
     */
    @PreAuthorize("@ss.hasPermi('award:award:add')")
    @Log(title = "获奖成果", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody AchievementsAward achievementsAward)
    {
        AjaxResult res = new AjaxResult();
        // 使用Feign客户端调用远程服务
        try {
            achievementsAward.setUserId(getUserId());
            achievementsAward.setDeptId(getDeptId());

            res = contestFeignClient.insertAward(achievementsAward);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return res;
    }

    /**
     * 修改获奖成果
     */
    @PreAuthorize("@ss.hasPermi('award:award:edit')")
    @Log(title = "获奖成果", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody AchievementsAward achievementsAward)
    {
        AjaxResult res = new AjaxResult();
        // 使用Feign客户端调用远程服务
        try {
            achievementsAward.setUserId(getUserId());
            achievementsAward.setDeptId(getDeptId());

            res = contestFeignClient.updateAward(achievementsAward);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return res;
    }

    /**
     * 删除获奖成果
     */
    @PreAuthorize("@ss.hasPermi('award:award:remove')")
    @Log(title = "获奖成果", businessType = BusinessType.DELETE)
	@DeleteMapping("/{awardIds}")
    public AjaxResult remove(@PathVariable Long[] awardIds)
    {
        for (int i = 0; i < awardIds.length; i++) {
            System.out.println(awardIds[i]);
        }
        AjaxResult res = new AjaxResult();
        // 使用Feign客户端调用远程服务
        DeleteRequest deleteRequest = new DeleteRequest(getUserId(),getDeptId(),awardIds);
        try {
            res = contestFeignClient.deleteAward(deleteRequest);
            System.out.println(res);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return res;
    }
}
