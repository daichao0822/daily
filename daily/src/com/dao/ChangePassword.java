package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class ChangePassword {
	public int changePassword(Connection con,int userId,String password,String newPassword)throws SQLException{
		String str="UPDATE t_user SET user_password=? WHERE user_id=? AND user_password=?";
		PreparedStatement pre=null;
		pre=con.prepareStatement(str);
		pre.setString(1, newPassword);
		pre.setInt(2, userId);
		pre.setString(3, password);
		
		int result=pre.executeUpdate();
		con.commit();
		pre.close();
		if(result!=1){
			return 0;
		}else{
			return 1;
		}
	}
}
