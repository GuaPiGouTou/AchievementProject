package com.ruoyi.attachment.controller;

import java.io.File;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletResponse;

import com.ruoyi.ContestFeign.ContestFeignClient;
import com.ruoyi.ContestFeign.IdsRequest;
import com.ruoyi.attachment.domain.ExportRequestDTO;
import com.ruoyi.attachment.service.IAchievementsAttachmentService;
import com.ruoyi.common.config.RuoYiConfig;
import com.ruoyi.common.utils.ServletUtils;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.common.utils.file.FileUtils;
import com.ruoyi.framework.config.ServerConfig;
import com.ruoyi.paper.domain.AchievementsPaper;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.attachment.domain.AchievementsAttachment;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 成果附件Controller
 * 
 * @author xixia
 * @date 2025-11-08
 */
@RestController
@RequestMapping("/attachment/attachment")
public class AchievementsAttachmentController extends BaseController
{
    @Autowired
    private IAchievementsAttachmentService achievementsAttachmentService;
    @Autowired
    private ServerConfig serverConfig;
    @Autowired
    private ContestFeignClient contestFeignClient;
    /**
     * 查询成果附件列表
     */
    @PreAuthorize("@ss.hasPermi('attachment:attachment:list')")
    @GetMapping("/list")
    public AjaxResult list(AchievementsAttachment achievementsAttachment)
    {
        Integer pageNum = ServletUtils.getParameterToInt("pageNum");
        Integer pageSize = ServletUtils.getParameterToInt("pageSize");
        AjaxResult res = new AjaxResult();
        // 使用Feign客户端调用远程服务
        try {
            achievementsAttachment.setUserId(getUserId());
            achievementsAttachment.setDeptId(getDeptId());

            res = contestFeignClient.selectAttachmentList(getUserId(), getDeptId(), pageNum, pageSize);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

        return res;
    }

    /**
     * 导出成果附件列表
     */
    @PreAuthorize("@ss.hasPermi('attachment:attachment:export')")
    @Log(title = "成果附件", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public AjaxResult export(HttpServletResponse response,@RequestBody ExportRequestDTO<AchievementsAttachment> exportRequestDTO)
    {
        // 1. 获取参数
        List<String> hiddenColumns = exportRequestDTO.getShowColumns();
        Long[] ids = exportRequestDTO.getIdList();

        // 2. 构造请求 (使用上面修改后的 IdsRequest)
        IdsRequest idsRequest = new IdsRequest(getUserId(), getDeptId(), ids);

        // 3. Feign 调用
        AjaxResult result = contestFeignClient.selectAttachmentByIds(idsRequest);

        // 4. 判断 total (处理 null 和 类型转换)
        Object totalObj = result.get("total");
        int total = (totalObj == null) ? 0 : Integer.parseInt(totalObj.toString());

        if (total == 0) {
            return AjaxResult.warn("未查询到数据");
        }

        // 5. 转换 List (从 LinkedHashMap 转为 实体对象)
        Object rows = result.get("rows");
        // 利用 FastJson 或 Jackson 进行 "序列化再反序列化" 来转换对象
        String jsonString = com.alibaba.fastjson2.JSON.toJSONString(rows);
        List<AchievementsAttachment> list = com.alibaba.fastjson2.JSON.parseArray(jsonString, AchievementsAttachment.class);

        // 6. 导出 Excel
        ExcelUtil<AchievementsAttachment> util = new ExcelUtil<>(AchievementsAttachment.class);
        if (hiddenColumns != null && !hiddenColumns.isEmpty()) {
            util.showColumn(hiddenColumns.toArray(new String[0]));
        }

        // 执行导出
        util.exportExcel(response, list, "附件成果数据");

        //返回 success
        return null;
    }

    /**
     * 获取成果附件详细信息
     */
    @PreAuthorize("@ss.hasPermi('attachment:attachment:query')")
    @GetMapping(value = "/{attachmentId}")
    public AjaxResult getInfo(@PathVariable("attachmentId") Long attachmentId)
    {
        AjaxResult res = new AjaxResult();
        // 使用Feign客户端调用远程服务
        try {
            res = contestFeignClient.selectAttachmentById(getUserId(),getDeptId(),attachmentId);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return res;
    }

    /**
     * 根据id，type获取成果附件详细信息
     */
    @PreAuthorize("@ss.hasPermi('attachment:attachment:query')")
    @GetMapping(value = "/idAndType")
    public AjaxResult getInfoByIdandType(AchievementsAttachment achievementsAttachment)
    {
        System.out.println(achievementsAttachment);
        return success(achievementsAttachmentService.selectAttachmentListByUserIdAndType(achievementsAttachment));
    }

    /**
     * 新增成果附件
     */
    @PreAuthorize("@ss.hasPermi('attachment:attachment:add')")
    @Log(title = "成果附件", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody AchievementsAttachment achievementsAttachment)
    {
        AjaxResult res = new AjaxResult();
        // 使用Feign客户端调用远程服务
        try {
            achievementsAttachment.setUserId(getUserId());
            achievementsAttachment.setDeptId(getDeptId());

            System.out.println(achievementsAttachment);
            res = contestFeignClient.insertAttachment(achievementsAttachment);

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return res;    }

    /**
     * 修改成果附件
     */
    @PreAuthorize("@ss.hasPermi('attachment:attachment:edit')")
    @Log(title = "成果附件", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody AchievementsAttachment achievementsAttachment)
    {
        AjaxResult res = new AjaxResult();
        // 使用Feign客户端调用远程服务
        try {
            achievementsAttachment.setUserId(getUserId());
            achievementsAttachment.setDeptId(getDeptId());

            res = contestFeignClient.updateAttachment(achievementsAttachment);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return res;    }

    /**
     * 删除成果附件
     */
    @PreAuthorize("@ss.hasPermi('attachment:attachment:remove')")
    @Log(title = "成果附件", businessType = BusinessType.DELETE)
	@DeleteMapping("/{attachmentIds}")
    public AjaxResult remove(@PathVariable Long[] attachmentIds)
    {
        try {
            // 1. 参数验证
            if (attachmentIds == null || attachmentIds.length == 0) {
                return AjaxResult.error("附件ID不能为空");
            }

            int successCount = 0;
            int failureCount = 0;
            List<String> messages = new ArrayList<>();

            // 2. 遍历处理每个附件ID
            for (Long attachmentId : attachmentIds) {
                try {
                    // 查询附件信息
                    AchievementsAttachment attachment = achievementsAttachmentService
                            .selectAchievementsAttachmentByAttachmentId(attachmentId);
                    String fileName = attachment.getFileName();
                    if (attachment == null) {
                        messages.add("附件 " + fileName + " 不存在");
                        failureCount++;
                        continue;
                    }

                    // 删除物理文件
                    String filePath = attachment.getFilePath();
                    if (StringUtils.isNotEmpty(filePath)) {
                        boolean fileDeleted = FileUtils.deleteFile(filePath);
                        if (!fileDeleted) {
                            messages.add("附件 " + fileName + " 物理文件删除失败");
                        }
                    }

                    // 删除数据库记录
                    int deleteResult = achievementsAttachmentService
                            .deleteAchievementsAttachmentByAttachmentIds(new Long[]{attachmentId});

                    if (deleteResult > 0) {
                        successCount++;

                    } else {
                        failureCount++;
                        messages.add("附件 " + fileName + " 数据库删除失败");
                    }

                } catch (Exception e) {
                    failureCount++;
                    messages.add("处理附件Id " + attachmentId + " 时发生错误: " + e.getMessage());

                }
            }

            // 3. 构建返回结果
            if (failureCount == 0) {
                return AjaxResult.success("成功删除 " + successCount + " 个附件");
            } else {
                String message = "删除完成: 成功 " + successCount + " 个, 失败 " + failureCount + " 个. " +
                        String.join("; ", messages);
                return successCount > 0 ?
                        AjaxResult.success(message) :
                        AjaxResult.error(message);
            }

        } catch (Exception e) {
            return AjaxResult.error("删除操作异常: " + e.getMessage());
        }
    }

    /**
     * 文件下载检查接口 - 返回JSON结果
     */
    @GetMapping("/download/check")
    public AjaxResult checkFileDownload(@RequestParam String resource) {
        System.out.println( resource);
        try {
            // 1. 参数验证
            if (StringUtils.isEmpty(resource)) {
                return error("资源路径不能为空");
            }

            if (!FileUtils.checkAllowDownload(resource)) {
                return error(StringUtils.format("资源文件({})非法，不允许下载。", resource));
            }

            // 2. 构建完整文件路径
            String localPath = RuoYiConfig.getProfile();
            String downloadPath = localPath + FileUtils.stripPrefix(resource);

            // 3. 检查文件是否存在
            File file = new File(downloadPath);
            if (!file.exists() || !file.isFile()) {

                return error("文件不存在: " + FileUtils.getName(resource));
            }

            // 4. 检查文件大小，避免空文件
            if (file.length() == 0) {

                return error("文件为空: " + FileUtils.getName(resource));
            }

            // 5. 构建文件信息响应
            String downloadName = StringUtils.substringAfterLast(downloadPath, "/");
            String fileUrl = serverConfig.getUrl() + "/common/download/stream?file=" +
                    URLEncoder.encode(downloadPath, "UTF-8");

            // 创建文件信息对象
            Map<String, Object> fileInfo = new HashMap<>();
            fileInfo.put("fileName", downloadName);
            fileInfo.put("filePath", downloadPath);
            fileInfo.put("fileSize", file.length());
            fileInfo.put("downloadUrl", fileUrl);
            fileInfo.put("canDownload", true);



            // 使用BaseController的success方法返回统一JSON格式
            return success(fileInfo);

        } catch (Exception e) {

            return error("文件下载检查失败: " + e.getMessage());
        }
    }


}
