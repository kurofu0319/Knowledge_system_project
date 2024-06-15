package com.project.web.controller.system;

import java.util.List;
import java.util.Map;
import java.util.HashMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import com.project.common.core.controller.BaseController;
import com.project.common.core.domain.AjaxResult;
import com.project.system.domain.ForumPost;
import com.project.system.domain.ForumReply;
import com.project.system.service.IForumPostService;
import com.project.system.service.IForumReplyService;

/**
 * 论坛
 *
 * author Furui
 */

@RestController
@RequestMapping("/forum")
public class ForumController extends BaseController {

    @Autowired
    private IForumPostService forumPostService;

    @Autowired
    private IForumReplyService forumReplyService;

    @GetMapping("/posts")
    public AjaxResult getAllPosts() {
        List<ForumPost> posts = forumPostService.selectAllPosts();
        return AjaxResult.success(posts);
    }

    @GetMapping("/post/{postId}")
    public AjaxResult getPostById(@PathVariable Long postId) {
        ForumPost post = forumPostService.selectPostById(postId);
        return AjaxResult.success(post);
    }

    @PostMapping("/post")
    public AjaxResult createPost(@RequestBody ForumPost post) {
        forumPostService.insertPost(post);
        return AjaxResult.success();
    }

    @DeleteMapping("/post/{id}")
    public AjaxResult deletePostAndReplies(@PathVariable Long id, @RequestParam String userName) {
        return toAjax(forumPostService.deletePostAndRepliesById(id, userName));
    }

    @PostMapping("/post/{postId}/like")
    public AjaxResult likePost(@PathVariable Long postId, @RequestParam String userName) {
        forumPostService.likePost(postId, userName);
        return AjaxResult.success();
    }

    @DeleteMapping("/post/{postId}/unlike")
    public AjaxResult unlikePost(@PathVariable Long postId, @RequestParam String userName) {
        forumPostService.unlikePost(postId, userName);
        return AjaxResult.success();
    }

    @GetMapping("/post/{postId}/like-status")
    public Map<String, Boolean> checkUserLikeStatus(@PathVariable Long postId, @RequestParam String userName) {
        boolean liked = forumPostService.checkUserLikeStatus(postId, userName);
        Map<String, Boolean> response = new HashMap<>();
        response.put("liked", liked);
        return response;
    }

    @GetMapping("/replies/{postId}")
    public AjaxResult getRepliesByPostId(@PathVariable Long postId) {
        List<ForumReply> replies = forumReplyService.selectRepliesByPostId(postId);
        return AjaxResult.success(replies);
    }

    @PostMapping("/reply")
    public AjaxResult createReply(@RequestBody ForumReply reply) {
        forumReplyService.insertReply(reply);
        return AjaxResult.success();
    }

    @DeleteMapping("/reply/{replyId}")
    public AjaxResult deleteReply(@PathVariable Long replyId) {
        int result = forumReplyService.deleteReplyById(replyId);
        return toAjax(result);
    }

    @PostMapping("/reply/{replyId}/like")
    public AjaxResult likeReply(@PathVariable Long replyId, @RequestParam String userName) {
        forumReplyService.likeReply(replyId, userName);
        return AjaxResult.success();
    }

    @DeleteMapping("/reply/{replyId}/unlike")
    public AjaxResult unlikeReply(@PathVariable Long replyId, @RequestParam String userName) {
        forumReplyService.unlikeReply(replyId, userName);
        return AjaxResult.success();
    }

    @GetMapping("/reply/{replyId}/like-status")
    public Map<String, Boolean> checkUserReplyLikeStatus(@PathVariable Long replyId, @RequestParam String userName) {
        boolean liked = forumReplyService.checkUserLikeStatus(replyId, userName);
        Map<String, Boolean> response = new HashMap<>();
        response.put("liked", liked);
        return response;
    }

}
