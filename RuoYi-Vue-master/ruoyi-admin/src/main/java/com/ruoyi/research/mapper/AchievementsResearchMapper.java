package com.ruoyi.research.mapper;

import java.util.List;
import com.ruoyi.research.domain.AchievementsResearch;

/**
 * 项目成果Mapper接口
 * 
 * @author xixia
 * @date 2025-12-16
 */
public interface AchievementsResearchMapper 
{
    /**
     * 查询项目成果
     * 
     * @param researchId 项目成果主键
     * @return 项目成果
     */
    public AchievementsResearch selectAchievementsResearchByResearchId(Long researchId);

    /**
     * 查询项目成果列表
     * 
     * @param achievementsResearch 项目成果
     * @return 项目成果集合
     */
    public List<AchievementsResearch> selectAchievementsResearchList(AchievementsResearch achievementsResearch);

    /**
     * 新增项目成果
     * 
     * @param achievementsResearch 项目成果
     * @return 结果
     */
    public int insertAchievementsResearch(AchievementsResearch achievementsResearch);

    /**
     * 修改项目成果
     * 
     * @param achievementsResearch 项目成果
     * @return 结果
     */
    public int updateAchievementsResearch(AchievementsResearch achievementsResearch);

    /**
     * 删除项目成果
     * 
     * @param researchId 项目成果主键
     * @return 结果
     */
    public int deleteAchievementsResearchByResearchId(Long researchId);

    /**
     * 批量删除项目成果
     * 
     * @param researchIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteAchievementsResearchByResearchIds(Long[] researchIds);
}
