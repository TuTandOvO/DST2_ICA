package cn.edu.zju.servlet;

import cn.edu.zju.bean.PageVisit;
import cn.edu.zju.bean.VisitLog;
import cn.edu.zju.dao.VisitStatisticsDao;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "StatisticsServlet", urlPatterns = {"/statistics"})
public class StatisticsServlet extends HttpServlet {
    
    private VisitStatisticsDao visitStatisticsDao = new VisitStatisticsDao();
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 不处理POST请求
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 获取总访问量
        int totalVisits = visitStatisticsDao.getTotalVisitCount();
        request.setAttribute("totalVisits", totalVisits);
        
        // 获取所有页面的访问统计
        List<PageVisit> pageVisits = visitStatisticsDao.getAllPageVisits();
        request.setAttribute("pageVisits", pageVisits);
        
        // 获取最近50条访问记录
        List<VisitLog> recentLogs = visitStatisticsDao.getRecentVisitLogs(50);
        request.setAttribute("recentLogs", recentLogs);
        
        request.getRequestDispatcher("/views/statistics.jsp").forward(request, response);
    }
} 