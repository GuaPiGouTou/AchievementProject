package com.ruoyi.textbook.service;

import java.util.List;
import com.ruoyi.textbook.domain.AchievementsTextbook;

/**
 * 教材著作Service接口
 * 
 * @author xixia
 * @date 2025-11-16
 */
public interface IAchievementsTextbookService 
{
    /**
     * 查询教材著作
     * 
     * @param textbookId 教材著作主键
     * @return 教材著作
     */
    public AchievementsTextbook selectAchievementsTextbookByTextbookId(Long textbookId);

    /**
     * 查询教材著作列表
     * 
     * @param achievementsTextbook 教材著作
     * @return 教材著作集合
     */
    public List<AchievementsTextbook> selectAchievementsTextbookList(AchievementsTextbook achievementsTextbook);

    /**
     * 新增教材著作
     * 
     * @param achievementsTextbook 教材著作
     * @return 结果
     */
    public int insertAchievementsTextbook(AchievementsTextbook achievementsTextbook);

    /**
     * 修改教材著作
     * 
     * @param achievementsTextbook 教材著作
     * @return 结果
     */
    public int updateAchievementsTextbook(AchievementsTextbook achievementsTextbook);

    /**
     * 批量删除教材著作
     * 
     * @param textbookIds 需要删除的教材著作主键集合
     * @return 结果
     */
    public int deleteAchievementsTextbookByTextbookIds(Long[] textbookIds);

    /**
     * 删除教材著作信息
     * 
     * @param textbookId 教材著作主键
     * @return 结果
     */
    public int deleteAchievementsTextbookByTextbookId(Long textbookId);
}
