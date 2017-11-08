package com.bean;

import java.sql.Timestamp;

public class ProjectTaskAssign {
	private int g_int_project;
	private int g_int_task;
	private Timestamp g_tim_begin_time;
	private Timestamp g_tim_end_time;
	private int g_int_work_time;
	private int g_int_exec_user;
	private String g_str_opinion;
	private int g_int_confirm_user;
	
	
	public void setG_int_project(int int_projectID){
		g_int_project=int_projectID;
	}
	
	public int getG_int_project(){
		return g_int_project;
	}
	
	public void setG_int_task(int int_taskID){
		g_int_task=int_taskID;
	}
	
	public int getG_int_task(){
		return g_int_task;
	}
	
	public void setG_tim_begin_time(Timestamp begin_time){
		g_tim_begin_time=begin_time;
	}
	
	public Timestamp getG_tim_begin_time(){
		return g_tim_begin_time;
	}
	
	public void setG_tim_end_time(Timestamp end_time){
		g_tim_end_time=end_time;
	}
	
	public Timestamp getG_tim_end_time(){
		return g_tim_end_time;
	}
	
	public void setG_int_work_time(int int_work_time){
		g_int_work_time=int_work_time;
	}
	
	public int getG_int_work_time(){
		return g_int_work_time;
	}
	
	public void setG_int_exec_user(int int_userID){
		g_int_exec_user=int_userID;
	}
	
	public int getG_int_exec_user(){
		return g_int_exec_user;
	}
	
	public void setG_str_opinion(String str_opinion){
		g_str_opinion=str_opinion;
	}
	
	public String getG_str_opinion(){
		return g_str_opinion;
	}
	
	public void setG_int_confirm_user(int int_userID){
		g_int_confirm_user=int_userID;
	}
	
	public int getG_int_confirm_user(){
		return g_int_confirm_user;
	}
}
