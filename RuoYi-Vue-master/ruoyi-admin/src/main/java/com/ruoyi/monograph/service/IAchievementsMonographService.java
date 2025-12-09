package com.ruoyi.monograph.service;

import java.util.List;
import com.ruoyi.monograph.domain.AchievementsMonograph;

/**
 * 成果专著Service接口
 * 
 * @author xixia
 * @date 2025-12-07
 */
public interface IAchievementsMonographService 
{
    /**
     * 查询成果专著
     * 
     * @param monographId 成果专著主键
     * @return 成果专著
     */
    public AchievementsMonograph selectAchievementsMonographByMonographId(Long monographId);

    /**
     * 查询成果专著列表
     * 
     * @param achievementsMonograph 成果专著
     * @return 成果专著集合
     */
    public List<AchievementsMonograph> selectAchievementsMonographList(AchievementsMonograph achievementsMonograph);

    /**
     * 新增成果专著
     * 
     * @param achievementsMonograph 成果专著
     * @return 结果
     */
    public int insertAchievementsMonograph(AchievementsMonograph achievementsMonograph);

    /**
     * 修改成果专著
     * 
     * @param achievementsMonograph 成果专著
     * @return 结果
     */
    public int updateAchievementsMonograph(AchievementsMonograph achievementsMonograph);

    /**
     * 批量删除成果专著
     * 
     * @param monographIds 需要删除的成果专著主键集合
     * @return 结果
     */
    public int deleteAchievementsMonographByMonographIds(Long[] monographIds);

    /**
     * 删除成果专著信息
     * 
     * @param monographId 成果专著主键
     * @return 结果
     */
    public int deleteAchievementsMonographByMonographId(Long monographId);
}
