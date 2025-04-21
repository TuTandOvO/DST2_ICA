package cn.edu.zju.dao;

import cn.edu.zju.bean.PageVisit;
import cn.edu.zju.bean.VisitLog;
import cn.edu.zju.dbutils.DBUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.atomic.AtomicInteger;

public class VisitStatisticsDao extends BaseDao {
    
    private static final Logger log = LoggerFactory.getLogger(VisitStatisticsDao.class);
    
    /**
     * 记录页面访问并增加计数
     */
    public void incrementPageVisit(String pagePath) {
        DBUtils.execSQL(connection -> {
            try {
                // 检查页面是否已存在
                String checkSql = "SELECT id, visit_count FROM page_visits WHERE page_path = ?";
                PreparedStatement checkStmt = connection.prepareStatement(checkSql);
                checkStmt.setString(1, pagePath);
                ResultSet rs = checkStmt.executeQuery();
                
                if (rs.next()) {
                    // 页面已存在，更新计数
                    int id = rs.getInt("id");
                    int currentCount = rs.getInt("visit_count");
                    
                    String updateSql = "UPDATE page_visits SET visit_count = ?, last_visit_time = NOW() WHERE id = ?";
                    PreparedStatement updateStmt = connection.prepareStatement(updateSql);
                    updateStmt.setInt(1, currentCount + 1);
                    updateStmt.setInt(2, id);
                    updateStmt.executeUpdate();
                    updateStmt.close();
                } else {
                    // 页面不存在，插入新记录
                    String insertSql = "INSERT INTO page_visits (page_path, visit_count, last_visit_time) VALUES (?, 1, NOW())";
                    PreparedStatement insertStmt = connection.prepareStatement(insertSql);
                    insertStmt.setString(1, pagePath);
                    insertStmt.executeUpdate();
                    insertStmt.close();
                }
                
                checkStmt.close();
            } catch (SQLException e) {
                log.error("增加页面访问计数失败", e);
            }
        });
    }
    
    /**
     * 记录详细的访问日志
     */
    public void logVisit(String pagePath, String ipAddress, String userAgent, String username) {
        DBUtils.execSQL(connection -> {
            try {
                String sql = "INSERT INTO visit_logs (page_path, ip_address, user_agent, visit_time, username) VALUES (?, ?, ?, NOW(), ?)";
                PreparedStatement stmt = connection.prepareStatement(sql);
                stmt.setString(1, pagePath);
                stmt.setString(2, ipAddress);
                stmt.setString(3, userAgent);
                stmt.setString(4, username);
                stmt.executeUpdate();
                stmt.close();
            } catch (SQLException e) {
                log.error("记录访问日志失败", e);
            }
        });
    }
    
    /**
     * 获取总访问量
     */
    public int getTotalVisitCount() {
        AtomicInteger totalCount = new AtomicInteger(0);
        
        DBUtils.execSQL(connection -> {
            try {
                String sql = "SELECT SUM(visit_count) as total FROM page_visits";
                PreparedStatement stmt = connection.prepareStatement(sql);
                ResultSet rs = stmt.executeQuery();
                
                if (rs.next()) {
                    totalCount.set(rs.getInt("total"));
                }
                
                stmt.close();
            } catch (SQLException e) {
                log.error("获取总访问量失败", e);
            }
        });
        
        return totalCount.get();
    }
    
    /**
     * 获取所有页面的访问统计
     */
    public List<PageVisit> getAllPageVisits() {
        List<PageVisit> pageVisits = new ArrayList<>();
        
        DBUtils.execSQL(connection -> {
            try {
                String sql = "SELECT id, page_path, visit_count, last_visit_time FROM page_visits ORDER BY visit_count DESC";
                PreparedStatement stmt = connection.prepareStatement(sql);
                ResultSet rs = stmt.executeQuery();
                
                while (rs.next()) {
                    PageVisit pageVisit = new PageVisit();
                    pageVisit.setId(rs.getLong("id"));
                    pageVisit.setPagePath(rs.getString("page_path"));
                    pageVisit.setVisitCount(rs.getInt("visit_count"));
                    pageVisit.setLastVisitTime(rs.getTimestamp("last_visit_time"));
                    pageVisits.add(pageVisit);
                }
                
                stmt.close();
            } catch (SQLException e) {
                log.error("获取页面访问统计失败", e);
            }
        });
        
        return pageVisits;
    }
    
    /**
     * 获取最近的访问日志
     */
    public List<VisitLog> getRecentVisitLogs(int limit) {
        List<VisitLog> visitLogs = new ArrayList<>();
        
        DBUtils.execSQL(connection -> {
            try {
                String sql = "SELECT id, page_path, ip_address, user_agent, visit_time, username FROM visit_logs ORDER BY visit_time DESC LIMIT ?";
                PreparedStatement stmt = connection.prepareStatement(sql);
                stmt.setInt(1, limit);
                ResultSet rs = stmt.executeQuery();
                
                while (rs.next()) {
                    VisitLog visitLog = new VisitLog();
                    visitLog.setId(rs.getLong("id"));
                    visitLog.setPagePath(rs.getString("page_path"));
                    visitLog.setIpAddress(rs.getString("ip_address"));
                    visitLog.setUserAgent(rs.getString("user_agent"));
                    visitLog.setVisitTime(rs.getTimestamp("visit_time"));
                    visitLog.setUsername(rs.getString("username"));
                    visitLogs.add(visitLog);
                }
                
                stmt.close();
            } catch (SQLException e) {
                log.error("获取最近访问日志失败", e);
            }
        });
        
        return visitLogs;
    }
} 