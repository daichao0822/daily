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

import com.bean.Task;
import com.dao.Connect;
import com.dao.ProjectQuery;
import com.dao.ProjectSet;

public class AddTaskForProjectServlet extends HttpServlet {

	
	/**
	 * 
	 */
	private static final long serialVersionUID = -3823985149347048028L;


	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("GBK");
		response.setCharacterEncoding("GBK");
		
		HttpSession session=request.getSession();
		if(session.getAttribute("userInfo")==null){
			response.sendRedirect("http://localhost/daily/page/PMO/session_error.jsp");
			return;
		}
		
		String str_flag=request.getParameter("flag");
		if(str_flag.equals("1")){
			int int_projectID=Integer.parseInt(request.getParameter("pid"));
			ProjectQuery query=new ProjectQuery();
			List<Task> list=new ArrayList<Task>();
			try {
				Connection con=Connect.getConnection();
				list=query.GetAllTaskForProject(con, int_projectID);
				con.close();
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			request.setAttribute("task", list);
			request.getRequestDispatcher("page/PMO/add_task_for_project.jsp?pid="+int_projectID).forward(request, response);
		}
		else if(str_flag.equals("2")){
			ProjectSet set=new ProjectSet();
			int int_projectID=Integer.parseInt(request.getParameter("projectID"));
			String[] strs_taskID=request.getParameterValues("taskID");
			int int_taskID=0;
			int int_result=0;
			try {
				Connection con=Connect.getConnection();
				for(int i=0;i<strs_taskID.length;i++){
					int_taskID=Integer.parseInt(strs_taskID[i]);
					int_result=set.AddTaskForProject(con, int_projectID, int_taskID);
					if(int_result==0){
						break;
					}
				}
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			if(int_result==1){
				request.getRequestDispatcher("page/PMO/add_task_for_project_success.jsp").forward(request, response);
			}
			else if(int_result==0){
				request.getRequestDispatcher("page/PMO/add_task_for_project_fail.jsp").forward(request, response);
			}
		}
	}

	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doGet(request,response);
	}

}
