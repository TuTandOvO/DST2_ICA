package cn.edu.zju.filter;

import cn.edu.zju.dao.VisitStatisticsDao;
import cn.edu.zju.servlet.CounterServlet;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter(filterName = "VisitCounterFilter", urlPatterns = "/*")
public class VisitCounterFilter implements Filter {
    
    private VisitStatisticsDao visitStatisticsDao;
    
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        visitStatisticsDao = new VisitStatisticsDao();
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) 
            throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        String requestURI = httpRequest.getRequestURI();
        String contextPath = httpRequest.getContextPath();
        
        // 去除上下文路径，得到相对URI
        String relativeURI = requestURI.substring(contextPath.length());
        
        // 只统计页面访问，不统计静态资源和AJAX请求
        if (!relativeURI.startsWith("/static/") && !relativeURI.equals("/counter")) {
            // 增加内存中的总访问计数（兼容性考虑）
            CounterServlet.incrementCounter(request.getServletContext());
            
            // 增加内存中的页面访问计数（兼容性考虑）
            CounterServlet.incrementPageCounter(request.getServletContext(), relativeURI);
            
            // 持久化到数据库
            visitStatisticsDao.incrementPageVisit(relativeURI);
            
            // 记录详细访问日志
            String ipAddress = request.getRemoteAddr();
            String userAgent = httpRequest.getHeader("User-Agent");
            
            // 获取当前登录用户（如果有）
            HttpSession session = httpRequest.getSession(false);
            String username = null;
            if (session != null) {
                Object usernameObj = session.getAttribute(AuthenticationFilter.USERNAME);
                if (usernameObj != null) {
                    username = usernameObj.toString();
                }
            }
            
            visitStatisticsDao.logVisit(relativeURI, ipAddress, userAgent, username);
        }
        
        // 继续处理请求
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
        // 清理操作
    }
} 