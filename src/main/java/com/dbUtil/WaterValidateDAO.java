package com.dbUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class WaterValidateDAO {

    private static final Logger logger = Logger.getLogger(WaterValidateDAO.class.getName());

    public void approveWater(int waterID) {
        try (Connection conn = DBConnect.openConnection();
             PreparedStatement stmt = conn.prepareStatement("UPDATE waterconsumption SET status = 'APPROVED' WHERE waterID = ?;")) {

            stmt.setInt(1, waterID);
            int affectedRows = stmt.executeUpdate();

            if (affectedRows > 0) {
                logger.info("Water consumption approved successfully.");
            } else {
                logger.warning("Failed to approve water consumption.");
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error approving water consumption", e);
        }
    }

    public void disapproveWater(int waterID) {
        try (Connection conn = DBConnect.openConnection();
             PreparedStatement stmt = conn.prepareStatement("UPDATE waterconsumption SET status = 'DISAPPROVED' WHERE waterID = ?;")) {

            stmt.setInt(1, waterID);
            int affectedRows = stmt.executeUpdate();

            if (affectedRows > 0) {
                logger.info("Water consumption disapproved successfully.");
            } else {
                logger.warning("Failed to disapprove water consumption.");
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error disapproving water consumption", e);
        }
    }

    public void deleteWater(int waterID) {
        try (Connection conn = DBConnect.openConnection()) {

            // Update application table to remove reference to water consumption
            String updateSql = "UPDATE application SET waterID = NULL WHERE waterID = ?;";
            try (PreparedStatement updateStmt = conn.prepareStatement(updateSql)) {
                updateStmt.setInt(1, waterID);
                int updateRs = updateStmt.executeUpdate();
                logger.info(updateRs + " row(s) updated in the application table.");
            }

            // Delete water consumption entry
            String deleteSql = "DELETE FROM waterconsumption WHERE waterID = ?;";
            try (PreparedStatement deleteStmt = conn.prepareStatement(deleteSql)) {
                deleteStmt.setInt(1, waterID);
                int deleteRs = deleteStmt.executeUpdate();
                logger.info(deleteRs + " row(s) deleted from the waterconsumption table.");
            }

        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error deleting water consumption entry", e);
        }
    }
}
