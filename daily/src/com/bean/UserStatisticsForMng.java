package com.bean;

//��bean������Ŀ����洢��ѯĳ��Ŀ�²�����Ա�����ͳ����Ϣ

public class UserStatisticsForMng {

	private int g_int_userID;//userID
	private String g_str_userName;//userName
	private String[] g_strs_taskName;//taskName
	private int g_int_userWorkTimeInPro;//����Ŀ�е��ܹ�ʱ
	private int g_int_projectPercent;//����Ŀ�е��ܹ�ʱռ��Ŀ�ܹ�ʱ
	private int g_int_dailyAmtInPro;//����Ŀ���ύ�ձ�����
	
	public void setG_int_userID(int int_userID){
		g_int_userID=int_userID;
	}
	
	public int getG_int_userID(){
		return g_int_userID;
	}
	
	public void setG_str_userName(String str_userName){
		g_str_userName=str_userName;
	}
	
	public String getG_str_userName(){
		return g_str_userName;
	}
	
	public void setG_strs_taskName(String[] strs_taskName){
		for(int i=0;i<strs_taskName.length;i++){
			g_strs_taskName[i]=strs_taskName[i];
		}
	}
	
	public String[] getG_strs_taskName(){
		return g_strs_taskName;
	}
	
	public void setG_int_userWorkTimeInPro(int int_time){
		g_int_userWorkTimeInPro=int_time;
	}
	
	public int getG_int_userWorkTimeInPro(){
		return g_int_userWorkTimeInPro;
	}
	
	public void setG_int_projectPercent(int int_percent){
		g_int_projectPercent=int_percent;
	}
	
	public int getG_int_projectPercent(){
		return g_int_projectPercent;
	}
	
	public void setG_int_dailyAmtInPro(int int_amount){
		g_int_dailyAmtInPro=int_amount;
	}
	
	public int getG_int_dailyAmtInPro(){
		return g_int_dailyAmtInPro;
	}
}
