package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;

public class AddUserForTask {
	
	public int GetTaskAssignID(Connection con)throws SQLException{
		String str_sql="SELECT MAX(task_assign_id) AS id FROM t_task_assign";
		PreparedStatement pre=null;
		pre=con.prepareStatement(str_sql);
		ResultSet rs=pre.executeQuery();
		int int_result=-1;
		if(rs.next()!=false){
			int_result=rs.getInt("id")+1;
		}
		else{
			int_result=1;
		}
		return int_result;
	}
	
	public int AddUser(Connection con,int int_ID,int int_projectID,int int_taskID,Timestamp tim_beginTime,Timestamp tim_endTime,int int_timeCount,int int_execUser,String str_opinion,int int_confirmUser)throws SQLException{
		String str_sql="INSERT INTO t_task_assign(task_assign_id,task_assign_project,task_assign_task,task_assign_begin_time,task_assign_end_time,task_assign_time_limit,task_assign_exec_user,task_assign_opinion,task_assign_confirm_user) VALUES(?,?,?,?,?,?,?,?,?)";
		PreparedStatement pre=null;
		pre=con.prepareStatement(str_sql);
		pre.setInt(1, int_ID);
		pre.setInt(2, int_projectID);
		pre.setInt(3, int_taskID);
		pre.setTimestamp(4, tim_beginTime);
		pre.setTimestamp(5, tim_endTime);
		pre.setInt(6,int_timeCount);
		pre.setInt(7, int_execUser);
		pre.setString(8, str_opinion);
		pre.setInt(9, int_confirmUser);
		int int_result=pre.executeUpdate();
		con.commit();
		pre.close();
		return int_result;
	}
}
