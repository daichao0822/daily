package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class ChangeUserInfo {
	public int addEmail(Connection con,String str_email,int int_userID)throws SQLException{
		String str_sql="UPDATE t_user SET user_email=? WHERE user_id=?";
		PreparedStatement pre=null;
		pre=con.prepareStatement(str_sql);
		pre.setString(1, str_email);
		pre.setInt(2, int_userID);
		int int_result=pre.executeUpdate();
		con.commit();
		pre.close();
		return int_result;
	}
}
