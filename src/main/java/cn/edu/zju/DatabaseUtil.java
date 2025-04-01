package cn.edu.zju;

import java.sql.*;
import java.util.*;

public class DatabaseUtil {
    private static final String URL = "jdbc:mysql://localhost:3306/biomed?serverTimezone=Asia/Shanghai&useSSL=false";
    private static final String USER = "biomed";
    private static final String PASSWORD = "biomed";

    public static void main(String[] args) {
        // 1️⃣ 测试数据库连接
        if (testConnection()) {
            System.out.println("✅ 成功连接到数据库！");

            // 2️⃣ 读取数据库数据
            List<Map<String, String>> dataList = queryDatabase();

            if (!dataList.isEmpty()) {
                System.out.println("✅ 数据成功读取，共 " + dataList.size() + " 条记录。");
            } else {
                System.out.println("⚠️ 读取成功，但查询结果为空！");
            }
        } else {
            System.out.println("❌ 无法连接到数据库！");
        }
    }

    /**
     * 测试数据库连接是否成功
     */
    public static boolean testConnection() {
        try (Connection connection = DriverManager.getConnection(URL, USER, PASSWORD)) {
            return connection != null;
        } catch (SQLException e) {
            System.err.println("❌ 数据库连接失败：" + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    /**
     * 查询数据库数据
     */
    public static List<Map<String, String>> queryDatabase() {
        List<Map<String, String>> dataList = new ArrayList<>();

        try (Connection connection = DriverManager.getConnection(URL, USER, PASSWORD);
             Statement statement = connection.createStatement();
             ResultSet resultSet = statement.executeQuery("SELECT * FROM drug")) {

            ResultSetMetaData metaData = resultSet.getMetaData();
            int columnCount = metaData.getColumnCount();

            while (resultSet.next()) {
                Map<String, String> row = new HashMap<>();
                for (int i = 1; i <= columnCount; i++) {
                    row.put(metaData.getColumnName(i), resultSet.getString(i));
                }
                dataList.add(row);
            }

        } catch (SQLException e) {
            System.err.println("❌ SQL 查询失败：" + e.getMessage());
            e.printStackTrace();
        }

        return dataList;
    }
}
