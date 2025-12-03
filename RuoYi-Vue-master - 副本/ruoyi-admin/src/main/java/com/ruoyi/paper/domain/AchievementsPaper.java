package com.ruoyi.paper.domain;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 论文成果对象 achievements_paper
 * 
 * @author xixia
 * @date 2025-11-26
 */
public class AchievementsPaper extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 论文id */
    @Excel(name = "论文id")
    private Long paperId;

    /** 用户角色ID */
    @Excel(name = "角色ID")
    private Long userId;

    /** 论文标题 */
    @Excel(name = "论文标题")
    private String paperTitle;

    /** 论文类别 */
    @Excel(name = "论文类别")
    private String paperCategory;

    /** 研究方向 */
    @Excel(name = "研究方向")
    private String researchDirection;

    /** 作者信息（1:第一作者,2:第二作者等） */
    @Excel(name = "作者信息", readConverterExp = "1=:第一作者,2:第二作者等")
    private String authorInformation;

    /** 期刊名称 */
    @Excel(name = "期刊名称")
    private String journal;

    /** 发表时间 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "发表时间", width = 30, dateFormat = "yyyy-MM-dd")
    private Date publishDate;

    /** 卷号 */
    @Excel(name = "卷号")
    private String volume;

    /** 期号 */
    @Excel(name = "期号")
    private String issue;

    /** 页码范围 */
    @Excel(name = "页码范围")
    private String pageRange;

    /** DOI号 */
    @Excel(name = "DOI号")
    private String doi;

    /** 审核状态 */
    @Excel(name = "审核状态")
    private String auditStatus;

    /** 创建时间 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "创建时间", width = 30, dateFormat = "yyyy-MM-dd")
    private Date createdAt;

    /** 更新时间 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "更新时间", width = 30, dateFormat = "yyyy-MM-dd")
    private Date updatedAt;

    /** 部门id */
    @Excel(name = "部门id")
    private Long deptId;

    public void setPaperId(Long paperId)
    {
        this.paperId = paperId;
    }

    public Long getPaperId()
    {
        return paperId;
    }

    public void setUserId(Long userId)
    {
        this.userId = userId;
    }

    public Long getUserId()
    {
        return userId;
    }

    public void setPaperTitle(String paperTitle)
    {
        this.paperTitle = paperTitle;
    }

    public String getPaperTitle()
    {
        return paperTitle;
    }

    public void setPaperCategory(String paperCategory)
    {
        this.paperCategory = paperCategory;
    }

    public String getPaperCategory()
    {
        return paperCategory;
    }

    public void setResearchDirection(String researchDirection)
    {
        this.researchDirection = researchDirection;
    }

    public String getResearchDirection()
    {
        return researchDirection;
    }

    public void setAuthorInformation(String authorInformation)
    {
        this.authorInformation = authorInformation;
    }

    public String getAuthorInformation()
    {
        return authorInformation;
    }

    public void setJournal(String journal)
    {
        this.journal = journal;
    }

    public String getJournal()
    {
        return journal;
    }

    public void setPublishDate(Date publishDate)
    {
        this.publishDate = publishDate;
    }

    public Date getPublishDate()
    {
        return publishDate;
    }

    public void setVolume(String volume)
    {
        this.volume = volume;
    }

    public String getVolume()
    {
        return volume;
    }

    public void setIssue(String issue)
    {
        this.issue = issue;
    }

    public String getIssue()
    {
        return issue;
    }

    public void setPageRange(String pageRange)
    {
        this.pageRange = pageRange;
    }

    public String getPageRange()
    {
        return pageRange;
    }

    public void setDoi(String doi)
    {
        this.doi = doi;
    }

    public String getDoi()
    {
        return doi;
    }

    public void setAuditStatus(String auditStatus)
    {
        this.auditStatus = auditStatus;
    }

    public String getAuditStatus()
    {
        return auditStatus;
    }

    public void setCreatedAt(Date createdAt)
    {
        this.createdAt = createdAt;
    }

    public Date getCreatedAt()
    {
        return createdAt;
    }

    public void setUpdatedAt(Date updatedAt)
    {
        this.updatedAt = updatedAt;
    }

    public Date getUpdatedAt()
    {
        return updatedAt;
    }

    public void setDeptId(Long deptId)
    {
        this.deptId = deptId;
    }

    public Long getDeptId()
    {
        return deptId;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("paperId", getPaperId())
            .append("userId", getUserId())
            .append("paperTitle", getPaperTitle())
            .append("paperCategory", getPaperCategory())
            .append("researchDirection", getResearchDirection())
            .append("authorInformation", getAuthorInformation())
            .append("journal", getJournal())
            .append("publishDate", getPublishDate())
            .append("volume", getVolume())
            .append("issue", getIssue())
            .append("pageRange", getPageRange())
            .append("doi", getDoi())
            .append("auditStatus", getAuditStatus())
            .append("createdAt", getCreatedAt())
            .append("updatedAt", getUpdatedAt())
            .append("deptId", getDeptId())
            .toString();
    }
}
