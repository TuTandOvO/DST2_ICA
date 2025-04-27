package cn.edu.zju.servlet;

import cn.edu.zju.dao.FavoriteDAO;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/addFavorite")
public class AddFavoriteServlet extends HttpServlet {
    private FavoriteDAO favoriteDAO = new FavoriteDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        // 如果没有登录，重定向到登录页面
        if (userId == null) {
            request.getRequestDispatcher("/views/signin.jsp").forward(request, response);
            return;
        }

        try {
            String drugId = request.getParameter("drugId");

            if (drugId != null && !drugId.isEmpty()) {
                // 执行添加收藏操作
                favoriteDAO.addFavorite(userId, drugId);
                // 添加完成后重定向到用户收藏页面
                response.sendRedirect("favorite?userId=" + userId);
            } else {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Drug ID is required");
            }
        } catch (Exception e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred while adding the favorite.");
        }
    }
}