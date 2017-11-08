package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.bean.MileStoneConf;
import com.bean.Milestone;
import com.bean.PCB;
import com.bean.Project;
import com.bean.ProjectTaskAssign;
import com.bean.Task;
import com.bean.User;

public class ProjectQuery {
	// 查询所有项目
	public List<Project> GetAllProject(Connection con) throws SQLException {
		String str_sql = "SELECT * FROM t_project";
		PreparedStatement pre = null;
		pre = con.prepareStatement(str_sql);
		ResultSet rs = pre.executeQuery();
		List<Project> list = new ArrayList<Project>();
		if (rs.next() != false) {
			do {
				Project pro = new Project();
				pro.setG_intProjectId(rs.getInt("project_id"));
				pro.setG_intProjectManager(rs.getInt("project_manager"));
				pro.setG_intProjectStatus(rs.getInt("project_status"));
				pro.setG_strProjectName(rs.getString("project_name"));
				pro.setG_strProjectNumber(rs.getString("project_number"));
				pro.setG_timProjectBeginTime(rs
						.getTimestamp("project_begin_time"));
				pro.setG_timProjectEndTime(rs.getTimestamp("project_end_time"));
				list.add(pro);
			} while (rs.next());
		} else {
			list = null;
		}
		con.commit();
		rs.close();
		pre.close();
		return list;
	}

	// 查询项目经理负责的所有项目
	public List<Project> GetProjectOfMng(Connection con, int int_userID)
			throws SQLException {
		String str_sql = "SELECT * FROM t_project where project_manager=?";
		PreparedStatement pre = null;
		pre = con.prepareStatement(str_sql);
		pre.setInt(1, int_userID);
		ResultSet rs = pre.executeQuery();
		List<Project> list = new ArrayList<Project>();
		if (rs.next() != false) {
			do {
				Project pro = new Project();
				pro.setG_intProjectId(rs.getInt("project_id"));
				pro.setG_intProjectManager(rs.getInt("project_manager"));
				pro.setG_intProjectStatus(rs.getInt("project_status"));
				pro.setG_strProjectName(rs.getString("project_name"));
				pro.setG_strProjectNumber(rs.getString("project_number"));
				pro.setG_timProjectBeginTime(rs
						.getTimestamp("project_begin_time"));
				pro.setG_timProjectEndTime(rs.getTimestamp("project_end_time"));
				list.add(pro);
			} while (rs.next());
		} else {
			list = null;
		}
		con.commit();
		rs.close();
		pre.close();
		return list;
	}

	// 查询ID=projectID的项目详细信息
	public List<Project> GetProjectDetail(Connection con, int int_projectID)
			throws SQLException {
		String str_sql = "SELECT * FROM t_project where project_id=?";
		PreparedStatement pre = null;
		pre = con.prepareStatement(str_sql);
		pre.setInt(1, int_projectID);
		ResultSet rs = pre.executeQuery();
		List<Project> list = new ArrayList<Project>();
		if (rs.next() != false) {
			do {
				Project pro = new Project();
				pro.setG_intProjectId(rs.getInt("project_id"));
				pro.setG_intProjectManager(rs.getInt("project_manager"));
				pro.setG_intProjectStatus(rs.getInt("project_status"));
				pro.setG_strProjectName(rs.getString("project_name"));
				pro.setG_strProjectNumber(rs.getString("project_number"));
				pro.setG_timProjectBeginTime(rs
						.getTimestamp("project_begin_time"));
				pro.setG_timProjectEndTime(rs.getTimestamp("project_end_time"));
				list.add(pro);
			} while (rs.next());
		} else {
			list = null;
		}
		con.commit();
		rs.close();
		pre.close();
		return list;
	}

