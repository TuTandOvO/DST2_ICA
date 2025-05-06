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
        HttpSession session = request.getSession(false); // 不创建新 session
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("signin.jsp");
            return;
        }

        int userId = (int) session.getAttribute("userId");

        List<Favorite> favorites = favoriteDAO.getFavoritesByUserId(userId);
        System.out.println("favorites number:" + favorites.size());

        request.setAttribute("favorites", favorites);
        request.getRequestDispatcher("/views/favorite.jsp").forward(request, response);
    }
}
