package com.ruoyi.web.controller.common;

import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ruoyi.attachment.domain.AchievementsAttachment;
import com.ruoyi.attachment.service.IAchievementsAttachmentService;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.model.LoginUser;
import com.ruoyi.common.utils.SecurityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import com.ruoyi.common.config.RuoYiConfig;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.common.utils.file.FileUploadUtils;
import com.ruoyi.common.utils.file.FileUtils;
import com.ruoyi.framework.config.ServerConfig;

/**
 * 通用请求处理
 * 
 * @author ruoyi
 */
@RestController
@RequestMapping("/common")
public class CommonController  extends BaseController
{
    private static final Logger log = LoggerFactory.getLogger(CommonController.class);
    @Autowired
    private IAchievementsAttachmentService achievementsAttachmentService;


    @Autowired
    private ServerConfig serverConfig;

    private static final String FILE_DELIMETER = ",";

    /**
     * 通用下载请求
     * 
     * @param fileName 文件名称
     * @param delete 是否删除
     */
    @GetMapping("/download")
    public void fileDownload(String fileName, Boolean delete, HttpServletResponse response, HttpServletRequest request)
    {
        try
        {
            if (!FileUtils.checkAllowDownload(fileName))
            {
                throw new Exception(StringUtils.format("文件名称({})非法，不允许下载。 ", fileName));
            }
            String realFileName = System.currentTimeMillis() + fileName.substring(fileName.indexOf("_") + 1);
            String filePath = RuoYiConfig.getDownloadPath() + fileName;

            response.setContentType(MediaType.APPLICATION_OCTET_STREAM_VALUE);
            FileUtils.setAttachmentResponseHeader(response, realFileName);
            FileUtils.writeBytes(filePath, response.getOutputStream());
            if (delete)
            {
                FileUtils.deleteFile(filePath);
            }
        }
        catch (Exception e)
        {
            log.error("下载文件失败", e);
        }
    }
    /**
     * 通用上传请求（单个）- 完善版本
     * 在上传文件成功后自动向数据库插入附件记录
     */
    @PostMapping("/uploadT")
    public AjaxResult uploadFileT(@RequestParam("paperId") String paperId,
                                  @RequestParam("attachmenttype") String attachmenttype,
                                 @RequestParam("file") MultipartFile file) throws Exception
    {
        System.out.println("上传文件开始");
        System.out.println(paperId + "paperId");
        System.out.println(file);
        System.out.println(attachmenttype);

        try
        {
            // 上传文件路径
            String filePath = RuoYiConfig.getUploadPath();
            // 上传并返回新文件名称
            String fileName = FileUploadUtils.upload(filePath, file);
            String url = serverConfig.getUrl() + fileName;

            // 构建成果附件对象
            AchievementsAttachment attachment = new AchievementsAttachment();

            // 设置关联ID - 将paperId转换为Long类型
            if (StringUtils.isNumeric(paperId)) {
                attachment.setUserId(Long.parseLong(paperId));
            } else {
                // 如果paperId不是纯数字，可以根据业务需求处理
                // 例如记录日志或使用默认值，这里先设置为null
                attachment.setUserId(null);
            }

            // 设置文件基本信息
            attachment.setFileName(file.getOriginalFilename()); // 原始文件名
            attachment.setFilePath(fileName); // 服务器存储路径
            attachment.setFileSize(file.getSize()); // 文件大小
            attachment.setAttachmentType(attachmenttype);
            // 提取文件扩展名
            String originalFilename = file.getOriginalFilename();
            if (StringUtils.isNotEmpty(originalFilename) && originalFilename.contains(".")) {
                attachment.setFileExtension(originalFilename.substring(originalFilename.lastIndexOf(".") + 1));
            } else {
                attachment.setFileExtension("unknown");
            }

            // 设置文件类型（根据扩展名或业务逻辑判断）
            String extension = attachment.getFileExtension().toLowerCase();
            if (extension.matches("(jpg|jpeg|png|gif|bmp)")) {

                attachment.setFileCategory("image");
            } else if (extension.matches("(pdf)")) {

                attachment.setFileCategory("document");
            } else if (extension.matches("(doc|docx)")) {

                attachment.setFileCategory("document");
            } else if (extension.matches("(xls|xlsx)")) {

                attachment.setFileCategory("document");
            } else {

                attachment.setFileCategory("other");
            }

            // 设置时间信息
            attachment.setUploadTime(new Date());

            // 设置上传用户信息（从安全上下文获取）
            try {
                LoginUser loginUser = SecurityUtils.getLoginUser();
                if (loginUser != null) {
                    attachment.setUploadUserId(loginUser.getUserId().toString());
                } else {
                    attachment.setUploadUserId("system"); // 默认值
                }
            } catch (Exception e) {
                attachment.setUploadUserId("system"); // 异常情况使用默认值
            }

            // 初始化下载次数
            attachment.setDownloadCount(0L);

            // 设置文件描述（可以根据业务需求调整）
            attachment.setDescription("成果附件 - " + file.getOriginalFilename());

            // 插入数据库记录
            int insertResult = achievementsAttachmentService.insertAchievementsAttachment(attachment);

            if (insertResult <= 0) {
                // 如果数据库插入失败，可以选择删除已上传的文件以保持数据一致性
                // FileUtils.deleteFile(filePath + fileName);
                throw new Exception("文件记录插入数据库失败");
            }

            // 构建返回结果
            AjaxResult ajax = AjaxResult.success();
            ajax.put("url", url);
            ajax.put("fileName", fileName);
            ajax.put("newFileName", FileUtils.getName(fileName));
            ajax.put("originalFilename", file.getOriginalFilename());
            ajax.put("attachmentId", attachment.getAttachmentId()); // 返回插入的附件ID
            ajax.put("message", "文件上传并记录保存成功");

            return ajax;
        }
        catch (Exception e)
        {
            // 记录详细错误日志
            log.error("文件上传失败: {}", e.getMessage());
            e.printStackTrace();
            return AjaxResult.error("文件上传失败: " + e.getMessage());
        }
    }
    /**
     * 通用上传请求（单个）
     */
    @PostMapping("/upload")
    public AjaxResult uploadFile(@RequestParam("paperId") String paperId,
                                 @RequestParam("file") MultipartFile file) throws Exception
    {
        System.out.println("上传文件开始");
        System.out.println(paperId+"paperId");
        System.out.println( file);
        try
        {
            // 上传文件路径
            String filePath = RuoYiConfig.getUploadPath();
            // 上传并返回新文件名称
            String fileName = FileUploadUtils.upload(filePath, file);
            String url = serverConfig.getUrl() + fileName;
            AjaxResult ajax = AjaxResult.success();
            ajax.put("url", url);
            ajax.put("fileName", fileName);
            ajax.put("newFileName", FileUtils.getName(fileName));
            ajax.put("originalFilename", file.getOriginalFilename());

            return ajax;
        }
        catch (Exception e)
        {
            return AjaxResult.error(e.getMessage());
        }
    }
    
