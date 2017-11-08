package com.bean;

import java.sql.Timestamp;

public class MileStoneConf {
	private int g_int_mileStoneConfID;
	private int g_int_mileStoneConfPCB;
	private int g_int_mileStoneID;
	private int g_int_mileStoneConfUser;
	private String g_str_mileStoneConfOpinion;
	private Timestamp g_tim_mileStoneConfTime;
	
	public void setG_int_mileStoneConfID(int int_confID){
		g_int_mileStoneConfID=int_confID;
	}
	
	public int getG_int_mileStoneConfID(){
		return g_int_mileStoneConfID;
	}
	
	public void setG_int_mileStoneConfPCB(int int_PCBID){
		g_int_mileStoneConfPCB=int_PCBID;
	}
	
	public int getG_int_mileStoneConfPCB(){
		return g_int_mileStoneConfPCB;
	}
	
	public void setG_int_mileStoneID(int int_mileStoneID){
		g_int_mileStoneID=int_mileStoneID;
	}
	
	public int getG_int_mileStoneID(){
		return g_int_mileStoneID;
	}
	
	public void setG_int_mileStoneConfUser(int int_userID){
		g_int_mileStoneConfUser=int_userID;
	}
	
	public int getG_int_mileStoneConfUser(){
		return g_int_mileStoneConfUser;
	}
	
	public void setG_str_mileStoneConfOpinion(String str_opinion){
		g_str_mileStoneConfOpinion=str_opinion;
	}
	
	public String getG_str_mileStoneConfOpinion(){
		return g_str_mileStoneConfOpinion;
	}
	
	public void setG_tim_mileStoneConfTime(Timestamp tim_confTime){
		g_tim_mileStoneConfTime=tim_confTime;
	}
	
	public Timestamp getG_tim_mileStoneConfTime(){
		return g_tim_mileStoneConfTime;
	}

}
