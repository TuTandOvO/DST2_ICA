package cn.edu.zju.bean;

import java.sql.Timestamp;

public class VisitLog {
    private long id;
    private String pagePath;
    private String ipAddress;
    private String userAgent;
    private Timestamp visitTime;
    private String username;

    public VisitLog() {
    }

    public VisitLog(String pagePath, String ipAddress, String userAgent, Timestamp visitTime, String username) {
        this.pagePath = pagePath;
        this.ipAddress = ipAddress;
        this.userAgent = userAgent;
        this.visitTime = visitTime;
        this.username = username;
    }

    // Getters and Setters
    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getPagePath() {
        return pagePath;
    }

    public void setPagePath(String pagePath) {
        this.pagePath = pagePath;
    }

    public String getIpAddress() {
        return ipAddress;
    }

    public void setIpAddress(String ipAddress) {
        this.ipAddress = ipAddress;
    }

    public String getUserAgent() {
        return userAgent;
    }

    public void setUserAgent(String userAgent) {
        this.userAgent = userAgent;
    }

    public Timestamp getVisitTime() {
        return visitTime;
    }

    public void setVisitTime(Timestamp visitTime) {
        this.visitTime = visitTime;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }
} 