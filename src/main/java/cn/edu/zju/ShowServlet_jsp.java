package cn.edu.zju;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet(name = "ShowServlet_jsp", urlPatterns = "/show_jsp")
public class ShowServlet_jsp extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Map<String, String>> dataList = DatabaseUtil.queryDatabase();
        request.setAttribute("dataList", dataList);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/views/showservlet.jsp");
        dispatcher.forward(request, response);
    }
}