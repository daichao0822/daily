package com.bean;

public class Milestone {
private int g_intMileStoneId;
private String g_strMileStoneName;
private String g_strMileStoneDescription;

public int getG_intMileStoneId(){
	return g_intMileStoneId;
}

public void setG_intMileStoneId(int mileStoneId){
	g_intMileStoneId=mileStoneId;
}

public String getG_strMileStoneName(){
	return g_strMileStoneName;
}

public void setG_strMileStoneName(String mileStoneName){
	g_strMileStoneName=mileStoneName;
}

public String getG_strMileStoneDescription(){
	return g_strMileStoneDescription;
}

public void setG_strMileStoneDescription(String mileStoneDescription){
	g_strMileStoneDescription=mileStoneDescription;
}
}
