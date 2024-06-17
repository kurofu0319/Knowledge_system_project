package com.project.web.controller.system;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import com.project.common.core.controller.BaseController;
import com.project.common.core.domain.AjaxResult;
import com.project.system.domain.SysNotification;
import com.project.system.service.ISysNotificationService;

/**
 * 通知管理
 *
 * author Furui
 */
@RestController
@RequestMapping("/system/notification")
public class SysNotificationController extends BaseController {

    @Autowired
    private ISysNotificationService notificationService;

    @GetMapping("/list")
    public AjaxResult list(@RequestParam String userName) {
        List<SysNotification> notifications = notificationService.selectNotificationList(userName);

        return AjaxResult.success(notifications);
    }

    @GetMapping("/{id}")
    public AjaxResult getInfo(@PathVariable Long id) {
        SysNotification notification = notificationService.selectNotificationById(id);
        return AjaxResult.success(notification);
    }

    @PostMapping
    public AjaxResult add(@RequestBody SysNotification notification) {
        notificationService.insertNotification(notification);
        return AjaxResult.success();
    }

    @PutMapping
    public AjaxResult edit(@RequestBody SysNotification notification) {
        notificationService.updateNotification(notification);
        return AjaxResult.success();
    }

    @DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids) {
        notificationService.deleteNotificationByIds(ids);
        return AjaxResult.success();
    }

    @PostMapping("/read/{id}")
    public AjaxResult markAsRead(@PathVariable Long id) {
        notificationService.markNotificationAsRead(id);
        return AjaxResult.success();
    }
}
