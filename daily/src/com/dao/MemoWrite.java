package com.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class MemoWrite {
	
	//填写备忘录
	public int WriteMemo(Connection con,int int_memoID,int int_userID,Date dat_date,String str_content)throws SQLException{
		String str_sql="INSERT INTO t_memo(memo_id,memo_user,memo_time,memo_content)VALUES(?,?,?,?)";
		PreparedStatement pre=null;
		pre=con.prepareStatement(str_sql);
		pre.setInt(1, int_memoID);
		pre.setInt(2, int_userID);
		pre.setDate(3, dat_date);
		pre.setString(4, str_content);
		int result=pre.executeUpdate();
		con.commit();
		pre.close();
		return result;
	}
	
	//得到新备忘录ID
	public int getMemoID(Connection con)throws SQLException{
		String str_sql="SELECT MAX(memo_id) AS id FROM t_memo";
		PreparedStatement pre=null;
		pre=con.prepareStatement(str_sql);
		ResultSet rs=pre.executeQuery();
		int int_id=-1;
		if(rs.next()!=false){
			int_id=rs.getInt("id")+1;
		}
		else{
			int_id=1;
		}
		con.commit();
		rs.close();
		pre.close();
		return int_id;
	}
}
