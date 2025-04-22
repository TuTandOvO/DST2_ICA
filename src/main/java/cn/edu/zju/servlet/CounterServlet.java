package cn.edu.zju.servlet;

import com.google.gson.Gson;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

@WebServlet(name = "CounterServlet", urlPatterns = "/counter")
public class CounterServlet extends HttpServlet {

    private static final String COUNTER_ATTRIBUTE = "visitCounter";
    private static final String PAGE_COUNTERS_ATTRIBUTE = "pageCounters";
    
    @Override
    public void init() throws ServletException {
        super.init();
        // 初始化计数器
        ServletContext context = getServletContext();
        if (context.getAttribute(COUNTER_ATTRIBUTE) == null) {
            context.setAttribute(COUNTER_ATTRIBUTE, 0);
        }
        if (context.getAttribute(PAGE_COUNTERS_ATTRIBUTE) == null) {
            context.setAttribute(PAGE_COUNTERS_ATTRIBUTE, new ConcurrentHashMap<String, Integer>());
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 不处理POST请求
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ServletContext context = getServletContext();
        String action = request.getParameter("action");
        
        if ("getPageStats".equals(action)) {
            // 返回页面统计信息（JSON格式）
            Map<String, Integer> pageCounters = getPageCounters(context);
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            PrintWriter out = response.getWriter();
            out.print(new Gson().toJson(pageCounters));
        } else {
            // 返回总访问量
            Integer counter = (Integer) context.getAttribute(COUNTER_ATTRIBUTE);
            response.setContentType("text/plain");
            PrintWriter out = response.getWriter();
            out.print(counter);
        }
    }
    
    /**
     * 增加总访问计数
     */
    public static void incrementCounter(ServletContext context) {
        Integer counter = (Integer) context.getAttribute(COUNTER_ATTRIBUTE);
        if (counter == null) {
            counter = 0;
        }
        context.setAttribute(COUNTER_ATTRIBUTE, counter + 1);
    }
    
    /**
     * 增加特定页面的访问计数
     */
    public static void incrementPageCounter(ServletContext context, String page) {
        Map<String, Integer> pageCounters = getPageCounters(context);
        Integer pageCount = pageCounters.getOrDefault(page, 0);
        pageCounters.put(page, pageCount + 1);
        context.setAttribute(PAGE_COUNTERS_ATTRIBUTE, pageCounters);
    }
    
    /**
     * 获取当前总访问计数
     */
    public static int getCounter(ServletContext context) {
        Integer counter = (Integer) context.getAttribute(COUNTER_ATTRIBUTE);
        return counter != null ? counter : 0;
    }
    
    /**
     * 获取所有页面的访问计数
     */
    @SuppressWarnings("unchecked")
    public static Map<String, Integer> getPageCounters(ServletContext context) {
        Map<String, Integer> pageCounters = (Map<String, Integer>) context.getAttribute(PAGE_COUNTERS_ATTRIBUTE);
        if (pageCounters == null) {
            pageCounters = new ConcurrentHashMap<>();
            context.setAttribute(PAGE_COUNTERS_ATTRIBUTE, pageCounters);
        }
        return pageCounters;
    }
    
    /**
     * 获取特定页面的访问计数
     */
    public static int getPageCounter(ServletContext context, String page) {
        Map<String, Integer> pageCounters = getPageCounters(context);
        return pageCounters.getOrDefault(page, 0);
    }
}
