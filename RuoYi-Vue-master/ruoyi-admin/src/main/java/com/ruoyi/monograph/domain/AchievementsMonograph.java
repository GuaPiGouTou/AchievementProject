package com.ruoyi.monograph.domain;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 成果专著对象 achievements_monograph
 * 
 * @author xixia
 * @date 2025-12-07
 */
public class AchievementsMonograph extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 专著id */
    @Excel(name = "专著id")
    private Long monographId;

    /** 用户ID */
    @Excel(name = "用户ID")
    private Long userId;

    /** 部门id */
    @Excel(name = "部门id")
    private Long deptId;

    /** 专著名称 */
    @Excel(name = "专著名称")
    private String monographTitle;

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

    /** 专著类型 */
    @Excel(name = "专著类型")
    private String monographType;

    /** 版次（如：第一版、第二版等） */
    @Excel(name = "版次", readConverterExp = "如=：第一版、第二版等")
    private String edition;

    /** 字数（万字） */
    @Excel(name = "字数", readConverterExp = "万=字")
    private Long wordCount;

    /** 页数 */
    @Excel(name = "页数")
    private Long pageCount;

    /** 著作语言 */
    @Excel(name = "著作语言")
    private String language;

    /** 学科分类 */
    @Excel(name = "学科分类")
    private String subjectCategory;

    /** 是否被收录（1:是,0:否） */
    @Excel(name = "是否被收录", readConverterExp = "1=:是,0:否")
    private Integer isIncluded;

    /** 收录数据库（如：CSSCI、CSCD等） */
    @Excel(name = "收录数据库", readConverterExp = "如=：CSSCI、CSCD等")
    private String includedDatabase;

    /** 获奖情况 */
    @Excel(name = "获奖情况")
    private String awardSituation;

    /** 合著者信息（JSON格式存储） */
    @Excel(name = "合著者信息", readConverterExp = "J=SON格式存储")
    private String coAuthors;

    /** 国际标准书号 */
    @Excel(name = "国际标准书号")
    private String internationalStandardBookNumber;

    /** 中国分类号 */
    @Excel(name = "中国分类号")
    private String chinaClassificationNumber;

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

    public void setMonographId(Long monographId) 
    {
        this.monographId = monographId;
    }

    public Long getMonographId() 
    {
        return monographId;
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

    public void setMonographTitle(String monographTitle) 
    {
        this.monographTitle = monographTitle;
    }

    public String getMonographTitle() 
    {
        return monographTitle;
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

    public void setMonographType(String monographType) 
    {
        this.monographType = monographType;
    }

    public String getMonographType() 
    {
        return monographType;
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

    public void setPageCount(Long pageCount) 
    {
        this.pageCount = pageCount;
    }

    public Long getPageCount() 
    {
        return pageCount;
    }

    public void setLanguage(String language) 
    {
        this.language = language;
    }

    public String getLanguage() 
    {
        return language;
    }

    public void setSubjectCategory(String subjectCategory) 
    {
        this.subjectCategory = subjectCategory;
    }

    public String getSubjectCategory() 
    {
        return subjectCategory;
    }

    public void setIsIncluded(Integer isIncluded) 
    {
        this.isIncluded = isIncluded;
    }

    public Integer getIsIncluded() 
    {
        return isIncluded;
    }

    public void setIncludedDatabase(String includedDatabase) 
    {
        this.includedDatabase = includedDatabase;
    }

    public String getIncludedDatabase() 
    {
        return includedDatabase;
    }

    public void setAwardSituation(String awardSituation) 
    {
        this.awardSituation = awardSituation;
    }

    public String getAwardSituation() 
    {
        return awardSituation;
    }

    public void setCoAuthors(String coAuthors) 
    {
        this.coAuthors = coAuthors;
    }

    public String getCoAuthors() 
    {
        return coAuthors;
    }

    public void setInternationalStandardBookNumber(String internationalStandardBookNumber) 
    {
        this.internationalStandardBookNumber = internationalStandardBookNumber;
    }

    public String getInternationalStandardBookNumber() 
    {
        return internationalStandardBookNumber;
    }

    public void setChinaClassificationNumber(String chinaClassificationNumber) 
    {
        this.chinaClassificationNumber = chinaClassificationNumber;
    }

    public String getChinaClassificationNumber() 
    {
        return chinaClassificationNumber;
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
            .append("monographId", getMonographId())
            .append("userId", getUserId())
            .append("deptId", getDeptId())
            .append("monographTitle", getMonographTitle())
            .append("authorRole", getAuthorRole())
            .append("pressName", getPressName())
            .append("isbnNumber", getIsbnNumber())
            .append("publishDate", getPublishDate())
            .append("monographType", getMonographType())
            .append("edition", getEdition())
            .append("wordCount", getWordCount())
            .append("pageCount", getPageCount())
            .append("language", getLanguage())
            .append("subjectCategory", getSubjectCategory())
            .append("isIncluded", getIsIncluded())
            .append("includedDatabase", getIncludedDatabase())
            .append("awardSituation", getAwardSituation())
            .append("coAuthors", getCoAuthors())
            .append("internationalStandardBookNumber", getInternationalStandardBookNumber())
            .append("chinaClassificationNumber", getChinaClassificationNumber())
            .append("auditStatus", getAuditStatus())
            .append("createdAt", getCreatedAt())
            .append("updatedAt", getUpdatedAt())
            .toString();
    }
}
