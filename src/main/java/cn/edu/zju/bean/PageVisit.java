package cn.edu.zju.bean;

import java.sql.Timestamp;

public class PageVisit {
    private long id;
    private String pagePath;
    private int visitCount;
    private Timestamp lastVisitTime;

    public PageVisit() {
    }

    public PageVisit(String pagePath, int visitCount, Timestamp lastVisitTime) {
        this.pagePath = pagePath;
        this.visitCount = visitCount;
        this.lastVisitTime = lastVisitTime;
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

    public int getVisitCount() {
        return visitCount;
    }

    public void setVisitCount(int visitCount) {
        this.visitCount = visitCount;
    }

    public Timestamp getLastVisitTime() {
        return lastVisitTime;
    }

    public void setLastVisitTime(Timestamp lastVisitTime) {
        this.lastVisitTime = lastVisitTime;
    }
} 