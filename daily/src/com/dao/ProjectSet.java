package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.bean.Project;
import com.bean.User;

public class ProjectSet {
	
	//获得用户参与的项目
	public List<Project> getUserProject(Connection con,int int_userID)throws SQLException{
		String str_sql="SELECT * FROM t_project WHERE project_id IN(SELECT project_user_project FROM t_project_user WHERE project_user_user=?) ORDER BY project_status DESC";
		PreparedStatement pre=null;
		pre=con.prepareStatement(str_sql);
		pre.setInt(1, int_userID);
		ResultSet rs=pre.executeQuery();
		List<Project> list=new ArrayList<Project>();
		if(rs.next()!=false){
			do{
				Project project=new Project();
				project.setG_intProjectId(rs.getInt("project_id"));
				project.setG_intProjectManager(rs.getInt("project_manager"));
				project.setG_intProjectStatus(rs.getInt("project_status"));
				project.setG_strProjectName(rs.getString("project_name"));
				project.setG_strProjectNumber(rs.getString("project_number"));
				project.setG_timProjectBeginTime(rs.getTimestamp("project_begin_time"));
				project.setG_timProjectEndTime(rs.getTimestamp("project_end_time"));
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
	
	//修改项目状态
	public int ChangeProjectStatus(Connection con,int int_projectID,int int_status)throws SQLException{
		java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 
		java.util.Date currentTime = new java.util.Date();//得到当前系统时间 
		String strDate = formatter.format(currentTime); //将日期时间格式化
		Timestamp tim_project_end_time=Timestamp.valueOf(strDate);
		
		String str_sql1="UPDATE t_project SET project_status=? WHERE project_id=?";
		String str_sql2="UPDATE t_project SET project_end_time=? WHERE project_id=?";
		PreparedStatement pre=null;
		pre=con.prepareStatement(str_sql1);
		pre.setInt(1, int_status);
		pre.setInt(2, int_projectID);
		int int_result=pre.executeUpdate();
		if(int_status==0){//如果将项目状态设置为停止，则插入项目停止时间
			if(int_result!=0){//如果执行str_slq1成功，则继续执行str_slq2
				pre=con.prepareStatement(str_sql2);
				pre.setTimestamp(1, tim_project_end_time);
				pre.setInt(2, int_projectID);
				int_result=pre.executeUpdate();
			}
		}
		con.commit();
		pre.close();
		return int_result;
	}
	
	//删除PCB的里程碑
	public int DeleteMilestoneOfPCB(Connection con,int int_milestoneConfID)throws SQLException{
		String str_sql="DELETE FROM t_milestone_conf WHERE milestone_conf_id=?";
		PreparedStatement pre=null;
		pre=con.prepareStatement(str_sql);
		pre.setInt(1, int_milestoneConfID);
		int int_result=pre.executeUpdate();
		con.commit();
		pre.close();
		return int_result;
	}
	
	//获得新里程碑确认ID
	public int GetIDForMilestoneConf(Connection con)throws SQLException{
		String str_sql="SELECT MAX(milestone_conf_id) AS id FROM t_milestone_conf";
		PreparedStatement pre=null;
		pre=con.prepareStatement(str_sql);
		ResultSet rs=pre.executeQuery();
		int int_result=0;
		if(rs.next()!=false){
			int_result=rs.getInt("id")+1;
		}
		con.commit();
		rs.close();
		pre.close();
		return int_result;
	}
	
	//为PCB添加新里程碑确认
	public int AddMilestoneForPCB(Connection con,int int_milestoneConfID,int int_milestoneID,int int_PCBID,int int_confirmUser,String str_confirmOpinion,Timestamp tim_confirmTime)throws SQLException{
		String str_sql="INSERT INTO t_milestone_conf(milestone_conf_id,milestone_conf_pcb,milestone_conf_milestone,milestone_conf_user,milestone_conf_opinion,milestone_conf_time) VALUES(?,?,?,?,?,?)";
		PreparedStatement pre=null;
		pre=con.prepareStatement(str_sql);
		pre.setInt(1, int_milestoneConfID);
		pre.setInt(2, int_PCBID);
		pre.setInt(3, int_milestoneID);
		pre.setInt(4, int_confirmUser);
		pre.setString(5, str_confirmOpinion);
		pre.setTimestamp(6, tim_confirmTime);
		int int_result=pre.executeUpdate();
		con.commit();
		pre.close();
		return int_result;
		
	}
	
	//删除项目
	public int DeleteProject(Connection con,int int_projectID)throws SQLException{
		String str_sql="DELETE FROM t_project WHERE project_id=?";
		PreparedStatement pre=null;
		pre=con.prepareStatement(str_sql);
		pre.setInt(1, int_projectID);
		int int_result=pre.executeUpdate();
		con.commit();
		pre.close();
		return int_result;
	}
	
	//检查项目编号是否存在
	public int CheckProjectNumber(Connection con,String str_number)throws SQLException{
		String str_sql="SELECT project_id FROM t_project WHERE project_number=?";
		PreparedStatement pre=null;
		pre=con.prepareStatement(str_sql);
		pre.setString(1, str_number);
		ResultSet rs=pre.executeQuery();
		int int_result=0;
		if(rs.next()!=false){
			int_result=1;
		}
		con.commit();
		rs.close();
		pre.close();
		return int_result;
	}
	
	//检查项目名称是否存在
	public int CheckProjectName(Connection con,String str_name)throws SQLException{
		String str_sql="SELECT project_id FROM t_project WHERE project_name=?";
		PreparedStatement pre=null;
		pre=con.prepareStatement(str_sql);
		pre.setString(1, str_name);
		ResultSet rs=pre.executeQuery();
		int int_result=0;
		if(rs.next()!=false){
			int_result=1;
		}
		con.commit();
		rs.close();
		pre.close();
		return int_result;
	}
	
	//创建新项目
	public int AddNewProject(Connection con,String str_projectNumber,String str_projectName,String str_projectDescription,Timestamp tim_project_start_time)throws SQLException{
		String str_sql="INSERT INTO t_project(project_number,project_name,project_manager,project_begin_time,project_end_time,project_status,project_description) VALUES(?,?,NULL,?,NULL,2,?)";
		PreparedStatement pre=null;
		pre=con.prepareStatement(str_sql);
		pre.setString(1, str_projectNumber);
		pre.setString(2, str_projectName);
		pre.setTimestamp(3, tim_project_start_time);
		pre.setString(4, str_projectDescription);
		int int_result=pre.executeUpdate();
		con.commit();
		pre.close();
		return int_result;
	}
	
	//获取备选项目经理
	public List<User> GetManagerForProject(Connection con)throws SQLException{
		String str_sql="SELECT user_id,user_name FROM t_user WHERE user_id!=1 AND user_id NOT IN(SELECT project_manager FROM t_project WHERE project_manager IS NOT NULL AND project_manager NOT IN(SELECT project_manager FROM t_project WHERE project_status=0))";
		PreparedStatement pre=null;
		pre=con.prepareStatement(str_sql);
		ResultSet rs=pre.executeQuery();
		List<User> list=new ArrayList<User>();
		if(rs.next()!=false){
			do{
				User user=new User();
				user.setG_intUserId(rs.getInt("user_id"));
				user.setG_strUserName(rs.getString("user_name"));
				list.add(user);
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
	
	//为某项目添加项目经理
	public int SetManagerForProject(Connection con,int int_projectID,int int_userID)throws SQLException{
		String str_sql1="UPDATE t_project SET project_manager=? WHERE project_id=?";
		String str_sql2="UPDATE t_user SET user_role2=1 WHERE user_id=?";
		String str_sql3="INSERT INTO t_project_user(project_user_project,project_user_user) VALUES(?,?)";
		PreparedStatement pre=null;
		pre=con.prepareStatement(str_sql1);
		pre.setInt(1, int_userID);
		pre.setInt(2, int_projectID);
		int int_result=pre.executeUpdate();
		if(int_result!=0){
			pre=con.prepareStatement(str_sql2);
			pre.setInt(1, int_userID);
			int_result=pre.executeUpdate();
			if(int_result!=0){
				pre=con.prepareStatement(str_sql3);
				pre.setInt(1, int_projectID);
				pre.setInt(2, int_userID);
				int_result=pre.executeUpdate();//将用户与项目关联信息写入项目——用户表
			}
		}
		con.commit();
		pre.close();
		return int_result;
	}
	
	//更改某项目项目经理
	public int ChangeManagerForProject(Connection con,int int_projectID,int int_userID,int int_oldManager)throws SQLException{
		
		String str_sql1="UPDATE t_user SET user_role2=0 WHERE user_id=(SELECT project_manager FROM t_project WHERE project_id=?)";//将原项目经理role2设置为0，去除项目经理权限
		String str_sql2="UPDATE t_project SET project_manager=? WHERE project_id=?";//更改项目经理
		String str_sql3="DELETE FROM t_project_user WHERE project_user_project=? AND project_user_user=?";//删除原项目经理在project_user表中的映射
		String str_sql4="UPDATE t_user SET user_role2=1 WHERE user_id=?";//赋予项目经理权限
		String str_sql5="INSERT INTO t_project_user(project_user_project,project_user_user) VALUES(?,?)";//为新项目经理添加  项目——用户映射
		PreparedStatement pre=null;
		pre=con.prepareStatement(str_sql1);
		pre.setInt(1, int_projectID);
		int int_result=pre.executeUpdate();
		if(int_result!=0){
			pre=con.prepareStatement(str_sql2);
			pre.setInt(1, int_userID);
			pre.setInt(2, int_projectID);
			int_result=pre.executeUpdate();
			if(int_result!=0){
				pre=con.prepareStatement(str_sql3);
				pre.setInt(1, int_projectID);
				pre.setInt(2, int_oldManager);
				int_result=pre.executeUpdate();
				if(int_result!=0){
					pre=con.prepareStatement(str_sql4);
					pre.setInt(1, int_userID);
					int_result=pre.executeUpdate();
					if(int_result!=0){
						pre=con.prepareStatement(str_sql5);
						pre.setInt(1, int_projectID);
						pre.setInt(2, int_userID);
						int_result=pre.executeUpdate();
					}
				}
			}
		}
		con.commit();
		pre.close();
		return int_result;
	}
	
	//删除项目经理
	public int DeleteManager(Connection con,int int_projectID,int int_userID)throws SQLException{
		String str_sql1="UPDATE t_user SET user_role2=0 WHERE user_id=?";
		String str_sql2="UPDATE t_project SET project_manager=NULL WHERE project_id=?";
		String str_sql3="DELETE FROM t_project_user WHERE project_user_project=? AND project_user_user=?";
		String str_sql4="DELETE FROM t_daily WHERE daily_project=? AND daily_user=?";
		PreparedStatement pre=null;
		pre=con.prepareStatement(str_sql1);
		pre.setInt(1, int_userID);
		int int_result=pre.executeUpdate();
		if(int_result!=0){
			pre=con.prepareStatement(str_sql2);
			pre.setInt(1, int_projectID);
			int_result=pre.executeUpdate();
			if(int_result!=0){
				pre=con.prepareStatement(str_sql3);
				pre.setInt(1, int_projectID);
				pre.setInt(2, int_userID);
				int_result=pre.executeUpdate();
				if(int_result!=0){
					pre=con.prepareStatement(str_sql4);
					pre.setInt(1, int_projectID);
					pre.setInt(2, int_userID);
					pre.executeUpdate();
				}
			}
		}
		con.commit();
		pre.close();
		return int_result;
	}
	
	//删除PCB
	 public int DeletePCB(Connection con,int int_PCBID)throws SQLException{
		 String str_sql="DELETE FROM t_pcb WHERE pcb_id=?";
		 PreparedStatement pre=null;
		 pre=con.prepareStatement(str_sql);
		 pre.setInt(1, int_PCBID);
		 int int_result=pre.executeUpdate();
		 con.commit();
		 pre.close();
		 return int_result;
	 }
	 
	 //添加PCB
	 public int AddPCB(Connection con,String str_PCBName,int int_projectID,int int_amount,int int_sample,int int_deliver,int int_produceStyle,int int_confirmUser,Timestamp tim_confirmTime,String str_opinion)throws SQLException{
		 String str_sql="INSERT INTO t_pcb(pcb_name,pcb_project,pcb_amount,pcb_sample,pcb_deliver,pcb_produce_style,pcb_confirm_user,pcb_confirm_time,pcb_confirm_opinion) VALUES(?,?,?,?,?,?,?,?,?)";
		 PreparedStatement pre=null;
		 pre=con.prepareStatement(str_sql);
		 pre.setString(1, str_PCBName);
		 pre.setInt(2, int_projectID);
		 pre.setInt(3, int_amount);
		 pre.setInt(4, int_sample);
		 pre.setInt(5, int_deliver);
		 pre.setInt(6, int_produceStyle);
		 pre.setInt(7, int_confirmUser);
		 pre.setTimestamp(8, tim_confirmTime);
		 pre.setString(9, str_opinion);
		 int int_result=pre.executeUpdate();
		 con.commit();
		 pre.close();
		 return int_result;
	 }
	 
	 //将任务从项目中移除
	 public int DeleteTaskFromProject(Connection con,int int_taskID,int int_projectID)throws SQLException{
		 String str_sql1="DELETE FROM t_project_task WHERE project_task_project=? AND project_task_task=?";
		 String str_sql2="DELETE FROM t_daily WHERE daily_project=? AND daily_task=?";
		 String str_sql3="DELETE FROM t_task_assign WHERE task_assign_project=? AND task_assign_task=?";
		 PreparedStatement pre=null;
		 int int_result=0;
		 pre=con.prepareStatement(str_sql1);//删除  项目——任务   表中的映射
		 pre.setInt(1, int_projectID);
		 pre.setInt(2, int_taskID);
		 int_result=pre.executeUpdate();
		 if(int_result!=0){
			 pre=con.prepareStatement(str_sql2);//删除日报表中的相关记录
			 pre.setInt(1, int_projectID);
			 pre.setInt(2, int_taskID);
			 pre.executeUpdate();
			 
			 pre=con.prepareStatement(str_sql3);//删除 任务分配表中的相关记录
			 pre.setInt(1, int_projectID);
			 pre.setInt(2, int_taskID);
			 pre.executeUpdate();
		 }
		 con.commit();
		 pre.close();
		 return int_result;
	 }
	 
	 //为项目添加任务
	 public int AddTaskForProject(Connection con,int int_projectID,int int_taskID)throws SQLException{
		 String str_sql="INSERT INTO t_project_task(project_task_project,project_task_task) VALUES(?,?)";
		 PreparedStatement pre=null;
		 pre=con.prepareStatement(str_sql);
		 pre.setInt(1, int_projectID);
		 pre.setInt(2, int_taskID);
		 int int_result=pre.executeUpdate();
		 con.commit();
		 pre.close();
		 return int_result;
	 }
	 
	 //删除任务
	 public int DeleteTask(Connection con,int int_taskID)throws SQLException{
		 String str_sql="DELETE FROM t_task WHERE task_id=?";
		 PreparedStatement pre=null;
		 pre=con.prepareStatement(str_sql);
		 pre.setInt(1, int_taskID);
		 int int_result=pre.executeUpdate();
		 con.commit();
		 pre.close();
		 return int_result;
	 }
	 
	 //检查任务名称是否存在
	 public int CheckTaskName(Connection con,String str_taskName)throws SQLException{
		 String str_sql="SELECT task_id FROM t_task WHERE task_name=?";
		 PreparedStatement pre=null;
		 pre=con.prepareStatement(str_sql);
		 pre.setString(1, str_taskName);
		 ResultSet rs=pre.executeQuery();
		 int int_result=0;
		 if(rs.next()!=false){
			 int_result=1;
		 }
		 con.commit();
		 rs.close();
		 pre.close();
		 return int_result;
	 }
	 
	 //新建任务
	 public int CreateNewTask(Connection con,String str_taskName,int int_taskType)throws SQLException{
		 String str_sql="INSERT INTO t_task(task_name,task_type) VALUES(?,?)";
		 PreparedStatement pre=null;
		 pre=con.prepareStatement(str_sql);
		 pre.setString(1, str_taskName);
		 pre.setInt(2, int_taskType);
		 int int_result=pre.executeUpdate();
		 con.commit();
		 pre.close();
		 return int_result;
	 }
}