	// 获得ID=projectID的项目的所有参与人员详细信息
	public List<User> GetUsersInPro(Connection con, int int_projectID)
			throws SQLException {
		String strSql = "SELECT * FROM t_user WHERE user_id IN(SELECT DISTINCT project_user_user FROM t_project_user WHERE project_user_project=? )";
		PreparedStatement pre = null;
		pre = con.prepareStatement(strSql);
		pre.setInt(1, int_projectID);
		ResultSet rs = pre.executeQuery();
		List<User> result = new ArrayList<User>();
		if (rs.next() != false) {
			do {
				User user1 = new User();
				user1.setG_intDepartment(rs.getInt("User_Department"));
				user1.setG_strEmail(rs.getString("User_Email"));
				user1.setG_strPassword(rs.getString("User_Password"));
				user1.setG_intUserId(rs.getInt("User_ID"));
				user1.setG_strUserName(rs.getString("User_Name"));
				user1.setG_strSex(rs.getString("User_Sex"));
				user1.setG_intRole1(rs.getInt("User_Role1"));
				user1.setG_intRole2(rs.getInt("User_Role2"));
				user1.setG_intRole3(rs.getInt("User_Role3"));
				user1.setG_intRole4(rs.getInt("User_Role4"));
				user1.setG_intRole5(rs.getInt("User_Role5"));
				result.add(user1);
			} while (rs.next());
		} else {
			result = null;
		}
		con.commit();
		rs.close();
		pre.close();
		return result;
	}

	// 获得ID=projectID项目的所有任务
	public List<Task> GetProTask(Connection con, int int_projectID)
			throws SQLException {
		String str_sql = "SELECT DISTINCT project_task_task FROM t_project_task WHERE project_task_project=? ";
		PreparedStatement pre = null;
		pre = con.prepareStatement(str_sql);
		pre.setInt(1, int_projectID);
		ResultSet rs = pre.executeQuery();
		List<Task> list = new ArrayList<Task>();
		if (rs.next() != false) {
			do {
				Task task = new Task();
				task.setG_intTaskId(rs.getInt("project_task_task"));
				list.add(task);
			} while (rs.next());
		} else {
			list = null;
		}
		con.commit();
		rs.close();
		pre.close();
		return list;
	}

	// 获取项目PCB列表
	public List<PCB> GetPCBForProject(Connection con, int int_projectID)
			throws SQLException {
		String str_sql = "SELECT * FROM t_pcb WHERE pcb_project=?";
		PreparedStatement pre = null;
		pre = con.prepareStatement(str_sql);
		pre.setInt(1, int_projectID);
		ResultSet rs = pre.executeQuery();
		List<PCB> list = new ArrayList<PCB>();
		if (rs.next() != false) {
			do {
				PCB pcb = new PCB();
				pcb.setG_intPCBAmount(rs.getInt("pcb_amount"));
				pcb.setG_intPCBConfirmUser(rs.getInt("pcb_confirm_user"));
				pcb.setG_intPCBDeliver(rs.getInt("pcb_deliver"));
				pcb.setG_intPCBId(rs.getInt("pcb_id"));
				pcb.setG_intPCBProduceStyle(rs.getInt("pcb_produce_style"));
				pcb.setG_intPCBProject(rs.getInt("pcb_project"));
				pcb.setG_intPCBSample(rs.getInt("pcb_sample"));
				pcb.setG_strPCBConfirmOpinion(rs
						.getString("pcb_confirm_opinion"));
				pcb.setG_strPCBName(rs.getString("pcb_name"));
				pcb.setG_timPCBConfirmTime(rs.getTimestamp("pcb_confirm_time"));
				list.add(pcb);
			} while (rs.next());
		} else {
			list = null;
		}
		con.commit();
		rs.close();
		pre.close();
		return list;
	}

	// 获得所有能被添加为项目人员的人员信息

