package com.bean;

import java.sql.Timestamp;

public class PCB {
private int g_intPCBId;
private String g_strPCBName;
private int g_intPCBProject;
private int g_intPCBAmount;
private int g_intPCBDeliver;
private int g_intPCBSample;
private int g_intPCBProduceStyle;
private String g_strPCBConfirmOpinion;
private int g_intPCBConfirmUser;
private Timestamp g_timPCBConfirmTime;

public int getG_intPCBId(){
	return g_intPCBId;
}

public void setG_intPCBId(int PCBId){
	g_intPCBId=PCBId;
}

public String getG_strPCBName(){
	return g_strPCBName;
}

public void setG_strPCBName(String PCBName){
	g_strPCBName=PCBName;
}

public int getG_intPCBProject(){
	return g_intPCBProject;
}

public void setG_intPCBProject(int PCBProject){
	g_intPCBProject=PCBProject;
}

public int getG_intPCBAmount(){
	return g_intPCBAmount;
}

public void setG_intPCBAmount(int PCBAmount){
	g_intPCBAmount=PCBAmount;
}

public int getG_intPCBDeliver(){
	return g_intPCBDeliver;
}

public void setG_intPCBDeliver(int PCBDeliver){
	g_intPCBDeliver=PCBDeliver;
}

public int getG_intPCBSample(){
	return g_intPCBSample;
}

public void setG_intPCBSample(int PCBSample){
	g_intPCBSample=PCBSample;
}

public int getG_intPCBProduceStyle(){
	return g_intPCBProduceStyle;
}

public void setG_intPCBProduceStyle(int PCBProduceStyle){
	g_intPCBProduceStyle=PCBProduceStyle;
}

public String getG_strPCBConfirmOpinion(){
	return g_strPCBConfirmOpinion;
}

public void setG_strPCBConfirmOpinion(String PCBConfirmOpinion){
	g_strPCBConfirmOpinion=PCBConfirmOpinion;
}

public int getG_intPCBConfirmUser(){
	return g_intPCBConfirmUser;
}

public void setG_intPCBConfirmUser(int PCBConfirmUser){
	g_intPCBConfirmUser=PCBConfirmUser;
}

public Timestamp getG_timPCBConfirmTime(){
	return g_timPCBConfirmTime;
}

public void setG_timPCBConfirmTime(Timestamp PCBConfirmTime){
	g_timPCBConfirmTime=PCBConfirmTime;
}
}
