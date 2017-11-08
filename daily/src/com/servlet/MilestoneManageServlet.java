package com.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.bean.Milestone;
import com.dao.Connect;
import com.dao.MilestoneManage;

public class MilestoneManageServlet extends HttpServlet {

	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1922605312278426712L;


	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("GBK");
		response.setCharacterEncoding("GBK");
		
		HttpSession session=request.getSession();
		
		String str_flag=request.getParameter("flag");
		MilestoneManage msMng=new MilestoneManage();
		Connection con;
		if(str_flag.equals("1")){//查询所有里程碑
			
			if(session.getAttribute("userInfo")==null){//session超时或用户已退出
				response.sendRedirect("http://localhost/daily/page/session_error.jsp");
				return;
			}
			
			List<Milestone> list=new ArrayList<Milestone>();
			try {
				con=Connect.getConnection();
				list=msMng.GetAllMilestone(con);
				con.close();
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			request.setAttribute("milestone", list);
			request.getRequestDispatcher("page/PMO/all_milestone.jsp").forward(request, response);
		}
		else if(str_flag.equals("2")){//删除里程碑
			
			if(session.getAttribute("userInfo")==null){//session超时或用户已退出
				response.sendRedirect("http://localhost/daily/page/session_error.jsp");
				return;
			}
			
			String[] strs_milestoneID=request.getParameterValues("milestoneID");
			int int_result=0;
			int int_milestoneID=0;
			try {
				con=Connect.getConnection();
				for(int i=0;i<strs_milestoneID.length;i++){
					int_milestoneID=Integer.parseInt(strs_milestoneID[i]);
					int_result=msMng.DeleteMilestone(con, int_milestoneID);
					if(int_result==0){
						break;
					}
				}
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			if(int_result==0){
				request.getRequestDispatcher("page/PMO/delete_milestone_fail.jsp").forward(request, response);
			}
			else if(int_result==1){
				request.getRequestDispatcher("page/PMO/delete_milestone_success.jsp").forward(request, response);
			}
		}
		else if(str_flag.equals("3")){//新建里程碑
			PrintWriter out=response.getWriter();
			
			if(session.getAttribute("userInfo")==null){//session超时或用户已退出
				out.print(5);
				return;
			}
			
			String str_milestoneName=request.getParameter("n");
			String str_milestoneDesc=request.getParameter("d");
			try {
				con=Connect.getConnection();
				if(msMng.CheckMilestoneName(con, str_milestoneName)==1){
					out.print(1);
				}
				else if(msMng.AddNewMilestone(con, str_milestoneDesc, str_milestoneName)==0){
					out.print(2);
				}
				else{
					out.print(3);
				}
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doGet(request,response);
	}

}
