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

import com.bean.Project;
import com.dao.Connect;
import com.dao.ProjectQuery;
import com.dao.ProjectSet;

public class ChangeProjectStatusServlet extends HttpServlet {

	
	/**
	 * 
	 */
	private static final long serialVersionUID = -6184169269671069690L;


	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("GBK");
		response.setCharacterEncoding("GBK");
		
		HttpSession session=request.getSession();
		if(session.getAttribute("userInfo")==null){//session超时或用户已退出
			response.sendRedirect("http://localhost/daily/page/PMO/session_error.jsp");
			return;
		}
		
		String str_flag=request.getParameter("flag");
		Connection con;
		if(str_flag.equals("1")){
			int int_projectID=Integer.parseInt(request.getParameter("id"));
			ProjectQuery query=new ProjectQuery();
			List<Project> project=new ArrayList<Project>();
			try {
				con=Connect.getConnection();
				project=query.GetProjectDetail(con, int_projectID);
				con.close();
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			request.setAttribute("project", project);
			request.getRequestDispatcher("page/PMO/change_project_status.jsp").forward(request, response);
		}
		else if(str_flag.equals("2")){
			int int_projectID=Integer.parseInt(request.getParameter("projectID"));
			int int_status=Integer.parseInt(request.getParameter("status"));
			int int_result=-1;
			ProjectSet set=new ProjectSet();
			try {
				con=Connect.getConnection();
				int_result=set.ChangeProjectStatus(con, int_projectID, int_status);
				con.close();
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			if(int_result==0){
				request.getRequestDispatcher("page/PMO/change_project_status_fail.jsp").forward(request, response);
			}
			else if(int_result==1){
				request.getRequestDispatcher("page/PMO/change_project_status_success.jsp").forward(request, response);
			}
		}
		
	}

	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		doGet(request,response);
	}

}
