package com.ruoyi.competition.domain;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 竞赛成果对象 achievements_competition
 * 
 * @author ruoyi
 * @date 2025-11-12
 */
public class AchievementsCompetition extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 竞赛id */
    @Excel(name = "竞赛id")
    private Long competitionId;

    /** 用户ID */
    private Long userId;

    /** 部门ID */
    private Long deptId;

    /** 竞赛名称 */
    @Excel(name = "竞赛名称")
    private String competitionName;

    /** 竞赛级别 */
    @Excel(name = "竞赛级别")
    private String competitionLevel;

    /** 竞赛类型 */
    @Excel(name = "竞赛类型")
    private String competitionType;

    /** 竞赛时间 */
    @JsonFormat(pattern = "yyyy-M-d'T'H:m:s")
    @Excel(name = "竞赛时间", width = 30, dateFormat = "yyyy-MM-dd'T'H:m:s")
    private Date competitionTime;

    /** 角色类型 */
    @Excel(name = "角色类型")
    private String roleType;

    /** 获奖等级 */
    @Excel(name = "获奖等级")
    private String awardLevel;

    /** 获奖日期 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "获奖日期", width = 30, dateFormat = "yyyy-MM-dd")
    private Date awardDate;

    /** 主办单位 */
    @Excel(name = "主办单位")
    private String organizer;

    /** 竞赛类别 */
    @Excel(name = "竞赛类别")
    private String competitionCategory;

    /** 团队人数 */
    @Excel(name = "团队人数")
    private Long teamSize;

    /** 团队名称 */
    @Excel(name = "团队名称")
    private String teamName;

    /** 指导的学生参赛（仅指导老师角色使用） */
    @Excel(name = "指导的学生参赛", readConverterExp = "仅指导老师角色使用")
    private String studentParticipants;

    /** 获奖证书编号 */
    @Excel(name = "获奖证书编号")
    private String awardCertificateNo;

    /** 竞赛官网 */
    @Excel(name = "竞赛官网")
    private String competitionWebsite;

    /** 审核状态 */
    @Excel(name = "审核状态")
    private String auditStatus;

    /** 创建时间 */
    @JsonFormat(pattern = "yyyy-M-d'T'H:m:s")
    @Excel(name = "竞赛时间", width = 30, dateFormat = "yyyy-MM-dd'T'H:m:s")
    private Date createdAt;

    /** 更新时间 */
    @JsonFormat(pattern = "yyyy-M-d'T'H:m:s")
    @Excel(name = "竞赛时间", width = 30, dateFormat = "yyyy-MM-dd'T'H:m:s")
    private Date updatedAt;

    public void setCompetitionId(Long competitionId) 
    {
        this.competitionId = competitionId;
    }

    public Long getCompetitionId() 
    {
        return competitionId;
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

    public void setCompetitionName(String competitionName) 
    {
        this.competitionName = competitionName;
    }

    public String getCompetitionName() 
    {
        return competitionName;
    }

    public void setCompetitionLevel(String competitionLevel) 
    {
        this.competitionLevel = competitionLevel;
    }

    public String getCompetitionLevel() 
    {
        return competitionLevel;
    }

    public void setCompetitionType(String competitionType) 
    {
        this.competitionType = competitionType;
    }

    public String getCompetitionType() 
    {
        return competitionType;
    }

    public void setCompetitionTime(Date competitionTime) 
    {
        this.competitionTime = competitionTime;
    }

    public Date getCompetitionTime() 
    {
        return competitionTime;
    }

    public void setRoleType(String roleType) 
    {
        this.roleType = roleType;
    }

    public String getRoleType() 
    {
        return roleType;
    }

    public void setAwardLevel(String awardLevel) 
    {
        this.awardLevel = awardLevel;
    }

    public String getAwardLevel() 
    {
        return awardLevel;
    }

    public void setAwardDate(Date awardDate) 
    {
        this.awardDate = awardDate;
    }

    public Date getAwardDate() 
    {
        return awardDate;
    }

    public void setOrganizer(String organizer) 
    {
        this.organizer = organizer;
    }

    public String getOrganizer() 
    {
        return organizer;
    }

    public void setCompetitionCategory(String competitionCategory) 
    {
        this.competitionCategory = competitionCategory;
    }

    public String getCompetitionCategory() 
    {
        return competitionCategory;
    }

    public void setTeamSize(Long teamSize) 
    {
        this.teamSize = teamSize;
    }

    public Long getTeamSize() 
    {
        return teamSize;
    }

    public void setTeamName(String teamName) 
    {
        this.teamName = teamName;
    }

    public String getTeamName() 
    {
        return teamName;
    }

    public void setStudentParticipants(String studentParticipants) 
    {
        this.studentParticipants = studentParticipants;
    }

    public String getStudentParticipants() 
    {
        return studentParticipants;
    }

    public void setAwardCertificateNo(String awardCertificateNo) 
    {
        this.awardCertificateNo = awardCertificateNo;
    }

    public String getAwardCertificateNo() 
    {
        return awardCertificateNo;
    }

    public void setCompetitionWebsite(String competitionWebsite) 
    {
        this.competitionWebsite = competitionWebsite;
    }

    public String getCompetitionWebsite() 
    {
        return competitionWebsite;
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
            .append("competitionId", getCompetitionId())
            .append("userId", getUserId())
            .append("deptId", getDeptId())
            .append("competitionName", getCompetitionName())
            .append("competitionLevel", getCompetitionLevel())
            .append("competitionType", getCompetitionType())
            .append("competitionTime", getCompetitionTime())
            .append("roleType", getRoleType())
            .append("awardLevel", getAwardLevel())
            .append("awardDate", getAwardDate())
            .append("organizer", getOrganizer())
            .append("competitionCategory", getCompetitionCategory())
            .append("teamSize", getTeamSize())
            .append("teamName", getTeamName())
            .append("studentParticipants", getStudentParticipants())
            .append("awardCertificateNo", getAwardCertificateNo())
            .append("competitionWebsite", getCompetitionWebsite())
            .append("auditStatus", getAuditStatus())
            .append("createdAt", getCreatedAt())
            .append("updatedAt", getUpdatedAt())
            .toString();
    }
}
