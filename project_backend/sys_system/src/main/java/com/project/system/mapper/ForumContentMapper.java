package com.project.system.mapper;

import com.project.system.domain.ForumContent;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface ForumContentMapper {

    void insert(ForumContent forumContent);

    List<ForumContent> findAll();

    void update_upload ();
}
