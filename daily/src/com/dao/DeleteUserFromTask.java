package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class DeleteUserFromTask {
	
	public int DeleteUser(Connection con,int int_projectID,int int_taskID,int int_userID)throws SQLException{
		String str_sql1="DELETE FROM t_task_assign WHERE task_assign_project=? AND task_assign_task=? AND task_assign_exec_user=?";
		String str_sql2="DELETE FROM t_daily WHERE daily_project=? AND daily_task=? AND daily_user=?";
		PreparedStatement pre=null;
		pre=con.prepareStatement(str_sql1);
		pre.setInt(1, int_projectID);
		pre.setInt(2, int_taskID);
		pre.setInt(3, int_userID);
		int int_result=pre.executeUpdate();
		if(int_result!=0){
			pre=con.prepareStatement(str_sql2);
			pre.setInt(1, int_projectID);
			pre.setInt(2, int_taskID);
			pre.setInt(3, int_userID);
			pre.executeUpdate();
		}
		con.commit();
		pre.close();
		return int_result;
	}
}
