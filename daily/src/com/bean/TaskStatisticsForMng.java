package com.bean;

//此bean用于项目经理存储查询某项目下某任务的相关统计信息

public class TaskStatisticsForMng {
	private String g_str_projectName;
	private String g_str_taskName;
	private int g_int_taskWorkTime;
	private int g_int_taskDailyAmt;
	
	public void setG_str_projectName(String str_projectName){
		g_str_projectName=str_projectName;
	}
	
	public String getG_str_projectName(){
		return g_str_projectName;
	}
	
	public void setG_str_taskName(String str_taskName){
		g_str_taskName=str_taskName;
	}
	
	public String getG_str_taskName(){
		return g_str_taskName;
	}
	
	public void setG_int_taskWorkTime(int int_taskWorkTime){
		g_int_taskWorkTime=int_taskWorkTime;
	}
	
	public int getG_int_taskWorkTime(){
		return g_int_taskWorkTime;
	}
	
	public void setG_int_taskDailyAmt(int int_dailyAmount){
		g_int_taskDailyAmt=int_dailyAmount;
	}
	
	public int getG_int_taskDailyAmt(){
		return g_int_taskDailyAmt;
	}
	
}
