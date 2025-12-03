package com.ruoyi.textbook.domain;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 教材著作对象 achievements_textbook
 * 
 * @author xixia
 * @date 2025-11-16
 */
public class AchievementsTextbook extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 教材id */
    @Excel(name = "教材id")
    private Long textbookId;

    /** 用户ID */
    @Excel(name = "用户ID")
    private Long userId;

    /** 部门ID */
    @Excel(name = "部门ID")
    private Long deptId;

    /** 教材名称 */
    @Excel(name = "教材名称")
    private String textbookName;

    /** 作者角色 */
    @Excel(name = "作者角色")
    private String authorRole;

    /** 出版社 */
    @Excel(name = "出版社")
    private String pressName;

    /** ISBN号 */
    @Excel(name = "ISBN号")
    private String isbnNumber;

    /** 出版时间 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "出版时间", width = 30, dateFormat = "yyyy-MM-dd")
    private Date publishDate;

    /** 教材类型 */
    @Excel(name = "教材类型")
    private String textbookType;

    /** 版次 */
    @Excel(name = "版次")
    private String edition;

    /** 字数（万字） */
    @Excel(name = "字数", readConverterExp = "万=字")
    private Long wordCount;

    /** 使用院校（JSON格式） */
    @Excel(name = "使用院校", readConverterExp = "J=SON格式")
    private String usingInstitutions;

    /** 适用专业 */
    @Excel(name = "适用专业")
    private String applicableMajor;

    /** 教材层次 */
    @Excel(name = "教材层次")
    private String textbookLevel;

    /** 批准文号 */
    @Excel(name = "批准文号")
    private String approvalNumber;

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

    public void setTextbookId(Long textbookId) 
    {
        this.textbookId = textbookId;
    }

    public Long getTextbookId() 
    {
        return textbookId;
    }

    public void setUserId(Long userId) 
    {
        this.userId = userId;
    }

    public Long getUserId() 
    {
        return userId;
    }

    public void setDeptId(Long deptId) 
    {
        this.deptId = deptId;
    }

    public Long getDeptId() 
    {
        return deptId;
    }

    public void setTextbookName(String textbookName) 
    {
        this.textbookName = textbookName;
    }

    public String getTextbookName() 
    {
        return textbookName;
    }

    public void setAuthorRole(String authorRole) 
    {
        this.authorRole = authorRole;
    }

    public String getAuthorRole() 
    {
        return authorRole;
    }

    public void setPressName(String pressName) 
    {
        this.pressName = pressName;
    }

    public String getPressName() 
    {
        return pressName;
    }

    public void setIsbnNumber(String isbnNumber) 
    {
        this.isbnNumber = isbnNumber;
    }

    public String getIsbnNumber() 
    {
        return isbnNumber;
    }

    public void setPublishDate(Date publishDate) 
    {
        this.publishDate = publishDate;
    }

    public Date getPublishDate() 
    {
        return publishDate;
    }

    public void setTextbookType(String textbookType) 
    {
        this.textbookType = textbookType;
    }

    public String getTextbookType() 
    {
        return textbookType;
    }

    public void setEdition(String edition) 
    {
        this.edition = edition;
    }

    public String getEdition() 
    {
        return edition;
    }

    public void setWordCount(Long wordCount) 
    {
        this.wordCount = wordCount;
    }

    public Long getWordCount() 
    {
        return wordCount;
    }

    public void setUsingInstitutions(String usingInstitutions) 
    {
        this.usingInstitutions = usingInstitutions;
    }

    public String getUsingInstitutions() 
    {
        return usingInstitutions;
    }

    public void setApplicableMajor(String applicableMajor) 
    {
        this.applicableMajor = applicableMajor;
    }

    public String getApplicableMajor() 
    {
        return applicableMajor;
    }

    public void setTextbookLevel(String textbookLevel) 
    {
        this.textbookLevel = textbookLevel;
    }

    public String getTextbookLevel() 
    {
        return textbookLevel;
    }

    public void setApprovalNumber(String approvalNumber) 
    {
        this.approvalNumber = approvalNumber;
    }

    public String getApprovalNumber() 
    {
        return approvalNumber;
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

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("textbookId", getTextbookId())
            .append("userId", getUserId())
            .append("deptId", getDeptId())
            .append("textbookName", getTextbookName())
            .append("authorRole", getAuthorRole())
            .append("pressName", getPressName())
            .append("isbnNumber", getIsbnNumber())
            .append("publishDate", getPublishDate())
            .append("textbookType", getTextbookType())
            .append("edition", getEdition())
            .append("wordCount", getWordCount())
            .append("usingInstitutions", getUsingInstitutions())
            .append("applicableMajor", getApplicableMajor())
            .append("textbookLevel", getTextbookLevel())
            .append("approvalNumber", getApprovalNumber())
            .append("auditStatus", getAuditStatus())
            .append("createdAt", getCreatedAt())
            .append("updatedAt", getUpdatedAt())
            .toString();
    }
}
