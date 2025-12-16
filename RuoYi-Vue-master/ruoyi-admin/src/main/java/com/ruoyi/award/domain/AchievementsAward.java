package com.ruoyi.award.domain;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 获奖成果对象 achievements_award
 * 
 * @author ruoyi
 * @date 2025-11-20
 */
public class AchievementsAward extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 奖项 */
    @Excel(name = "奖项ID")
    private Long awardId;

    /** 用户ID */
    @Excel(name = "用户ID")
    private Long userId;

    /** 部门ID */
    @Excel(name = "部门ID")
    private Long deptId;

    /** 奖项名称 */
    @Excel(name = "奖项名称")
    private String awardName;

    /** 获奖人 */
    @Excel(name = "获奖人")
    private String awardWinner;

    /** 颁奖单位 */
    @Excel(name = "颁奖单位")
    private String awardUnit;

    /** 获奖时间 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "获奖时间", width = 30, dateFormat = "yyyy-MM-dd")
    private Date awardDate;

    /** 奖项级别 */
    @Excel(name = "奖项级别")
    private String awardLevel;

    /** 奖项类别 */
    @Excel(name = "奖项类别")
    private String awardCategory;

    /** 获奖等次 */
    @Excel(name = "获奖等次")
    private String awardRanking;

    /** 颁奖典礼日期 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "颁奖典礼日期", width = 30, dateFormat = "yyyy-MM-dd")
    private Date awardCeremonyDate;

    /** 颁奖地点 */
    @Excel(name = "颁奖地点")
    private String awardCeremonyPlace;

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

    public void setAwardId(Long awardId) 
    {
        this.awardId = awardId;
    }

    public Long getAwardId() 
    {
        return awardId;
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

    public void setAwardName(String awardName) 
    {
        this.awardName = awardName;
    }

    public String getAwardName() 
    {
        return awardName;
    }

    public void setAwardWinner(String awardWinner) 
    {
        this.awardWinner = awardWinner;
    }

    public String getAwardWinner() 
    {
        return awardWinner;
    }

    public void setAwardUnit(String awardUnit) 
    {
        this.awardUnit = awardUnit;
    }

    public String getAwardUnit() 
    {
        return awardUnit;
    }

    public void setAwardDate(Date awardDate) 
    {
        this.awardDate = awardDate;
    }

    public Date getAwardDate() 
    {
        return awardDate;
    }

    public void setAwardLevel(String awardLevel) 
    {
        this.awardLevel = awardLevel;
    }

    public String getAwardLevel() 
    {
        return awardLevel;
    }

    public void setAwardCategory(String awardCategory) 
    {
        this.awardCategory = awardCategory;
    }

    public String getAwardCategory() 
    {
        return awardCategory;
    }

    public void setAwardRanking(String awardRanking) 
    {
        this.awardRanking = awardRanking;
    }

    public String getAwardRanking() 
    {
        return awardRanking;
    }

    public void setAwardCeremonyDate(Date awardCeremonyDate) 
    {
        this.awardCeremonyDate = awardCeremonyDate;
    }

    public Date getAwardCeremonyDate() 
    {
        return awardCeremonyDate;
    }

    public void setAwardCeremonyPlace(String awardCeremonyPlace) 
    {
        this.awardCeremonyPlace = awardCeremonyPlace;
    }

    public String getAwardCeremonyPlace() 
    {
        return awardCeremonyPlace;
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
            .append("awardId", getAwardId())
            .append("userId", getUserId())
            .append("deptId", getDeptId())
            .append("awardName", getAwardName())
            .append("awardWinner", getAwardWinner())
            .append("awardUnit", getAwardUnit())
            .append("awardDate", getAwardDate())
            .append("awardLevel", getAwardLevel())
            .append("awardCategory", getAwardCategory())
            .append("awardRanking", getAwardRanking())
            .append("awardCeremonyDate", getAwardCeremonyDate())
            .append("awardCeremonyPlace", getAwardCeremonyPlace())
            .append("auditStatus", getAuditStatus())
            .append("createdAt", getCreatedAt())
            .append("updatedAt", getUpdatedAt())
            .toString();
    }
}
