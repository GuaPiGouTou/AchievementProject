package com.ruoyi.software.domain;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 软著成果对象 achievements_software
 * 
 * @author xixia
 * @date 2025-12-07
 */
public class AchievementsSoftware extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 软著id */
    @Excel(name = "软著id")
    private Long softwareId;

    /** 用户ID */
    @Excel(name = "用户ID")
    private Long userId;

    /** 部门ID */
    @Excel(name = "部门ID")
    private Long deptId;

    /** 软件名称 */
    @Excel(name = "软件名称")
    private String softwareName;

    /** 软件版本 */
    @Excel(name = "软件版本")
    private String softwareVersion;

    /** 登记号 */
    @Excel(name = "登记号")
    private String certificateNo;

    /** 发表日期 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "发表日期", width = 30, dateFormat = "yyyy-MM-dd")
    private Date publishDate;

    /** 登记日期 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "登记日期", width = 30, dateFormat = "yyyy-MM-dd")
    private Date registerDate;

    /** 开发完成日期 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "开发完成日期", width = 30, dateFormat = "yyyy-MM-dd")
    private Date developmentDate;

    /** 编程语言 */
    @Excel(name = "编程语言")
    private String programmingLanguage;

    /** 软件类型 */
    @Excel(name = "软件类型")
    private String softwareType;

    /** 软著等级 */
    @Excel(name = "软著等级")
    private String softwareCopyrightCertificateLevel;

    /** 证书类型 */
    @Excel(name = "证书类型")
    private String certificateType;

    /** 主要功能 */
    @Excel(name = "主要功能")
    private String mainFunction;

    /** 应用领域 */
    @Excel(name = "应用领域")
    private String applicationField;

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

    public void setSoftwareId(Long softwareId) 
    {
        this.softwareId = softwareId;
    }

    public Long getSoftwareId() 
    {
        return softwareId;
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

    public void setSoftwareName(String softwareName) 
    {
        this.softwareName = softwareName;
    }

    public String getSoftwareName() 
    {
        return softwareName;
    }

    public void setSoftwareVersion(String softwareVersion) 
    {
        this.softwareVersion = softwareVersion;
    }

    public String getSoftwareVersion() 
    {
        return softwareVersion;
    }

    public void setCertificateNo(String certificateNo) 
    {
        this.certificateNo = certificateNo;
    }

    public String getCertificateNo() 
    {
        return certificateNo;
    }

    public void setPublishDate(Date publishDate) 
    {
        this.publishDate = publishDate;
    }

    public Date getPublishDate() 
    {
        return publishDate;
    }

    public void setRegisterDate(Date registerDate) 
    {
        this.registerDate = registerDate;
    }

    public Date getRegisterDate() 
    {
        return registerDate;
    }

    public void setDevelopmentDate(Date developmentDate) 
    {
        this.developmentDate = developmentDate;
    }

    public Date getDevelopmentDate() 
    {
        return developmentDate;
    }

    public void setProgrammingLanguage(String programmingLanguage) 
    {
        this.programmingLanguage = programmingLanguage;
    }

    public String getProgrammingLanguage() 
    {
        return programmingLanguage;
    }

    public void setSoftwareType(String softwareType) 
    {
        this.softwareType = softwareType;
    }

    public String getSoftwareType() 
    {
        return softwareType;
    }

    public void setSoftwareCopyrightCertificateLevel(String softwareCopyrightCertificateLevel) 
    {
        this.softwareCopyrightCertificateLevel = softwareCopyrightCertificateLevel;
    }

    public String getSoftwareCopyrightCertificateLevel() 
    {
        return softwareCopyrightCertificateLevel;
    }

    public void setCertificateType(String certificateType) 
    {
        this.certificateType = certificateType;
    }

    public String getCertificateType() 
    {
        return certificateType;
    }

    public void setMainFunction(String mainFunction) 
    {
        this.mainFunction = mainFunction;
    }

    public String getMainFunction() 
    {
        return mainFunction;
    }

    public void setApplicationField(String applicationField) 
    {
        this.applicationField = applicationField;
    }

    public String getApplicationField() 
    {
        return applicationField;
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
            .append("softwareId", getSoftwareId())
            .append("userId", getUserId())
            .append("deptId", getDeptId())
            .append("softwareName", getSoftwareName())
            .append("softwareVersion", getSoftwareVersion())
            .append("certificateNo", getCertificateNo())
            .append("publishDate", getPublishDate())
            .append("registerDate", getRegisterDate())
            .append("developmentDate", getDevelopmentDate())
            .append("programmingLanguage", getProgrammingLanguage())
            .append("softwareType", getSoftwareType())
            .append("softwareCopyrightCertificateLevel", getSoftwareCopyrightCertificateLevel())
            .append("certificateType", getCertificateType())
            .append("mainFunction", getMainFunction())
            .append("applicationField", getApplicationField())
            .append("auditStatus", getAuditStatus())
            .append("createdAt", getCreatedAt())
            .append("updatedAt", getUpdatedAt())
            .toString();
    }
}
