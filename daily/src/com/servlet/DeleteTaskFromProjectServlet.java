package com.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dao.Connect;
import com.dao.ProjectSet;

public class DeleteTaskFromProjectServlet extends HttpServlet {

	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1725504367631762878L;


	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		request.setCharacterEncoding("GBK");
		response.setCharacterEncoding("GBK");
		
		PrintWriter out = response.getWriter();
		HttpSession session=request.getSession();
		if(session.getAttribute("userInfo")==null){
			out.print(2);//session超时或用户已退出
			return;
		}
		int int_taskID=Integer.parseInt(request.getParameter("tid"));
		int int_projectID=Integer.parseInt(request.getParameter("pid"));
		int int_result=0;
		ProjectSet set=new ProjectSet();
		try {
			Connection con=Connect.getConnection();
			int_result=set.DeleteTaskFromProject(con, int_taskID, int_projectID);
			con.close();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		out.print(int_result);
	}

	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doGet(request,response);
	}

}
