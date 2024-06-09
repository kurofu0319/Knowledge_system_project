package com.project.system.service.impl;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.project.system.domain.ForumPost;
import com.project.system.domain.ForumLike;
import com.project.system.mapper.ForumPostMapper;
import com.project.system.service.IForumPostService;
import com.project.system.service.INotificationService;
import org.springframework.transaction.annotation.Transactional;

@Service
public class ForumPostServiceImpl implements IForumPostService {

    @Autowired
    private ForumPostMapper forumPostMapper;

    @Autowired
    private INotificationService notificationService;

    @Override
    public List<ForumPost> selectAllPosts() {
        return forumPostMapper.selectAllPosts();
    }

    @Override
    public int insertPost(ForumPost post) {
        return forumPostMapper.insertPost(post);
    }

    @Override
    public ForumPost selectPostById(Long postId) {
        return forumPostMapper.selectPostById(postId);
    }

    @Override
    @Transactional
    public int deletePostAndRepliesById(Long id, String userName) {
        forumPostMapper.deleteLikesByPostId(id);
        int rows = forumPostMapper.deleteRepliesByPostId(id);
        rows += forumPostMapper.deletePostAndRepliesById(id, userName);
        return rows;
    }

    @Override
    public void likePost(Long postId, String userName) {
        ForumLike like = new ForumLike();
        like.setPostId(postId);
        like.setUserName(userName);
        like.setCreatedAt(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
        forumPostMapper.likePost(like);
        forumPostMapper.incrementPostLikes(postId);

        ForumPost post = forumPostMapper.selectPostById(postId);
        notificationService.notifyUser(post.getUserName(), "Your post has been liked by " + userName);
    }

    @Override
    public void unlikePost(Long postId, String userName) {
        ForumLike like = new ForumLike();
        like.setPostId(postId);
        like.setUserName(userName);
        forumPostMapper.unlikePost(like);
        forumPostMapper.decrementPostLikes(postId);
    }

    @Override
    public boolean checkUserLikeStatus(Long postId, String userName) {
        return forumPostMapper.checkUserLikeStatus(userName, postId);
    }
}
