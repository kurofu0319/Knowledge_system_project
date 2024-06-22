package com.project.system.mapper;

import com.project.system.domain.ForumContent;
import com.project.system.domain.UserFile;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface UserFileMapper {

    void insert(UserFile userFile);

    List<UserFile> findByUserName(String userName);

    void update_upload (String userName);

    void delete_file(UserFile userFile);
}
