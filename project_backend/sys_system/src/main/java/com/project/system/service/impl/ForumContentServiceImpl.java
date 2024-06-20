package com.project.system.service.impl;

import com.project.system.domain.ForumContent;
import com.project.system.mapper.ForumContentMapper;
import com.project.system.service.IForumContentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ForumContentServiceImpl implements IForumContentService {

    @Autowired
    private ForumContentMapper forumContentMapper;

    @Override
    public void saveFile(ForumContent forumContent) {
        forumContentMapper.insert(forumContent);
    }

    @Override
    public List<ForumContent> getAllFiles() {
        return forumContentMapper.findAll();
    }

    @Override
    public void uploadFile() {
        forumContentMapper.update_upload();
    }

}
