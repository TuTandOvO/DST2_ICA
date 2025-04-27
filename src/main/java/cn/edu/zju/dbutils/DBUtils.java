package cn.edu.zju.dbutils;

import cn.edu.zju.AppConfig;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.function.Consumer;

public class DBUtils {

    private static final Logger log = LoggerFactory.getLogger(DBUtils.class);

    public static Connection getConnection() {
        Connection connection = null;
        AppConfig appConfig = AppConfig.getInstance();
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            log.info("", e);
        }
        try {
            connection = DriverManager.getConnection(appConfig.getJdbcUrl()
                    , appConfig.getJdbcUsername()
                    , appConfig.getJdbcPassword());
        } catch (SQLException e) {
            log.info("", e);
        }
        return connection;
    }

    public static void execSQL(Consumer<Connection> consumer) {
        Connection connection = null;
        try {
            connection = getConnection();
            consumer.accept(connection);
        } finally {
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException e) {
                    log.info("", e);
                }
            }
        }
    }

    public static void close(Connection connection, AutoCloseable... closeables) {
        if (connection != null) {
            try {
                connection.close();
            } catch (SQLException e) {
                log.info("", e);
            }
        }
        for (AutoCloseable closeable : closeables) {
            if (closeable != null) {
                try {
                    closeable.close();
                } catch (Exception e) {
                    log.info("", e);
                }
            }
        }
    }
}