package cn.edu.zju.bean;

import java.util.Date;

public class Favorite {
    private int id;
    private int userId;
    private String drugId;
    private Date createdAt;

    public Favorite() {
    }

    public Favorite(int userId, String drugId, Date createdAt) {
        this.userId = userId;
        this.drugId = drugId;
        this.createdAt = createdAt;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getDrugId() {
        return drugId;
    }

    public void setDrugId(String drugId) {
        this.drugId = drugId;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }
}
