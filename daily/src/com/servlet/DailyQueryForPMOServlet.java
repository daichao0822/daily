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

public class DailyQueryForPMOServlet extends HttpServlet {

	
	/**
	 * 
	 */
	private static final long serialVersionUID = 453989600281384884L;


	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("GBK");
		response.setCharacterEncoding("GBK");
		
		HttpSession session=request.getSession();
		if(session.getAttribute("userInfo")==null){
			response.sendRedirect("http://localhost/daily/page/session_error.jsp");
			return;
		}
		
		String str_flag=request.getParameter("flag");
		ProjectQuery query=new ProjectQuery();
		Connection con;
		if(str_flag.equals("1")){//�ձ���ѯǰ�����ݳ�ʼ��
			List<Project> project=new ArrayList<Project>();
			List<User> user=new ArrayList<User>();
			try {
				con=Connect.getConnection();
				project=query.GetAllProject(con);
				user=query.GetAllProjectUser(con);
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
			request.getRequestDispatcher("page/PMO/daily_query.jsp").forward(request, response);
		}
		else if(str_flag.equals("2")){//����Ŀ��ѯ
			int int_projectID=Integer.parseInt(request.getParameter("project"));
			DailyQuery dailyQuery=new DailyQuery();
			List<Daily> daily=new ArrayList<Daily>();
			try {
				con=Connect.getConnection();
				daily=dailyQuery.GetAllDailyOfProject(con, int_projectID);
				con.close();
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			request.setAttribute("dailys", daily);
			request.getRequestDispatcher("page/PMO/dailys.jsp").forward(request, response);
		}
        else if(str_flag.equals("3")){//���ύ���ڲ�ѯ
        	String str_startTime=request.getParameter("startTime");
			String str_endTime=request.getParameter("endTime");
			//����ʼʱ��ת����Timestamp����
			Timestamp tim_startTime = Timestamp.valueOf(str_startTime);
			//����ֹʱ��ת����Timestamp����
			Timestamp tim_endTime=Timestamp.valueOf(str_endTime);
			List<Daily> daily=new ArrayList<Daily>();
			DailyQuery dailyQuery=new DailyQuery();
			try {
				con=Connect.getConnection();
				daily=dailyQuery.GetDailyBetweenDateForPMO(con, tim_startTime, tim_endTime);
				con.close();
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			request.setAttribute("dailys", daily);
			request.getRequestDispatcher("page/PMO/dailys.jsp").forward(request, response);
		}
        else if(str_flag.equals("4")){//����Ŀ�����ѯ
        	int int_projectID=Integer.parseInt(request.getParameter("projectID"));
			int int_taskID=Integer.parseInt(request.getParameter("taskID"));
			DailyQuery dailyQuery=new DailyQuery();
			List<Daily> daily=new ArrayList<Daily>();
			try {
				con=Connect.getConnection();
				daily=dailyQuery.GetTaskDailyForMng(con, int_projectID, int_taskID);
				con.close();
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			request.setAttribute("dailys", daily);
			request.getRequestDispatcher("page/PMO/dailys.jsp").forward(request, response);
        }
        else if(str_flag.equals("5")){//����Ա��ѯ
        	int int_userID=Integer.parseInt(request.getParameter("projectUser"));
			DailyQuery dailyQuery=new DailyQuery();
			List<Daily> daily=new ArrayList<Daily>();
			try {
				con=Connect.getConnection();
				daily=dailyQuery.GetUserProjectDaily(con, int_userID);
				con.close();
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			request.setAttribute("dailys", daily);
			request.getRequestDispatcher("page/PMO/dailys.jsp").forward(request, response);
        }
        else if(str_flag.equals("6")){//��ѯĳ�ձ���ϸ��Ϣ
        	int int_dailyID=Integer.parseInt(request.getParameter("did"));
			Daily daily=new Daily();
			DailyQuery dailyQuery=new DailyQuery();
			List<DailyReply> reply=new ArrayList<DailyReply>();
			try {
				con=Connect.getConnection();
				daily=dailyQuery.DailyDetail(con, int_dailyID);
				reply=dailyQuery.getDailyReply(con, int_dailyID);
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
			request.getRequestDispatcher("page/PMO/daily_detail.jsp").forward(request, response);
        }
	}

	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doGet(request,response);
	}

}
