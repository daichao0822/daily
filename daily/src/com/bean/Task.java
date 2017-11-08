package com.bean;

public class Task {
private int g_intTaskId;
private String g_strTaskName;
private int g_intTaskType;

public int getG_intTaskId(){
	return g_intTaskId;
}

public void setG_intTaskId(int taskId){
	g_intTaskId=taskId;
}

public String getG_strTaskName(){
	return g_strTaskName;
}

public void setG_strTaskName(String taskName){
	g_strTaskName=taskName;
}

public int getG_intTaskType(){
	return g_intTaskType;
}

public void setG_intTaskType(int taskType){
	g_intTaskType=taskType;
}
}
