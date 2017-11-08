package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.bean.User;

public class DepartmentManage {
	//删除部门
	public int DeleteDepartment(Connection con,int int_departmentID)throws SQLException{
		String str_sql="DELETE FROM t_department WHERE department_id=?";
		PreparedStatement pre=null;
		pre=con.prepareStatement(str_sql);
		pre.setInt(1, int_departmentID);
		int int_result=pre.executeUpdate();
		con.commit();
		pre.close();
		return int_result;
	}
	
	//新建部门
	public int CreateNewDepartment(Connection con,int int_head,String str_departmentName,String str_departmentDes)throws SQLException{
		String str_sql1="INSERT INTO t_department(department_name,department_description,department_head) VALUES(?,?,?)";
		String str_sql2="INSERT INTO t_department(department_name,department_description,department_head) VALUES(?,?,NULL)";
		PreparedStatement pre=null;
		if(int_head!=-1){
			pre=con.prepareStatement(str_sql1);
			pre.setString(1, str_departmentName);
			pre.setString(2, str_departmentDes);
			pre.setInt(3, int_head);
		}
		else{
			pre=con.prepareStatement(str_sql2);
			pre.setString(1, str_departmentName);
			pre.setString(2, str_departmentDes);
		}
		int int_result=pre.executeUpdate();
		con.commit();
		pre.close();
		return int_result;
	}
	
	//删除部门长
	public int DeleteHeadOfDepartment(Connection con,int int_departmentID,int int_userID)throws SQLException{
		String str_sql1="UPDATE t_department SET department_head=NULL WHERE department_id=?";
		String str_sql2="UPDATE t_user SET user_role3=0 WHERE user_id=?";
		PreparedStatement pre=null;
		pre=con.prepareStatement(str_sql1);
		pre.setInt(1, int_departmentID);
		int int_result=pre.executeUpdate();
		if(int_result!=0){
			pre=con.prepareStatement(str_sql2);
			pre.setInt(1, int_userID);
			int_result=pre.executeUpdate();
		}
		con.commit();
		pre.close();
		return int_result;
	}
	
	//更改部门长
	public int ChangeHeadOfDepartment(Connection con,int int_newHead,int int_oldHead,int int_departmentID)throws SQLException{
		String str_sql1="UPDATE t_department SET department_head=? WHERE department_id=?";
		String str_sql2="UPDATE t_user SET user_role3=1 WHERE user_id=?";
		String str_sql3="UPDATE t_user SET user_role3=0 WHERE user_id=?";
		String str_sql4="UPDATE t_user SET user_department=? WHERE user_id=?";
		PreparedStatement pre=null;
		pre=con.prepareStatement(str_sql1);
		pre.setInt(1, int_newHead);
		pre.setInt(2, int_departmentID);
		int int_result=pre.executeUpdate();
		if(int_result!=0){
			pre=con.prepareStatement(str_sql2);
			pre.setInt(1, int_newHead);
			int_result=pre.executeUpdate();
			if(int_result!=0){
				pre=con.prepareStatement(str_sql3);
				pre.setInt(1, int_oldHead);
				int_result=pre.executeUpdate();
				if(int_result!=0){
					pre=con.prepareStatement(str_sql4);
					pre.setInt(1, int_departmentID);
					pre.setInt(2, int_newHead);
					int_result=pre.executeUpdate();
				}
			}
		}
		con.commit();
		pre.close();
		return int_result;
	}
	
	//指定部门长
	public int AddHeadOfDepartment(Connection con,int int_departmentID,int int_userID)throws SQLException{
		String str_sql1="UPDATE t_department SET department_head=? WHERE department_id=?";
		String str_sql2="UPDATE t_user SET user_role3=1 WHERE user_id=?";
		String str_sql3="UPDATE t_user SET user_department=? WHERE user_id=?";
		PreparedStatement pre=null;
		pre=con.prepareStatement(str_sql1);
		pre.setInt(1, int_userID);
		pre.setInt(2, int_departmentID);
		int int_result=pre.executeUpdate();
		if(int_result!=0){
			pre=con.prepareStatement(str_sql2);
			pre.setInt(1, int_userID);
			int_result=pre.executeUpdate();
			if(int_result!=0){
				pre=con.prepareStatement(str_sql3);
				pre.setInt(1, int_departmentID);
				pre.setInt(2, int_userID);
				int_result=pre.executeUpdate();
			}
		}
		con.commit();
		pre.close();
		return int_result;
	}
	
	//查询部门长候选人
	public List<User> GetNewHeadOfDepartment(Connection con)throws SQLException{
		String str_sql="SELECT * FROM t_user WHERE user_id!=1 AND user_id NOT IN(SELECT DISTINCT department_head FROM t_department WHERE department_head IS NOT NULL )";
		PreparedStatement pre=null;
		pre=con.prepareStatement(str_sql);
		List<User> list=new ArrayList<User>();
		ResultSet rs=pre.executeQuery();
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
	
	//查询部门名称是否存在
	public int CheckDepartmentName(Connection con,String str_departmentName)throws SQLException{
		String str_sql="SELECT department_id FROM t_department WHERE department_name=?";
		PreparedStatement pre=null;
		pre=con.prepareStatement(str_sql);
		pre.setString(1, str_departmentName);
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
}
