package com.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.bean.ProjectTaskAssign;
import com.bean.Task;
import com.dao.Connect;
import com.dao.ProjectQuery;

public class TaskDetailForPMOServlet extends HttpServlet {

	
	/**
	 * 
	 */
	private static final long serialVersionUID = -6917278298956468957L;


	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("GBK");
		response.setCharacterEncoding("GBK");
		
		HttpSession session = request.getSession();
		if(session.getAttribute("userInfo")==null){
			response.sendRedirect("http://localhost/daily/page/PMO/session_error.jsp");
			return;
		}
		
		int int_taskID=Integer.parseInt(request.getParameter("tid"));
		int int_projectID=Integer.parseInt(request.getParameter("pid"));
		ProjectQuery query=new ProjectQuery();
		ProjectTaskAssign assign=new ProjectTaskAssign();
		Task task=new Task();
		try {
			Connection con=Connect.getConnection();
			assign=query.GetProjectTaskAssign(con, int_projectID, int_taskID);
			task=query.GetTaskDetail(con, int_taskID);
			con.close();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		request.setAttribute("assign", assign);
		request.setAttribute("task", task);
		request.getRequestDispatcher("page/PMO/task_detail.jsp?pid="+int_projectID).forward(request, response);
	}

	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doGet(request,response);
	}

}