    /**
     * 通用上传请求（多个）
     */
    @PostMapping("/uploads")
//    public AjaxResult uploadFiles(List<MultipartFile> files) throws Exception
    public AjaxResult uploadFiles(@RequestParam("paperId") String paperId,
                                  @RequestParam("files") List<MultipartFile> files) throws Exception
    {
        System.out.println("上传文件开始");
        System.out.println(paperId+"paperId");
        System.out.println( files);
        try
        {
            // 上传文件路径
            String filePath = RuoYiConfig.getUploadPath();
            List<String> urls = new ArrayList<String>();
            List<String> fileNames = new ArrayList<String>();
            List<String> newFileNames = new ArrayList<String>();
            List<String> originalFilenames = new ArrayList<String>();
            for (MultipartFile file : files)
            {
                // 上传并返回新文件名称
                String fileName = FileUploadUtils.upload(filePath, file);
                String url = serverConfig.getUrl() + fileName;
                urls.add(url);
                fileNames.add(fileName);
                newFileNames.add(FileUtils.getName(fileName));
                originalFilenames.add(file.getOriginalFilename());
            }
            AjaxResult ajax = AjaxResult.success();
            ajax.put("urls", StringUtils.join(urls, FILE_DELIMETER));
            ajax.put("fileNames", StringUtils.join(fileNames, FILE_DELIMETER));
            ajax.put("newFileNames", StringUtils.join(newFileNames, FILE_DELIMETER));
            ajax.put("originalFilenames", StringUtils.join(originalFilenames, FILE_DELIMETER));
            return ajax;
        }
        catch (Exception e)
        {
            return AjaxResult.error(e.getMessage());
        }
    }

