package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class DeleteUserFromProject {
	
	public int DeleteUserFromPro(Connection con,int int_userID,int int_projectID)throws SQLException{
		String str_sql1="DELETE FROM t_project_user WHERE project_user_user=? AND project_user_project=?";
		String str_sql2="DELETE FROM t_task_assign WHERE task_assign_exec_user=? AND task_assign_project=?";
		String str_sql3="DELETE FROM t_daily WHERE daily_user=? AND daily_project=?";
		PreparedStatement pre=con.prepareStatement(str_sql3);
		pre.setInt(1, int_userID);
		pre.setInt(2, int_projectID);
		int result=pre.executeUpdate();
		
			pre=con.prepareStatement(str_sql2);
			pre.setInt(1, int_userID);
			pre.setInt(2, int_projectID);
			result=pre.executeUpdate();
		
				pre=con.prepareStatement(str_sql1);
				pre.setInt(1, int_userID);
				pre.setInt(2, int_projectID);
				result=pre.executeUpdate();
			
		
		con.commit();
		pre.close();
		return result;
	}
}
