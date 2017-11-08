package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.bean.Daily;
import com.bean.Department;
import com.bean.User;

public class DepartmentQuery {
	
	//查询部门ID=int_departmentID的部门信息
	public Department GetDepartmentalInfo(Connection con,int int_departmentID)throws SQLException{
		String str_sql="SELECT * FROM t_department WHERE department_id=?";
		PreparedStatement pre=null;
		pre=con.prepareStatement(str_sql);
		pre.setInt(1, int_departmentID);
		ResultSet rs=pre.executeQuery();
		Department dep=new Department();
		if(rs.next()!=false){
			dep.setG_intDepartmentHead(rs.getInt("department_head"));
			dep.setG_intDepartmentId(rs.getInt("department_id"));
			dep.setG_strDepartmentDescription(rs.getString("department_description"));
			dep.setG_strDepartmentName(rs.getString("department_name"));
		}
		else{
			dep=null;
		}
		con.commit();
		rs.close();
		pre.close();
		return dep;
	}
	
	//获取部门人员详细信息
	public List<User> GetUserInDepartment(Connection con,int int_departmentID)throws SQLException{
		String str_sql="SELECT * FROM t_user WHERE user_department=?";
		PreparedStatement pre=null;
		pre=con.prepareStatement(str_sql);
		pre.setInt(1, int_departmentID);
		ResultSet rs=pre.executeQuery();
		List<User> result=new ArrayList<User>();
		if(rs.next()!=false){
			do{
				User user1=new User();
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
			}while(rs.next());
		}
		else{
			result=null;
		}
		con.commit();
		rs.close();
		pre.close();
		return result;
	}
	
	//获得一周前的日期
	public String lastWeek(){
	   Date date = new Date();
	   int year=Integer.parseInt(new SimpleDateFormat("yyyy").format(date));
	   int month=Integer.parseInt(new SimpleDateFormat("MM").format(date));
	   int day=Integer.parseInt(new SimpleDateFormat("dd").format(date))-6;
	   int hour=Integer.parseInt(new SimpleDateFormat("HH").format(date));
	   int minute=Integer.parseInt(new SimpleDateFormat("mm").format(date));
	   int second=Integer.parseInt(new SimpleDateFormat("ss").format(date));
	   
	   if(day<1){
	    month-=1;
	    if(month==0){
	     year-=1;month=12;
	    }
	    if(month==4||month==6||month==9||month==11){
	     day=30+day;
	    }else if(month==1||month==3||month==5||month==7||month==8||month==10||month==12)
	    {
	     day=31+day;
	    }else if(month==2){
	     if(year%400==0||(year %4==0&&year%100!=0))day=29+day;
	     else day=28+day;
	    }     
	   }
	   String y = year+"";String m ="";String d ="";String mm="";String ss="";
	   if(month<10) m = "0"+month;
	   else m=month+"";
	   if(day<10) d = "0"+day;
	   else d = day+"";
	   if(minute<10) mm="0"+minute;
	   else mm=minute+"";
	   if(second<10) ss="0"+second;
	   else ss=second+"";
	   return y+"-"+m+"-"+d+" "+hour+":"+mm+":"+ss;
	}

	//获得一月前的日期
	public String lastMonth(){
	   Date date = new Date();
	   int year=Integer.parseInt(new SimpleDateFormat("yyyy").format(date));
	   int month=Integer.parseInt(new SimpleDateFormat("MM").format(date))-1;
	   int day=Integer.parseInt(new SimpleDateFormat("dd").format(date));
	   int hour=Integer.parseInt(new SimpleDateFormat("HH").format(date));
	   int minute=Integer.parseInt(new SimpleDateFormat("mm").format(date));
	   int second=Integer.parseInt(new SimpleDateFormat("ss").format(date));

	   if(month==0){
	    year-=1;month=12;
	   }
	   else if(day>28){
	    if(month==2){
	     if(year%400==0||(year %4==0&&year%100!=0)){
	      day=29;
	     }else day=28;
	    }else if((month==4||month==6||month==9||month==11)&&day==31)
	    {
	     day=30;
	    }
	   }
	   String y = year+"";String m ="";String d ="";String mm="";String ss="";
	   if(month<10) m = "0"+month;
	   else m=month+"";
	   if(day<10) d = "0"+day;
	   else d = day+"";
	   if(minute<10) mm="0"+minute;
	   else mm=minute+"";
	   if(second<10) ss="0"+second;
	   else ss=second+"";
	   return y+"-"+m+"-"+d+" "+hour+":"+mm+":"+ss;
	}

	
	
