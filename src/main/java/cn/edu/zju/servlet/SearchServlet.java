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
import java.util.stream.Collectors;

@WebServlet("/search")
public class SearchServlet extends HttpServlet {
    private static final Logger log = LoggerFactory.getLogger(SearchServlet.class);

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String keyword = request.getParameter("keyword");
        String table = request.getParameter("table");
        List<Map<String, Object>> results = new ArrayList<>();
        List<Map<String, Object>> relationships = new ArrayList<>();

        if (keyword != null && !keyword.trim().isEmpty()) {
            DBUtils.execSQL(conn -> {
                String sql;
                // 根据不同的表格选择不同的查询语句
                switch (table) {
                    case "gene_info":
                        sql = "SELECT DISTINCT " +
                                "g.gene_id, g.gene_symbol, " +
                                "d.id as drug_id, d.name as drug_name, " +
                                "di.disease_id, di.disease_name " +
                                "FROM gene_info g " +
                                "LEFT JOIN gene_drug gd ON g.gene_id = gd.gene_id " +
                                "LEFT JOIN drug d ON gd.drug_id = d.id " +
                                "LEFT JOIN disease_gene dg ON g.gene_id = dg.gene_id " +
                                "LEFT JOIN disease_info di ON dg.disease_id = di.disease_id " +
                                "WHERE LOWER(g.gene_symbol) LIKE LOWER(?) OR LOWER(g.gene_id) LIKE LOWER(?)";
                        break;

                    case "disease_info":
                        sql = "SELECT DISTINCT " +
                                "di.disease_id, di.disease_name, " +
                                "g.gene_id, g.gene_symbol, " +
                                "d.id as drug_id, d.name as drug_name " +
                                "FROM disease_info di " +
                                "LEFT JOIN disease_gene dg ON di.disease_id = dg.disease_id " +
                                "LEFT JOIN gene_info g ON dg.gene_id = g.gene_id " +
                                "LEFT JOIN gene_drug gd ON g.gene_id = gd.gene_id " +
                                "LEFT JOIN drug d ON gd.drug_id = d.id " +
                                "WHERE LOWER(di.disease_name) LIKE LOWER(?) OR LOWER(di.disease_id) LIKE LOWER(?)";
                        break;
                    default: // drug table
                        sql = "SELECT DISTINCT " +
                                "d.id as drug_id, d.name as drug_name, " +
                                "g.gene_id, g.gene_symbol, " +
                                "di.disease_id, di.disease_name " +
                                "FROM drug d " +
                                "LEFT JOIN gene_drug gd ON d.id = gd.drug_id " +
                                "LEFT JOIN gene_info g ON gd.gene_id = g.gene_id " +
                                "LEFT JOIN disease_gene dg ON g.gene_id = dg.gene_id " +
                                "LEFT JOIN disease_info di ON dg.disease_id = di.disease_id " +
                                "WHERE LOWER(d.name) LIKE LOWER(?) OR LOWER(d.id) LIKE LOWER(?)";
                        break;
                }

                try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                    // 设置两个参数，一个用于名称搜索，一个用于ID搜索
                    String searchPattern = "%" + keyword + "%";
                    stmt.setString(1, searchPattern);
                    stmt.setString(2, searchPattern);

                    ResultSet rs = stmt.executeQuery();

                    while (rs.next()) {
                        // 准备表格显示数据
                        Map<String, Object> result = new HashMap<>();
                        result.put("Drug ID", rs.getString("drug_id"));
                        result.put("Drug Name", rs.getString("drug_name"));
                        result.put("Gene Symbol", rs.getString("gene_symbol"));
                        result.put("Disease Name", rs.getString("disease_name"));
                        results.add(result);

                        // 准备关系图数据
                        Map<String, Object> relation = new HashMap<>();
                        relation.put("drug_id", rs.getString("drug_id"));
                        relation.put("drug_name", rs.getString("drug_name"));
                        relation.put("gene_id", rs.getString("gene_id"));
                        relation.put("gene_symbol", rs.getString("gene_symbol"));
                        relation.put("disease_id", rs.getString("disease_id"));
                        relation.put("disease_name", rs.getString("disease_name"));
                        relationships.add(relation);
                    }
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }

                log.info("Found {} relationships for table {} with keyword {}",
                        relationships.size(), table, keyword);
            });
        }

        request.setAttribute("results", results);
        request.setAttribute("relationships", relationships);
        request.setAttribute("keyword", keyword);
        request.setAttribute("table", table != null ? table : "drug");
        request.getRequestDispatcher("/views/search.jsp").forward(request, response);
    }
}