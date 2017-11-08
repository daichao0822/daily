package com.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Timestamp;
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
import com.dao.DailyQuery;
import com.dao.DepartmentQuery;

public class DailyQueryForDepServlet extends HttpServlet {

	
	/**
	 * 
	 */
	private static final long serialVersionUID = -3084181568199454870L;


	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("GBK");
		response.setCharacterEncoding("GBK");
		
		String str_flag=request.getParameter("flag");
		HttpSession session=request.getSession();
		if(session.getAttribute("userInfo")==null){
			response.sendRedirect("http://localhost/daily/page/session_error.jsp");
			return;
		}
		User headOfDep=(User)session.getAttribute("userInfo");
		int int_departmentID=headOfDep.getG_intDepartment();
		DepartmentQuery dep=new DepartmentQuery();
		Connection con;
		if(str_flag.equals("1")){//进行部门长查询日报前的数据初始化
			
			List<User> userInDep=new ArrayList<User>();
			try {
				con=Connect.getConnection();
				userInDep=dep.GetUserInDepartment(con, int_departmentID);
				con.close();
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			request.setAttribute("user", userInDep);
			request.getRequestDispatcher("page/head_of_department/daily_query.jsp").forward(request, response);
		}
		else if(str_flag.equals("2")){//查询部门所有日报
			List<Daily> list=new ArrayList<Daily>();
			try {
				con=Connect.getConnection();
				list=dep.GetDepartmentalDaily(con, int_departmentID);
				con.close();
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			request.setAttribute("dailys", list);
			request.getRequestDispatcher("page/head_of_department/dailys.jsp").forward(request, response);
		}
		else if(str_flag.equals("3")){//按日期查询部门所有日报
			List<Daily> list=new ArrayList<Daily>();
			String str_startTime=request.getParameter("startTime");
			String str_endTime=request.getParameter("endTime");
			//将开始时间转换成Timestamp类型
			Timestamp tim_startTime = Timestamp.valueOf(str_startTime);
			//将截止时间转换成Timestamp类型
			Timestamp tim_endTime=Timestamp.valueOf(str_endTime);
			try {
				con=Connect.getConnection();
				list=dep.GetDepartmentDailyByTime(con, int_departmentID, tim_startTime, tim_endTime);
				con.close();
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			request.setAttribute("dailys", list);
			request.getRequestDispatcher("page/head_of_department/dailys.jsp").forward(request, response);
		}
		else if(str_flag.equals("4")){//按日期查询个人日报
			List<Daily> list=new ArrayList<Daily>();
			int int_userID=Integer.parseInt(request.getParameter("user1"));
			String str_startTime=request.getParameter("startTime1");
			String str_endTime=request.getParameter("endTime1");
			//将开始时间转换成Timestamp类型
			Timestamp tim_startTime = Timestamp.valueOf(str_startTime);
			//将截止时间转换成Timestamp类型
			Timestamp tim_endTime=Timestamp.valueOf(str_endTime);
			try {
				con=Connect.getConnection();
				list=dep.GetUserDailyByTime(con, int_userID, tim_startTime, tim_endTime);
				con.close();
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			request.setAttribute("dailys", list);
			request.getRequestDispatcher("page/head_of_department/dailys.jsp").forward(request, response);
		}
		else if(str_flag.equals("5")){//查询个人所有日报
			DailyQuery query=new DailyQuery();
			List<Daily> list=new ArrayList<Daily>();
			int int_userID=Integer.parseInt(request.getParameter("user"));
			try {
				con=Connect.getConnection();
				list=query.AllDaily(con, int_userID);
				con.close();
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			request.setAttribute("dailys", list);
			request.getRequestDispatcher("page/head_of_department/dailys.jsp").forward(request, response);
		}
		else if(str_flag.equals("6")){//查询某日报详细信息
			DailyQuery query=new DailyQuery();
			List<DailyReply> reply=new ArrayList<DailyReply>();
			int int_dailyID=Integer.parseInt(request.getParameter("did"));
			Daily daily=new Daily();
			try {
				con=Connect.getConnection();
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
			request.getRequestDispatcher("page/head_of_department/daily_detail.jsp").forward(request, response);
		}
	}

	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doGet(request,response);
	}

}
