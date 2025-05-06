package cn.edu.zju.servlet;

import cn.edu.zju.dbutils.DBUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/getColumn")
public class GetColumnServlet extends HttpServlet {
    private static final Logger log = LoggerFactory.getLogger(GetColumnServlet.class);

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<String> column = new ArrayList<>();
        String table = request.getParameter("table");

        if (table != null && !table.trim().isEmpty()) {
            DBUtils.execSQL(conn -> {
                try {
                    // fetching columns from the specified table
                    String query = "SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = ?";
                    try (PreparedStatement stmt = conn.prepareStatement(query)) {
                        stmt.setString(1, table);
                        try (ResultSet rs = stmt.executeQuery()) {
                            while (rs.next()) {
                                column.add(rs.getString("COLUMN_NAME"));
                            }
                        }
                    }
                } catch (SQLException e) {
                    log.error("Error fetching columns for table: {}", table, e);
                }
            });
        }

        response.setContentType("application/json");
        request.setAttribute("column", column);
        response.getWriter().write(new com.google.gson.Gson().toJson(column));
    }
}