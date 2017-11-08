package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class DeleteUserFromSystem {
	//���û�ID=int_userID���û���ϵͳɾ��
	public int DeleteUser(Connection con,int int_userID)throws SQLException{
		String str_sql="DELETE FROM t_user WHERE user_id=?";
		PreparedStatement pre=null;
		pre=con.prepareStatement(str_sql);
		pre.setInt(1, int_userID);
		int int_result=pre.executeUpdate();
		con.commit();
		pre.close();
		return int_result;
	}

}
