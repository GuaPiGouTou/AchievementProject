package com.ruoyi.monograph.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.monograph.mapper.AchievementsMonographMapper;
import com.ruoyi.monograph.domain.AchievementsMonograph;
import com.ruoyi.monograph.service.IAchievementsMonographService;

/**
 * 成果专著Service业务层处理
 * 
 * @author xixia
 * @date 2025-12-07
 */
@Service
public class AchievementsMonographServiceImpl implements IAchievementsMonographService 
{
    @Autowired
    private AchievementsMonographMapper achievementsMonographMapper;

    /**
     * 查询成果专著
     * 
     * @param monographId 成果专著主键
     * @return 成果专著
     */
    @Override
    public AchievementsMonograph selectAchievementsMonographByMonographId(Long monographId)
    {
        return achievementsMonographMapper.selectAchievementsMonographByMonographId(monographId);
    }

    /**
     * 查询成果专著列表
     * 
     * @param achievementsMonograph 成果专著
     * @return 成果专著
     */
    @Override
    public List<AchievementsMonograph> selectAchievementsMonographList(AchievementsMonograph achievementsMonograph)
    {
        return achievementsMonographMapper.selectAchievementsMonographList(achievementsMonograph);
    }

    /**
     * 新增成果专著
     * 
     * @param achievementsMonograph 成果专著
     * @return 结果
     */
    @Override
    public int insertAchievementsMonograph(AchievementsMonograph achievementsMonograph)
    {
        return achievementsMonographMapper.insertAchievementsMonograph(achievementsMonograph);
    }

    /**
     * 修改成果专著
     * 
     * @param achievementsMonograph 成果专著
     * @return 结果
     */
    @Override
    public int updateAchievementsMonograph(AchievementsMonograph achievementsMonograph)
    {
        return achievementsMonographMapper.updateAchievementsMonograph(achievementsMonograph);
    }

    /**
     * 批量删除成果专著
     * 
     * @param monographIds 需要删除的成果专著主键
     * @return 结果
     */
    @Override
    public int deleteAchievementsMonographByMonographIds(Long[] monographIds)
    {
        return achievementsMonographMapper.deleteAchievementsMonographByMonographIds(monographIds);
    }

    /**
     * 删除成果专著信息
     * 
     * @param monographId 成果专著主键
     * @return 结果
     */
    @Override
    public int deleteAchievementsMonographByMonographId(Long monographId)
    {
        return achievementsMonographMapper.deleteAchievementsMonographByMonographId(monographId);
    }
}
