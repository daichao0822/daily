package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;

public class DailyReply {
	
	public int getDailyReplyID(Connection con)throws SQLException{
		String str_sql="SELECT MAX(daily_reply_id) AS id FROM t_daily_reply";
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
	
	public int ReplyDaily(Connection con,int int_replyID,int int_dailyID,int int_userID,Timestamp tim_time,String str_content,String str_image)throws SQLException{
		String str_sql="INSERT INTO t_daily_reply(daily_reply_id,daily_reply_daily,daily_reply_user,daily_reply_time,daily_reply_content,daily_reply_image)VALUES(?,?,?,?,?,?)";
		PreparedStatement pre=null;
		pre=con.prepareStatement(str_sql);
		pre.setInt(1, int_replyID);
		pre.setInt(2, int_dailyID);
		pre.setInt(3, int_userID);
		pre.setTimestamp(4, tim_time);
		pre.setString(5, str_content);
		pre.setString(6, str_image);
		int result=pre.executeUpdate();
		con.commit();
		pre.close();
		return result;
	}
}
