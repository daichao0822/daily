package com.bean;

import java.sql.Timestamp;

public class DailyReply {
	private int g_intDailyReplyID;
	private int g_intDailyReplyDaily;
	private int g_intDailyReplyUser;
	private Timestamp g_timDailyReplyTime;
	private String g_strDailyReplyContent;
	private String g_strDailyReplyImage;
	
	public int getG_intDailyReplyID(){
		return g_intDailyReplyID;
	}
	
	public void setG_intDailyReplyID(int dailyReplyID){
		g_intDailyReplyID=dailyReplyID;
	}
	
	public int getG_intDailyReplyDaily(){
		return g_intDailyReplyDaily;
	}
	
	public void setG_intDailyReplyDaily(int dailyReplyDaily){
		g_intDailyReplyDaily=dailyReplyDaily;
	}
	
	public int getG_intDailyReplyUser(){
		return g_intDailyReplyUser;
	}
	
	public void setG_intDailyReplyUser(int dailyReplyUser){
		g_intDailyReplyUser=dailyReplyUser;
	}
	
	public Timestamp getG_timDailyReplyTime(){
		return g_timDailyReplyTime;
	}
	
	public void setG_timDailyReplyTime(Timestamp dailyReplyTime){
		g_timDailyReplyTime=dailyReplyTime;
	}
	
	public String getG_strDailyReplyContent(){
		return g_strDailyReplyContent;
	}
	
	public void setG_strDailyReplyContent(String replyContent){
		g_strDailyReplyContent=replyContent;
	}
	
	public String getG_strDailyReplyImage(){
		return g_strDailyReplyImage;
	}
	
	public void setG_strDailyReplyImage(String image){
		g_strDailyReplyImage=image;
	}
}
