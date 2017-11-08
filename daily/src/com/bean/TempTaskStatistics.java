package com.bean;

public class TempTaskStatistics {
	
	private	String g_str_taskName;
	private	int g_int_taskWorkTime;
	private	int g_int_taskDailyAmount;
	
	public void setG_str_taskName(String taskName){
		g_str_taskName=taskName;
	}
	
	public String getG_str_taskName(){
		return g_str_taskName;
	}
	
	public void setG_int_taskWorkTime(int taskWorkTime){
		g_int_taskWorkTime=taskWorkTime;
	}
	
	public int getG_int_taskWorkTime(){
		return g_int_taskWorkTime;
	}
	
	public void setG_int_taskDailyAmount(int amount){
		g_int_taskDailyAmount=amount;
	}
	
	public int getG_int_taskDailyAmount(){
		return g_int_taskDailyAmount;
	}
}
