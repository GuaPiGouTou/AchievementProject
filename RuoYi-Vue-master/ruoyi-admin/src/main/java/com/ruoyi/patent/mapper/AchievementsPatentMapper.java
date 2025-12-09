package com.ruoyi.patent.mapper;

import java.util.List;
import com.ruoyi.patent.domain.AchievementsPatent;

/**
 * 专利成果Mapper接口
 * 
 * @author xixia
 * @date 2025-12-09
 */
public interface AchievementsPatentMapper 
{
    /**
     * 查询专利成果
     * 
     * @param patentId 专利成果主键
     * @return 专利成果
     */
    public AchievementsPatent selectAchievementsPatentByPatentId(Long patentId);

    /**
     * 查询专利成果列表
     * 
     * @param achievementsPatent 专利成果
     * @return 专利成果集合
     */
    public List<AchievementsPatent> selectAchievementsPatentList(AchievementsPatent achievementsPatent);

    /**
     * 新增专利成果
     * 
     * @param achievementsPatent 专利成果
     * @return 结果
     */
    public int insertAchievementsPatent(AchievementsPatent achievementsPatent);

    /**
     * 修改专利成果
     * 
     * @param achievementsPatent 专利成果
     * @return 结果
     */
    public int updateAchievementsPatent(AchievementsPatent achievementsPatent);

    /**
     * 删除专利成果
     * 
     * @param patentId 专利成果主键
     * @return 结果
     */
    public int deleteAchievementsPatentByPatentId(Long patentId);

    /**
     * 批量删除专利成果
     * 
     * @param patentIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteAchievementsPatentByPatentIds(Long[] patentIds);
}
