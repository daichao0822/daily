package com.bean;

import java.sql.Timestamp;

public class Daily {
private int g_intDailyId;
private int g_intDailyUser;
private Timestamp g_timDailyBeginTime;
private Timestamp g_timDailyEndTime;
private int g_intDailyCount;
private int g_intDailyProject;
private int g_intDailyType;
private int g_intDailyTask;
private String g_strDailyTaskDescription;
private String g_strDailyTaskStatus;
private String g_strDailyProblem;
private int g_intDailyCheckup;
private String g_strDailyRemark;
private int g_intDailyCheckUser;
private Timestamp g_timDailySubmitTime;
private String g_strDailyImage;

public int getG_intDailyId(){
	return g_intDailyId;
}

public void setG_intDailyId(int dailyId){
	g_intDailyId=dailyId;
}

public int getG_intDailyUser(){
	return g_intDailyUser;
}

public void setG_intDailyUser(int dailyUser){
	g_intDailyUser=dailyUser;
}

public Timestamp getG_timDailyBeginTime(){
	return g_timDailyBeginTime;
}

public void setG_timDailyBeginTiem(Timestamp dailyBeginTime){
	g_timDailyBeginTime=dailyBeginTime;
}

public Timestamp getG_timDailyEndTime(){
	return g_timDailyEndTime;
}

public void setG_timDailyEndTime(Timestamp dailyEndTime){
	g_timDailyEndTime=dailyEndTime;
}

public int getG_intDailyCount(){
	return g_intDailyCount;
}

public void setG_intDailyCount(int dailyCount){
	g_intDailyCount=dailyCount;
}

public int getG_intDailyProject(){
	return g_intDailyProject;
}

public void setG_intDailyProject(int dailyProject){
	g_intDailyProject=dailyProject;
}

public int getG_intDailyType(){
	return g_intDailyType;
}

public void setG_intDialyType(int dailyType){
	g_intDailyType=dailyType;
}

public int getG_intDailyTask(){
	return g_intDailyTask;
}

public void setG_intDailyTask(int dailyTask){
	g_intDailyTask=dailyTask;
}

public String getG_strDailyTaskDescription(){
	return g_strDailyTaskDescription;
}

public void setG_strDailyTaskDescription(String dailyTaskDescription){
	g_strDailyTaskDescription=dailyTaskDescription;
}

public String getG_strDailyTaskStatus(){
	return g_strDailyTaskStatus;
}

public void setG_strDailyTaskStatus(String dailyTaskStatus){
	g_strDailyTaskStatus=dailyTaskStatus;
}

public String getG_strDailyProblem(){
	return g_strDailyProblem;
}

public void setG_strDailyProblem(String dailyProblem){
	g_strDailyProblem=dailyProblem;
}

public int getG_intDailyCheckup(){
	return g_intDailyCheckup;
}

public void setG_intDailyCheckup(int dailyCheckup){
	g_intDailyCheckup=dailyCheckup;
}

public int getG_intDailyCheckUser(){
	return g_intDailyCheckUser;
}

public void setG_intDailyCheckUser(int dailyCheckUser){
	g_intDailyCheckUser=dailyCheckUser;
}

public String getG_strDailyRemark(){
	return g_strDailyRemark;
}

public void setG_strDailyRemark(String dailyRemark){
	g_strDailyRemark=dailyRemark;
}

public Timestamp getG_timDailySubmitTime(){
	return g_timDailySubmitTime;
}

public void setG_timeDailySubmitTime(Timestamp dailySubmitTime){
	g_timDailySubmitTime=dailySubmitTime;
}

public String getG_strDailyImage(){
	return g_strDailyImage;
}

public void setG_strDailyImage(String image){
	g_strDailyImage=image;
}
}
