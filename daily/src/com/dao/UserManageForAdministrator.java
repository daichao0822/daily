package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.bean.Department;
import com.bean.User;

public class UserManageForAdministrator {
	//查询所有人员
	public List<User> GetAllUser(Connection con)throws SQLException{
		String str_sql="SELECT * FROM t_user";
		PreparedStatement pre=null;
		pre=con.prepareStatement(str_sql);
		ResultSet rs=pre.executeQuery();
		List<User> result=new ArrayList<User>();
		if(rs.next()!=false){
			do{
			User user1=new User();
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
			}
			while(rs.next());
		}
		else{
			result=null;
		}
		con.commit();
		rs.close();
		pre.close();
		return result;
	}
	
	//查询所有部门
	public List<Department> GetAllDepartment(Connection con)throws SQLException{
		String str_sql="SELECT * FROM t_department";
		PreparedStatement pre=null;
		pre=con.prepareStatement(str_sql);
		ResultSet rs=pre.executeQuery();
		List<Department> list=new ArrayList<Department>();
		if(rs.next()!=false){
			do{
				Department dep=new Department();
				dep.setG_intDepartmentId(rs.getInt("department_id"));
				dep.setG_strDepartmentName(rs.getString("department_name"));
				dep.setG_intDepartmentHead(rs.getInt("department_head"));
				dep.setG_strDepartmentDescription(rs.getString("department_description"));
				list.add(dep);
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
	
	//查询所有PMO
	public List<User> GetAllPMO(Connection con)throws SQLException{
		String str_sql="SELECT * FROM t_user WHERE user_role4=1";
		PreparedStatement pre=null;
		pre=con.prepareStatement(str_sql);
		ResultSet rs=pre.executeQuery();
		List<User> result=new ArrayList<User>();
		if(rs.next()!=false){
			do{
			User user1=new User();
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
			}
			while(rs.next());
		}
		else{
			result=null;
		}
		con.commit();
		rs.close();
		pre.close();
		return result;
	}
	
	//查询非PMO人员
	public List<User> GetNewPMO(Connection con)throws SQLException{
		String str_sql="SELECT * FROM t_user WHERE user_role4=0";
		PreparedStatement pre=null;
		pre=con.prepareStatement(str_sql);
		ResultSet rs=pre.executeQuery();
		List<User> result=new ArrayList<User>();
		if(rs.next()!=false){
			do{
			User user1=new User();
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
			}
			while(rs.next());
		}
		else{
			result=null;
		}
		con.commit();
		rs.close();
		pre.close();
		return result;
	}
	
	//添加PMO
	public int AddNewPMO(Connection con,int int_userID)throws SQLException{
		String str_sql="UPDATE t_user SET user_role4=1 WHERE user_id=?";
		PreparedStatement pre=null;
		pre=con.prepareStatement(str_sql);
		pre.setInt(1, int_userID);
		int int_result=pre.executeUpdate();
		con.commit();
		pre.close();
		return int_result;
	}
	
	//删除PMO
	public int DeletePMO(Connection con,int int_userID)throws SQLException{
		String str_sql="UPDATE t_user SET user_role4=0 WHERE user_id=?";
		PreparedStatement pre=null;
		pre=con.prepareStatement(str_sql);
		pre.setInt(1, int_userID);
		int int_result=pre.executeUpdate();
		con.commit();
		pre.close();
		return int_result;
	}
}
