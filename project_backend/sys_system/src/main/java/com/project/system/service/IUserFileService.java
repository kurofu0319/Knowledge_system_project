package com.project.system.service;

import com.project.system.domain.UserFile;

import java.util.List;

public interface IUserFileService {
    void saveFile(UserFile userFile);
    List<UserFile> getFilesByUserName(String userName);
    void uploadFile(String UserName);
}
