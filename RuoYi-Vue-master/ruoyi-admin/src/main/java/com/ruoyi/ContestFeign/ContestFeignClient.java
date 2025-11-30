package com.ruoyi.ContestFeign;

import com.ruoyi.award.domain.AchievementsAward;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.competition.domain.AchievementsCompetition;
import com.ruoyi.competition.domain.demo;
import com.ruoyi.textbook.domain.AchievementsTextbook;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@FeignClient(value = "gateway-service", url = "http://172.16.46.77:1234")
//@FeignClient(value = "gateway-service", url = "http://localhost:1234")
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
    AjaxResult deleteContests( @RequestBody DeleteRequest request);
//    ---------------------------------------------------------------------------------
    /**
     * 查询教材列表
     */
    @GetMapping("/api/selectTextbookList")
    AjaxResult getTextbookList(
            @RequestParam("userId") Long userId,
            @RequestParam("deptId") Long deptId,
            @RequestParam("pageNum") Integer pageNum,
            @RequestParam("pageSize") Integer pageSize
        );

    /**
     * 查询教材记录详细信息
     */
    @GetMapping("/api/selectTextbookById")
    AjaxResult getTextbookById(
            @RequestParam("userId") Long userId,
            @RequestParam("deptId") Long deptId,
            @RequestParam("textbookId") Long textbookId
    );

    /**
     * 新增教材成果
     */
    @PostMapping("/api/insertTextbook")
    AjaxResult insertTextbook(@RequestBody AchievementsTextbook achievementsTextbook);

    /**
     * 更新教材记录
     */
    @PostMapping("/api/updateTextbook")
    AjaxResult updateTextbook(@RequestBody AchievementsTextbook achievementsTextbook);

    /**
     * 删除竞赛记录
     */
    @PostMapping("/api/deleteTextbooks")
    AjaxResult deleteTextbooks( @RequestParam("userId") Long userId,
                               @RequestParam("deptId") Long deptId,
                               @RequestParam("textbookIds") Long[] textbookIds);
//    ---------------------------------------------------------------------------------
    /**
     * 查询教材列表
     */
    @GetMapping("/api/selectAwardkList")
    AjaxResult getAwardList(
            @RequestParam("userId") Long userId,
            @RequestParam("deptId") Long deptId,
            @RequestParam("pageNum") Integer pageNum,
            @RequestParam("pageSize") Integer pageSize
        );

    /**
     * 查询教材记录详细信息
     */
    @GetMapping("/api/selectAwardById")
    AjaxResult getAwardById(
            @RequestParam("userId") Long userId,
            @RequestParam("deptId") Long deptId,
            @RequestParam("awardId") Long textbookId
    );

    /**
     * 新增教材成果
     */
    @PostMapping("/api/insertAward")
    AjaxResult insertAward(@RequestBody AchievementsAward achievementsAward);

    /**
     * 更新教材记录
     */
    @PostMapping("/api/updateTextbook")
    AjaxResult updateAward(@RequestBody  AchievementsAward achievementsAward);

    /**
     * 删除竞赛记录
     */
    @PostMapping("/api/deleteAwardIds")
    AjaxResult deleteAward( @RequestParam("userId") Long userId,
                               @RequestParam("deptId") Long deptId,
                               @RequestParam("awardId") Long[] textbookIds);
//    ---------------------------------------------------------------------------------
}
