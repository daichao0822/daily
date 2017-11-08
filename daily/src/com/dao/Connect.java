package com.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Connect {
	public static Connection getConnection() throws ClassNotFoundException,
			SQLException {
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager
				.getConnection(
						"jdbc:mysql://localhost:3306/vantron?useUnicode=true&characterEncoding=GBK",
						"root", "root");
		con.setAutoCommit(false);
		return con;
	}
}
