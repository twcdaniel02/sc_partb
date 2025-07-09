package com.dbUtil;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class ElectricValidateDAO {

    private static final Logger logger = Logger.getLogger(ElectricValidateDAO.class.getName());

    public static Connection openConnection() {
        Connection connection = null;

        String dbURL = "jdbc:mysql://localhost:3306/carbonsense";
        String username = "root";
        String password = "";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(dbURL, username, password);
        } catch (SQLException ex) {
            logger.log(Level.SEVERE, "SQL Exception occurred while opening connection", ex);
        } catch (ClassNotFoundException ex) {
            logger.log(Level.SEVERE, "JDBC Driver class not found", ex);
        }

        return connection;
    }

    public void approveElectric(int electricityID) {
        try (Connection conn = openConnection();
             PreparedStatement stmt = conn.prepareStatement("UPDATE electricityconsumption SET status = 'APPROVED' WHERE electricityID = ?;")) {

            stmt.setInt(1, electricityID);
            int affectedRows = stmt.executeUpdate();

            if (affectedRows > 0) {
                logger.info("Electricity consumption approved successfully.");
            } else {
                logger.warning("Failed to approve electricity consumption.");
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error approving electricity consumption", e);
        }
    }

    public void disapproveElectric(int electricityID) {
        try (Connection conn = openConnection();
             PreparedStatement stmt = conn.prepareStatement("UPDATE electricityconsumption SET status = 'DISAPPROVED' WHERE electricityID = ?;")) {

            stmt.setInt(1, electricityID);
            int affectedRows = stmt.executeUpdate();

            if (affectedRows > 0) {
                logger.info("Electricity consumption disapproved successfully.");
            } else {
                logger.warning("Failed to disapprove electricity consumption.");
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error disapproving electricity consumption", e);
        }
    }

    public void deleteElectric(int electricityID) {
        try (Connection conn = openConnection()) {

            // Update application table to remove reference to electricity consumption
            String updateSql = "UPDATE application SET electricityID = NULL WHERE electricityID = ?;";
            try (PreparedStatement updateStmt = conn.prepareStatement(updateSql)) {
                updateStmt.setInt(1, electricityID);
                int updateRs = updateStmt.executeUpdate();
                logger.info(updateRs + " row(s) updated in the application table.");
            }

            // Delete electricity consumption entry
            String deleteSql = "DELETE FROM electricityconsumption WHERE electricityID = ?;";
            try (PreparedStatement deleteStmt = conn.prepareStatement(deleteSql)) {
                deleteStmt.setInt(1, electricityID);
                int deleteRs = deleteStmt.executeUpdate();
                logger.info(deleteRs + " row(s) deleted from the electricityconsumption table.");
            }

        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error deleting electricity consumption entry", e);
        }
    }
}
