package com.ruoyi.transfer.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.transfer.mapper.AchievementsTransferMapper;
import com.ruoyi.transfer.domain.AchievementsTransfer;
import com.ruoyi.transfer.service.IAchievementsTransferService;

/**
 * 成果转化Service业务层处理
 * 
 * @author xixia
 * @date 2025-12-09
 */
@Service
public class AchievementsTransferServiceImpl implements IAchievementsTransferService 
{
    @Autowired
    private AchievementsTransferMapper achievementsTransferMapper;

    /**
     * 查询成果转化
     * 
     * @param transferId 成果转化主键
     * @return 成果转化
     */
    @Override
    public AchievementsTransfer selectAchievementsTransferByTransferId(Long transferId)
    {
        return achievementsTransferMapper.selectAchievementsTransferByTransferId(transferId);
    }

    /**
     * 查询成果转化列表
     * 
     * @param achievementsTransfer 成果转化
     * @return 成果转化
     */
    @Override
    public List<AchievementsTransfer> selectAchievementsTransferList(AchievementsTransfer achievementsTransfer)
    {
        return achievementsTransferMapper.selectAchievementsTransferList(achievementsTransfer);
    }

    /**
     * 新增成果转化
     * 
     * @param achievementsTransfer 成果转化
     * @return 结果
     */
    @Override
    public int insertAchievementsTransfer(AchievementsTransfer achievementsTransfer)
    {
        return achievementsTransferMapper.insertAchievementsTransfer(achievementsTransfer);
    }

    /**
     * 修改成果转化
     * 
     * @param achievementsTransfer 成果转化
     * @return 结果
     */
    @Override
    public int updateAchievementsTransfer(AchievementsTransfer achievementsTransfer)
    {
        return achievementsTransferMapper.updateAchievementsTransfer(achievementsTransfer);
    }

    /**
     * 批量删除成果转化
     * 
     * @param transferIds 需要删除的成果转化主键
     * @return 结果
     */
    @Override
    public int deleteAchievementsTransferByTransferIds(Long[] transferIds)
    {
        return achievementsTransferMapper.deleteAchievementsTransferByTransferIds(transferIds);
    }

    /**
     * 删除成果转化信息
     * 
     * @param transferId 成果转化主键
     * @return 结果
     */
    @Override
    public int deleteAchievementsTransferByTransferId(Long transferId)
    {
        return achievementsTransferMapper.deleteAchievementsTransferByTransferId(transferId);
    }
}
