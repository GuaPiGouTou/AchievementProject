package com.ruoyi.award.mapper;

import java.util.List;
import com.ruoyi.award.domain.AchievementsAward;

/**
 * 获奖成果Mapper接口
 * 
 * @author ruoyi
 * @date 2025-11-20
 */
public interface AchievementsAwardMapper 
{
    /**
     * 查询获奖成果
     * 
     * @param awardId 获奖成果主键
     * @return 获奖成果
     */
    public AchievementsAward selectAchievementsAwardByAwardId(Long awardId);

    /**
     * 查询获奖成果列表
     * 
     * @param achievementsAward 获奖成果
     * @return 获奖成果集合
     */
    public List<AchievementsAward> selectAchievementsAwardList(AchievementsAward achievementsAward);

    /**
     * 新增获奖成果
     * 
     * @param achievementsAward 获奖成果
     * @return 结果
     */
    public int insertAchievementsAward(AchievementsAward achievementsAward);

    /**
     * 修改获奖成果
     * 
     * @param achievementsAward 获奖成果
     * @return 结果
     */
    public int updateAchievementsAward(AchievementsAward achievementsAward);

    /**
     * 删除获奖成果
     * 
     * @param awardId 获奖成果主键
     * @return 结果
     */
    public int deleteAchievementsAwardByAwardId(Long awardId);

    /**
     * 批量删除获奖成果
     * 
     * @param awardIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteAchievementsAwardByAwardIds(Long[] awardIds);
}
