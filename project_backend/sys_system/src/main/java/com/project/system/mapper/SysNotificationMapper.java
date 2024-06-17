package com.project.system.mapper;

import com.project.system.domain.SysNotification;
import java.util.List;

public interface SysNotificationMapper {
    List<SysNotification> selectNotificationList(String userName);

    SysNotification selectNotificationById(Long id);

    int insertNotification(SysNotification notification);

    int updateNotification(SysNotification notification);

    int deleteNotificationByIds(Long[] ids);

    int markNotificationAsRead(Long id);

    int deleteNotificationByUserNameAndPostId(SysNotification notification);

    int deleteNotificationByUserNameAndReplyId(SysNotification notification);

    int deleteNotificationByPostId(Long postId);

    int deleteNotificationByReplyId(Long replyId);
}
