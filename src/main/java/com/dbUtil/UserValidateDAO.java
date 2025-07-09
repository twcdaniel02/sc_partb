package com.dbUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class UserValidateDAO {

    private static final Logger logger = Logger.getLogger(UserValidateDAO.class.getName());

    public void approveUser(int userID) {
        try (Connection conn = DBConnect.openConnection();
             PreparedStatement stmt = conn.prepareStatement("UPDATE users SET status = 'APPROVED' WHERE userID = ?;")) {

            stmt.setInt(1, userID);
            int affectedRows = stmt.executeUpdate();

            if (affectedRows > 0) {
                logger.info("User account approved successfully.");
            } else {
                logger.warning("Failed to approve user account.");
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error approving user account", e);
        }
    }

    public void disapproveUser(int userID) {
        try (Connection conn = DBConnect.openConnection();
             PreparedStatement stmt = conn.prepareStatement("UPDATE users SET status = 'DISAPPROVED' WHERE userID = ?;")) {

            stmt.setInt(1, userID);
            int affectedRows = stmt.executeUpdate();

            if (affectedRows > 0) {
                logger.info("User account disapproved successfully.");
            } else {
                logger.warning("Failed to disapprove user account.");
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error disapproving user account", e);
        }
    }

    public void deleteUser(int userID) {
        try (Connection conn = DBConnect.openConnection()) {

            String deleteSql = "DELETE FROM users WHERE userID = ?;";
            try (PreparedStatement deleteStmt = conn.prepareStatement(deleteSql)) {
                deleteStmt.setInt(1, userID);
                int deleteRs = deleteStmt.executeUpdate();
                logger.info(deleteRs + " row(s) deleted from the user table.");
            }

        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error deleting user account", e);
        }
    }
}
