package com.project.system.service.impl;

import com.project.system.domain.ForumLike;
import com.project.system.domain.ForumReply;
import com.project.system.domain.SysNotification;
import com.project.system.mapper.SysNotificationMapper;
import com.project.system.service.ISysNotificationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

@Service
public class SysNotificationServiceImpl implements ISysNotificationService {

    @Autowired
    private SysNotificationMapper notificationMapper;

    @Override
    public List<SysNotification> selectNotificationList(String userName) {
        return notificationMapper.selectNotificationList(userName);
    }

    @Override
    public SysNotification selectNotificationById(Long id) {
        return notificationMapper.selectNotificationById(id);
    }

    @Override
    public int insertNotification(SysNotification notification) {
        return notificationMapper.insertNotification(notification);
    }

    @Override
    public int updateNotification(SysNotification notification) {
        return notificationMapper.updateNotification(notification);
    }

    @Override
    public int deleteNotificationByIds(Long[] ids) {
        return notificationMapper.deleteNotificationByIds(ids);
    }

    @Override
    public int markNotificationAsRead(Long id) {
        return notificationMapper.markNotificationAsRead(id);
    }

    @Override
    public int deleteNotificationByUserNameAndPostId(String userName, Long postId) {
        SysNotification notification = new SysNotification();
        notification.setUserName(userName);
        notification.setPostId(postId);


        return notificationMapper.deleteNotificationByUserNameAndPostId(notification);
    }

    @Override
    public int deleteNotificationByUserNameAndReplyId(String userName, Long replyId) {
        SysNotification notification = new SysNotification();
        notification.setUserName(userName);
        notification.setReplyId(replyId);


        return notificationMapper.deleteNotificationByUserNameAndReplyId(notification);
    }

    @Override
    public int deleteNotificationByPostId(Long postId) {
        return notificationMapper.deleteNotificationByPostId(postId);
    }

    @Override
    public int deleteNotificationByReplyId(Long replyId) {
        return notificationMapper.deleteNotificationByReplyId(replyId);
    }
}
