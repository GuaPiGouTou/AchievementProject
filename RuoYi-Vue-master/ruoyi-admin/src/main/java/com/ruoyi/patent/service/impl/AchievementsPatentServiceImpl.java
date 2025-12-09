package com.ruoyi.patent.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.patent.mapper.AchievementsPatentMapper;
import com.ruoyi.patent.domain.AchievementsPatent;
import com.ruoyi.patent.service.IAchievementsPatentService;

/**
 * 专利成果Service业务层处理
 * 
 * @author xixia
 * @date 2025-12-09
 */
@Service
public class AchievementsPatentServiceImpl implements IAchievementsPatentService 
{
    @Autowired
    private AchievementsPatentMapper achievementsPatentMapper;

    /**
     * 查询专利成果
     * 
     * @param patentId 专利成果主键
     * @return 专利成果
     */
    @Override
    public AchievementsPatent selectAchievementsPatentByPatentId(Long patentId)
    {
        return achievementsPatentMapper.selectAchievementsPatentByPatentId(patentId);
    }

    /**
     * 查询专利成果列表
     * 
     * @param achievementsPatent 专利成果
     * @return 专利成果
     */
    @Override
    public List<AchievementsPatent> selectAchievementsPatentList(AchievementsPatent achievementsPatent)
    {
        return achievementsPatentMapper.selectAchievementsPatentList(achievementsPatent);
    }

    /**
     * 新增专利成果
     * 
     * @param achievementsPatent 专利成果
     * @return 结果
     */
    @Override
    public int insertAchievementsPatent(AchievementsPatent achievementsPatent)
    {
        return achievementsPatentMapper.insertAchievementsPatent(achievementsPatent);
    }

    /**
     * 修改专利成果
     * 
     * @param achievementsPatent 专利成果
     * @return 结果
     */
    @Override
    public int updateAchievementsPatent(AchievementsPatent achievementsPatent)
    {
        return achievementsPatentMapper.updateAchievementsPatent(achievementsPatent);
    }

    /**
     * 批量删除专利成果
     * 
     * @param patentIds 需要删除的专利成果主键
     * @return 结果
     */
    @Override
    public int deleteAchievementsPatentByPatentIds(Long[] patentIds)
    {
        return achievementsPatentMapper.deleteAchievementsPatentByPatentIds(patentIds);
    }

    /**
     * 删除专利成果信息
     * 
     * @param patentId 专利成果主键
     * @return 结果
     */
    @Override
    public int deleteAchievementsPatentByPatentId(Long patentId)
    {
        return achievementsPatentMapper.deleteAchievementsPatentByPatentId(patentId);
    }
}
