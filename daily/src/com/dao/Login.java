package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.bean.Memo;
import com.bean.User;

public class Login {
	//登录检查
	public User login(Connection con,User user)throws SQLException{
		String strSql="SELECT * FROM t_user WHERE user_name=? AND user_password=?";
		PreparedStatement pre=null;
		pre=con.prepareStatement(strSql);
		pre.setString(1, user.getG_strUserName());
		pre.setString(2, user.getG_strPassword());
		ResultSet rs=pre.executeQuery();
		User user1=null;
		while(rs.next()){
			user1=new User();
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
		}
		con.commit();
		rs.close();
		pre.close();
		return user1;
	}
	//获取备忘录信息
	public List<Memo> getMemo(Connection con,User user)throws SQLException{
		String strSql="SELECT * FROM t_memo WHERE t_memo.memo_time=(select current_date) AND t_memo.memo_user=?";
		PreparedStatement pre=null;
		pre=con.prepareStatement(strSql);
		pre.setInt(1,user.getG_intUserId() );
		ResultSet rs=pre.executeQuery();
		List<Memo> list=new ArrayList<Memo>();
		if(rs.next()!=false){
			do{
				Memo memo=new Memo();
				memo.setG_datMemoDate(rs.getDate("memo_time"));
				memo.setG_intMemoId(rs.getInt("memo_id"));
				memo.setG_intMemoUser(rs.getInt("memo_user"));
				memo.setG_strMemoContent(rs.getString("memo_content"));
				list.add(memo);
			}while(rs.next());
		}
		con.commit();
		rs.close();
		pre.close();
		return list;
	}
}
