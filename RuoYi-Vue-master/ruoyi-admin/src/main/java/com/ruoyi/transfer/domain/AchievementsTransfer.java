package com.ruoyi.transfer.domain;

import java.math.BigDecimal;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 成果转化对象 achievements_transfer
 * 
 * @author xixia
 * @date 2025-12-09
 */
public class AchievementsTransfer extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 转化id */
    @Excel(name = "转化id")
    private Long transferId;

    /** 用户ID */
    @Excel(name = "用户ID")
    private Long userId;

    /** 部门ID */
    @Excel(name = "部门ID")
    private Long deptId;

    /** 成果名称 */
    @Excel(name = "成果名称")
    private String achievementName;

    /** 成果类型 */
    @Excel(name = "成果类型")
    private String achievementType;

    /** 成果编号 */
    @Excel(name = "成果编号")
    private String achievementNumber;

    /** 转化方式 */
    @Excel(name = "转化方式")
    private String transferMethod;

    /** 合作企业 */
    @Excel(name = "合作企业")
    private String partnerEnterprise;

    /** 转化金额（万元） */
    @Excel(name = "转化金额", readConverterExp = "万=元")
    private BigDecimal transferAmount;

    /** 转化时间 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "转化时间", width = 30, dateFormat = "yyyy-MM-dd")
    private Date transferDate;

    /** 转化内容描述 */
    @Excel(name = "转化内容描述")
    private String transferDescription;

    /** 有效期限 */
    @Excel(name = "有效期限")
    private String validityPeriod;

    /** 地域范围 */
    @Excel(name = "地域范围")
    private String territoryRange;

    /** 支付方式 */
    @Excel(name = "支付方式")
    private String paymentMethod;

    /** 转化状态 */
    @Excel(name = "转化状态")
    private String transferStatus;

    /** 是否独占许可 */
    @Excel(name = "是否独占许可")
    private Integer isExclusive;

    /** 经济效益 */
    @Excel(name = "经济效益")
    private String economicBenefits;

    /** 社会效益 */
    @Excel(name = "社会效益")
    private String socialBenefits;

    /** 联系人 */
    @Excel(name = "联系人")
    private String contactPerson;

    /** 联系电话 */
    @Excel(name = "联系电话")
    private String contactPhone;

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

    /** 归档类型 */
    @Excel(name = "归档类型")
    private String archivalType;

    public void setTransferId(Long transferId) 
    {
        this.transferId = transferId;
    }

    public Long getTransferId() 
    {
        return transferId;
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

    public void setAchievementName(String achievementName) 
    {
        this.achievementName = achievementName;
    }

    public String getAchievementName() 
    {
        return achievementName;
    }

    public void setAchievementType(String achievementType) 
    {
        this.achievementType = achievementType;
    }

    public String getAchievementType() 
    {
        return achievementType;
    }

    public void setAchievementNumber(String achievementNumber) 
    {
        this.achievementNumber = achievementNumber;
    }

    public String getAchievementNumber() 
    {
        return achievementNumber;
    }

    public void setTransferMethod(String transferMethod) 
    {
        this.transferMethod = transferMethod;
    }

    public String getTransferMethod() 
    {
        return transferMethod;
    }

    public void setPartnerEnterprise(String partnerEnterprise) 
    {
        this.partnerEnterprise = partnerEnterprise;
    }

    public String getPartnerEnterprise() 
    {
        return partnerEnterprise;
    }

    public void setTransferAmount(BigDecimal transferAmount) 
    {
        this.transferAmount = transferAmount;
    }

    public BigDecimal getTransferAmount() 
    {
        return transferAmount;
    }

    public void setTransferDate(Date transferDate) 
    {
        this.transferDate = transferDate;
    }

    public Date getTransferDate() 
    {
        return transferDate;
    }

    public void setTransferDescription(String transferDescription) 
    {
        this.transferDescription = transferDescription;
    }

    public String getTransferDescription() 
    {
        return transferDescription;
    }

    public void setValidityPeriod(String validityPeriod) 
    {
        this.validityPeriod = validityPeriod;
    }

    public String getValidityPeriod() 
    {
        return validityPeriod;
    }

    public void setTerritoryRange(String territoryRange) 
    {
        this.territoryRange = territoryRange;
    }

    public String getTerritoryRange() 
    {
        return territoryRange;
    }

    public void setPaymentMethod(String paymentMethod) 
    {
        this.paymentMethod = paymentMethod;
    }

    public String getPaymentMethod() 
    {
        return paymentMethod;
    }

    public void setTransferStatus(String transferStatus) 
    {
        this.transferStatus = transferStatus;
    }

    public String getTransferStatus() 
    {
        return transferStatus;
    }

    public void setIsExclusive(Integer isExclusive) 
    {
        this.isExclusive = isExclusive;
    }

    public Integer getIsExclusive() 
    {
        return isExclusive;
    }

    public void setEconomicBenefits(String economicBenefits) 
    {
        this.economicBenefits = economicBenefits;
    }

    public String getEconomicBenefits() 
    {
        return economicBenefits;
    }

    public void setSocialBenefits(String socialBenefits) 
    {
        this.socialBenefits = socialBenefits;
    }

    public String getSocialBenefits() 
    {
        return socialBenefits;
    }

    public void setContactPerson(String contactPerson) 
    {
        this.contactPerson = contactPerson;
    }

    public String getContactPerson() 
    {
        return contactPerson;
    }

    public void setContactPhone(String contactPhone) 
    {
        this.contactPhone = contactPhone;
    }

    public String getContactPhone() 
    {
        return contactPhone;
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

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("transferId", getTransferId())
            .append("userId", getUserId())
            .append("deptId", getDeptId())
            .append("achievementName", getAchievementName())
            .append("achievementType", getAchievementType())
            .append("achievementNumber", getAchievementNumber())
            .append("transferMethod", getTransferMethod())
            .append("partnerEnterprise", getPartnerEnterprise())
            .append("transferAmount", getTransferAmount())
            .append("transferDate", getTransferDate())
            .append("transferDescription", getTransferDescription())
            .append("validityPeriod", getValidityPeriod())
            .append("territoryRange", getTerritoryRange())
            .append("paymentMethod", getPaymentMethod())
            .append("transferStatus", getTransferStatus())
            .append("isExclusive", getIsExclusive())
            .append("economicBenefits", getEconomicBenefits())
            .append("socialBenefits", getSocialBenefits())
            .append("contactPerson", getContactPerson())
            .append("contactPhone", getContactPhone())
            .append("auditStatus", getAuditStatus())
            .append("createdAt", getCreatedAt())
            .append("updatedAt", getUpdatedAt())
            .append("archivalType", getArchivalType())
            .toString();
    }
}
