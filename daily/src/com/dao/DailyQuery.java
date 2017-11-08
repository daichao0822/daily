package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.bean.Daily;
import com.bean.DailyReply;

public class DailyQuery {
	
	//��ѯ�û�ID=userID���û������ձ�������ѯ������Ϣ�����ձ��ύ���ڽ�������
	public List<Daily> AllDaily(Connection con,int userID)throws SQLException{
		String strSQL="SELECT * FROM t_daily WHERE t_daily.daily_user=? ORDER BY t_daily.daily_submit_time DESC";
		PreparedStatement pre=null;
		pre=con.prepareStatement(strSQL);
		pre.setInt(1, userID);
		ResultSet rs=pre.executeQuery();
		List<Daily> list=new ArrayList<Daily>();
		if(rs.next()!=false){
			do{
				Daily daily=new Daily();
				daily.setG_intDailyId(rs.getInt("daily_id"));
				daily.setG_intDialyType(rs.getInt("daily_type"));
				daily.setG_intDailyUser(rs.getInt("daily_user"));
				daily.setG_timeDailySubmitTime(rs.getTimestamp("daily_submit_time"));
				daily.setG_intDailyCheckup(rs.getInt("daily_checkup"));
				daily.setG_intDailyCount(rs.getInt("daily_time_count"));
				list.add(daily);
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
	
	//��ѯ�û�ID=int_userID���û�������Ŀ�ձ�������ѯ������Ϣ�����ձ��ύ���ڽ�������
	public List<Daily> GetUserProjectDaily(Connection con,int int_userID)throws SQLException{
		String strSQL="SELECT * FROM t_daily WHERE t_daily.daily_user=? AND daily_type=1 ORDER BY t_daily.daily_submit_time DESC";
		PreparedStatement pre=null;
		pre=con.prepareStatement(strSQL);
		pre.setInt(1, int_userID);
		ResultSet rs=pre.executeQuery();
		List<Daily> list=new ArrayList<Daily>();
		if(rs.next()!=false){
			do{
				Daily daily=new Daily();
				daily.setG_intDailyId(rs.getInt("daily_id"));
				daily.setG_intDialyType(rs.getInt("daily_type"));
				daily.setG_intDailyUser(rs.getInt("daily_user"));
				daily.setG_timeDailySubmitTime(rs.getTimestamp("daily_submit_time"));
				daily.setG_intDailyCheckup(rs.getInt("daily_checkup"));
				daily.setG_intDailyCount(rs.getInt("daily_time_count"));
				list.add(daily);
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
	
	//��ѯ�û�ID=int_userID���ձ�����ѯ�����Ǹ��û��ύ���ձ�������Ŀ���û�ID=int_managerID����Ŀ����������
	public List<Daily> GetUserDailyForMng(Connection con,int int_userID,int int_managerID)throws SQLException{
		String str_sql="SELECT * FROM t_daily WHERE daily_user=? AND daily_type=1 AND daily_project IN(SELECT project_id FROM t_project WHERE project_manager=?) ORDER BY daily_submit_time DESC";
		PreparedStatement pre=null;
		pre=con.prepareStatement(str_sql);
		pre.setInt(1, int_userID);
		pre.setInt(2, int_managerID);
		ResultSet rs=pre.executeQuery();
		List<Daily> list=new ArrayList<Daily>();
		if(rs.next()!=false){
			do{
				Daily daily=new Daily();
				daily.setG_intDailyId(rs.getInt("daily_id"));
				daily.setG_intDailyUser(rs.getInt("daily_user"));
				daily.setG_timeDailySubmitTime(rs.getTimestamp("daily_submit_time"));
				daily.setG_intDailyCheckup(rs.getInt("daily_checkup"));
				daily.setG_intDialyType(rs.getInt("daily_type"));
				list.add(daily);
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
	//��ѯ�ձ�ID=dailyID�����ձ�daily_user=userID���ձ�
	public Daily getDailyForMember(Connection con,int dailyID,int userID)throws SQLException{
		String strSQL="SELECT * FROM t_daily WHERE t_daily.daily_id=? AND t_daily.daily_user=?";
		PreparedStatement pre=null;
		pre=con.prepareStatement(strSQL);
		pre.setInt(1, dailyID);
		pre.setInt(2, userID);
		ResultSet rs=pre.executeQuery();
		Daily daily=new Daily();
		if(rs.next()!=false){
			do{
				daily.setG_intDailyCheckup(rs.getInt("daily_checkup"));
				daily.setG_intDailyCheckUser(rs.getInt("daily_check_user"));
				daily.setG_intDailyCount(rs.getInt("daily_time_count"));
				daily.setG_intDailyId(rs.getInt("daily_id"));
				daily.setG_intDailyProject(rs.getInt("daily_project"));
				daily.setG_intDailyTask(rs.getInt("daily_task"));
				daily.setG_intDailyUser(rs.getInt("daily_user"));
				daily.setG_intDialyType(rs.getInt("daily_type"));
				daily.setG_strDailyProblem(rs.getString("daily_problem"));
				daily.setG_strDailyRemark(rs.getString("daily_remark"));
				daily.setG_strDailyTaskDescription(rs.getString("daily_task_description"));
				daily.setG_strDailyTaskStatus(rs.getString("daily_task_status"));
				daily.setG_timDailyBeginTiem(rs.getTimestamp("daily_begin_time"));
				daily.setG_timDailyEndTime(rs.getTimestamp("daily_end_time"));
				daily.setG_timeDailySubmitTime(rs.getTimestamp("daily_submit_time"));
				daily.setG_strDailyImage(rs.getString("daily_image"));
			}while(rs.next());
		}
		else{
			daily=null;
		}
		con.commit();
		rs.close();
		pre.close();
		return daily;
	}
	
	//��ѯ�ձ�ID=dailyID���ձ�����ϸ��Ϣ
	public Daily DailyDetail(Connection con,int dailyID)throws SQLException{
		String strSQL="SELECT * FROM t_daily WHERE t_daily.daily_id=?";
		PreparedStatement pre=null;
		pre=con.prepareStatement(strSQL);
		pre.setInt(1, dailyID);
		ResultSet rs=pre.executeQuery();
		Daily daily=new Daily();
		if(rs.next()!=false){
			do{
				daily.setG_intDailyCheckup(rs.getInt("daily_checkup"));
				daily.setG_intDailyCheckUser(rs.getInt("daily_check_user"));
				daily.setG_intDailyCount(rs.getInt("daily_time_count"));
				daily.setG_intDailyId(rs.getInt("daily_id"));
				daily.setG_intDailyProject(rs.getInt("daily_project"));
				daily.setG_intDailyTask(rs.getInt("daily_task"));
				daily.setG_intDailyUser(rs.getInt("daily_user"));
				daily.setG_intDialyType(rs.getInt("daily_type"));
				daily.setG_strDailyProblem(rs.getString("daily_problem"));
				daily.setG_strDailyRemark(rs.getString("daily_remark"));
				daily.setG_strDailyTaskDescription(rs.getString("daily_task_description"));
				daily.setG_strDailyTaskStatus(rs.getString("daily_task_status"));
				daily.setG_timDailyBeginTiem(rs.getTimestamp("daily_begin_time"));
				daily.setG_timDailyEndTime(rs.getTimestamp("daily_end_time"));
				daily.setG_timeDailySubmitTime(rs.getTimestamp("daily_submit_time"));
				daily.setG_strDailyImage(rs.getString("daily_image"));
			}while(rs.next());
		}
		else{
			daily=null;
		}
		con.commit();
		rs.close();
		pre.close();
		return daily;
	}
	
	// ��ѯָ���ձ��Ļظ���Ϣ
	public List<DailyReply> getDailyReply(Connection con,int dailyID)throws SQLException{
		String strSQL="SELECT * FROM t_daily_reply WHERE daily_reply_daily=?";
		PreparedStatement pre=null;
		pre=con.prepareStatement(strSQL);
		pre.setInt(1, dailyID);
		ResultSet rs=pre.executeQuery();
		List<DailyReply> list=new ArrayList<DailyReply>();
		if(rs.next()!=false){
			do{
				DailyReply dailyReply=new DailyReply();
				dailyReply.setG_intDailyReplyDaily(rs.getInt("daily_reply_daily"));
				dailyReply.setG_intDailyReplyID(rs.getInt("daily_reply_id"));
				dailyReply.setG_intDailyReplyUser(rs.getInt("daily_reply_user"));
				dailyReply.setG_strDailyReplyContent(rs.getString("daily_reply_content"));
				dailyReply.setG_timDailyReplyTime(rs.getTimestamp("daily_reply_time"));
				dailyReply.setG_strDailyReplyImage(rs.getString("daily_reply_image"));
				list.add(dailyReply);
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
	
	//�����ڲ�ѯĳ���ձ������ձ��ύ���ڽ�������
	public List<Daily> getDailyBetweenDate(Connection con,Timestamp beginTime,Timestamp endTime,int userID)throws SQLException{
		String strSQL="SELECT * FROM t_daily WHERE daily_user=? AND daily_submit_time BETWEEN ? AND ? ORDER BY daily_submit_time DESC";
		PreparedStatement pre=null;
		pre=con.prepareStatement(strSQL);
		pre.setInt(1, userID);
		pre.setTimestamp(2, beginTime);
		pre.setTimestamp(3, endTime);
		ResultSet rs=pre.executeQuery();
		List<Daily> list=new ArrayList<Daily>();
		if(rs.next()!=false){
			do{
				Daily daily=new Daily();
				daily.setG_intDailyId(rs.getInt("daily_id"));
				daily.setG_intDialyType(rs.getInt("daily_type"));
				daily.setG_intDailyUser(rs.getInt("daily_user"));
				daily.setG_timeDailySubmitTime(rs.getTimestamp("daily_submit_time"));
				daily.setG_intDailyCheckup(rs.getInt("daily_checkup"));
				daily.setG_intDialyType(rs.getInt("daily_type"));
				list.add(daily);
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
	
	//�����ڲ�ѯ��Ŀ��������Ͻ��Χ����Ա�ձ������ձ��ύ���ڽ�������
	public List<Daily> GetDailyBetweenDateForMng(Connection con,Timestamp tim_startTime,Timestamp tim_endTime,int int_userID)throws SQLException{
		String strSQL="SELECT * FROM t_daily WHERE daily_submit_time BETWEEN ? AND ? AND daily_type=1 AND daily_project IN(SELECT project_id FROM t_project WHERE project_manager=?) ORDER BY daily_submit_time DESC";
		PreparedStatement pre=null;
		pre=con.prepareStatement(strSQL);
		pre.setTimestamp(1, tim_startTime);
		pre.setTimestamp(2, tim_endTime);
		pre.setInt(3, int_userID);
		ResultSet rs=pre.executeQuery();
		List<Daily> list=new ArrayList<Daily>();
		if(rs.next()!=false){
			do{
				Daily daily=new Daily();
				daily.setG_intDailyId(rs.getInt("daily_id"));
				daily.setG_intDailyUser(rs.getInt("daily_user"));
				daily.setG_timeDailySubmitTime(rs.getTimestamp("daily_submit_time"));
				daily.setG_intDailyCheckup(rs.getInt("daily_checkup"));
				daily.setG_intDialyType(rs.getInt("daily_type"));
				list.add(daily);
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
	
	//���ύ���ڲ�ѯ�ձ������ύ���ڽ�������
	public List<Daily> GetDailyBetweenDateForPMO(Connection con,Timestamp tim_startTime,Timestamp tim_endTime)throws SQLException{
		String strSQL="SELECT * FROM t_daily WHERE daily_submit_time BETWEEN ? AND ?  AND daily_type=1 ORDER BY daily_submit_time DESC";
		PreparedStatement pre=null;
		pre=con.prepareStatement(strSQL);
		pre.setTimestamp(1, tim_startTime);
		pre.setTimestamp(2, tim_endTime);
		ResultSet rs=pre.executeQuery();
		List<Daily> list=new ArrayList<Daily>();
		if(rs.next()!=false){
			do{
				Daily daily=new Daily();
				daily.setG_intDailyId(rs.getInt("daily_id"));
				daily.setG_intDailyUser(rs.getInt("daily_user"));
				daily.setG_timeDailySubmitTime(rs.getTimestamp("daily_submit_time"));
				daily.setG_intDailyCheckup(rs.getInt("daily_checkup"));
				daily.setG_intDialyType(rs.getInt("daily_type"));
				list.add(daily);
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
	
	//��ѯĳ����ĳ��Ŀ���ύ���ձ������ձ��ύ���ڽ�������
	public List<Daily> getProjectDaily(Connection con,String projectName,int int_userID)throws SQLException{
		String strSQL="SELECT * FROM t_daily WHERE daily_project=(SELECT project_id FROM t_project WHERE project_name=?) AND daily_user=? ORDER BY daily_submit_time DESC";
		PreparedStatement pre=null;
		pre=con.prepareStatement(strSQL);
		pre.setString(1, projectName);
		pre.setInt(2, int_userID);
		ResultSet rs=pre.executeQuery();
		List<Daily> list=new ArrayList<Daily>();
		if(rs.next()!=false){
			do{
				Daily daily=new Daily();
				daily.setG_intDailyId(rs.getInt("daily_id"));
				daily.setG_intDialyType(rs.getInt("daily_type"));
				daily.setG_intDailyUser(rs.getInt("daily_user"));
				daily.setG_timeDailySubmitTime(rs.getTimestamp("daily_submit_time"));
				daily.setG_intDailyCheckup(rs.getInt("daily_checkup"));
				daily.setG_intDialyType(rs.getInt("daily_type"));
				list.add(daily);
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
	
	//�������ѯĳ���ձ�,���ձ��ύ���ڽ�������
	public List<Daily> getTaskDaily(Connection con,String taskName,int int_userID)throws SQLException{
		String strSQL="SELECT * FROM t_daily WHERE daily_task=(SELECT task_id FROM t_task WHERE task_name=?) AND daily_user=? ORDER BY daily_submit_time DESC";
		PreparedStatement pre=null;
		pre=con.prepareStatement(strSQL);
		pre.setString(1, taskName);
		pre.setInt(2, int_userID);
		ResultSet rs=pre.executeQuery();
		List<Daily> list=new ArrayList<Daily>();
		if(rs.next()!=false){
			do{
				Daily daily=new Daily();
				daily.setG_intDailyId(rs.getInt("daily_id"));
				daily.setG_intDialyType(rs.getInt("daily_type"));
				daily.setG_intDailyUser(rs.getInt("daily_user"));
				daily.setG_timeDailySubmitTime(rs.getTimestamp("daily_submit_time"));
				daily.setG_intDailyCheckup(rs.getInt("daily_checkup"));
				daily.setG_intDialyType(rs.getInt("daily_type"));
				list.add(daily);
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
	
	//��ѯĳ��Ŀ�µ������ձ������ձ��ύ���ڽ�������
	public List<Daily> GetTaskDailyForMng(Connection con,int int_projectID,int int_taskID)throws SQLException{
		String str_sql="SELECT * FROM t_daily WHERE daily_project=? AND daily_task=? ORDER BY daily_submit_time DESC";
		PreparedStatement pre=null;
		pre=con.prepareStatement(str_sql);
		pre.setInt(1, int_projectID);
		pre.setInt(2, int_taskID);
		ResultSet rs=pre.executeQuery();
		List<Daily> list=new ArrayList<Daily>();
		if(rs.next()!=false){
			do{
				Daily daily=new Daily();
				daily.setG_intDailyId(rs.getInt("daily_id"));
				daily.setG_intDailyUser(rs.getInt("daily_user"));
				daily.setG_timeDailySubmitTime(rs.getTimestamp("daily_submit_time"));
				daily.setG_intDailyCheckup(rs.getInt("daily_checkup"));
				daily.setG_intDialyType(rs.getInt("daily_type"));
				list.add(daily);
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
	
	//��ѯĳ��Ŀ�����ձ�,����ȡ������Ϣ
	public List<Daily> GetAllDailyOfProject(Connection con,int int_projectID)throws SQLException{
		String str_sql="SELECT * FROM t_daily WHERE daily_project=? ORDER BY daily_submit_time DESC";
		PreparedStatement pre=null;
		pre=con.prepareStatement(str_sql);
		pre.setInt(1, int_projectID);
		ResultSet rs=pre.executeQuery();
		List<Daily> list=new ArrayList<Daily>();
		if(rs.next()!=false){
			do{
				Daily daily=new Daily();
				daily.setG_intDailyId(rs.getInt("daily_id"));
				daily.setG_intDailyUser(rs.getInt("daily_user"));
				daily.setG_timeDailySubmitTime(rs.getTimestamp("daily_submit_time"));
				daily.setG_intDailyCheckup(rs.getInt("daily_checkup"));
				daily.setG_intDialyType(rs.getInt("daily_type"));
				list.add(daily);
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
	
	//��ȡ���ձ�ID
	public int getNewDailyID(Connection con)throws SQLException{
		String strSQL="SELECT MAX(daily_id) AS newID FROM t_daily";
		PreparedStatement pre=null;
		pre=con.prepareStatement(strSQL);
		ResultSet rs=pre.executeQuery();
		rs.next();
		int newID=rs.getInt("newID")+1;
		con.commit();
		rs.close();
		pre.close();
		return newID;
	}
}
