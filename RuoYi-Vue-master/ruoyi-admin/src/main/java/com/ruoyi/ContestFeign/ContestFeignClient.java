package com.ruoyi.ContestFeign;

import com.ruoyi.attachment.domain.AchievementsAttachment;
import com.ruoyi.award.domain.AchievementsAward;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.competition.domain.AchievementsCompetition;
import com.ruoyi.competition.domain.demo;
import com.ruoyi.paper.domain.AchievementsPaper;
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
     * 删除教材记录
     */
    @PostMapping("/api/deleteTextbooks")
    AjaxResult deleteTextbooks(@RequestBody DeleteRequest request);
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
     * 删除获奖记录
     */
    @PostMapping("/api/deleteAwardIds")
    AjaxResult deleteAward( @RequestBody DeleteRequest request);
//    ---------------------------------------------------------------------------------
    /**
     * 查询论文列表
     */
    @GetMapping("/api/selectPaperList")
    AjaxResult getPaperList(
            @RequestParam("userId") Long userId,
            @RequestParam("deptId") Long deptId,
            @RequestParam("pageNum") Integer pageNum,
            @RequestParam("pageSize") Integer pageSize
    );

    /**
     * 查询论文记录详细信息
     */
    @GetMapping("/api/selectPaperById")
    AjaxResult getPaperById(
            @RequestParam("userId") Long userId,
            @RequestParam("deptId") Long deptId,
            @RequestParam("competitionId") Long competitionId
    );

    /**
     * 新增论文成果
     */
    @PostMapping("/api/insertPaper")
    AjaxResult insertPaper(@RequestBody AchievementsPaper achievementsPaper);

    /**
     * 更新论文记录
     */
    @PostMapping("/api/updatePaper")
    AjaxResult updatePaper(@RequestBody AchievementsPaper achievementsPaper);


    /**
     * 删除论文记录
     */
    @PostMapping("/api/deletePapers")
    AjaxResult deletePapers( @RequestBody DeleteRequest request);
//    ---------------------------------------------------------------------------------//    ---------------------------------------------------------------------------------
    /**
     * 查询附件列表
     */
    @GetMapping("/api/selectAttachmentList")
    AjaxResult selectAttachmentList(
            @RequestParam("userId") Long userId,
            @RequestParam("deptId") Long deptId,
            @RequestParam("pageNum") Integer pageNum,
            @RequestParam("pageSize") Integer pageSize
    );

    /**
     * 查询附件记录详细信息
     */
    @GetMapping("/api/selectAttachmentById")
    AjaxResult selectAttachmentById(
            @RequestParam("userId") Long userId,
            @RequestParam("deptId") Long deptId,
            @RequestParam("competitionId") Long competitionId
    );

    /**
     * 新增附件记录
     */
    @PostMapping("/api/insertAttachment")
    AjaxResult insertAttachment(@RequestBody AchievementsAttachment AchievementsAttachment);

    /**
     * 更新附件记录
     */
    @PostMapping("/api/updateAttachment")
    AjaxResult updateAttachment(@RequestBody AchievementsAttachment AchievementsAttachment);


    /**
     * 删除附件记录
     */
    @PostMapping("/api/deleteAttachments")
    AjaxResult deleteAttachments( @RequestBody DeleteRequest request);
//    ---------------------------------------------------------------------------------
}
