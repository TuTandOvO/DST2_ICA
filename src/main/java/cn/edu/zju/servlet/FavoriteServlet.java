package cn.edu.zju.servlet;

import cn.edu.zju.dao.FavoriteDAO;
import cn.edu.zju.bean.Favorite;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/favorite")
public class FavoriteServlet extends HttpServlet {
    private FavoriteDAO favoriteDAO = new FavoriteDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userIdParam = request.getParameter("userId");
        if (userIdParam == null) {
            response.sendRedirect("signin.jsp");
            return;
        }

        int userId = Integer.parseInt(userIdParam);

        List<Favorite> favorites = favoriteDAO.getFavoritesByUserId(userId);
        System.out.println("favorites number:" + favorites.size());

        // 把查询到的favorites列表放到request里
        request.setAttribute("favorites", favorites);

        // 转发到favorite.jsp页面
        request.getRequestDispatcher("/views/favorite.jsp").forward(request, response);
    }
}