package com.ruoyi.transfer.mapper;

import java.util.List;
import com.ruoyi.transfer.domain.AchievementsTransfer;

/**
 * 成果转化Mapper接口
 * 
 * @author xixia
 * @date 2025-12-09
 */
public interface AchievementsTransferMapper 
{
    /**
     * 查询成果转化
     * 
     * @param transferId 成果转化主键
     * @return 成果转化
     */
    public AchievementsTransfer selectAchievementsTransferByTransferId(Long transferId);

    /**
     * 查询成果转化列表
     * 
     * @param achievementsTransfer 成果转化
     * @return 成果转化集合
     */
    public List<AchievementsTransfer> selectAchievementsTransferList(AchievementsTransfer achievementsTransfer);

    /**
     * 新增成果转化
     * 
     * @param achievementsTransfer 成果转化
     * @return 结果
     */
    public int insertAchievementsTransfer(AchievementsTransfer achievementsTransfer);

    /**
     * 修改成果转化
     * 
     * @param achievementsTransfer 成果转化
     * @return 结果
     */
    public int updateAchievementsTransfer(AchievementsTransfer achievementsTransfer);

    /**
     * 删除成果转化
     * 
     * @param transferId 成果转化主键
     * @return 结果
     */
    public int deleteAchievementsTransferByTransferId(Long transferId);

    /**
     * 批量删除成果转化
     * 
     * @param transferIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteAchievementsTransferByTransferIds(Long[] transferIds);
}
