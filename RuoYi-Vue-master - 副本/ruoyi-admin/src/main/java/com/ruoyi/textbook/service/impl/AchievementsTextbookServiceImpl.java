package com.ruoyi.textbook.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.textbook.mapper.AchievementsTextbookMapper;
import com.ruoyi.textbook.domain.AchievementsTextbook;
import com.ruoyi.textbook.service.IAchievementsTextbookService;

/**
 * 教材著作Service业务层处理
 * 
 * @author xixia
 * @date 2025-11-16
 */
@Service
public class AchievementsTextbookServiceImpl implements IAchievementsTextbookService 
{
    @Autowired
    private AchievementsTextbookMapper achievementsTextbookMapper;

    /**
     * 查询教材著作
     * 
     * @param textbookId 教材著作主键
     * @return 教材著作
     */
    @Override
    public AchievementsTextbook selectAchievementsTextbookByTextbookId(Long textbookId)
    {
        return achievementsTextbookMapper.selectAchievementsTextbookByTextbookId(textbookId);
    }

    /**
     * 查询教材著作列表
     * 
     * @param achievementsTextbook 教材著作
     * @return 教材著作
     */
    @Override
    public List<AchievementsTextbook> selectAchievementsTextbookList(AchievementsTextbook achievementsTextbook)
    {
        return achievementsTextbookMapper.selectAchievementsTextbookList(achievementsTextbook);
    }

    /**
     * 新增教材著作
     * 
     * @param achievementsTextbook 教材著作
     * @return 结果
     */
    @Override
    public int insertAchievementsTextbook(AchievementsTextbook achievementsTextbook)
    {
        return achievementsTextbookMapper.insertAchievementsTextbook(achievementsTextbook);
    }

    /**
     * 修改教材著作
     * 
     * @param achievementsTextbook 教材著作
     * @return 结果
     */
    @Override
    public int updateAchievementsTextbook(AchievementsTextbook achievementsTextbook)
    {
        return achievementsTextbookMapper.updateAchievementsTextbook(achievementsTextbook);
    }

    /**
     * 批量删除教材著作
     * 
     * @param textbookIds 需要删除的教材著作主键
     * @return 结果
     */
    @Override
    public int deleteAchievementsTextbookByTextbookIds(Long[] textbookIds)
    {
        return achievementsTextbookMapper.deleteAchievementsTextbookByTextbookIds(textbookIds);
    }

    /**
     * 删除教材著作信息
     * 
     * @param textbookId 教材著作主键
     * @return 结果
     */
    @Override
    public int deleteAchievementsTextbookByTextbookId(Long textbookId)
    {
        return achievementsTextbookMapper.deleteAchievementsTextbookByTextbookId(textbookId);
    }
}
