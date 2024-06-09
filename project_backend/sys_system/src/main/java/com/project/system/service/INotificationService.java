package com.project.system.service;

import java.util.List;
import com.project.system.domain.Notification;

public interface INotificationService {
    void notifyUser(String userName, String message);
    List<Notification> getNotificationsByUserName(String userName);
    void markNotificationAsRead(Long id);
}
