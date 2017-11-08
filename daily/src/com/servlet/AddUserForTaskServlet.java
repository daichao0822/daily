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

import com.bean.User;
import com.dao.AddUserForTask;
import com.dao.Connect;
import com.dao.ProjectQuery;

public class AddUserForTaskServlet extends HttpServlet {

	
	/**
	 * 
	 */
	private static final long serialVersionUID = -1425439010835688410L;


	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("GBK");
		response.setCharacterEncoding("GBK");
		
		HttpSession session=request.getSession();
		if(session.getAttribute("userInfo")==null){
			response.sendRedirect("http://localhost/daily/page/manager/session_error.jsp");
			return;
		}
		
		String str_flag=request.getParameter("flag");
		if(str_flag.equals("1")){
			int int_taskID=Integer.parseInt(request.getParameter("tid"));
			int int_projectID=Integer.parseInt(request.getParameter("pid"));
			ProjectQuery query=new ProjectQuery();
			List<User> user=new ArrayList<User>();
			try {
				Connection con=Connect.getConnection();
				user=query.GetUserForTask(con, int_projectID);
				con.close();
				request.setAttribute("user", user);
				request.getRequestDispatcher("page/manager/add_user_for_task.jsp?tid="+int_taskID+"&pid="+int_projectID).forward(request, response);
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		else if(str_flag.equals("2")){
			int int_taskID=Integer.parseInt(request.getParameter("tid"));
			int int_projectID=Integer.parseInt(request.getParameter("pid"));
			int int_execUser=Integer.parseInt(request.getParameter("selectUser"));
			int int_confirmUser=Integer.parseInt(request.getParameter("confirmUser"));
			String str_opinion=request.getParameter("opinion");
			String strStartTime=request.getParameter("startTime");
			String strEndTime=request.getParameter("endTime");
			//将开始时间转换成Timestamp类型
			Timestamp tim_startTime = Timestamp.valueOf(strStartTime);
			//将截止时间转换成Timestamp类型
			Timestamp tim_endTime=Timestamp.valueOf(strEndTime);
			int int_timeCount=(int)((tim_endTime.getTime()-tim_startTime.getTime())/1000);//工期
			int int_result=-1;
			AddUserForTask add=new AddUserForTask();
			try {
				Connection con=Connect.getConnection();
				int int_ID=add.GetTaskAssignID(con);
				int_result=add.AddUser(con, int_ID, int_projectID, int_taskID, tim_startTime, tim_endTime, int_timeCount, int_execUser, str_opinion, int_confirmUser);
				if(int_result==1){
					request.getRequestDispatcher("page/manager/add_user_for_task_success.jsp").forward(request, response);
				}
				else{
					request.getRequestDispatcher("page/manager/add_user_for_task_fail.jsp").forward(request, response);
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
