package com.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dao.Connect;
import com.dao.DeleteUserFromTask;

public class DeleteUserFromTaskServlet extends HttpServlet {

	
	/**
	 * 
	 */
	private static final long serialVersionUID = -5991661144583153371L;


	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("GBK");
		response.setCharacterEncoding("GBK");
		
		HttpSession session=request.getSession();
		if(session.getAttribute("userInfo")==null){
			response.sendRedirect("http://localhost/daily/page/manager/session_error.jsp");
			return;
		}
		
			int int_projectID=Integer.parseInt(request.getParameter("pid"));
			int int_taskID=Integer.parseInt(request.getParameter("tid"));
			int int_userID=Integer.parseInt(request.getParameter("u"));
			DeleteUserFromTask delete=new DeleteUserFromTask();
			try {
				Connection con=Connect.getConnection();
				int int_result=delete.DeleteUser(con, int_projectID, int_taskID, int_userID);
				if(int_result!=0){
					request.getRequestDispatcher("page/manager/delete_user_from_task_success.jsp").forward(request, response);
				}
				else{
					request.getRequestDispatcher("page/manager/delete_user_from_task_fail.jsp").forward(request, response);
				}
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
	

	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doGet(request,response);
	}

}
