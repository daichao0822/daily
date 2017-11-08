package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.bean.Milestone;

public class MilestoneManage {
	//查询所有里程碑
	public List<Milestone> GetAllMilestone(Connection con)throws SQLException{
		String str_sql="SELECT * FROM t_milestone";
		PreparedStatement pre=null;
		pre=con.prepareStatement(str_sql);
		ResultSet rs=pre.executeQuery();
		List<Milestone> list=new ArrayList<Milestone>();
		if(rs.next()!=false){
			do{
				Milestone ms=new Milestone();
				ms.setG_intMileStoneId(rs.getInt("milestone_id"));
				ms.setG_strMileStoneDescription(rs.getString("milestone_description"));
				ms.setG_strMileStoneName(rs.getString("milestone_name"));
				list.add(ms);
			}while(rs.next());
		}
		else{
			list=null;
		}
		con.commit();
		rs.close();
		pre.close();
		return list;
	}
	
	//添加新里程碑
	public int AddNewMilestone(Connection con,String str_milestoneDesc,String str_milestoneName)throws SQLException{
		String str_sql="INSERT INTO t_milestone(milestone_name,milestone_description) VALUES(?,?)";
		PreparedStatement pre=null;
		pre=con.prepareStatement(str_sql);
		pre.setString(1, str_milestoneName);
		pre.setString(2, str_milestoneDesc);
		int int_result=pre.executeUpdate();
		con.commit();
		pre.close();
		return int_result;
	}
	
	//删除里程碑
	public int DeleteMilestone(Connection con,int int_milestoneID)throws SQLException{
		String str_sql="DELETE FROM t_milestone WHERE milestone_id=?";
		PreparedStatement pre=null;
		pre=con.prepareStatement(str_sql);
		pre.setInt(1, int_milestoneID);
		int int_result=pre.executeUpdate();
		con.commit();
		pre.close();
		return int_result;
	}
	
	//查询里程碑名称是否存在
	public int CheckMilestoneName(Connection con,String str_milestoneName)throws SQLException{
		String str_sql="SELECT milestone_id FROM t_milestone WHERE milestone_name=?";
		PreparedStatement pre=null;
		pre=con.prepareStatement(str_sql);
		pre.setString(1, str_milestoneName);
		ResultSet rs=pre.executeQuery();
		int int_result=0;
		if(rs.next()!=false){
			int_result=1;
		}
		con.commit();
		pre.close();
		return int_result;
	}
}
