package com.project.system.service;

import java.util.List;
import com.project.system.domain.ForumPost;

public interface IForumPostService {
    List<ForumPost> selectAllPosts();
    int insertPost(ForumPost post);
    int deletePostAndRepliesById(Long id, String userName);
    ForumPost selectPostById(Long postId);
    void likePost(Long postId, String userName);
    void unlikePost(Long postId, String userName);
    boolean checkUserLikeStatus(Long postId, String userName);

}