	public List<User> GetUsersForPro(Connection con) throws SQLException {
		String str_sql = "SELECT * FROM t_user WHERE user_id!=1 AND user_id NOT IN(SELECT DISTINCT project_user_user FROM t_project_user WHERE project_user_user IS NOT NULL AND project_user_project NOT IN (SELECT project_id FROM t_project WHERE project_id IS NOT NULL AND project_status=0))";
		PreparedStatement pre = null;
		pre = con.prepareStatement(str_sql);
		ResultSet rs = pre.executeQuery();
		List<User> result = new ArrayList<User>();
		if (rs.next() != false) {
			do {
				User user1 = new User();
				user1.setG_intDepartment(rs.getInt("User_Department"));
				user1.setG_strEmail(rs.getString("User_Email"));
				user1.setG_intUserId(rs.getInt("User_ID"));
				user1.setG_strUserName(rs.getString("User_Name"));
				user1.setG_strSex(rs.getString("User_Sex"));
				user1.setG_intRole1(rs.getInt("User_Role1"));
				user1.setG_intRole2(rs.getInt("User_Role2"));
				user1.setG_intRole3(rs.getInt("User_Role3"));
				user1.setG_intRole4(rs.getInt("User_Role4"));
				user1.setG_intRole5(rs.getInt("User_Role5"));
				result.add(user1);
			} while (rs.next());
		} else {
			result = null;
		}
		con.commit();
		rs.close();
		pre.close();
		return result;
	}

	// 获得所有能添加到项目的任务
	public List<Task> GetAllTaskForProject(Connection con, int int_projectID)
			throws SQLException {
		String str_sql = "SELECT * FROM t_task WHERE task_id NOT IN(SELECT project_task_task FROM t_project_task WHERE project_task_task IS NOT NULL AND project_task_project=?) AND task_type=1";
		PreparedStatement pre = null;
		pre = con.prepareStatement(str_sql);
		pre.setInt(1, int_projectID);
		ResultSet rs = pre.executeQuery();
		List<Task> list = new ArrayList<Task>();
		if (rs.next() != false) {
			do {
				Task task = new Task();
				task.setG_intTaskId(rs.getInt("task_id"));
				task.setG_intTaskType(rs.getInt("task_type"));
				task.setG_strTaskName(rs.getString("task_name"));
				list.add(task);
			} while (rs.next());
		} else {
			list = null;
		}
		con.commit();
		rs.close();
		pre.close();
		return list;
	}

	// 获得所有能被赋予项目任务的人员
	public List<User> GetUserForTask(Connection con, int int_projectID)
			throws SQLException {
		String str_sql = "SELECT * FROM t_user WHERE user_id IN" +
				"(SELECT DISTINCT project_user_user FROM t_project_user WHERE project_user_user IS NOT NULL AND project_user_project=?)" +
				" AND user_id NOT IN(SELECT a.task_assign_exec_user FROM t_task_assign a WHERE a.task_assign_exec_user IS NOT NULL AND" +
				" a.task_assign_project NOT IN(SELECT project_id FROM t_project WHERE project_id IS NOT NULL AND project_status=0 ))";
		PreparedStatement pre = null;
		pre = con.prepareStatement(str_sql);
		pre.setInt(1, int_projectID);
		ResultSet rs = pre.executeQuery();
		List<User> result = new ArrayList<User>();
		if (rs.next() != false) {
			do {
				User user1 = new User();
				user1.setG_intDepartment(rs.getInt("User_Department"));
				user1.setG_strEmail(rs.getString("User_Email"));
				user1.setG_intUserId(rs.getInt("User_ID"));
				user1.setG_strUserName(rs.getString("User_Name"));
				user1.setG_strSex(rs.getString("User_Sex"));
				user1.setG_intRole1(rs.getInt("User_Role1"));
				user1.setG_intRole2(rs.getInt("User_Role2"));
				user1.setG_intRole3(rs.getInt("User_Role3"));
				user1.setG_intRole4(rs.getInt("User_Role4"));
				user1.setG_intRole5(rs.getInt("User_Role5"));
				result.add(user1);
			} while (rs.next());
		} else {
			result = null;
		}
		con.commit();
		rs.close();
		pre.close();
		return result;
	}

