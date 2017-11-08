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

import com.bean.PCB;
import com.bean.Project;
import com.bean.Task;
import com.bean.User;
import com.dao.Connect;
import com.dao.ProjectQuery;

public class ProjectDetailForPMOServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = -4099928502480740257L;

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
		int int_projectID=Integer.parseInt(request.getParameter("id"));
		ProjectQuery query=new ProjectQuery();
		List<Project> project=new ArrayList<Project>();
		List<PCB> pcb=new ArrayList<PCB>();
		List<Task> task=new ArrayList<Task>();
		List<User> user=new ArrayList<User>();
		try {
			Connection con=Connect.getConnection();
			project=query.GetProjectDetail(con, int_projectID);
			pcb=query.GetPCBForProject(con, int_projectID);
			task=query.GetProTask(con, int_projectID);
			user=query.GetUsersInPro(con, int_projectID);
			con.close();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		request.setAttribute("project", project);
		request.setAttribute("pcb", pcb);
		request.setAttribute("task", task);
		request.setAttribute("user", user);
		if(str_flag.equals("1")){
			request.getRequestDispatcher("page/PMO/stopped_project_detail.jsp").forward(request, response);
		}
		else if(str_flag.equals("2")){
			request.getRequestDispatcher("page/PMO/suspend_project_detail.jsp").forward(request, response);
		}
		else if(str_flag.equals("3")){
			request.getRequestDispatcher("page/PMO/running_project_detail.jsp").forward(request, response);
		}
	}

	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doGet(request,response);
	}

}
