package com.project.system.service;

import java.util.List;
import com.project.system.domain.ForumReply;

public interface IForumReplyService {
    List<ForumReply> selectRepliesByPostId(Long postId);
    int insertReply(ForumReply reply);
    int deleteReplyById(Long replyId);
    void likeReply(Long replyId, String userName);
    void unlikeReply(Long replyId, String userName);
    boolean checkUserLikeStatus(Long replyId, String userName);
}
