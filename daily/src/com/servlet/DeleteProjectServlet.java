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
import com.dao.ProjectSet;

public class DeleteProjectServlet extends HttpServlet {

	
	/**
	 * 
	 */
	private static final long serialVersionUID = 849163474463811246L;


	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("GBK");
		response.setCharacterEncoding("GBK");
		
		HttpSession session=request.getSession();
		if(session.getAttribute("userInfo")==null){
			response.sendRedirect("http://localhost/daily/page/session_error.jsp");
			return;
		}
		
		String[] strs_projectID=request.getParameterValues("projectID");
		ProjectSet set=new ProjectSet();
		int int_result=-1;
		int int_projectID=-1;
		try {
			Connection con=Connect.getConnection();
			for(int i=0;i<strs_projectID.length;i++){
				int_projectID=Integer.parseInt(strs_projectID[i]);
				int_result=set.DeleteProject(con, int_projectID);
				if(int_result==0){
					request.getRequestDispatcher("page/PMO/delete_project_fail.jsp").forward(request, response);
					break;
				}
			}
			con.close();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		if(int_result==1){
			request.getRequestDispatcher("page/PMO/delete_project_success.jsp").forward(request, response);
		}
	}

	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doGet(request,response);
	}

}
