package com.bean;

import java.sql.Timestamp;

public class Project {
private int g_intProjectId;
private String g_strProjectName;
private int g_intProjectManager;
private String g_strProjectNumber;
private Timestamp g_timProjectBeginTime;
private Timestamp g_timProjectEndTime;
private int g_intProjectStatus;

public int getG_intProjectId(){
	return g_intProjectId;
}

public void setG_intProjectId(int projectId){
	g_intProjectId=projectId;
}

public String getG_strProjectName(){
	return g_strProjectName;
}

public void setG_strProjectName(String projectName){
	g_strProjectName=projectName;
}

public int getG_intProjectManager(){
	return g_intProjectManager;
}

public void setG_intProjectManager(int projectManager){
	g_intProjectManager=projectManager;
}

public String getG_strProjectNumber(){
	return g_strProjectNumber;
}

public void setG_strProjectNumber(String projectNumber){
	g_strProjectNumber=projectNumber;
}

public Timestamp getG_timProjectBeginTime(){
	return g_timProjectBeginTime;
}

public void setG_timProjectBeginTime(Timestamp projectBeginTime){
	g_timProjectBeginTime=projectBeginTime;
}

public Timestamp getG_timProjectEndTime(){
	return g_timProjectEndTime;
}

public void setG_timProjectEndTime(Timestamp projectEndTime){
	g_timProjectEndTime=projectEndTime;
}

public int getG_intProjectStatus(){
	return g_intProjectStatus;
}

public void setG_intProjectStatus(int projectStatus){
	g_intProjectStatus=projectStatus;
}

}
