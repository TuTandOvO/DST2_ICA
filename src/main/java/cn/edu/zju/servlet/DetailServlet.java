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
import java.util.*;

@WebServlet("/details")
public class DetailServlet extends HttpServlet {
    private static final Logger log = LoggerFactory.getLogger(DetailServlet.class);

    // ✅ 安全表名白名单，防止 SQL 注入
    private static final Set<String> ALLOWED_TABLES = new HashSet<>(Arrays.asList(
            "gene_info", "drug", "disease_gene", "disease_info","dosing_guideline","drug_label","gene_drug"
    ));

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");
        String table = request.getParameter("table");

        Map<String, Object> detail = new HashMap<>();

        if (id != null && !id.trim().isEmpty() && table != null && ALLOWED_TABLES.contains(table)) {
            DBUtils.execSQL(conn -> {
                String query = "SELECT * FROM " + table + " WHERE id = ?";
                try (PreparedStatement stmt = conn.prepareStatement(query)) {
                    stmt.setString(1, id);
                    try (ResultSet rs = stmt.executeQuery()) {
                        if (rs.next()) {
                            ResultSetMetaData metaData = rs.getMetaData();
                            int columnCount = metaData.getColumnCount();
                            for (int i = 1; i <= columnCount; i++) {
                                String columnName = metaData.getColumnName(i);
                                Object columnValue = rs.getObject(i);
                                detail.put(columnName, columnValue);
                            }
                        }
                    }
                } catch (SQLException e) {
                    log.error("Error fetching detail for ID: " + id, e);
                }
            });
        } else {
            // ✅ 非法访问或缺失参数
            request.setAttribute("errorMessage", "Invalid request. Please check your parameters.");
        }

        request.setAttribute("detail", detail);
        request.getRequestDispatcher("/views/details.jsp").forward(request, response);
    }
}
