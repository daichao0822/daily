package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class AddNewUser {
	//为新增加用户分配ID
	public int GetUserID(Connection con)throws SQLException{
		String str_sql="SELECT MAX(user_id) AS id FROM t_user";
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
		con.commit();
		rs.close();
		pre.close();
		return int_result;
	}
	
	//添加系统新用户
	public int AddNewUserForSys(Connection con,int int_userID,String str_userName,String str_password,String str_sex,int int_departmentID,String str_email)throws SQLException{
		String str_sql="INSERT INTO t_user(user_id,user_name,user_password,user_sex,user_department,user_email) VALUES (?,?,?,?,?,?)";
		PreparedStatement pre=null;
		pre=con.prepareStatement(str_sql);
		pre.setInt(1, int_userID);
		pre.setString(2, str_userName);
		pre.setString(3, str_password);
		pre.setString(4, str_sex);
		pre.setInt(5, int_departmentID);
		pre.setString(6, str_email);
		int int_result=pre.executeUpdate();
		con.commit();
		pre.close();
		return int_result;
	}
	
	//检查用户名是否被占用
	public int CheckUserName(Connection con,String str_userName)throws SQLException{
		String str_sql="SELECT user_id FROM t_user WHERE user_name=?";
		PreparedStatement pre=null;
		pre=con.prepareStatement(str_sql);
		pre.setString(1, str_userName);
		ResultSet rs=pre.executeQuery();
		int int_result=-1;
		if(rs.next()!=false){
			int_result=0;
		}
		else{
			int_result=1;
		}
		con.commit();
		rs.close();
		pre.close();
		return int_result;
	}
}
