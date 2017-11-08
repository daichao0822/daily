package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class TempTaskStatisticsDao {
	
	//获得某人所提交过的临时任务的ID
	public int[] GetUserTempTaskID(Connection con,int int_userID)throws SQLException{
		String str_sql="SELECT DISTINCT daily_task FROM t_daily WHERE daily_user=? AND daily_task IN(SELECT DISTINCT task_id FROM t_task WHERE task_type=0)";
		PreparedStatement pre=null;
		pre=con.prepareStatement(str_sql);
		pre.setInt(1, int_userID);
		ResultSet rs=pre.executeQuery();
		int[] list = null;
		if(rs.next()!=false){
			rs.last();
			int int_row=rs.getRow();
			list=new int[int_row];
			rs.beforeFirst();
			int i=0;
			while(rs.next()){
				list[i]=rs.getInt("daily_task");
				i++;
			}
		}
		con.commit();
		rs.close();
		pre.close();
		return list;
	}
	
	//获得某人提交的某临时任务的总工时
	public int GetTempTaskWorkTime(Connection con,int int_userID,int int_taskID)throws SQLException{
		String str_sql="SELECT SUM(daily_time_count) AS time FROM t_daily WHERE daily_task=? AND daily_user=?";
		PreparedStatement pre=null;
		pre=con.prepareStatement(str_sql);
		pre.setInt(1, int_taskID);
		pre.setInt(2, int_userID);
		ResultSet rs=pre.executeQuery();
		int int_result=0;
		if(rs.next()!=false){
			int_result=rs.getInt("time");
		}
		con.commit();
		rs.close();
		pre.close();
		return int_result;
	}
	
	//获得某人提交的某临时任务下的日报总数
	public int GetTempTaskDailyAmount(Connection con,int int_userID,int int_taskID)throws SQLException{
		String str_sql="SELECT COUNT(*) AS time FROM t_daily WHERE daily_task=? AND daily_user=?";
		PreparedStatement pre=null;
		pre=con.prepareStatement(str_sql);
		pre.setInt(1, int_taskID);
		pre.setInt(2, int_userID);
		ResultSet rs=pre.executeQuery();
		int int_result=0;
		if(rs.next()!=false){
			int_result=rs.getInt("time");
		}
		con.commit();
		rs.close();
		pre.close();
		return int_result;
		
	}
}
