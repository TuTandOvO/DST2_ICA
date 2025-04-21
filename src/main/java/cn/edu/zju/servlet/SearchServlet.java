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
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/search")
public class SearchServlet extends HttpServlet {

    private static final Logger log = LoggerFactory.getLogger(SearchServlet.class);

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String keyword = request.getParameter("keyword");
        log.info("Keyword received: " + keyword);
    List<Map<String, Object>> results = new ArrayList<>();

        if (keyword != null && !keyword.trim().isEmpty()) {
            DBUtils.execSQL(conn -> {
                String sql = "SELECT * FROM drug WHERE name LIKE ?";
                try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                    stmt.setString(1, "%" + keyword + "%");
                    try (ResultSet rs = stmt.executeQuery()) {
                        ResultSetMetaData metaData = rs.getMetaData();
                        int columnCount = metaData.getColumnCount();

                        while (rs.next()) {
                            Map<String, Object> row = new HashMap<>();
                            for (int i = 1; i <= columnCount; i++) {
                                row.put(metaData.getColumnName(i), rs.getObject(i));
                            }
                            results.add(row);
                        }
                    }
                } catch (SQLException e) {
                    log.error("Error during query execution", e);
                }
                log.info("Results size: " + results.size());
            });
            System.out.println(results);
    }

        request.setAttribute("results", results);
        request.setAttribute("keyword", keyword);
        request.setAttribute("debugKeyword", keyword);
        request.getRequestDispatcher("/views/search.jsp").forward(request, response);
}
}