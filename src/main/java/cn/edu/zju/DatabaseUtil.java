package cn.edu.zju;

import java.sql.*;
import java.util.*;

public class DatabaseUtil {
    private static final String URL = "jdbc:mysql://localhost:3306/biomed?serverTimezone=Asia/Shanghai&useSSL=false";
    private static final String USER = "biomed";
    private static final String PASSWORD = "biomed";

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
            e.printStackTrace();
            System.err.println("SQL Error: " + e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
        }
        return dataList;
    }
}
class databaseconnection {
    public static void main(String[] args) {
        String url = "jdbc:mysql://localhost:3306/biomed?serverTimezone=Asia/Shanghai";
        String user = "biomed";
        String password = "biomed";

        try {
            // 加载MySQL驱动
            Class.forName("com.mysql.cj.jdbc.Driver");

            // 建立连接
            Connection connection = DriverManager.getConnection(url, user, password);

            // 创建Statement对象
            Statement statement = connection.createStatement();

            // 执行查询
            ResultSet resultSet = statement.executeQuery("SELECT * FROM drug");

            // 关闭连接
            resultSet.close();
            statement.close();
            connection.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
