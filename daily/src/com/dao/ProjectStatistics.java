package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.bean.Task;

public class ProjectStatistics {
	
	//获得项目运行总时间
	public int GetProjectRunTime(Connection con,int int_projectID)throws SQLException{
		String str_sql="SELECT * FROM t_project WHERE project_id=?";
		PreparedStatement pre=null;
		pre=con.prepareStatement(str_sql);
		pre.setInt(1, int_projectID);
		ResultSet rs=pre.executeQuery();
		Timestamp tim_bg=null;
		Timestamp tim_ed=null;
		int status=-1;
		int result=-1;
		if(rs.next()!=false){
			tim_bg=rs.getTimestamp("project_begin_time");
			tim_ed=rs.getTimestamp("project_end_time");
			status=rs.getInt("project_status");
		}
		if(status!=-1){//如果项目存在
			if(status==2||status==1){//如果项目状态为 正在进行 或者 暂停
				Date currentTime=new Date();
				Timestamp now=new Timestamp(currentTime.getTime());
			    result=(int)(now.getTime()-tim_bg.getTime());
			}
			else if(status==0){//如果项目状态为停止
				result=(int)(tim_ed.getTime()-tim_bg.getTime());
			}
		}
		con.commit();
		rs.close();
		pre.close();
		return result;
	}
	
	//获得某人参与某项目任务
	public List<Task> GetProjectTaskForUser(Connection con,int int_projectID,int int_userID)throws SQLException{
		String str_sql="SELECT task_assign_task FROM t_task_assign WHERE task_assign_project=? AND task_assign_exec_user=?";
		PreparedStatement pre=null;
		pre=con.prepareStatement(str_sql);
		pre.setInt(1, int_projectID);
		pre.setInt(2, int_userID);
		ResultSet rs=pre.executeQuery();
		List<Task> list=new ArrayList<Task>();
		if(rs.next()!=false){
			do{
				Task task=new Task();
				task.setG_intTaskId(rs.getInt("task_assign_task"));
				list.add(task);
			}while(rs.next());
		}
		else {
			list=null;
		}
		con.commit();
		rs.close();
		pre.close();
		return list;
	}
	
	//获得项目总工时
	public int GetProjectWorkTime(Connection con,int int_projectID)throws SQLException{
		String str_sql="SELECT SUM(daily_time_count) AS time FROM t_daily WHERE daily_project=?";
		PreparedStatement pre=null;
		pre=con.prepareStatement(str_sql);
		pre.setInt(1, int_projectID);
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
	
	//获得某人某项目总工时
	public int GetPerUserPjectWorkTime(Connection con,int int_projectID,int int_userID)throws SQLException{
		String str_sql="SELECT SUM(daily_time_count) AS time FROM t_daily WHERE daily_project=? AND daily_user=?";
		PreparedStatement pre=null;
		pre=con.prepareStatement(str_sql);
		pre.setInt(1, int_projectID);
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
	
	//获得某项目下某任务总工时
	public int GetTaskWorkTime(Connection con,int int_taskID,int int_projectID)throws SQLException{
		String str_sql="SELECT SUM(daily_time_count) AS time FROM t_daily WHERE daily_task=? AND daily_project=?";
		PreparedStatement pre=null;
		pre=con.prepareStatement(str_sql);
		pre.setInt(1, int_taskID);
		pre.setInt(2, int_projectID);
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
	
	//获得某人在某项目下的某任务总工时
	public int GetUserTaskWorkTime(Connection con,int int_taskID,int int_userID,int int_projectID)throws SQLException{
		String str_sql="SELECT SUM(daily_time_count) AS time FROM t_daily WHERE daily_task=? AND daily_user=? AND daily_project=?";
		PreparedStatement pre=null;
		pre=con.prepareStatement(str_sql);
		pre.setInt(1, int_taskID);
		pre.setInt(2, int_userID);
		pre.setInt(3, int_projectID);
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
	
	//获得某人某项目总日报数
	public int GetProjectDailyAmountForUser(Connection con,int int_userID,int int_projectID)throws SQLException{
		String str_sql="SELECT COUNT(*) AS time FROM t_daily WHERE daily_project=? AND daily_user=?";
		PreparedStatement pre=null;
		pre=con.prepareStatement(str_sql);
		pre.setInt(1, int_projectID);
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
	
	//获得某人在某项目下某任务总日报数
	public int GetTaskDailyAmountForUser(Connection con,int int_taskID,int int_userID,int int_projectID)throws SQLException{
		String str_sql="SELECT COUNT(*) AS time FROM t_daily WHERE daily_task=? AND daily_user=? AND daily_project=?";
		PreparedStatement pre=null;
		pre=con.prepareStatement(str_sql);
		pre.setInt(1, int_taskID);
		pre.setInt(2, int_userID);
		pre.setInt(3, int_projectID);
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
	
	//获得某项目总日报数
	public int GetDailyAmtOfPro(Connection con,int int_projectID)throws SQLException{
		String str_sql="SELECT COUNT(daily_id) AS amount FROM t_daily WHERE t_daily.daily_project=?";
		PreparedStatement pre=null;
		pre=con.prepareStatement(str_sql);
		pre.setInt(1, int_projectID);
		ResultSet rs=pre.executeQuery();
		int int_result=0;
		if(rs.next()!=false){
			int_result=rs.getInt("amount");
		}
		con.commit();
		rs.close();
		pre.close();
		return int_result;
	}
	
	//获得某项目下某任务总日报数
	public int GetDailyAmtOfTaskForPro(Connection con,int int_projectID,int int_taskID)throws SQLException{
		String str_sql="SELECT COUNT(daily_id) AS amount FROM t_daily WHERE t_daily.daily_project=? AND t_daily.daily_task=?";
		PreparedStatement pre=null;
		pre=con.prepareStatement(str_sql);
		pre.setInt(1, int_projectID);
		pre.setInt(2, int_taskID);
		ResultSet rs=pre.executeQuery();
		int int_result=0;
		if(rs.next()!=false){
			int_result=rs.getInt("amount");
		}
		con.commit();
		rs.close();
		pre.close();
		return int_result;
	}
}
