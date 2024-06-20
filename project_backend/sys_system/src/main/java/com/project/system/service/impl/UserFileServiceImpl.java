package com.project.system.service.impl;

import com.project.system.domain.UserFile;
import com.project.system.mapper.UserFileMapper;
import com.project.system.service.IUserFileService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserFileServiceImpl implements IUserFileService {

    @Autowired
    private UserFileMapper userFileMapper;

    @Override
    public void saveFile(UserFile userFile) {
        userFileMapper.insert(userFile);
    }

    @Override
    public List<UserFile> getFilesByUserName(String userName) {
        return userFileMapper.findByUserName(userName);
    }

    @Override
    public void uploadFile(String userName) {
        userFileMapper.update_upload(userName);
    }

}
