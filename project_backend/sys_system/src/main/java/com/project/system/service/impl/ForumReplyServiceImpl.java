package com.project.system.service.impl;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.project.system.domain.ForumReply;
import com.project.system.domain.ForumLike;
import com.project.system.mapper.ForumReplyMapper;
import com.project.system.service.IForumReplyService;
import com.project.system.service.INotificationService;

@Service
public class ForumReplyServiceImpl implements IForumReplyService {

    @Autowired
    private ForumReplyMapper forumReplyMapper;

    @Autowired
    private INotificationService notificationService;

    @Override
    public List<ForumReply> selectRepliesByPostId(Long postId) {
        return forumReplyMapper.selectRepliesByPostId(postId);
    }

    @Override
    public int insertReply(ForumReply reply) {
        return forumReplyMapper.insertReply(reply);
    }

    @Override
    public int deleteReplyById(Long replyId) {
        forumReplyMapper.deleteLikesById(replyId);
        return forumReplyMapper.deleteReplyById(replyId);
    }

    @Override
    public void likeReply(Long replyId, String userName) {
        ForumLike like = new ForumLike();
        like.setReplyId(replyId);
        like.setUserName(userName);
        like.setCreatedAt(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
        forumReplyMapper.likeReply(like);
        forumReplyMapper.incrementReplyLikes(replyId);

        ForumReply reply = forumReplyMapper.selectReplyById(replyId);
        notificationService.notifyUser(reply.getUserName(), "Your reply has been liked by " + userName);
    }

    @Override
    public void unlikeReply(Long replyId, String userName) {
        ForumLike like = new ForumLike();
        like.setReplyId(replyId);
        like.setUserName(userName);
        forumReplyMapper.unlikeReply(like);
        forumReplyMapper.decrementReplyLikes(replyId);
    }

    @Override
    public boolean checkUserLikeStatus(Long replyId, String userName) {
        return forumReplyMapper.checkUserLikeStatus(userName, replyId);
    }

    @Override
    public ForumReply selectReplyById(Long replyId) {
        return forumReplyMapper.selectReplyById(replyId);
    }
}
