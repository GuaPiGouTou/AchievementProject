package com.ruoyi.paper.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.paper.mapper.AchievementsPaperMapper;
import com.ruoyi.paper.domain.AchievementsPaper;
import com.ruoyi.paper.service.IAchievementsPaperService;

/**
 * 论文成果Service业务层处理
 * 
 * @author xixia
 * @date 2025-11-26
 */
@Service
public class AchievementsPaperServiceImpl implements IAchievementsPaperService 
{
    @Autowired
    private AchievementsPaperMapper achievementsPaperMapper;

    /**
     * 查询论文成果
     * 
     * @param paperId 论文成果主键
     * @return 论文成果
     */
    @Override
    public AchievementsPaper selectAchievementsPaperByPaperId(Long paperId)
    {
        return achievementsPaperMapper.selectAchievementsPaperByPaperId(paperId);
    }

    /**
     * 查询论文成果列表
     * 
     * @param achievementsPaper 论文成果
     * @return 论文成果
     */
    @Override
    public List<AchievementsPaper> selectAchievementsPaperList(AchievementsPaper achievementsPaper)
    {
        return achievementsPaperMapper.selectAchievementsPaperList(achievementsPaper);
    }

    /**
     * 新增论文成果
     * 
     * @param achievementsPaper 论文成果
     * @return 结果
     */
    @Override
    public int insertAchievementsPaper(AchievementsPaper achievementsPaper)
    {
        return achievementsPaperMapper.insertAchievementsPaper(achievementsPaper);
    }

    /**
     * 修改论文成果
     * 
     * @param achievementsPaper 论文成果
     * @return 结果
     */
    @Override
    public int updateAchievementsPaper(AchievementsPaper achievementsPaper)
    {
        return achievementsPaperMapper.updateAchievementsPaper(achievementsPaper);
    }

    /**
     * 批量删除论文成果
     * 
     * @param paperIds 需要删除的论文成果主键
     * @return 结果
     */
    @Override
    public int deleteAchievementsPaperByPaperIds(Long[] paperIds)
    {
        return achievementsPaperMapper.deleteAchievementsPaperByPaperIds(paperIds);
    }

    /**
     * 删除论文成果信息
     * 
     * @param paperId 论文成果主键
     * @return 结果
     */
    @Override
    public int deleteAchievementsPaperByPaperId(Long paperId)
    {
        return achievementsPaperMapper.deleteAchievementsPaperByPaperId(paperId);
    }
}
