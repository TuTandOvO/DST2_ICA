package cn.edu.zju.servlet;

import cn.edu.zju.filter.AuthenticationFilter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "SigninServlet",  urlPatterns = "/signin")
public class SigninServlet extends HttpServlet {

    private static final String USERNAME_1 = "zju";
    private static final String PASSWORD_1 = "zju";
    private static final int USER_ID_1 = 1;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        if (USERNAME_1.equals(username) && PASSWORD_1.equals(password)) {
            HttpSession session = request.getSession();
            session.setAttribute(AuthenticationFilter.ROLE_VIEW_DOSING_GUIDELINE, 1);
            session.setAttribute(AuthenticationFilter.USERNAME, USERNAME_1);
            session.setAttribute("userId", USER_ID_1);
            response.sendRedirect("index");
        } else {
            request.setAttribute("error", "username or password error");
            request.getRequestDispatcher("/views/signin.jsp").forward(request, response);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/views/signin.jsp").forward(request, response);
    }
}
