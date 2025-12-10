package com.ruoyi.ContestFeign;

import com.ruoyi.attachment.domain.AchievementsAttachment;
import com.ruoyi.award.domain.AchievementsAward;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.competition.domain.AchievementsCompetition;
import com.ruoyi.competition.domain.demo;
import com.ruoyi.monograph.domain.AchievementsMonograph;
import com.ruoyi.paper.domain.AchievementsPaper;
import com.ruoyi.patent.domain.AchievementsPatent;
import com.ruoyi.software.domain.AchievementsSoftware;
import com.ruoyi.textbook.domain.AchievementsTextbook;
import com.ruoyi.transfer.domain.AchievementsTransfer;
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
     * 查询获奖列表
     */
    @GetMapping("/api/selectAwardkList")
    AjaxResult getAwardList(
            @RequestParam("userId") Long userId,
            @RequestParam("deptId") Long deptId,
            @RequestParam("pageNum") Integer pageNum,
            @RequestParam("pageSize") Integer pageSize
        );

    /**
     * 查询获奖记录详细信息
     */
    @GetMapping("/api/selectAwardById")
    AjaxResult getAwardById(
            @RequestParam("userId") Long userId,
            @RequestParam("deptId") Long deptId,
            @RequestParam("awardId") Long awardId
    );

    /**
     * 新增获奖成果
     */
    @PostMapping("/api/insertAward")
    AjaxResult insertAward(@RequestBody AchievementsAward achievementsAward);

    /**
     * 更新获奖记录
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
            @RequestParam("paperId") Long paperId
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
//    ---------------------------------------------------------------------------------

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
            @RequestParam("attachmentId") Long attachmentId
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
//    ---------------------------------------------------------------------------------//    ---------------------------------------------------------------------------------

    /**
     * 查询专著列表
     */
    @GetMapping("/api/selectMonographList")
    AjaxResult selectMonographList(
            @RequestParam("userId") Long userId,
            @RequestParam("deptId") Long deptId,
            @RequestParam("pageNum") Integer pageNum,
            @RequestParam("pageSize") Integer pageSize
    );

    /**
     * 查询专著记录详细信息
     */
    @GetMapping("/api/selectMonographById")
    AjaxResult selectMonographById(
            @RequestParam("userId") Long userId,
            @RequestParam("deptId") Long deptId,
            @RequestParam("monographId") Long monographId
    );

    /**
     * 新增专著记录
     */
    @PostMapping("/api/insertMonograph")
    AjaxResult insertMonograph(@RequestBody AchievementsMonograph achievementsMonograph);

    /**
     * 更新专著记录
     */
    @PostMapping("/api/updateMonograph")
    AjaxResult updateMonograph(@RequestBody AchievementsMonograph achievementsMonograph);


    /**
     * 删除专著记录
     */
    @PostMapping("/api/deleteMonographs")
    AjaxResult deleteMonographs( @RequestBody DeleteRequest request);
//    ---------------------------------------------------------------------------------//    ---------------------------------------------------------------------------------//    ---------------------------------------------------------------------------------

    /**
     * 查询软著列表
     */
    @GetMapping("/api/selectSoftwareList")
    AjaxResult selectSoftwareList(
            @RequestParam("userId") Long userId,
            @RequestParam("deptId") Long deptId,
            @RequestParam("pageNum") Integer pageNum,
            @RequestParam("pageSize") Integer pageSize
    );

    /**
     * 查询软著记录详细信息
     */
    @GetMapping("/api/selectSoftwareById")
    AjaxResult selectSoftwareById(
            @RequestParam("userId") Long userId,
            @RequestParam("deptId") Long deptId,
            @RequestParam("softwareId") Long softwareId
    );

    /**
     * 新增软著记录
     */
    @PostMapping("/api/insertSoftware")
    AjaxResult insertSoftware(@RequestBody AchievementsSoftware achievementsSoftware);

    /**
     * 更新软著记录
     */
    @PostMapping("/api/updateSoftware")
    AjaxResult updateSoftware(@RequestBody AchievementsSoftware achievementsSoftware);


    /**
     * 删除软著记录
     */
    @PostMapping("/api/deleteSoftwares")
    AjaxResult deleteSoftwares( @RequestBody DeleteRequest request);
//    ---------------------------------------------------------------------------------//    ---------------------------------------------------------------------------------//    ---------------------------------------------------------------------------------//    ---------------------------------------------------------------------------------

    /**
     * 查询成果转化列表
     */
    @GetMapping("/api/selectTransferList")
    AjaxResult selectTransferList(
            @RequestParam("userId") Long userId,
            @RequestParam("deptId") Long deptId,
            @RequestParam("pageNum") Integer pageNum,
            @RequestParam("pageSize") Integer pageSize
    );

    /**
     * 查询成果转化记录详细信息
     */
    @GetMapping("/api/selectTransferById")
    AjaxResult selectTransferById(
            @RequestParam("userId") Long userId,
            @RequestParam("deptId") Long deptId,
            @RequestParam("transferId") Long softwareId
    );

    /**
     * 新增成果转化记录
     */
    @PostMapping("/api/insertTransfer")
    AjaxResult insertTransfer(@RequestBody AchievementsTransfer achievementsTransfer);

    /**
     * 更新成果转化记录
     */
    @PostMapping("/api/updateTransfer")
    AjaxResult updateTransfer(@RequestBody AchievementsTransfer achievementsTransfer);


    /**
     * 删除成果转化记录
     */
    @PostMapping("/api/deleteTransfers")
    AjaxResult deleteTransfers( @RequestBody DeleteRequest request);
//    ---------------------------------------------------------------------------------//    ---------------------------------------------------------------------------------//    ---------------------------------------------------------------------------------//    ---------------------------------------------------------------------------------//    ---------------------------------------------------------------------------------

    /**
     * 查询专利列表
     */
    @GetMapping("/api/selectPatentList")
    AjaxResult selectPatentList(
            @RequestParam("userId") Long userId,
            @RequestParam("deptId") Long deptId,
            @RequestParam("pageNum") Integer pageNum,
            @RequestParam("pageSize") Integer pageSize
    );

    /**
     * 查询专利记录详细信息
     */
    @GetMapping("/api/selectPatentById")
    AjaxResult selectPatentById(
            @RequestParam("userId") Long userId,
            @RequestParam("deptId") Long deptId,
            @RequestParam("patentId") Long patentId
    );

    /**
     * 新增专利记录
     */
    @PostMapping("/api/insertPatent")
    AjaxResult insertPatent(@RequestBody AchievementsPatent achievementsPatent);

    /**
     * 更新专利记录
     */
    @PostMapping("/api/updatePatent")
    AjaxResult updatePatent(@RequestBody AchievementsPatent achievementsPatent);


    /**
     * 删除成果转化记录
     */
    @PostMapping("/api/deletePatents")
    AjaxResult deletePatents( @RequestBody DeleteRequest request);
//    ---------------------------------------------------------------------------------
}
