package com.project.system.service;

import com.project.system.domain.SysNotification;
import java.util.List;

public interface ISysNotificationService {
    List<SysNotification> selectNotificationList(String userName);

    SysNotification selectNotificationById(Long id);

    int insertNotification(SysNotification notification);

    int updateNotification(SysNotification notification);

    int deleteNotificationByIds(Long[] ids);

    int markNotificationAsRead(Long id);

    int deleteNotificationByUserNameAndPostId(String userName, Long postId);

    int deleteNotificationByUserNameAndReplyId(String userName, Long replyId);

    int deleteNotificationByPostId(Long postId);

    int deleteNotificationByReplyId(Long replyId);
}
