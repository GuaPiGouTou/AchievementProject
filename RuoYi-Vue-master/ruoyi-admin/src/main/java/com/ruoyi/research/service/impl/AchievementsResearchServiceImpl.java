package com.ruoyi.research.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.research.mapper.AchievementsResearchMapper;
import com.ruoyi.research.domain.AchievementsResearch;
import com.ruoyi.research.service.IAchievementsResearchService;

/**
 * 项目成果Service业务层处理
 * 
 * @author xixia
 * @date 2025-12-16
 */
@Service
public class AchievementsResearchServiceImpl implements IAchievementsResearchService 
{
    @Autowired
    private AchievementsResearchMapper achievementsResearchMapper;

    /**
     * 查询项目成果
     * 
     * @param researchId 项目成果主键
     * @return 项目成果
     */
    @Override
    public AchievementsResearch selectAchievementsResearchByResearchId(Long researchId)
    {
        return achievementsResearchMapper.selectAchievementsResearchByResearchId(researchId);
    }

    /**
     * 查询项目成果列表
     * 
     * @param achievementsResearch 项目成果
     * @return 项目成果
     */
    @Override
    public List<AchievementsResearch> selectAchievementsResearchList(AchievementsResearch achievementsResearch)
    {
        return achievementsResearchMapper.selectAchievementsResearchList(achievementsResearch);
    }

    /**
     * 新增项目成果
     * 
     * @param achievementsResearch 项目成果
     * @return 结果
     */
    @Override
    public int insertAchievementsResearch(AchievementsResearch achievementsResearch)
    {
        return achievementsResearchMapper.insertAchievementsResearch(achievementsResearch);
    }

    /**
     * 修改项目成果
     * 
     * @param achievementsResearch 项目成果
     * @return 结果
     */
    @Override
    public int updateAchievementsResearch(AchievementsResearch achievementsResearch)
    {
        return achievementsResearchMapper.updateAchievementsResearch(achievementsResearch);
    }

    /**
     * 批量删除项目成果
     * 
     * @param researchIds 需要删除的项目成果主键
     * @return 结果
     */
    @Override
    public int deleteAchievementsResearchByResearchIds(Long[] researchIds)
    {
        return achievementsResearchMapper.deleteAchievementsResearchByResearchIds(researchIds);
    }

    /**
     * 删除项目成果信息
     * 
     * @param researchId 项目成果主键
     * @return 结果
     */
    @Override
    public int deleteAchievementsResearchByResearchId(Long researchId)
    {
        return achievementsResearchMapper.deleteAchievementsResearchByResearchId(researchId);
    }
}
