package com.ruoyi.software.service;

import java.util.List;
import com.ruoyi.software.domain.AchievementsSoftware;

/**
 * 软著成果Service接口
 * 
 * @author xixia
 * @date 2025-12-07
 */
public interface IAchievementsSoftwareService 
{
    /**
     * 查询软著成果
     * 
     * @param softwareId 软著成果主键
     * @return 软著成果
     */
    public AchievementsSoftware selectAchievementsSoftwareBySoftwareId(Long softwareId);

    /**
     * 查询软著成果列表
     * 
     * @param achievementsSoftware 软著成果
     * @return 软著成果集合
     */
    public List<AchievementsSoftware> selectAchievementsSoftwareList(AchievementsSoftware achievementsSoftware);

    /**
     * 新增软著成果
     * 
     * @param achievementsSoftware 软著成果
     * @return 结果
     */
    public int insertAchievementsSoftware(AchievementsSoftware achievementsSoftware);

    /**
     * 修改软著成果
     * 
     * @param achievementsSoftware 软著成果
     * @return 结果
     */
    public int updateAchievementsSoftware(AchievementsSoftware achievementsSoftware);

    /**
     * 批量删除软著成果
     * 
     * @param softwareIds 需要删除的软著成果主键集合
     * @return 结果
     */
    public int deleteAchievementsSoftwareBySoftwareIds(Long[] softwareIds);

    /**
     * 删除软著成果信息
     * 
     * @param softwareId 软著成果主键
     * @return 结果
     */
    public int deleteAchievementsSoftwareBySoftwareId(Long softwareId);
}
