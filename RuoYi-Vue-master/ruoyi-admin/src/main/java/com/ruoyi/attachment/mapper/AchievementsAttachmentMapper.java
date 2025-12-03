package com.ruoyi.attachment.mapper;

import java.util.List;
import com.ruoyi.attachment.domain.AchievementsAttachment;

/**
 * 成果附件Mapper接口
 * 
 * @author xixia
 * @date 2025-11-08
 */
public interface AchievementsAttachmentMapper 
{
    /**
     * 查询成果附件
     * 
     * @param attachmentId 成果附件主键
     * @return 成果附件
     */
    public AchievementsAttachment selectAchievementsAttachmentByAttachmentId(Long attachmentId);

    /**
     * 查询成果附件列表
     * 
     * @param achievementsAttachment 成果附件
     * @return 成果附件集合
     */
    public List<AchievementsAttachment> selectAchievementsAttachmentList(AchievementsAttachment achievementsAttachment);
  /**
     * 根据id，type查询成果附件列表
     *
     * @param achievementsAttachment 成果附件
     * @return 成果附件集合
     */
    public List<AchievementsAttachment> selectAttachmentListByUserIdAndType(AchievementsAttachment achievementsAttachment);

    /**
     * 新增成果附件
     * 
     * @param achievementsAttachment 成果附件
     * @return 结果
     */
    public int insertAchievementsAttachment(AchievementsAttachment achievementsAttachment);

    /**
     * 修改成果附件
     * 
     * @param achievementsAttachment 成果附件
     * @return 结果
     */
    public int updateAchievementsAttachment(AchievementsAttachment achievementsAttachment);

    /**
     * 删除成果附件
     * 
     * @param attachmentId 成果附件主键
     * @return 结果
     */
    public int deleteAchievementsAttachmentByAttachmentId(Long attachmentId);

    /**
     * 批量删除成果附件
     * 
     * @param attachmentIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteAchievementsAttachmentByAttachmentIds(Long[] attachmentIds);
}
