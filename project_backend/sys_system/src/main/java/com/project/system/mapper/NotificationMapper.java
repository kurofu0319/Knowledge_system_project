package com.project.system.mapper;

import java.util.List;
import com.project.system.domain.Notification;

public interface NotificationMapper {
    void insertNotification(Notification notification);
    List<Notification> selectNotificationsByUserName(String userName);
    void markNotificationAsRead(Long id);
}