	// 查询某人参与某项目的所有任务
	public String[] GetUserTaskInPro(Connection con, int int_userID,
			int int_projectID) throws SQLException {
		String str_sql = "SELECT task_name from t_task WHERE task_id IN(SELECT DISTINCT task_assign_task FROM t_task_assign WHERE task_assign_user=? AND task_assign_project=? )";
		PreparedStatement pre = null;
		pre = con.prepareStatement(str_sql);
		pre.setInt(1, int_userID);
		pre.setInt(2, int_projectID);
		ResultSet rs = pre.executeQuery();
		String[] tasks = new String[7];
		int i = 0;
		if (rs.next() != false) {
			do {
				tasks[i] = rs.getString("task_name");
				i++;
			} while (rs.next());
		}
		con.commit();
		rs.close();
		pre.close();
		return tasks;
	}

	// 获得ID=projectID的项目的任务分配情况
	public ProjectTaskAssign GetProjectTaskAssign(Connection con,
			int int_projectID, int int_taskID) throws SQLException {
		String str_sql = "SELECT * FROM t_task_assign WHERE task_assign_project=? AND task_assign_task=?";
		PreparedStatement pre = null;
		pre = con.prepareStatement(str_sql);
		pre.setInt(1, int_projectID);
		pre.setInt(2, int_taskID);
		ResultSet rs = pre.executeQuery();
		ProjectTaskAssign assign = new ProjectTaskAssign();
		if (rs.next() != false) {
			assign.setG_int_confirm_user(rs.getInt("task_assign_confirm_user"));
			assign.setG_int_exec_user(rs.getInt("task_assign_exec_user"));
			assign.setG_int_project(rs.getInt("task_assign_project"));
			assign.setG_int_task(rs.getInt("task_assign_task"));
			assign.setG_int_work_time(rs.getInt("task_assign_time_limit"));
			assign.setG_str_opinion(rs.getString("task_assign_opinion"));
			assign.setG_tim_begin_time(rs
					.getTimestamp("task_assign_begin_time"));
			assign.setG_tim_end_time(rs.getTimestamp("task_assign_end_time"));
		} else {
			assign = null;
		}
		con.commit();
		rs.close();
		pre.close();
		return assign;
	}

	// 查询项目经理所管辖的所有项目人员
	public List<User> GetUserUnderManager(Connection con, int int_userID)
			throws SQLException {
		String str_sql = "SELECT DISTINCT user_id,user_name FROM t_user WHERE user_id IN(SELECT project_user_user FROM t_project_user WHERE project_user_project IN(SELECT project_id From t_project WHERE project_manager=?))";
		PreparedStatement pre = null;
		pre = con.prepareStatement(str_sql);
		pre.setInt(1, int_userID);
		ResultSet rs = pre.executeQuery();
		List<User> user = new ArrayList<User>();
		if (rs.next() != false) {
			do {
				User u = new User();
				u.setG_intUserId(rs.getInt("user_id"));
				u.setG_strUserName(rs.getString("user_name"));
				user.add(u);
			} while (rs.next());
		} else {
			user = null;
		}
		con.commit();
		rs.close();
		pre.close();
		return user;
	}

	// 查询PCB里程碑
	public List<MileStoneConf> GetMileStoneConf(Connection con, int int_PCBID)
			throws SQLException {
		String str_sql = "SELECT * FROM t_milestone_conf WHERE milestone_conf_pcb=?";
		PreparedStatement pre = null;
		pre = con.prepareStatement(str_sql);
		pre.setInt(1, int_PCBID);
		ResultSet rs = pre.executeQuery();
		List<MileStoneConf> list = new ArrayList<MileStoneConf>();
		if (rs.next() != false) {
			do {
				MileStoneConf conf = new MileStoneConf();
				conf.setG_int_mileStoneConfID(rs.getInt("milestone_conf_id"));
				conf.setG_int_mileStoneConfPCB(rs.getInt("milestone_conf_pcb"));
				conf.setG_int_mileStoneConfUser(rs
						.getInt("milestone_conf_user"));
				conf
						.setG_int_mileStoneID(rs
								.getInt("milestone_conf_milestone"));
				conf.setG_str_mileStoneConfOpinion(rs
						.getString("milestone_conf_opinion"));
				conf.setG_tim_mileStoneConfTime(rs
						.getTimestamp("milestone_conf_time"));
				list.add(conf);
			} while (rs.next());
		} else {
			list = null;
		}
		con.commit();
		rs.close();
		pre.close();
		return list;
	}

