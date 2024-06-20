package com.project.system.service;

import com.project.system.domain.ForumContent;

import java.util.List;

public interface IForumContentService {
    void saveFile(ForumContent forumContent);
    List<ForumContent> getAllFiles();
    void uploadFile();
}
