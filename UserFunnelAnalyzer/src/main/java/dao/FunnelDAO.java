package dao;

import model.FunnelData;
import util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

public class FunnelDAO {

    // ─── Insert a single funnel record ──────────────────────────────────────────

    public boolean insertFunnelData(FunnelData data) {
        String sql = "INSERT INTO user_funnel (user_id, stage, device, source) VALUES (?, ?, ?, ?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, data.getUserId());
            ps.setString(2, data.getStage());
            ps.setString(3, data.getDevice());
            ps.setString(4, data.getSource());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("[FunnelDAO] insertFunnelData error: " + e.getMessage());
            return false;
        }
    }

    // ─── Batch insert (used by SimulateServlet) ──────────────────────────────────

    public int insertBatch(java.util.List<FunnelData> records) {
        String sql = "INSERT INTO user_funnel (user_id, stage, device, source) VALUES (?, ?, ?, ?)";
        int inserted = 0;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            for (FunnelData data : records) {
                ps.setInt(1, data.getUserId());
                ps.setString(2, data.getStage());
                ps.setString(3, data.getDevice());
                ps.setString(4, data.getSource());
                ps.addBatch();
            }

            int[] results = ps.executeBatch();
            for (int r : results) inserted += r;

        } catch (SQLException e) {
            System.err.println("[FunnelDAO] insertBatch error: " + e.getMessage());
        }

        return inserted;
    }

    // ─── Count records per stage ─────────────────────────────────────────────────

    public Map<String, Integer> getStageCounts() {
        Map<String, Integer> counts = new HashMap<>();

        // Initialise all stages to 0 so no key is ever missing
        counts.put("visit",    0);
        counts.put("signup",   0);
        counts.put("cart",     0);
        counts.put("purchase", 0);

        String sql = "SELECT stage, COUNT(*) AS total FROM user_funnel GROUP BY stage";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                String stage = rs.getString("stage").toLowerCase().trim();
                int    count = rs.getInt("total");
                if (counts.containsKey(stage)) {
                    counts.put(stage, count);
                }
            }

        } catch (SQLException e) {
            System.err.println("[FunnelDAO] getStageCounts error: " + e.getMessage());
        }

        return counts;
    }
}