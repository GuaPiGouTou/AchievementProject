package com.ruoyi.patent.domain;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 专利成果对象 achievements_patent
 * 
 * @author xixia
 * @date 2025-12-09
 */
public class AchievementsPatent extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 专利id */
    @Excel(name = "专利id")
    private Long patentId;

    /** 用户ID */
    @Excel(name = "用户ID")
    private Long userId;

    /** 部门ID */
    @Excel(name = "部门ID")
    private Long deptId;

    /** 专利名称 */
    @Excel(name = "专利名称")
    private String patentName;

    /** 专利号 */
    @Excel(name = "专利号")
    private String patentNo;

    /** 专利类型 */
    @Excel(name = "专利类型")
    private String patentType;

    /** 发明人顺序 */
    @Excel(name = "发明人顺序")
    private String authorOrder;

    /** 申请日期 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "申请日期", width = 30, dateFormat = "yyyy-MM-dd")
    private Date applicationDate;

    /** 授权日期 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "授权日期", width = 30, dateFormat = "yyyy-MM-dd")
    private Date authorizationDate;

    /** 公布日期 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "公布日期", width = 30, dateFormat = "yyyy-MM-dd")
    private Date publicationDate;

    /** 公布号 */
    @Excel(name = "公布号")
    private String publicationNo;


    public String getAuthorizationNo() {
        return authorizationNo;
    }

    public void setAuthorizationNo(String authorizationNo) {
        this.authorizationNo = authorizationNo;
    }

    /** 公布号 */
    @Excel(name = "授权号")
    private String authorizationNo;

    /** 专利有效期 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "专利有效期", width = 30, dateFormat = "yyyy-MM-dd")
    private Date patentValidity;

    /** 专利所属学科 */
    @Excel(name = "专利所属学科")
    private String patentSubject;

    /** 专利状态 */
    @Excel(name = "专利状态")
    private String patentStatus;

    /** 技术领域 */
    @Excel(name = "技术领域")
    private String technicalField;

    /** 专利法律状态 */
    @Excel(name = "专利法律状态")
    private String legalStatus;

    /** 证书类型 */
    @Excel(name = "证书类型")
    private String certificateType;

    /** 审核状态 */
    @Excel(name = "审核状态")
    private String auditStatus;

    /** 创建时间 */
    @JsonFormat(pattern = "yyyy-M-d'T'H:m:s")
    @Excel(name = "创建时间", width = 30, dateFormat = "yyyy-M-d'T'H:m:s")
    private Date createdAt;

    /** 更新时间 */
    @JsonFormat(pattern = "yyyy-M-d'T'H:m:s")
    @Excel(name = "更新时间", width = 30, dateFormat = "yyyy-M-d'T'H:m:s")
    private Date updatedAt;

    /** 归档类别 */
    @Excel(name = "归档类别")
    private String archivalType;

    /** 成果项目类型 */
    @Excel(name = "成果项目类型")
    private String achievementsType;

    public void setPatentId(Long patentId) 
    {
        this.patentId = patentId;
    }

    public Long getPatentId() 
    {
        return patentId;
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

    public void setPatentName(String patentName) 
    {
        this.patentName = patentName;
    }

    public String getPatentName() 
    {
        return patentName;
    }

    public void setPatentNo(String patentNo) 
    {
        this.patentNo = patentNo;
    }

    public String getPatentNo() 
    {
        return patentNo;
    }

    public void setPatentType(String patentType) 
    {
        this.patentType = patentType;
    }

    public String getPatentType() 
    {
        return patentType;
    }

    public void setAuthorOrder(String authorOrder)
    {
        this.authorOrder = authorOrder;
    }

    public String getAuthorOrder()
    {
        return authorOrder;
    }

    public void setApplicationDate(Date applicationDate) 
    {
        this.applicationDate = applicationDate;
    }

    public Date getApplicationDate() 
    {
        return applicationDate;
    }

    public void setAuthorizationDate(Date authorizationDate) 
    {
        this.authorizationDate = authorizationDate;
    }

    public Date getAuthorizationDate() 
    {
        return authorizationDate;
    }

    public void setPublicationDate(Date publicationDate) 
    {
        this.publicationDate = publicationDate;
    }

    public Date getPublicationDate() 
    {
        return publicationDate;
    }

    public void setPublicationNo(String publicationNo) 
    {
        this.publicationNo = publicationNo;
    }

    public String getPublicationNo() 
    {
        return publicationNo;
    }

    public void setPatentValidity(Date patentValidity) 
    {
        this.patentValidity = patentValidity;
    }

    public Date getPatentValidity() 
    {
        return patentValidity;
    }

    public void setPatentSubject(String patentSubject) 
    {
        this.patentSubject = patentSubject;
    }

    public String getPatentSubject() 
    {
        return patentSubject;
    }

    public void setPatentStatus(String patentStatus) 
    {
        this.patentStatus = patentStatus;
    }

    public String getPatentStatus() 
    {
        return patentStatus;
    }


    public void setTechnicalField(String technicalField) 
    {
        this.technicalField = technicalField;
    }

    public String getTechnicalField() 
    {
        return technicalField;
    }

    public void setLegalStatus(String legalStatus) 
    {
        this.legalStatus = legalStatus;
    }

    public String getLegalStatus() 
    {
        return legalStatus;
    }

    public void setCertificateType(String certificateType) 
    {
        this.certificateType = certificateType;
    }

    public String getCertificateType() 
    {
        return certificateType;
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

    public void setArchivalType(String archivalType)
    {
        this.archivalType = archivalType;
    }

    public String getArchivalType()
    {
        return archivalType;
    }

    public void setAchievementsType(String achievementsType)
    {
        this.achievementsType = achievementsType;
    }

    public String getAchievementsType()
    {
        return achievementsType;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("patentId", getPatentId())
            .append("userId", getUserId())
            .append("deptId", getDeptId())
            .append("patentName", getPatentName())
            .append("patentNo", getPatentNo())
            .append("patentType", getPatentType())
            .append("authorOrder", getAuthorOrder())
            .append("applicationDate", getApplicationDate())
            .append("authorizationDate", getAuthorizationDate())
            .append("publicationDate", getPublicationDate())
            .append("publicationNo", getPublicationNo())
            .append("authorizationNo", getAuthorizationNo())
            .append("patentValidity", getPatentValidity())
            .append("patentSubject", getPatentSubject())
            .append("patentStatus", getPatentStatus())
            .append("technicalField", getTechnicalField())
            .append("legalStatus", getLegalStatus())
            .append("certificateType", getCertificateType())
            .append("auditStatus", getAuditStatus())
            .append("createdAt", getCreatedAt())
            .append("updatedAt", getUpdatedAt())
            .append("archivalType", getArchivalType())
            .append("achievementsType", getAchievementsType())
            .toString();
    }
}
