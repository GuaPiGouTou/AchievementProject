package com.ruoyi.attachment.service.impl;

import java.util.Collections;
import java.util.List;
import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.common.utils.api.RestTemplateConfig;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import com.ruoyi.attachment.mapper.AchievementsAttachmentMapper;
import com.ruoyi.attachment.domain.AchievementsAttachment;
import com.ruoyi.attachment.service.IAchievementsAttachmentService;
import org.springframework.web.client.RestTemplate;

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
     * 根据id，type查询成果附件列表
     *
     * @param achievementsAttachment 成果附件
     * @return 成果附件
     */
    @Override
    public List<AchievementsAttachment> selectAttachmentListByUserIdAndType(AchievementsAttachment achievementsAttachment) {
       /*
       *
       RestTemplate restTemplate = new RestTemplate();
        // 设置请求头，指定JSON格式
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        // 如果需要认证，可以添加Token等
        // headers.set("Authorization", "Bearer " + yourToken);

        // 将对象封装到HttpEntity中
        HttpEntity<AchievementsAttachment> request = new HttpEntity<>(achievementsAttachment, headers);
        String apiUrl   = "http://localhost:8080/api/attachment/idAndType";
        // 发送POST请求
//        AchievementsAttachment createdAttachment = restTemplate.postForObject(
//                apiUrl,
//                request,
//                AchievementsAttachment.class
//        );
        String url = "http://jsonplaceholder.typicode.com/posts/1";
        String res = restTemplate.getForObject(url, String.class);
        System.out.println(res);
       * */
        List<AchievementsAttachment> resACh = achievementsAttachmentMapper.selectAttachmentListByUserIdAndType(achievementsAttachment);
        System.out.println(resACh);
        return resACh;

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
