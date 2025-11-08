package com.ruoyi.attachment.service.impl;

import java.util.List;
import com.ruoyi.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.attachment.mapper.AchievementsAttachmentMapper;
import com.ruoyi.attachment.domain.AchievementsAttachment;
import com.ruoyi.attachment.service.IAchievementsAttachmentService;

/**
 * 成果附件Service业务层处理
 * 
 * @author xixia
 * @date 2025-11-08
 */
@Service
public class AchievementsAttachmentServiceImpl implements IAchievementsAttachmentService 
{
    @Autowired
    private AchievementsAttachmentMapper achievementsAttachmentMapper;

    /**
     * 查询成果附件
     * 
     * @param attachmentId 成果附件主键
     * @return 成果附件
     */
    @Override
    public AchievementsAttachment selectAchievementsAttachmentByAttachmentId(Long attachmentId)
    {
        return achievementsAttachmentMapper.selectAchievementsAttachmentByAttachmentId(attachmentId);
    }

    /**
     * 查询成果附件列表
     * 
     * @param achievementsAttachment 成果附件
     * @return 成果附件
     */
    @Override
    public List<AchievementsAttachment> selectAchievementsAttachmentList(AchievementsAttachment achievementsAttachment)
    {
        return achievementsAttachmentMapper.selectAchievementsAttachmentList(achievementsAttachment);
    }

    /**
     * 新增成果附件
     * 
     * @param achievementsAttachment 成果附件
     * @return 结果
     */
    @Override
    public int insertAchievementsAttachment(AchievementsAttachment achievementsAttachment)
    {
        achievementsAttachment.setCreateTime(DateUtils.getNowDate());
        return achievementsAttachmentMapper.insertAchievementsAttachment(achievementsAttachment);
    }

    /**
     * 修改成果附件
     * 
     * @param achievementsAttachment 成果附件
     * @return 结果
     */
    @Override
    public int updateAchievementsAttachment(AchievementsAttachment achievementsAttachment)
    {
        achievementsAttachment.setUpdateTime(DateUtils.getNowDate());
        return achievementsAttachmentMapper.updateAchievementsAttachment(achievementsAttachment);
    }

    /**
     * 批量删除成果附件
     * 
     * @param attachmentIds 需要删除的成果附件主键
     * @return 结果
     */
    @Override
    public int deleteAchievementsAttachmentByAttachmentIds(Long[] attachmentIds)
    {
        return achievementsAttachmentMapper.deleteAchievementsAttachmentByAttachmentIds(attachmentIds);
    }

    /**
     * 删除成果附件信息
     * 
     * @param attachmentId 成果附件主键
     * @return 结果
     */
    @Override
    public int deleteAchievementsAttachmentByAttachmentId(Long attachmentId)
    {
        return achievementsAttachmentMapper.deleteAchievementsAttachmentByAttachmentId(attachmentId);
    }
}
