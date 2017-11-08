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
import com.bean.Project;
import com.bean.User;
import com.dao.Connect;
import com.dao.DailyQuery;
import com.dao.ProjectQuery;

public class DailyQueryForMngServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = -6073210757736317004L;

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("GBK");
		response.setCharacterEncoding("GBK");

		String str_flag = request.getParameter("flag");
		HttpSession session = request.getSession();
		if(session.getAttribute("userInfo")==null){
			response.sendRedirect("http://localhost/daily/page/session_error.jsp");
			return;
		}
		User manager = (User) session.getAttribute("userInfo");
		int int_managerID = manager.getG_intUserId();
		if (str_flag.equals("1")) {//page/manager/menu.jsp页面调用此servlet
			ProjectQuery query = new ProjectQuery();
			List<Project> project = new ArrayList<Project>();
			List<User> user = new ArrayList<User>();
			try {
				Connection con = Connect.getConnection();
				project = query.GetProjectOfMng(con, int_managerID);
				user = query.GetUserUnderManager(con, int_managerID);
				con.close();
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			request.setAttribute("project", project);
			request.setAttribute("user", user);
			request.getRequestDispatcher(
					"page/manager/daily_query.jsp?u=" + int_managerID).forward(
					request, response);
		} else if (str_flag.equals("2")) {//daily_query.jsp页面调用此servlet,按项目查询日报
			int int_projectID=Integer.parseInt(request.getParameter("project"));
			DailyQuery query=new DailyQuery();
			List<Daily> daily=new ArrayList<Daily>();
			try {
				Connection con=Connect.getConnection();
				daily=query.GetAllDailyOfProject(con, int_projectID);
				con.close();
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			request.setAttribute("dailys", daily);
			request.getRequestDispatcher("page/manager/dailys.jsp").forward(request, response);

		} else if (str_flag.equals("3")) {//daily_query.jsp页面调用此servlet,按提交日期查询
			String str_startTime=request.getParameter("startTime");
			String str_endTime=request.getParameter("endTime");
			//将开始时间转换成Timestamp类型
			Timestamp tim_startTime = Timestamp.valueOf(str_startTime);
			//将截止时间转换成Timestamp类型
			Timestamp tim_endTime=Timestamp.valueOf(str_endTime);
			List<Daily> daily=new ArrayList<Daily>();
			DailyQuery query=new DailyQuery();
			try {
				Connection con=Connect.getConnection();
				daily=query.GetDailyBetweenDateForMng(con, tim_startTime, tim_endTime, int_managerID);
				con.close();
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			request.setAttribute("dailys", daily);
			request.getRequestDispatcher("page/manager/dailys.jsp").forward(request, response);

		} else if (str_flag.equals("4")) {//manager目录下的daily_query.jspd调用此servlet，按项目任务查询日报
			int int_projectID=Integer.parseInt(request.getParameter("projectID"));
			int int_taskID=Integer.parseInt(request.getParameter("taskID"));
			DailyQuery query=new DailyQuery();
			List<Daily> daily=new ArrayList<Daily>();
			try {
				Connection con=Connect.getConnection();
				daily=query.GetTaskDailyForMng(con, int_projectID, int_taskID);
				con.close();
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			request.setAttribute("dailys", daily);
			request.getRequestDispatcher("page/manager/dailys.jsp").forward(request, response);

		} else if (str_flag.equals("5")) {//manager目录下的daily_query.jsp调用此servlet，按项目人员查询日报
			int int_userID=Integer.parseInt(request.getParameter("projectUser"));
			DailyQuery query=new DailyQuery();
			List<Daily> daily=new ArrayList<Daily>();
			try {
				Connection con=Connect.getConnection();
				daily=query.GetUserDailyForMng(con, int_userID, int_managerID);
				con.close();
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			request.setAttribute("dailys", daily);
			request.getRequestDispatcher("page/manager/dailys.jsp").forward(request, response);

		} else if (str_flag.equals("6")) {//查询某日报详细信息
			int int_dailyID=Integer.parseInt(request.getParameter("did"));
			Daily daily=new Daily();
			DailyQuery query=new DailyQuery();
			List<DailyReply> reply=new ArrayList<DailyReply>();
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
			request.getRequestDispatcher("page/manager/daily_detail.jsp").forward(request, response);
		}
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doGet(request, response);
	}

}
