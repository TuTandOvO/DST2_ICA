package cn.edu.zju.dao;

import cn.edu.zju.bean.Favorite;
import cn.edu.zju.dbutils.DBUtils;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class FavoriteDAO {

    public static void addFavorite(int userId, String drugId) {
        Connection conn = null;
        PreparedStatement stmt = null;
        try {
            conn = DBUtils.getConnection(); //connect to the database
            String sql = "INSERT INTO favorites (user_id, drug_id) VALUES (?, ?)";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, userId);
            stmt.setString(2, drugId);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtils.close(conn, stmt, null);
        }
    }

    public static List<Favorite> getFavoritesByUserId(int userId) {
        List<Favorite> favorites = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            String sql = "SELECT * FROM favorites WHERE user_id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, userId);
            rs = stmt.executeQuery();

            while (rs.next()) {
                Favorite favorite = new Favorite();
                favorite.setId(rs.getInt("id"));
                favorite.setUserId(rs.getInt("user_id"));
                favorite.setDrugId(rs.getString("drug_id"));
                favorite.setCreatedAt(rs.getTimestamp("created_at"));
                favorites.add(favorite);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtils.close(conn, stmt, rs);
        }
        return favorites;
    }
}
