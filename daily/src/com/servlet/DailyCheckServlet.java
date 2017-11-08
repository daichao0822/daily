package com.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.bean.Daily;
import com.bean.DailyReply;
import com.bean.User;
import com.dao.Connect;
import com.dao.DailyCheck;
import com.dao.DailyQuery;

public class DailyCheckServlet extends HttpServlet {

	
	/**
	 * 
	 */
	private static final long serialVersionUID = 3797696893005750987L;


	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("GBK");
		response.setCharacterEncoding("GBK");
		
		String flag=request.getParameter("flag");
		HttpSession session=request.getSession();
		if(session.getAttribute("userInfo")==null){
			response.sendRedirect("http://localhost/daily/page/session_error.jsp");
			return;
		}
		User user=(User)session.getAttribute("userInfo");
		int int_headOfDep=user.getG_intUserId();
		int int_departmentID=user.getG_intDepartment();
		if(flag.equals("1")){//获取本部门未审阅日报
			DailyCheck dailyCheck=new DailyCheck();
			List<Daily> list=new ArrayList<Daily>();
			try {
				Connection con=Connect.getConnection();
				list=dailyCheck.GetAllUncheckDailyForDep(con, int_departmentID);
				con.close();
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			request.setAttribute("dailys", list);
			request.getRequestDispatcher("page/head_of_department/dailys_for_check.jsp").forward(request, response);
		}
		else if(flag.equals("2")){//获取日报相信信息
			 int int_dailyID=Integer.parseInt(request.getParameter("did"));
			 DailyQuery query=new DailyQuery();
			 List<DailyReply> reply=new ArrayList<DailyReply>();
			 Daily daily=new Daily();
			 try {
				Connection con=Connect.getConnection();
				daily=query.DailyDetail(con, int_dailyID);
				reply=query.getDailyReply(con, int_dailyID);
				con.close();
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			request.setAttribute("dailyDetail", daily);
			request.setAttribute("dailyReply", reply);
			request.getRequestDispatcher("page/head_of_department/daily_check.jsp?u="+int_headOfDep).forward(request, response);
		}
		else if(flag.equals("3")){
			int int_checkUserID=Integer.parseInt(request.getParameter("checkUser"));
			int int_dailyID=Integer.parseInt(request.getParameter("dailyID"));
			String str_checkOpinion=request.getParameter("checkOpinion");
			DailyCheck check=new DailyCheck();
			int int_result=-1;
			try {
				Connection con=Connect.getConnection();
				int_result=check.CheckDaily(con, int_checkUserID, str_checkOpinion, int_dailyID);
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			if(int_result==0){
				request.getRequestDispatcher("page/head_of_department/check_daily_fail.jsp").forward(request, response);
			}
			else if(int_result==1){
				request.getRequestDispatcher("page/head_of_department/check_daily_success.jsp").forward(request, response);
			}
			else{
				//插入日报审阅信息异常
			}
		}
	}

	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doGet(request,response);
	}

}
