package com.ruoyi.attachment.domain;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 成果附件对象 achievements_attachment
 * 
 * @author xixia
 * @date 2025-11-08
 */
public class AchievementsAttachment extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 附件ID */
    private Long attachmentId;

    /** 关联子表ID */
    @Excel(name = "关联子表ID")
    private Long userId;

    /** 附件类型 */
    @Excel(name = "附件类型")
    private String attachmentType;

    /** 文件名称 */
    @Excel(name = "文件名称")
    private String fileName;

    /** 文件路径 */
    @Excel(name = "文件路径")
    private String filePath;

    /** 文件大小（字节） */
    @Excel(name = "文件大小", readConverterExp = "字=节")
    private Long fileSize;

    /** 文件扩展名 */
    @Excel(name = "文件扩展名")
    private String fileExtension;

    /** 文件分类 */
    @Excel(name = "文件分类")
    private String fileCategory;

    /** 文件描述 */
    @Excel(name = "文件描述")
    private String description;

    /** 上传时间 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "上传时间", width = 30, dateFormat = "yyyy-MM-dd")
    private Date uploadTime;

    /** 上传用户ID */
    @Excel(name = "上传用户ID")
    private String uploadUserId;

    /** 下载次数 */
    @Excel(name = "下载次数")
    private Long downloadCount;

    public void setAttachmentId(Long attachmentId) 
    {
        this.attachmentId = attachmentId;
    }

    public Long getAttachmentId() 
    {
        return attachmentId;
    }

    public void setUserId(Long userId) 
    {
        this.userId = userId;
    }

    public Long getUserId() 
    {
        return userId;
    }

    public void setAttachmentType(String attachmentType) 
    {
        this.attachmentType = attachmentType;
    }

    public String getAttachmentType() 
    {
        return attachmentType;
    }

    public void setFileName(String fileName) 
    {
        this.fileName = fileName;
    }

    public String getFileName() 
    {
        return fileName;
    }

    public void setFilePath(String filePath) 
    {
        this.filePath = filePath;
    }

    public String getFilePath() 
    {
        return filePath;
    }

    public void setFileSize(Long fileSize) 
    {
        this.fileSize = fileSize;
    }

    public Long getFileSize() 
    {
        return fileSize;
    }

    public void setFileExtension(String fileExtension) 
    {
        this.fileExtension = fileExtension;
    }

    public String getFileExtension() 
    {
        return fileExtension;
    }

    public void setFileCategory(String fileCategory) 
    {
        this.fileCategory = fileCategory;
    }

    public String getFileCategory() 
    {
        return fileCategory;
    }

    public void setDescription(String description) 
    {
        this.description = description;
    }

    public String getDescription() 
    {
        return description;
    }

    public void setUploadTime(Date uploadTime) 
    {
        this.uploadTime = uploadTime;
    }

    public Date getUploadTime() 
    {
        return uploadTime;
    }

    public void setUploadUserId(String uploadUserId) 
    {
        this.uploadUserId = uploadUserId;
    }

    public String getUploadUserId() 
    {
        return uploadUserId;
    }

    public void setDownloadCount(Long downloadCount) 
    {
        this.downloadCount = downloadCount;
    }

    public Long getDownloadCount() 
    {
        return downloadCount;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("attachmentId", getAttachmentId())
            .append("userId", getUserId())
            .append("attachmentType", getAttachmentType())
            .append("fileName", getFileName())
            .append("filePath", getFilePath())
            .append("fileSize", getFileSize())
            .append("fileExtension", getFileExtension())
            .append("fileCategory", getFileCategory())
            .append("description", getDescription())
            .append("uploadTime", getUploadTime())
            .append("uploadUserId", getUploadUserId())
            .append("downloadCount", getDownloadCount())
            .append("createBy", getCreateBy())
            .append("createTime", getCreateTime())
            .append("updateBy", getUpdateBy())
            .append("updateTime", getUpdateTime())
            .toString();
    }
}
