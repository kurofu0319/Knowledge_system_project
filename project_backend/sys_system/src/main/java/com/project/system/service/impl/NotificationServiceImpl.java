package com.project.system.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.project.system.domain.Notification;
import com.project.system.mapper.NotificationMapper;
import com.project.system.service.INotificationService;

@Service
public class NotificationServiceImpl implements INotificationService {

    @Autowired
    private NotificationMapper notificationMapper;

    @Override
    public void notifyUser(String userName, String message) {
        Notification notification = new Notification();
        notification.setUserName(userName);
        notification.setMessage(message);
        notificationMapper.insertNotification(notification);
    }

    @Override
    public List<Notification> getNotificationsByUserName(String userName) {
        return notificationMapper.selectNotificationsByUserName(userName);
    }

    @Override
    public void markNotificationAsRead(Long id) {
        notificationMapper.markNotificationAsRead(id);
    }
}