	// 查询能被添加到PCB的里程碑
	public List<Milestone> GetMilestoneForPCB(Connection con, int int_PCBID)
			throws SQLException {
		String str_sql = "SELECT * FROM t_milestone WHERE milestone_id NOT IN (SELECT DISTINCT milestone_conf_milestone FROM t_milestone_conf WHERE milestone_conf_pcb=?)";
		PreparedStatement pre = null;
		pre = con.prepareStatement(str_sql);
		pre.setInt(1, int_PCBID);
		ResultSet rs = pre.executeQuery();
		List<Milestone> list = new ArrayList<Milestone>();
		if (rs.next() != false) {
			do {
				Milestone milestone = new Milestone();
				milestone.setG_intMileStoneId(rs.getInt("milestone_id"));
				milestone.setG_strMileStoneName(rs.getString("milestone_name"));
				list.add(milestone);
			} while (rs.next());
		} else {
			list = null;
		}
		con.commit();
		rs.close();
		pre.close();
		return list;
	}

	// 查询任务详细信息
	public Task GetTaskDetail(Connection con, int int_taskID)
			throws SQLException {
		String str_sql = "SELECT * FROM t_task WHERE task_id=?";
		PreparedStatement pre = null;
		pre = con.prepareStatement(str_sql);
		pre.setInt(1, int_taskID);
		ResultSet rs = pre.executeQuery();
		Task result = new Task();
		if (rs.next() != false) {
			result.setG_intTaskId(rs.getInt("task_id"));
			result.setG_intTaskType(rs.getInt("task_type"));
			result.setG_strTaskName(rs.getString("task_name"));
		} else {
			result = null;
		}
		con.commit();
		rs.close();
		pre.close();
		return result;
	}

	// 查询所有任务
	public List<Task> GetAllTask(Connection con) throws SQLException {
		String str_sql = "SELECT * FROM t_task ORDER BY task_type DESC";
		PreparedStatement pre = null;
		pre = con.prepareStatement(str_sql);
		ResultSet rs = pre.executeQuery();
		List<Task> list = new ArrayList<Task>();
		if (rs.next() != false) {
			do {
				Task task = new Task();
				task.setG_intTaskId(rs.getInt("task_id"));
				task.setG_intTaskType(rs.getInt("task_type"));
				task.setG_strTaskName(rs.getString("task_name"));
				list.add(task);
			} while (rs.next());
		} else {
			list = null;
		}
		con.commit();
		rs.close();
		pre.close();
		return list;
	}

	// 查询所有项目人员
	public List<User> GetAllProjectUser(Connection con) throws SQLException {
		String str_sql = "SELECT * FROM t_user WHERE user_id IN(SELECT DISTINCT project_user_user FROM t_project_user)";
		PreparedStatement pre = null;
		pre = con.prepareStatement(str_sql);
		ResultSet rs = pre.executeQuery();
		List<User> list = new ArrayList<User>();
		if (rs.next() != false) {
			do {
				User user = new User();
				user.setG_intUserId(rs.getInt("user_id"));
				user.setG_strUserName(rs.getString("user_name"));
				list.add(user);
			} while (rs.next());
		} else {
			list = null;
		}
		con.commit();
		rs.close();
		pre.close();
		return list;
	}
}