	//查询用户ID=int_userID的用户最近一个月提交日报
	public List<Daily> GetUserDailyInLastMonth(Connection con,int int_userID)throws SQLException{
		String str_lastMonthTime=lastMonth();
		Timestamp tim_lastMonthTime=Timestamp.valueOf(str_lastMonthTime);//获得一个月前的时间
		String str_sql="SELECT * FROM t_daily WHERE daily_user=? AND daily_submit_time > ?";
		PreparedStatement pre=null;
		pre=con.prepareStatement(str_sql);
		pre.setInt(1, int_userID);
		pre.setTimestamp(2, tim_lastMonthTime);
		ResultSet rs=pre.executeQuery();
		List<Daily> dailys=new ArrayList<Daily>();
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
				dailys.add(daily);
			}while(rs.next());
		}
		else{
			dailys=null;
		}
		con.commit();
		rs.close();
		pre.close();
		return dailys;
	}
	
	//查询用户ID=int_userID的用户最近一周提交日报
	public List<Daily> GetUserDailyInLastWeek(Connection con,int int_userID)throws SQLException{
		String str_lastWeekTime=lastWeek();
		Timestamp tim_lastMonthTime=Timestamp.valueOf(str_lastWeekTime);//获得一周前的时间
		String str_sql="SELECT * FROM t_daily WHERE daily_user=? AND daily_submit_time > ?";
		PreparedStatement pre=null;
		pre=con.prepareStatement(str_sql);
		pre.setInt(1, int_userID);
		pre.setTimestamp(2, tim_lastMonthTime);
		ResultSet rs=pre.executeQuery();
		List<Daily> dailys=new ArrayList<Daily>();
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
				dailys.add(daily);
			}while(rs.next());
		}
		else{
			dailys=null;
		}
		con.commit();
		rs.close();
		pre.close();
		return dailys;
	}
	
	//查询某部门所有日报,仅查询部分信息
	public List<Daily> GetDepartmentalDaily(Connection con,int int_departmentID)throws SQLException{
		String str_sql="SELECT * FROM t_daily WHERE daily_user IN (SELECT DISTINCT user_id FROM t_user WHERE user_department=?) ORDER BY daily_user";
		PreparedStatement pre=null;
		pre=con.prepareStatement(str_sql);
		pre.setInt(1, int_departmentID);
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
	
	//按提交日期范围查询某部门日报
	public List<Daily> GetDepartmentDailyByTime(Connection con,int int_departmentID,Timestamp tim_startTime,Timestamp tim_endTime)throws SQLException{
		String strSQL="SELECT * FROM t_daily WHERE daily_user IN(SELECT DISTINCT user_id FROM t_user WHERE user_department=?) AND daily_submit_time BETWEEN ? AND ? ORDER BY daily_submit_time DESC";
		PreparedStatement pre=null;
		pre=con.prepareStatement(strSQL);
		pre.setInt(1, int_departmentID);
		pre.setTimestamp(2, tim_startTime);
		pre.setTimestamp(3, tim_endTime);
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
	
	//按提交日期范围查询某人日报
	public List<Daily> GetUserDailyByTime(Connection con,int int_userID,Timestamp tim_startTime,Timestamp tim_endTime)throws SQLException{
		String strSQL="SELECT * FROM t_daily WHERE daily_user=? AND daily_submit_time BETWEEN ? AND ? ORDER BY daily_submit_time DESC";
		PreparedStatement pre=null;
		pre=con.prepareStatement(strSQL);
		pre.setInt(1, int_userID);
		pre.setTimestamp(2, tim_startTime);
		pre.setTimestamp(3, tim_endTime);
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
	
	
}
