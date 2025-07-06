package com.dbUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ReportDAO {

	public float getWaterUsageValueM3(int waterID) throws SQLException {
		String waterSql = "SELECT waterUsageValueM3 FROM waterConsumption WHERE WaterID = ? AND status = 'APPROVED'";

		try (Connection conn = DBConnect.openConnection(); PreparedStatement waterStmt = conn.prepareStatement(waterSql)) {

			waterStmt.setInt(1, waterID);

			try (ResultSet waterRs = waterStmt.executeQuery()) {
				return waterRs.next() ? waterRs.getFloat("waterUsageValueM3") : 0.0f;
			}
		}
	}

	public float getElectricityUsageValueM3(int electricityID) throws SQLException {
		String electricitySql = "SELECT electricUsageValueM3 FROM electricityConsumption WHERE ElectricityID = ? AND status = 'APPROVED'";

		try (Connection conn = DBConnect.openConnection();
				PreparedStatement electricityStmt = conn.prepareStatement(electricitySql)) {

			electricityStmt.setInt(1, electricityID);

			try (ResultSet electricityRs = electricityStmt.executeQuery()) {
				return electricityRs.next() ? electricityRs.getFloat("electricUsageValueM3") : 0.0f;
			}
		}
	}

	public float getRecycleKG(int recycleID) throws SQLException {
		String recycleSql = "SELECT recycleKG FROM recycle WHERE RecycleID = ? AND status = 'APPROVED'";

		try (Connection conn = DBConnect.openConnection(); PreparedStatement recycleStmt = conn.prepareStatement(recycleSql)) {

			recycleStmt.setInt(1, recycleID);

			try (ResultSet recycleRs = recycleStmt.executeQuery()) {
				return recycleRs.next() ? recycleRs.getFloat("recycleKG") : 0.0f;
			}
		}
	}

}
