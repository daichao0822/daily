package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.bean.Daily;

public class DailyCheck {
	
	//查询部门ID=int_departmentID的部门的所有未审阅日报
	public List<Daily> GetAllUncheckDailyForDep(Connection con,int int_departmentID)throws SQLException{
		String str_sql="SELECT * FROM t_daily WHERE daily_checkup=0 AND daily_user IN (SELECT DISTINCT user_id FROM t_user WHERE user_department=?) ORDER BY daily_user";
		PreparedStatement pre=null;
		pre=con.prepareStatement(str_sql);
		pre.setInt(1, int_departmentID);
		ResultSet rs=pre.executeQuery();
		List<Daily> list=new ArrayList<Daily>();
		if(rs.next()!=false){
			do{
				Daily daily=new Daily();
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
	
	//审阅某日报
	public int CheckDaily(Connection con,int int_checkUserID,String str_checkOpinion,int int_dailyID)throws SQLException{
		String str_sql="UPDATE t_daily SET daily_checkup=1 ,daily_remark=?,daily_check_user=? WHERE daily_id=?";
		PreparedStatement pre=null;
		pre=con.prepareStatement(str_sql);
		pre.setString(1, str_checkOpinion);
		pre.setInt(2, int_checkUserID);
		pre.setInt(3, int_dailyID);
		int int_result=pre.executeUpdate();
		con.commit();
		pre.close();
		return int_result;
	}

}
