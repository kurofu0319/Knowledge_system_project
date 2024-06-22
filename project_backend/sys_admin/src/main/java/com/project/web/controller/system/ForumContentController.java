package com.project.web.controller.system;

import com.project.system.domain.ForumContent;
import com.project.system.service.IForumContentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/forumContent/files")
public class ForumContentController {

    @Autowired
    private IForumContentService forumContentService;

    @PostMapping("/save")
    public ResponseEntity<ForumContent> saveFileUrl(@RequestBody ForumContent forumContent) {
        forumContentService.saveFile(forumContent);
        return ResponseEntity.ok(forumContent);
    }

    @GetMapping("/all")
    public ResponseEntity<List<ForumContent>> getAllFiles() {
        return ResponseEntity.ok(forumContentService.getAllFiles());
    }

    @GetMapping("/upload")
    public ResponseEntity<List<ForumContent>> uploadFiles() {
        forumContentService.uploadFile();
        return ResponseEntity.ok(forumContentService.getAllFiles());
    }

    @PostMapping("/delete")
    public ResponseEntity<ForumContent> deleteFile(@RequestBody ForumContent forumContent) {
        forumContentService.deleteFile(forumContent);
        return ResponseEntity.ok(forumContent);
    }
}
