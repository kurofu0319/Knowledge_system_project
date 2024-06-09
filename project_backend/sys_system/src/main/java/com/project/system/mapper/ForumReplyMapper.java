package com.project.system.mapper;

import java.util.List;
import com.project.system.domain.ForumReply;
import com.project.system.domain.ForumLike;
import org.apache.ibatis.annotations.Param;

public interface ForumReplyMapper {
    List<ForumReply> selectRepliesByPostId(Long postId);
    int insertReply(ForumReply reply);
    int deleteReplyById(@Param("id") Long replyId);
    void incrementReplyLikes(Long replyId);
    void decrementReplyLikes(Long replyId);
    ForumReply selectReplyById(Long replyId);
    void likeReply(ForumLike like);
    void unlikeReply(ForumLike like);
    int deleteLikesById(@Param("id") Long replyId);
    boolean checkUserLikeStatus(@Param("userName") String userName, @Param("replyId") Long replyId);
}
