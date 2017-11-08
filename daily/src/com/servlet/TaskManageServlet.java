package com.servlet;

import java.io.IOException;
import java.io.PrintWriter;
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

public class TaskManageServlet extends HttpServlet {

	
	/**
	 * 
	 */
	private static final long serialVersionUID = -8041146992317665007L;


	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("GBK");
		response.setCharacterEncoding("GBK");
		
		HttpSession session = request.getSession();
		
		String str_flag=request.getParameter("flag");
		Connection con;
		if(str_flag.equals("1")){//获得所有任务
			
			if(session.getAttribute("userInfo")==null){//session超时或用户已退出
				response.sendRedirect("http://localhost/daily/page/session_error.jsp");
				return;
			}
			
			ProjectQuery query=new ProjectQuery();
			List<Task> list=new ArrayList<Task>();
			try {
				con=Connect.getConnection();
				list=query.GetAllTask(con);
				con.close();
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			request.setAttribute("task", list);
			request.getRequestDispatcher("page/PMO/all_task.jsp").forward(request, response);
		}
		else if(str_flag.equals("2")){//删除任务
			
			if(session.getAttribute("userInfo")==null){//session超时或用户已退出
				response.sendRedirect("http://localhost/daily/page/session_error.jsp");
				return;
			}
			
			String[] strs_task=request.getParameterValues("taskID");
			int int_result=0;
			int int_taskID=0;
			ProjectSet set=new ProjectSet();
			try {
				con=Connect.getConnection();
				for(int i=0;i<strs_task.length;i++){
					int_taskID=Integer.parseInt(strs_task[i]);
					int_result=set.DeleteTask(con, int_taskID);
					if(int_result==0){
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
			if(int_result==0){
				request.getRequestDispatcher("page/PMO/delete_task_fail.jsp").forward(request, response);
			}
			else if(int_result==1){
				request.getRequestDispatcher("page/PMO/delete_task_success.jsp").forward(request, response);
			}
		}
		else if(str_flag.equals("3")){//新建任务
			PrintWriter out=response.getWriter();
			if(session.getAttribute("userInfo")==null){//session超时或用户已退出
				out.print(5);
				return;
			}
			String str_taskName=request.getParameter("n");
			int int_taskType=Integer.parseInt(request.getParameter("t"));
			ProjectSet set=new ProjectSet();
			int int_result=0;
			try {
				con=Connect.getConnection();
				int_result=set.CheckTaskName(con, str_taskName);
				if(int_result==1){//任务名称已经存在
					out.print(1);
				}
				else{
					int_result=set.CreateNewTask(con, str_taskName, int_taskType);
					if(int_result==0){//添加任务失败
						out.print(2);
					}
					else if(int_result==1){//添加项目成功
						out.print(3);
					}
					else{//添加项目异常
						out.print(4);
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
		}
	}

	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doGet(request,response);
	}

}
