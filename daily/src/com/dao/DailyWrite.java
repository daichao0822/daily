package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.bean.Project;
import com.bean.Task;

public class DailyWrite {
	
	//获取项目人员参加的项目的列表
	public List<Project> getProject(Connection con,int int_userID)throws SQLException{
		String strSQL="SELECT * FROM t_project WHERE project_id IN(SELECT DISTINCT project_user_project FROM t_project_user WHERE project_user_user=?) AND project_status=2";//获取项目状态为正在进行的项目
		PreparedStatement pre=null;
		pre=con.prepareStatement(strSQL);
		pre.setInt(1, int_userID);
		ResultSet rs=pre.executeQuery();
		List<Project> list=new ArrayList<Project>();
		if(rs.next()!=false){
			do{
				Project project=new Project();
				project.setG_intProjectId(rs.getInt("project_id"));
				project.setG_intProjectManager(rs.getInt("project_manager"));
				project.setG_timProjectBeginTime(rs.getTimestamp("project_begin_time"));
				project.setG_strProjectName(rs.getString("project_name"));
				list.add(project);
			}while(rs.next());
		}
		else{
			list=null;
		}
		con.commit();
		rs.close();
		pre.close();
		return list;
	}
	
	//获取任务列表
	public List<Task> getTask(Connection con,String projectID,String dailyType,int int_userID)throws SQLException{
		String strSQL=null;
		int intType=Integer.parseInt(dailyType);
		int intID=-1;
		if(intType==1){//查询对应项目ID下的任务
			intID=Integer.parseInt(projectID);
			strSQL="SELECT * FROM t_task WHERE task_id IN(SELECT task_assign_task FROM t_task_assign WHERE task_assign_project=? AND task_assign_exec_user=?)";
			PreparedStatement pre=null;
			pre=con.prepareStatement(strSQL);
			pre.setInt(1, intID);
			pre.setInt(2, int_userID);
			ResultSet rs=pre.executeQuery();
			List<Task> list=new ArrayList<Task>();
			if(rs.next()!=false){
				do{
					Task task=new Task();
					task.setG_intTaskId(rs.getInt("task_id"));
					task.setG_intTaskType(rs.getInt("task_type"));
					task.setG_strTaskName(rs.getString("task_name"));
					list.add(task);
				}while(rs.next());
			}
			else{
				list=null;
			}
			con.commit();
			rs.close();
			pre.close();
			return list;
		}
		else{//查询临时任务
			strSQL="SELECT * FROM t_task WHERE task_type=0";
			PreparedStatement pre=null;
			pre=con.prepareStatement(strSQL);
			ResultSet rs=pre.executeQuery();
			List<Task> list=new ArrayList<Task>();
			if(rs.next()!=false){
				do{
					Task task=new Task();
					task.setG_intTaskId(rs.getInt("task_id"));
					task.setG_intTaskType(rs.getInt("task_type"));
					task.setG_strTaskName(rs.getString("task_name"));
					list.add(task);
				}while(rs.next());
			}
			else{
				list=null;
			}
			con.commit();
			rs.close();
			pre.close();
			return list;
		}
	}
	
	//填写日报
	 public int WriteDaily(Connection con,int int_dailyID,int int_userID,int int_projectID,int int_taskID,int int_dailyType,int int_timeCount,String str_taskDescription,String str_complete,String str_problem,Timestamp tim_submitTime,Timestamp tim_startTime,Timestamp tim_endTime,String str_dailyImage)throws SQLException{
		 String str_sql=null;
		 if(int_projectID!=-1){//填写项目日报
			 str_sql="INSERT INTO t_daily(daily_id,daily_user,daily_project,daily_task,daily_type,daily_time_count,daily_task_description,daily_task_status,daily_problem,daily_submit_time,daily_begin_time,daily_end_time,daily_checkup,daily_image) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
			 PreparedStatement pre=null;
			 pre=con.prepareStatement(str_sql);
			 pre.setInt(1, int_dailyID);
			 pre.setInt(2,int_userID );
			 pre.setInt(3,int_projectID );
			 pre.setInt(4,int_taskID );
			 pre.setInt(5,int_dailyType );
			 pre.setInt(6,int_timeCount );
			 pre.setString(7,str_taskDescription );
			 pre.setString(8,str_complete );
			 pre.setString(9,str_problem );
			 pre.setTimestamp(10,tim_submitTime );
			 pre.setTimestamp(11,tim_startTime );
			 pre.setTimestamp(12,tim_endTime );
			 pre.setInt(13, 0);//默认设置为 未审阅
			 pre.setString(14,str_dailyImage );
			 int result=pre.executeUpdate();
			 con.commit();
			 pre.close();
			 if(result!=1){
				 return 0;
			 }
			 else{
				 return 1;
			 }
		 }
		 else{//填写非项目日报
			 str_sql="INSERT INTO t_daily(daily_id,daily_user,daily_task,daily_type,daily_time_count,daily_task_description,daily_task_status,daily_problem,daily_submit_time,daily_begin_time,daily_end_time,daily_checkup,daily_project,daily_image) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,NULL,?)";
			 PreparedStatement pre=null;
			 pre=con.prepareStatement(str_sql);
			 pre.setInt(1, int_dailyID);
			 pre.setInt(2,int_userID );
			 pre.setInt(3,int_taskID );
			 pre.setInt(4,int_dailyType );
			 pre.setInt(5,int_timeCount );
			 pre.setString(6,str_taskDescription );
			 pre.setString(7,str_complete );
			 pre.setString(8,str_problem );
			 pre.setTimestamp(9,tim_submitTime );
			 pre.setTimestamp(10,tim_startTime );
			 pre.setTimestamp(11,tim_endTime );
			 pre.setInt(12, 0);//默认设置为 未审阅
			 pre.setString(13, str_dailyImage);
			 int result=pre.executeUpdate();
			 con.commit();
			 pre.close();
			 if(result!=1){
				 return 0;
			 }
			 else{
				 return 1;
			 }
		 }
		 
	 }
}
