package com.ruoyi.research.domain;

import java.math.BigDecimal;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 项目成果对象 achievements_research
 * 
 * @author xixia
 * @date 2025-12-16
 */
public class AchievementsResearch extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 项目id */
    @Excel(name = "项目id")
    private Long researchId;

    /** 用户ID */
    @Excel(name = "用户ID")
    private Long userId;

    /** 部门ID */
    @Excel(name = "部门ID")
    private Long deptId;

    /** 项目编号 */
    @Excel(name = "项目编号")
    private String projectNumber;

    /** 项目类别 */
    @Excel(name = "项目类别")
    private String projectCategory;

    /** 项目级别 */
    @Excel(name = "项目级别")
    private String projectLevel;

    /** 项目类型 */
    @Excel(name = "项目类型")
    private String projectType;

    /** 项目名称 */
    @Excel(name = "项目名称")
    private String projectName;

    /** 负责人 */
    @Excel(name = "负责人")
    private String principal;

    /** 参与人（JSON格式存储） */
    @Excel(name = "参与人", readConverterExp = "J=SON格式存储")
    private String participants;

    /** 立项单位 */
    @Excel(name = "立项单位")
    private String organizingUnit;

    /** 总经费（万元） */
    @Excel(name = "总经费", readConverterExp = "万=元")
    private BigDecimal totalFunding;

    /** 已到账经费 */
    @Excel(name = "已到账经费")
    private BigDecimal receivedFunding;

    /** 经费拨款单位 */
    @Excel(name = "经费拨款单位")
    private String fundingUnit;

    /** 开始时间 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "开始时间", width = 30, dateFormat = "yyyy-MM-dd")
    private Date startDate;

    /** 结束时间 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "结束时间", width = 30, dateFormat = "yyyy-MM-dd")
    private Date endDate;

    /** 实际结题时间 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "实际结题时间", width = 30, dateFormat = "yyyy-MM-dd")
    private Date actualEndDate;

    /** 项目状态 */
    @Excel(name = "项目状态")
    private String projectStatus;

    /** 结题状态 */
    @Excel(name = "结题状态")
    private String completionStatus;

    /** 研究领域 */
    @Excel(name = "研究领域")
    private String researchField;

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

    public void setResearchId(Long researchId) 
    {
        this.researchId = researchId;
    }

    public Long getResearchId() 
    {
        return researchId;
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

    public void setProjectNumber(String projectNumber) 
    {
        this.projectNumber = projectNumber;
    }

    public String getProjectNumber() 
    {
        return projectNumber;
    }

    public void setProjectCategory(String projectCategory) 
    {
        this.projectCategory = projectCategory;
    }

    public String getProjectCategory() 
    {
        return projectCategory;
    }

    public void setProjectLevel(String projectLevel) 
    {
        this.projectLevel = projectLevel;
    }

    public String getProjectLevel() 
    {
        return projectLevel;
    }

    public void setProjectType(String projectType) 
    {
        this.projectType = projectType;
    }

    public String getProjectType() 
    {
        return projectType;
    }

    public void setProjectName(String projectName) 
    {
        this.projectName = projectName;
    }

    public String getProjectName() 
    {
        return projectName;
    }

    public void setPrincipal(String principal) 
    {
        this.principal = principal;
    }

    public String getPrincipal() 
    {
        return principal;
    }

    public void setParticipants(String participants) 
    {
        this.participants = participants;
    }

    public String getParticipants() 
    {
        return participants;
    }

    public void setOrganizingUnit(String organizingUnit) 
    {
        this.organizingUnit = organizingUnit;
    }

    public String getOrganizingUnit() 
    {
        return organizingUnit;
    }

    public void setTotalFunding(BigDecimal totalFunding) 
    {
        this.totalFunding = totalFunding;
    }

    public BigDecimal getTotalFunding() 
    {
        return totalFunding;
    }

    public void setReceivedFunding(BigDecimal receivedFunding) 
    {
        this.receivedFunding = receivedFunding;
    }

    public BigDecimal getReceivedFunding() 
    {
        return receivedFunding;
    }

    public void setFundingUnit(String fundingUnit) 
    {
        this.fundingUnit = fundingUnit;
    }

    public String getFundingUnit() 
    {
        return fundingUnit;
    }

    public void setStartDate(Date startDate) 
    {
        this.startDate = startDate;
    }

    public Date getStartDate() 
    {
        return startDate;
    }

    public void setEndDate(Date endDate) 
    {
        this.endDate = endDate;
    }

    public Date getEndDate() 
    {
        return endDate;
    }

    public void setActualEndDate(Date actualEndDate) 
    {
        this.actualEndDate = actualEndDate;
    }

    public Date getActualEndDate() 
    {
        return actualEndDate;
    }

    public void setProjectStatus(String projectStatus) 
    {
        this.projectStatus = projectStatus;
    }

    public String getProjectStatus() 
    {
        return projectStatus;
    }

    public void setCompletionStatus(String completionStatus) 
    {
        this.completionStatus = completionStatus;
    }

    public String getCompletionStatus() 
    {
        return completionStatus;
    }

    public void setResearchField(String researchField) 
    {
        this.researchField = researchField;
    }

    public String getResearchField() 
    {
        return researchField;
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
            .append("researchId", getResearchId())
            .append("userId", getUserId())
            .append("deptId", getDeptId())
            .append("projectNumber", getProjectNumber())
            .append("projectCategory", getProjectCategory())
            .append("projectLevel", getProjectLevel())
            .append("projectType", getProjectType())
            .append("projectName", getProjectName())
            .append("principal", getPrincipal())
            .append("participants", getParticipants())
            .append("organizingUnit", getOrganizingUnit())
            .append("totalFunding", getTotalFunding())
            .append("receivedFunding", getReceivedFunding())
            .append("fundingUnit", getFundingUnit())
            .append("startDate", getStartDate())
            .append("endDate", getEndDate())
            .append("actualEndDate", getActualEndDate())
            .append("projectStatus", getProjectStatus())
            .append("completionStatus", getCompletionStatus())
            .append("researchField", getResearchField())
            .append("auditStatus", getAuditStatus())
            .append("createdAt", getCreatedAt())
            .append("updatedAt", getUpdatedAt())
            .toString();
    }
}
