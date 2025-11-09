package com.ruoyi.paper.service;

import java.util.List;
import com.ruoyi.paper.domain.AchievementsPaper;

/**
 * 论文成果Service接口
 * 
 * @author xixia
 * @date 2025-11-05
 */
public interface IAchievementsPaperService 
{
    /**
     * 查询论文成果
     * 
     * @param paperId 论文成果主键
     * @return 论文成果
     */
    public AchievementsPaper selectAchievementsPaperByPaperId(Long paperId);

    /**
     * 查询论文成果列表
     * 
     * @param achievementsPaper 论文成果
     * @return 论文成果集合
     */
    public List<AchievementsPaper> selectAchievementsPaperList(AchievementsPaper achievementsPaper);

    /**
     * 新增论文成果
     * 
     * @param achievementsPaper 论文成果
     * @return 结果
     */
    public int insertAchievementsPaper(AchievementsPaper achievementsPaper);

    /**
     * 修改论文成果
     * 
     * @param achievementsPaper 论文成果
     * @return 结果
     */
    public int updateAchievementsPaper(AchievementsPaper achievementsPaper);

    /**
     * 批量删除论文成果
     * 
     * @param paperIds 需要删除的论文成果主键集合
     * @return 结果
     */
    public int deleteAchievementsPaperByPaperIds(Long[] paperIds);

    /**
     * 删除论文成果信息
     * 
     * @param paperId 论文成果主键
     * @return 结果
     */
    public int deleteAchievementsPaperByPaperId(Long paperId);
}
