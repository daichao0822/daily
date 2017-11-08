package com.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Timestamp;
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

public class DailyQueryForMemberServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = -5511795988429286752L;

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("GBK");
		response.setCharacterEncoding("GBK");
		
		String strDailyID=request.getParameter("dailyID");
		HttpSession session=request.getSession();
		if(session.getAttribute("userInfo")==null){
			response.sendRedirect("http://localhost/daily/page/session_error.jsp");
			return;
		}
		User user=(User)session.getAttribute("userInfo");
		String g_strFlag=request.getParameter("flag");
		
		if(g_strFlag.equals("1")){//���ձ�ID��ѯ�ձ�
			int userID=user.getG_intUserId();
			int intDailyID=Integer.parseInt(strDailyID);
			try {
				Connection con=Connect.getConnection();
				DailyQuery dailyDetail=new DailyQuery();
				Daily daily=dailyDetail.getDailyForMember(con, intDailyID, userID);//��ȡ�ձ���ѯ���
				List<DailyReply> list=dailyDetail.getDailyReply(con, intDailyID);//��ȡ�ձ��ظ���ѯ���
				con.close();//�ر����ݿ�����
				request.setAttribute("dailyReply", list);
				request.setAttribute("dailyDetail", daily);
				request.getRequestDispatcher("page/member/daily_detail.jsp").forward(request, response);
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		else if(g_strFlag.equals("2")){//��ʱ���ѯ
			String strStartTime=request.getParameter("startTime");
			String strEndTime=request.getParameter("endTime");
			int int_userID=user.getG_intUserId();
			//����ʼʱ��ת����Timestamp����
			Timestamp timStartTime = Timestamp.valueOf(strStartTime);
			//����ֹʱ��ת����Timestamp����
			Timestamp timEndTime=Timestamp.valueOf(strEndTime);
			try {
				Connection con=Connect.getConnection();
				DailyQuery _dailyQuery=new DailyQuery();
				List<Daily> daily=_dailyQuery.getDailyBetweenDate(con, timStartTime, timEndTime ,int_userID);//��ȡ��ѯ���
				//�ر����ݿ�����
				request.setAttribute("dailys", daily);
				request.getRequestDispatcher("page/member/dailys.jsp").forward(request, response);
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		else if(g_strFlag.equals("3")){//����Ŀ��ѯ
			String strProjectName=request.getParameter("projectName");
			int int_userID=user.getG_intUserId();
			try {
				Connection con=Connect.getConnection();
				DailyQuery _projectDaily=new DailyQuery();
				List<Daily> daily=_projectDaily.getProjectDaily(con, strProjectName,int_userID);
				con.close();//�ر����ݿ�����
				request.setAttribute("dailys", daily);
				request.getRequestDispatcher("page/member/dailys.jsp").forward(request, response);
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		else if(g_strFlag.equals("4")){//�������ѯ
			String strTaskName=request.getParameter("taskName");
			int int_userID=user.getG_intUserId();
			try {
				Connection con=Connect.getConnection();
				DailyQuery _taskDaily=new DailyQuery();
				List<Daily> daily=_taskDaily.getTaskDaily(con, strTaskName,int_userID);
				con.close();//�ر����ݿ�
				request.setAttribute("dailys", daily);
				request.getRequestDispatcher("page/member/dailys.jsp").forward(request, response);
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		else if(g_strFlag.equals("5")){//��ѯ���������ձ�
			int userID=user.getG_intUserId();
			try {
				Connection con=Connect.getConnection();
				DailyQuery _allDaily=new DailyQuery();
				List<Daily> daily=_allDaily.AllDaily(con, userID);
				con.close();//�ر����ݿ�
				request.setAttribute("dailys", daily);
				request.getRequestDispatcher("page/member/dailys.jsp").forward(request, response);
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
