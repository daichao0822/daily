package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class AddUserForProject {
	
	//为ID=int_projectID的项目添加ID=int_userID的用户
	public int AddUser(Connection con,int int_userID,int int_projectID)throws SQLException{
		String str_sql="INSERT INTO t_project_user(project_user_user,project_user_project) VALUES(?,?)";
		PreparedStatement pre=con.prepareStatement(str_sql);
		pre.setInt(1, int_userID);
		pre.setInt(2, int_projectID);
		int result=pre.executeUpdate();
		con.commit();
		pre.close();
		return result;
	}
}
