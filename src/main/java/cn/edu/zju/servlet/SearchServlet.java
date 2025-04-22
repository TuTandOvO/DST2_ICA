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
        String database = request.getParameter("database");
        String table = request.getParameter("table");

        log.info("Keyword received: " + keyword);
        log.info("Database selected: " + database);
        log.info("Table selected: " + table);

        List<Map<String, Object>> results = new ArrayList<>();
        String queryTarget = (table == null || table.isEmpty()) ? database : table;

        if (keyword != null && !keyword.trim().isEmpty()) {
            DBUtils.execSQL(conn -> {
                List<String> columns = null;
                try {
                    columns = getColumns(conn, queryTarget);
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
                StringBuilder sql = new StringBuilder("SELECT * FROM " + queryTarget + " WHERE ");
                for (int i = 0; i < columns.size(); i++) {
                    sql.append(columns.get(i)).append(" LIKE ?");
                    if (i < columns.size() - 1) {
                        sql.append(" OR ");
                    }
                }

                try (PreparedStatement stmt = conn.prepareStatement(sql.toString())) {
                    for (int i = 1; i <= columns.size(); i++) {
                        stmt.setString(i, "%" + keyword + "%");
                    }
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
            });
        }

        request.setAttribute("results", results);
        request.setAttribute("keyword", keyword);
        request.setAttribute("database", database);
        request.setAttribute("table", table);
        request.getRequestDispatcher("/views/search.jsp").forward(request, response);
    }

    private List<String> getColumns(Connection conn, String queryTarget) throws SQLException {
        List<String> columns = new ArrayList<>();
        String columnQuery = "SELECT * FROM " + queryTarget + " LIMIT 1";
        try (PreparedStatement columnStmt = conn.prepareStatement(columnQuery);
             ResultSet rs = columnStmt.executeQuery()) {
            ResultSetMetaData metaData = rs.getMetaData();
            for (int i = 1; i <= metaData.getColumnCount(); i++) {
                columns.add(metaData.getColumnName(i));
            }
        }
        return columns;
    }
}