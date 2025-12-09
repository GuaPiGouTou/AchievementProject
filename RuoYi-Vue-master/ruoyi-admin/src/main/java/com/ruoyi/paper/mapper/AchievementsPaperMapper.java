package com.ruoyi.paper.mapper;

import java.util.List;
import com.ruoyi.paper.domain.AchievementsPaper;

/**
 * 论文成果Mapper接口
 * 
 * @author xixia
 * @date 2025-11-26
 */
public interface AchievementsPaperMapper 
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
     * 删除论文成果
     * 
     * @param paperId 论文成果主键
     * @return 结果
     */
    public int deleteAchievementsPaperByPaperId(Long paperId);

    /**
     * 批量删除论文成果
     * 
     * @param paperIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteAchievementsPaperByPaperIds(Long[] paperIds);
}
