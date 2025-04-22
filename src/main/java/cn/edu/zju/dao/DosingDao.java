package cn.edu.zju.dao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import cn.edu.zju.dbutils.DBUtils; // ✅ 加这一行！

public class DosingDao {
    public int getDosageCount() {
        String sql = "SELECT COUNT(*) FROM dosing_guideline";
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }
}

