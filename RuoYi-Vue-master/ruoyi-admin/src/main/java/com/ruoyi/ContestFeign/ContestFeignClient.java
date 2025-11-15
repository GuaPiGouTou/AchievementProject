package com.ruoyi.ContestFeign;

import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.competition.domain.AchievementsCompetition;
import com.ruoyi.competition.domain.demo;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@FeignClient(value = "gateway-service", url = "http://172.16.46.77:1234") // 使用服务名，如果直接调用可用url属性指定完整URL
public interface ContestFeignClient {
    /**
     * 查询竞赛列表
     */
    @GetMapping("/api/selectContestList")
    AjaxResult getContestList(
            @RequestParam("userId") Long userId,
            @RequestParam("deptId") Long deptId,
            @RequestParam("pageNum") Integer pageNum,
            @RequestParam("pageSize") Integer pageSize
        );

    /**
     * 查询竞赛记录详细信息
     */
    @GetMapping("/api/selectContestById")
    AjaxResult getContestById(
            @RequestParam("userId") Long userId,
            @RequestParam("deptId") Long deptId,
            @RequestParam("competitionId") Long competitionId
    );

    /**
     * 新增竞赛成果
     */
    @PostMapping("/api/insertContest")
    AjaxResult insertContest(@RequestBody AchievementsCompetition achievementsCompetition);

    /**
     * 更新竞赛记录
     */
    @PostMapping("/api/updateContest")
    AjaxResult updateContest(@RequestBody AchievementsCompetition achievementsCompetition);

    /**
     * 删除竞赛记录
     */
    @PostMapping("/api/deleteContests")
    AjaxResult deleteContests( @RequestParam("userId") Long userId,
                               @RequestParam("deptId") Long deptId,
                               @RequestParam("competitionIds") List<Long> competitionIds);
}
