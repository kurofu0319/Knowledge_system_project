package com.project.web.controller.system;

import com.project.system.domain.ForumContent;
import com.project.system.domain.UserFile;
import com.project.system.service.IUserFileService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;

@RestController
@RequestMapping("/userfiles")
public class UserFileController {

    @Autowired
    private IUserFileService userFileService;

    @PostMapping("/save")
    public ResponseEntity<UserFile> saveFileUrl(@RequestBody UserFile userFile) {
        userFileService.saveFile(userFile);
        return ResponseEntity.ok(userFile);
    }

    @GetMapping("/all")
    public ResponseEntity<List<UserFile>> getAllFiles(@RequestParam("userName") String userName) {
        return ResponseEntity.ok(userFileService.getFilesByUserName(userName));
    }

    @GetMapping("/upload")
    public ResponseEntity<String> uploadFiles(@RequestParam("userName") String userName) {
        userFileService.uploadFile(userName);
        return ResponseEntity.ok(userName);
    }

    @PostMapping("/delete")
    public ResponseEntity<UserFile> deleteFile(@RequestBody UserFile userFile) {
        userFileService.deleteFile(userFile);
        return ResponseEntity.ok(userFile);
    }
}
