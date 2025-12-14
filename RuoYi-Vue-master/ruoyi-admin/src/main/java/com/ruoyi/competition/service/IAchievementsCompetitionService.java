package com.ruoyi.competition.service;

import java.util.List;
import com.ruoyi.competition.domain.AchievementsCompetition;
import org.apache.ibatis.annotations.Param;

/**
 * 竞赛成果Service接口
 * 
 * @author ruoyi
 * @date 2025-11-12
 */
public interface IAchievementsCompetitionService 
{
    /**
     * 查询竞赛成果
     * 
     * @param competitionId 竞赛成果主键
     * @return 竞赛成果
     */
    public AchievementsCompetition selectAchievementsCompetitionByCompetitionId(Long competitionId);

    /**
     * 查询竞赛成果列表
     * 
     * @param achievementsCompetition 竞赛成果
     * @return 竞赛成果集合
     */
    public List<AchievementsCompetition> selectAchievementsCompetitionList(AchievementsCompetition achievementsCompetition);

    /**
     * 新增竞赛成果
     * 
     * @param achievementsCompetition 竞赛成果
     * @return 结果
     */
    public int insertAchievementsCompetition(AchievementsCompetition achievementsCompetition);

    /**
     * 修改竞赛成果
     * 
     * @param achievementsCompetition 竞赛成果
     * @return 结果
     */
    public int updateAchievementsCompetition(AchievementsCompetition achievementsCompetition);

    /**
     * 批量删除竞赛成果
     * 
     * @param competitionIds 需要删除的竞赛成果主键集合
     * @return 结果
     */
    public int deleteAchievementsCompetitionByCompetitionIds(Long[] competitionIds);

    /**
     * 删除竞赛成果信息
     * 
     * @param competitionId 竞赛成果主键
     * @return 结果
     */
    public int deleteAchievementsCompetitionByCompetitionId(Long competitionId);

    /**
     * 根据ids查询
     * @param ids
     * @param permissionParams
     * @return
     */
    public List<AchievementsCompetition> selectAchievementsCompetitionListByIds(
            @Param("ids") List<Integer> ids,
            @Param("permissionParams") AchievementsCompetition permissionParams
    );
}
