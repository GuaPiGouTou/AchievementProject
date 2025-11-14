package com.ruoyi.competition.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.competition.mapper.AchievementsCompetitionMapper;
import com.ruoyi.competition.domain.AchievementsCompetition;
import com.ruoyi.competition.service.IAchievementsCompetitionService;

/**
 * 竞赛成果Service业务层处理
 * 
 * @author ruoyi
 * @date 2025-11-12
 */
@Service
public class AchievementsCompetitionServiceImpl implements IAchievementsCompetitionService 
{
    @Autowired
    private AchievementsCompetitionMapper achievementsCompetitionMapper;

    /**
     * 查询竞赛成果
     * 
     * @param competitionId 竞赛成果主键
     * @return 竞赛成果
     */
    @Override
    public AchievementsCompetition selectAchievementsCompetitionByCompetitionId(Long competitionId)
    {
        return achievementsCompetitionMapper.selectAchievementsCompetitionByCompetitionId(competitionId);
    }

    /**
     * 查询竞赛成果列表
     * 
     * @param achievementsCompetition 竞赛成果
     * @return 竞赛成果
     */
    @Override
    public List<AchievementsCompetition> selectAchievementsCompetitionList(AchievementsCompetition achievementsCompetition)
    {
        return achievementsCompetitionMapper.selectAchievementsCompetitionList(achievementsCompetition);
    }

    /**
     * 新增竞赛成果
     * 
     * @param achievementsCompetition 竞赛成果
     * @return 结果
     */
    @Override
    public int insertAchievementsCompetition(AchievementsCompetition achievementsCompetition)
    {
        return achievementsCompetitionMapper.insertAchievementsCompetition(achievementsCompetition);
    }

    /**
     * 修改竞赛成果
     * 
     * @param achievementsCompetition 竞赛成果
     * @return 结果
     */
    @Override
    public int updateAchievementsCompetition(AchievementsCompetition achievementsCompetition)
    {
        return achievementsCompetitionMapper.updateAchievementsCompetition(achievementsCompetition);
    }

    /**
     * 批量删除竞赛成果
     * 
     * @param competitionIds 需要删除的竞赛成果主键
     * @return 结果
     */
    @Override
    public int deleteAchievementsCompetitionByCompetitionIds(Long[] competitionIds)
    {
        return achievementsCompetitionMapper.deleteAchievementsCompetitionByCompetitionIds(competitionIds);
    }

    /**
     * 删除竞赛成果信息
     * 
     * @param competitionId 竞赛成果主键
     * @return 结果
     */
    @Override
    public int deleteAchievementsCompetitionByCompetitionId(Long competitionId)
    {
        return achievementsCompetitionMapper.deleteAchievementsCompetitionByCompetitionId(competitionId);
    }
}
