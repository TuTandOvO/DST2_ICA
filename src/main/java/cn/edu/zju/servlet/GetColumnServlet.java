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

@WebServlet("/getTables")
public class GetColumnServlet extends HttpServlet {
    private static final Logger log = LoggerFactory.getLogger(GetColumnServlet.class);

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<String> tables = new ArrayList<>();
        String database = request.getParameter("database");

        if (database != null && !database.trim().isEmpty()) {
            DBUtils.execSQL(conn -> {
                try {
                    // 获取指定数据库中的所有表名
                    String query = "SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = ?";
                    try (PreparedStatement stmt = conn.prepareStatement(query)) {
                        stmt.setString(1, database);
                        try (ResultSet rs = stmt.executeQuery()) {
                            while (rs.next()) {
                                tables.add(rs.getString("TABLE_NAME"));
                            }
                        }
                    }
                } catch (SQLException e) {
                    log.error("Error fetching tables for database: " + database, e);
                }
            });
        }

        response.setContentType("application/json");
        response.getWriter().write(new com.google.gson.Gson().toJson(tables));
    }
}