    /**
     * 本地资源通用下载
     */
//    @GetMapping("/download/resource")
//    public void resourceDownload(String resource, HttpServletRequest request, HttpServletResponse response)
//            throws Exception
//    {
//        try
//        {
//            if (!FileUtils.checkAllowDownload(resource))
//            {
//                throw new Exception(StringUtils.format("资源文件({})非法，不允许下载。 ", resource));
//            }
//            // 本地资源路径
//            String localPath = RuoYiConfig.getProfile();
//            // 数据库资源地址
//            String downloadPath = localPath + FileUtils.stripPrefix(resource);
//            // 下载名称
//            String downloadName = StringUtils.substringAfterLast(downloadPath, "/");
//            response.setContentType(MediaType.APPLICATION_OCTET_STREAM_VALUE);
//            FileUtils.setAttachmentResponseHeader(response, downloadName);
//            FileUtils.writeBytes(downloadPath, response.getOutputStream());
//            System.out.println(downloadPath);
//        }
//        catch (Exception e)
//        {
//            log.error("下载文件失败", e);
//        }
//    }
    /**
     * 本地资源通用下载 - JSON统一响应版本
     * 使用BaseController的success方法返回统一JSON格式
     */



    /**
     * 本地资源通用下载 - 修复版本
     * 添加文件存在性检查和错误处理
     */
    @GetMapping("/download/resource")
    public void resourceDownload(String resource, HttpServletRequest request, HttpServletResponse response) {
        try {
            // 1. 参数验证
            if (StringUtils.isEmpty(resource)) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write("资源路径不能为空");
                return;
            }

            if (!FileUtils.checkAllowDownload(resource)) {
                response.setStatus(HttpServletResponse.SC_FORBIDDEN);
                response.getWriter().write(StringUtils.format("资源文件({})非法，不允许下载。", resource));
                return;
            }

            // 2. 构建完整文件路径
            String localPath = RuoYiConfig.getProfile();
            String downloadPath = localPath + FileUtils.stripPrefix(resource);

            // 3. 检查文件是否存在
            File file = new File(downloadPath);
            if (!file.exists() || !file.isFile()) {
                log.warn("文件不存在: {}", downloadPath);
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                response.getWriter().write("文件不存在: " + FileUtils.getName(resource));
                return;
            }

            // 4. 检查文件大小，避免下载空文件
            if (file.length() == 0) {
                log.warn("文件为空: {}", downloadPath);
                response.setStatus(HttpServletResponse.SC_NO_CONTENT);
                response.getWriter().write("文件为空: " + FileUtils.getName(resource));
                return;
            }

            // 5. 设置响应头
            String downloadName = StringUtils.substringAfterLast(downloadPath, "/");
            response.setContentType(MediaType.APPLICATION_OCTET_STREAM_VALUE);
            FileUtils.setAttachmentResponseHeader(response, downloadName);

            // 6. 写入文件内容到响应流
            FileUtils.writeBytes(downloadPath, response.getOutputStream());

            log.info("文件下载成功: {} -> {}", downloadPath, downloadName);

        } catch (Exception e) {
            log.error("下载文件失败: resource={}, error={}", resource, e.getMessage(), e);

            try {
                // 避免重复提交响应头
                if (!response.isCommitted()) {
                    response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                    response.getWriter().write("文件下载失败: " + e.getMessage());
                }
            } catch (IOException ioException) {
                log.error("发送错误响应失败", ioException);
            }
        }
    }

    /**
     * 删除本地文件API
     * 提供安全的文件删除功能，包含权限验证和完整错误处理
     */
    @DeleteMapping("/delete")
    public AjaxResult deleteFile(@RequestParam String filePath,
                                 HttpServletRequest request) {
        try {
            // 1. 参数验证
            if (StringUtils.isEmpty(filePath)) {
                log.warn("删除文件失败: 文件路径为空");
                return error("文件路径不能为空");
            }

            // 2. 安全校验 - 防止路径遍历攻击
            if (!FileUtils.checkAllowDownload(filePath)) {
                log.warn("删除文件失败: 文件路径非法 - {}", filePath);
                return error("文件路径非法，不允许操作");
            }

            // 3. 构建完整文件路径

            String basePath = RuoYiConfig.getProfile();
            String fullPath = basePath + FileUtils.stripPrefix(filePath);
            System.out.println(fullPath);
            // 4. 规范化路径，防止目录遍历
            File file = new File(fullPath).getCanonicalFile();
            File baseDir = new File(basePath).getCanonicalFile();

            // 5. 检查路径是否在允许的目录内
            if (!file.getPath().startsWith(baseDir.getPath())) {
                log.warn("删除文件失败: 路径越界访问 - 原始路径: {}, 解析路径: {}", fullPath, file.getPath());
                return error("文件路径越界，不允许操作");
            }

            // 6. 检查文件是否存在
            if (!file.exists()) {
                log.warn("删除文件失败: 文件不存在 - {}", file.getPath());
                return error("文件不存在: " + FileUtils.getName(filePath));
            }

            // 7. 检查是否是文件（防止删除目录）
            if (!file.isFile()) {
                log.warn("删除文件失败: 路径不是文件 - {}", file.getPath());
                return error("指定路径不是文件: " + FileUtils.getName(filePath));
            }

            // 8. 检查文件权限
            if (!file.canWrite()) {
                log.warn("删除文件失败: 文件不可写 - {}", file.getPath());
                return error("文件不可写，权限不足");
            }

            // 9. 记录删除操作日志（安全审计）
            try {
                LoginUser loginUser = SecurityUtils.getLoginUser();
                String username = loginUser != null ? loginUser.getUsername() : "unknown";
                log.info("用户[{}]尝试删除文件: {}", username, file.getPath());
            } catch (Exception e) {
                log.warn("无法获取用户信息，继续执行删除操作");
            }

            // 10. 执行文件删除
            boolean deleteResult = FileUtils.deleteFile(file.getPath());

            if (deleteResult) {
                log.info("文件删除成功: {}", file.getPath());


                return success("文件删除成功");
            } else {
                log.error("文件删除操作失败: {}", file.getPath());
                return error("文件删除失败，可能是权限不足或文件被占用");
            }

        } catch (IOException e) {
            log.error("文件路径解析失败: filePath={}, error={}", filePath, e.getMessage(), e);
            return error("文件路径解析失败: " + e.getMessage());
        } catch (SecurityException e) {
            log.error("文件删除权限错误: filePath={}, error={}", filePath, e.getMessage(), e);
            return error("安全权限错误: " + e.getMessage());
        } catch (Exception e) {
            log.error("删除文件异常: filePath={}, error={}", filePath, e.getMessage(), e);
            return error("删除文件失败: " + e.getMessage());
        }
    }


}
