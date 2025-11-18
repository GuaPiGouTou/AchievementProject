package com.ruoyi.paper.service.impl;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;

/*
* import com.ruoyi.common.annotation.DataScope;
import com.ruoyi.common.core.domain.entity.SysUser;
import com.ruoyi.common.utils.SecurityUtils;
import org.apache.http.HttpEntity;
import org.apache.http.NameValuePair;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;
* */
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.paper.mapper.AchievementsPaperMapper;
import com.ruoyi.paper.domain.AchievementsPaper;
import com.ruoyi.paper.service.IAchievementsPaperService;

/**
 * 论文成果Service业务层处理
 * 
 * @author xixia
 * @date 2025-11-05
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
//        try {
//        //创建Http工具 发送请求 响应
//        CloseableHttpClient httpClient =HttpClients.createDefault();
//        //创建Post请求
//        HttpPost httpPost = new HttpPost("https://httpbin.org/post");
//        //创建请求参数
//        List<NameValuePair> list = new ArrayList<NameValuePair>();
//        list.add(new BasicNameValuePair("name", achievementsPaperMapper.selectAchievementsPaperList(achievementsPaper).toString()));
//        //创建HttpEntity文本实现类对象，设置参数，设置编码
//        HttpEntity entity = new UrlEncodedFormEntity( list, "UTF-8");
//        //放入httpPost对象中
//        httpPost.setEntity(entity);
//        //创建响应对象
//        CloseableHttpResponse response = httpClient.execute(httpPost);
//        //转为为字符串类型
//        String result = EntityUtils.toString(response.getEntity());
//        //输出结果
//        System.out.println(result);
//        //释放资源
//        response.close();
//        httpClient.close();
//        } catch (Exception e) {
//            throw new RuntimeException(e);
//        }
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
