package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ChangeIDForName {
	
	//���û�IDת�����û���
	public String getUserName(Connection con,int userID)throws SQLException{
		String strSQL="SELECT user_name FROM t_user WHERE user_id=?";
		PreparedStatement pre=null;
		pre=con.prepareStatement(strSQL);
		pre.setInt(1, userID);
		ResultSet rs=pre.executeQuery();
		String strUserName=null;
		if(rs.next()!=false){
			strUserName=rs.getString("user_name");
		}
		else{
			strUserName="��";
		}
		con.commit();
		rs.close();
		pre.close();
		return strUserName;
	}
	
	//����ĿIDת������Ŀ��
	public String getProjectName(Connection con,int projectID)throws SQLException{
		String strSQL="SELECT project_name FROM t_project WHERE project_id=?";
		PreparedStatement pre=null;
		pre=con.prepareStatement(strSQL);
		pre.setInt(1, projectID);
		ResultSet rs=pre.executeQuery();
		String strProjectName=null;
		if(rs.next()!=false){
			strProjectName=rs.getString("project_name");
		}
		con.commit();
		rs.close();
		pre.close();
		return strProjectName;
	}
	
	//������IDת����������
	public String getTaskName(Connection con,int taskID)throws SQLException{
		String strSQL="SELECT task_name FROM t_task WHERE task_id=?";
		PreparedStatement pre=null;
		pre=con.prepareStatement(strSQL);
		pre.setInt(1, taskID);
		ResultSet rs=pre.executeQuery();
		String strTaskName=null;
		if(rs.next()!=false){
			strTaskName=rs.getString("task_name");
		}
		con.commit();
		rs.close();
		pre.close();
		return strTaskName;
	}
	
	//������IDת���ɲ�������
	public String GetDepartmentName(Connection con,int int_departmentID)throws SQLException{
		String strSQL="SELECT department_name FROM t_department WHERE department_id=?";
		PreparedStatement pre=null;
		pre=con.prepareStatement(strSQL);
		pre.setInt(1, int_departmentID);
		ResultSet rs=pre.executeQuery();
		String str_DepartmentName=null;
		if(rs.next()!=false){
			str_DepartmentName=rs.getString("department_name");
		}
		else{
			str_DepartmentName="��";
		}
		con.commit();
		rs.close();
		pre.close();
		return str_DepartmentName;
	}
	
	//��PCB_IDת����PCB����
	public String GetPCBName(Connection con,int int_PCBID)throws SQLException{
		String str_sql="SELECT pcb_name FROM t_pcb WHERE pcb_id=?";
		PreparedStatement pre=null;
		pre=con.prepareStatement(str_sql);
		pre.setInt(1, int_PCBID);
		ResultSet rs=pre.executeQuery();
		String str_PCBName=null;
		if(rs.next()!=false){
			str_PCBName=rs.getString("pcb_name");
		}
		else{
			str_PCBName="��";
		}
		con.commit();
		rs.close();
		pre.close();
		return str_PCBName;
	}
	
	//����̱�IDת������̱�����
	public String GetMilestoneName(Connection con,int int_milestoneID)throws SQLException{
		String str_sql="SELECT milestone_name FROM t_milestone WHERE milestone_id=?";
		PreparedStatement pre=null;
		pre=con.prepareStatement(str_sql);
		pre.setInt(1, int_milestoneID);
		ResultSet rs=pre.executeQuery();
		String str_milestoneName=null;
		if(rs.next()!=false){
			str_milestoneName=rs.getString("milestone_name");
		}
		else{
			str_milestoneName="��";
		}
		con.commit();
		rs.close();
		pre.close();
		return str_milestoneName;
	}
}
