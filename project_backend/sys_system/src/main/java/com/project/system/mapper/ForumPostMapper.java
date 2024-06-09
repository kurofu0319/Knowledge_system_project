package com.project.system.mapper;

import java.util.List;
import com.project.system.domain.ForumPost;
import com.project.system.domain.ForumLike;
import org.apache.ibatis.annotations.Param;

public interface ForumPostMapper {
    List<ForumPost> selectAllPosts();
    int insertPost(ForumPost post);
    int deletePostById(@Param("id") Long id);
    int deleteRepliesByPostId(@Param("id") Long id);
    int deleteLikesByPostId(@Param("id") Long id);
    int deletePostAndRepliesById(@Param("id") Long id, @Param("userName") String userName);
    ForumPost selectPostById(Long postId);
    void incrementPostLikes(Long postId);
    void decrementPostLikes(Long postId);
    void likePost(ForumLike like);
    void unlikePost(ForumLike like);
    Boolean checkUserLikeStatus(@Param("userName") String userName, @Param("postId") Long postId);
}
