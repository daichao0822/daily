package com.bean;

public class TaskStatistics {
private	String g_str_taskName;
private	int g_int_taskWorkTime;
private	int g_int_userTaskWorkTime;
private	int g_int_taskPercent;
private	int g_int_projectPercent;
private	int g_int_dailyAmount;
	
	public void setG_str_taskName(String taskName){
		g_str_taskName=taskName;
	}
	
	public String getG_str_taskName(){
		return g_str_taskName;
	}
	
	public void setG_int_taskWorkTime(int time){
		g_int_taskWorkTime=time;
	}
	
	public int getG_int_taskWorkTime(){
		return g_int_taskWorkTime;
	}
	
	public void setG_int_userTaskWorkTime(int time){
		g_int_userTaskWorkTime=time;
	}
	
	public int getG_int_userTaskWorkTime(){
		return g_int_userTaskWorkTime;
	}
	
	public void setG_int_taskPercent(int percent){
		g_int_taskPercent=percent;
	}
	
	public int getG_int_taskPercent(){
		return g_int_taskPercent;
	}
	
	public void setG_int_projectPercent(int percent){
		g_int_projectPercent=percent;
	}
	
	public int getG_int_projectPercent(){
		return g_int_projectPercent;
	}
	
	public void setG_int_dailyAmount(int amount){
		g_int_dailyAmount=amount;
	}
	
	public int getG_int_dailyAmount(){
		return g_int_dailyAmount;
	}
}
