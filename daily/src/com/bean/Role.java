package com.bean;

public class Role {
private int g_intRoleId;
private String g_strRoleName;
private String g_strRoleDescription;

public int getG_intRoleId(){
	return g_intRoleId;
}

public void setG_intRoleId(int roleId){
	g_intRoleId=roleId;
}

public String getG_strRoleName(){
	return g_strRoleName;
}

public void setG_strRoleName(String roleName){
	g_strRoleName=roleName;
}

public String getG_strRoleDescription(){
	return g_strRoleDescription;
}

public void setG_strRoleDescription(String roleDescription){
	g_strRoleDescription=roleDescription;
}
}
