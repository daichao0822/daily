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
import com.dao.DeleteUserFromProject;

public class DeleteUserFromProjectServlet extends HttpServlet {

	
	/**
	 * 
	 */
	private static final long serialVersionUID = 8101363061878846389L;


	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("GBK");
		response.setCharacterEncoding("GBK");
		
		HttpSession session=request.getSession();
		if(session.getAttribute("userInfo")==null){
			response.sendRedirect("http://localhost/daily/page/manager/session_error.jsp");
			return;
		}
		
		String str_projectID=request.getParameter("id");
		String[] user=request.getParameterValues("userid");
		DeleteUserFromProject del=new DeleteUserFromProject();
		int i=0;
		int int_projectID=Integer.parseInt(str_projectID);
		int int_result=-1;
		try {
			Connection con=Connect.getConnection();
			for(i=0;i<user.length;i++){
				int int_userID=Integer.parseInt(user[i]);
				int_result=del.DeleteUserFromPro(con, int_userID, int_projectID);
				if(int_result==0){
					request.getRequestDispatcher("page/manager/delete_user_fail.jsp").forward(request, response);
					break;
				}
			}
			if(i==user.length){
				request.getRequestDispatcher("page/manager/delete_user_success.jsp").forward(request, response);
			}
			con.close();
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

		this.doGet(request,response);
	}

}
