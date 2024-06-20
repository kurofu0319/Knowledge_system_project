package com.project.system.domain;

public class UserFile {
    private Long id;
    private String userName;
    private String fileName;
    private String uploadDate;
    private String fileUrl;
    private boolean has_upload;

    public boolean isHas_upload() {
        return has_upload;
    }

    public void setHas_upload(boolean has_upload) {
        this.has_upload = has_upload;
    }

    // Getters and Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public String getUploadDate() {
        return uploadDate;
    }

    public void setUploadDate(String uploadDate) {
        this.uploadDate = uploadDate;
    }

    public String getFileUrl() {
        return fileUrl;
    }

    public void setFileUrl(String fileUrl) {
        this.fileUrl = fileUrl;
    }
}
