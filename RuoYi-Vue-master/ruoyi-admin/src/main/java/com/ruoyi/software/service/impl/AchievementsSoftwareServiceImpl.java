package com.ruoyi.software.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.software.mapper.AchievementsSoftwareMapper;
import com.ruoyi.software.domain.AchievementsSoftware;
import com.ruoyi.software.service.IAchievementsSoftwareService;

/**
 * 软著成果Service业务层处理
 * 
 * @author xixia
 * @date 2025-12-07
 */
@Service
public class AchievementsSoftwareServiceImpl implements IAchievementsSoftwareService 
{
    @Autowired
    private AchievementsSoftwareMapper achievementsSoftwareMapper;

    /**
     * 查询软著成果
     * 
     * @param softwareId 软著成果主键
     * @return 软著成果
     */
    @Override
    public AchievementsSoftware selectAchievementsSoftwareBySoftwareId(Long softwareId)
    {
        return achievementsSoftwareMapper.selectAchievementsSoftwareBySoftwareId(softwareId);
    }

    /**
     * 查询软著成果列表
     * 
     * @param achievementsSoftware 软著成果
     * @return 软著成果
     */
    @Override
    public List<AchievementsSoftware> selectAchievementsSoftwareList(AchievementsSoftware achievementsSoftware)
    {
        return achievementsSoftwareMapper.selectAchievementsSoftwareList(achievementsSoftware);
    }

    /**
     * 新增软著成果
     * 
     * @param achievementsSoftware 软著成果
     * @return 结果
     */
    @Override
    public int insertAchievementsSoftware(AchievementsSoftware achievementsSoftware)
    {
        return achievementsSoftwareMapper.insertAchievementsSoftware(achievementsSoftware);
    }

    /**
     * 修改软著成果
     * 
     * @param achievementsSoftware 软著成果
     * @return 结果
     */
    @Override
    public int updateAchievementsSoftware(AchievementsSoftware achievementsSoftware)
    {
        return achievementsSoftwareMapper.updateAchievementsSoftware(achievementsSoftware);
    }

    /**
     * 批量删除软著成果
     * 
     * @param softwareIds 需要删除的软著成果主键
     * @return 结果
     */
    @Override
    public int deleteAchievementsSoftwareBySoftwareIds(Long[] softwareIds)
    {
        return achievementsSoftwareMapper.deleteAchievementsSoftwareBySoftwareIds(softwareIds);
    }

    /**
     * 删除软著成果信息
     * 
     * @param softwareId 软著成果主键
     * @return 结果
     */
    @Override
    public int deleteAchievementsSoftwareBySoftwareId(Long softwareId)
    {
        return achievementsSoftwareMapper.deleteAchievementsSoftwareBySoftwareId(softwareId);
    }
}
