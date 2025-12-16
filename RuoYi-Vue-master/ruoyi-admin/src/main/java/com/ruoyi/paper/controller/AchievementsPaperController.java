package com.ruoyi.paper.controller;

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
import org.springframework.web.bind.annotation.*;
import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.paper.domain.AchievementsPaper;
import com.ruoyi.paper.service.IAchievementsPaperService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 论文成果Controller
 * 
 * @author xixia
 * @date 2025-11-26
 */
@RestController
@RequestMapping("/paper/paper")
public class AchievementsPaperController extends BaseController
{
    @Autowired
    private IAchievementsPaperService achievementsPaperService;
    @Autowired
    private ContestFeignClient contestFeignClient;
    /**
     * 查询论文成果列表
     */
    @PreAuthorize("@ss.hasPermi('paper:paper:list')")
    @GetMapping("/list")
    public AjaxResult list(AchievementsPaper achievementsPaper)
    {
        Integer pageNum = ServletUtils.getParameterToInt("pageNum");
        Integer pageSize = ServletUtils.getParameterToInt("pageSize");
        AjaxResult res = new AjaxResult();
        // 使用Feign客户端调用远程服务
        try {
            res = contestFeignClient.getPaperList(getUserId(), getDeptId(), pageNum, pageSize);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return res;
    }


    /**
     * 导出论文成果列表
     */
    @PreAuthorize("@ss.hasPermi('paper:paper:export')")
    @Log(title = "论文成果", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public AjaxResult export(HttpServletResponse response, @RequestBody ExportRequestDTO<AchievementsPaper> exportRequestDTO)
    {
        // 1. 获取参数
        List<String> hiddenColumns = exportRequestDTO.getShowColumns();
        Long[] ids = exportRequestDTO.getIdList();
        System.out.println(exportRequestDTO);
        // 2. 构造请求 (使用上面修改后的 IdsRequest)
        IdsRequest idsRequest = new IdsRequest(getUserId(), getDeptId(), ids);

        // 3. Feign 调用
        AjaxResult result = contestFeignClient.selectPaperByIds(idsRequest);
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
        List<AchievementsPaper> list = com.alibaba.fastjson2.JSON.parseArray(jsonString, AchievementsPaper.class);

        // 6. 导出 Excel
        ExcelUtil<AchievementsPaper> util = new ExcelUtil<>(AchievementsPaper.class);
        if (hiddenColumns != null && !hiddenColumns.isEmpty()) {
            util.showColumn(hiddenColumns.toArray(new String[0]));
        }

        // 执行导出
        util.exportExcel(response, list, "论文成果数据");

        //返回 success
        return null;
    }

    /**
     * 获取论文成果详细信息
     */
    @PreAuthorize("@ss.hasPermi('paper:paper:query')")
    @GetMapping(value = "/{paperId}")
    public AjaxResult getInfo(@PathVariable("paperId") Long paperId)
    {
        AjaxResult res = new AjaxResult();
        // 使用Feign客户端调用远程服务
        try {
            res = contestFeignClient.getPaperById(getUserId(),getDeptId(),paperId);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return res;    }

    /**
     * 新增论文成果
     */
    @PreAuthorize("@ss.hasPermi('paper:paper:add')")
    @Log(title = "论文成果", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody AchievementsPaper achievementsPaper)
    {
        AjaxResult res = new AjaxResult();
        // 使用Feign客户端调用远程服务
        try {
            achievementsPaper.setUserId(getUserId());
            achievementsPaper.setDeptId(getDeptId());

            System.out.println(achievementsPaper);
            res = contestFeignClient.insertPaper(achievementsPaper);

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return res;
    }

    /**
     * 修改论文成果
     */
    @PreAuthorize("@ss.hasPermi('paper:paper:edit')")
    @Log(title = "论文成果", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody AchievementsPaper achievementsPaper)
    {
        AjaxResult res = new AjaxResult();
        // 使用Feign客户端调用远程服务
        try {
            achievementsPaper.setUserId(getUserId());
            achievementsPaper.setDeptId(getDeptId());

            res = contestFeignClient.updatePaper(achievementsPaper);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return res;
    }

    /**
     * 删除论文成果
     */
    @PreAuthorize("@ss.hasPermi('paper:paper:remove')")
    @Log(title = "论文成果", businessType = BusinessType.DELETE)
	@DeleteMapping("/{paperIds}")
    public AjaxResult remove(@PathVariable Long[] paperIds)
    {
        for (int i = 0; i < paperIds.length; i++) {
            System.out.println(paperIds[i]);
        }
        AjaxResult res = new AjaxResult();
        // 使用Feign客户端调用远程服务
        DeleteRequest deleteRequest = new DeleteRequest(getUserId(),getDeptId(),paperIds);
        try {
            res = contestFeignClient.deletePapers(deleteRequest);
            System.out.println(res);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return res;    }
}
