package com.ruoyi.award.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.award.mapper.AchievementsAwardMapper;
import com.ruoyi.award.domain.AchievementsAward;
import com.ruoyi.award.service.IAchievementsAwardService;

/**
 * 获奖成果Service业务层处理
 * 
 * @author ruoyi
 * @date 2025-11-20
 */
@Service
public class AchievementsAwardServiceImpl implements IAchievementsAwardService 
{
    @Autowired
    private AchievementsAwardMapper achievementsAwardMapper;

    /**
     * 查询获奖成果
     * 
     * @param awardId 获奖成果主键
     * @return 获奖成果
     */
    @Override
    public AchievementsAward selectAchievementsAwardByAwardId(Long awardId)
    {
        return achievementsAwardMapper.selectAchievementsAwardByAwardId(awardId);
    }

    /**
     * 查询获奖成果列表
     * 
     * @param achievementsAward 获奖成果
     * @return 获奖成果
     */
    @Override
    public List<AchievementsAward> selectAchievementsAwardList(AchievementsAward achievementsAward)
    {
        return achievementsAwardMapper.selectAchievementsAwardList(achievementsAward);
    }

    /**
     * 新增获奖成果
     * 
     * @param achievementsAward 获奖成果
     * @return 结果
     */
    @Override
    public int insertAchievementsAward(AchievementsAward achievementsAward)
    {
        return achievementsAwardMapper.insertAchievementsAward(achievementsAward);
    }

    /**
     * 修改获奖成果
     * 
     * @param achievementsAward 获奖成果
     * @return 结果
     */
    @Override
    public int updateAchievementsAward(AchievementsAward achievementsAward)
    {
        return achievementsAwardMapper.updateAchievementsAward(achievementsAward);
    }

    /**
     * 批量删除获奖成果
     * 
     * @param awardIds 需要删除的获奖成果主键
     * @return 结果
     */
    @Override
    public int deleteAchievementsAwardByAwardIds(Long[] awardIds)
    {
        return achievementsAwardMapper.deleteAchievementsAwardByAwardIds(awardIds);
    }

    /**
     * 删除获奖成果信息
     * 
     * @param awardId 获奖成果主键
     * @return 结果
     */
    @Override
    public int deleteAchievementsAwardByAwardId(Long awardId)
    {
        return achievementsAwardMapper.deleteAchievementsAwardByAwardId(awardId);
    }
}
