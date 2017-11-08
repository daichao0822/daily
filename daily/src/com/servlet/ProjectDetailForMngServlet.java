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
import com.bean.ProjectTaskAssign;
import com.bean.Task;
import com.bean.User;
import com.dao.Connect;
import com.dao.ProjectQuery;
import com.dao.ProjectStatistics;

public class ProjectDetailForMngServlet extends HttpServlet {

	
	/**
	 * 
	 */
	private static final long serialVersionUID = 401560238740644464L;


	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		request.setCharacterEncoding("GBK");
		response.setCharacterEncoding("GBK");
		
		HttpSession session=request.getSession();
		if(session.getAttribute("userInfo")==null){
			response.sendRedirect("http://localhost/daily/page/session_error.jsp");
			return;
		}
		
		String g_str_flag=request.getParameter("flag");
			String str_projectID=request.getParameter("id");
			int int_projectID=Integer.parseInt(str_projectID);
			int int_proWorkTime=0;
			int int_proDailyAmount=0;
			ProjectStatistics proSta=new ProjectStatistics();
			ProjectQuery proQuery=new ProjectQuery();
			List<Project> proDetail=new ArrayList<Project>();
			List<User> user=new ArrayList<User>();
			List<Task> task=new ArrayList<Task>();
			List<ProjectTaskAssign> taskAssign=new ArrayList<ProjectTaskAssign>();
			Connection con;
			try {
				con = Connect.getConnection();
				int_proWorkTime=proSta.GetProjectWorkTime(con, int_projectID);
				int_proDailyAmount=proSta.GetDailyAmtOfPro(con, int_projectID);
				proDetail=proQuery.GetProjectDetail(con, int_projectID);
				user=proQuery.GetUsersInPro(con, int_projectID);
				task=proQuery.GetProTask(con, int_projectID);
				if(task!=null){
				for(int i=0;i<task.size();i++){//获取任务统计信息
					ProjectTaskAssign assign=proQuery.GetProjectTaskAssign(con, int_projectID, task.get(i).getG_intTaskId());
					if(assign==null){
						assign=new ProjectTaskAssign();
						assign.setG_int_confirm_user(-1);
						assign.setG_int_exec_user(-1);
						assign.setG_int_project(int_projectID);
						assign.setG_int_task(task.get(i).getG_intTaskId());
						assign.setG_int_work_time(0);
						assign.setG_str_opinion("");
						assign.setG_tim_begin_time(null);
						assign.setG_tim_end_time(null);
					}
					taskAssign.add(assign);
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
			request.setAttribute("user", user);
			request.setAttribute("taskAssign", taskAssign);
			request.setAttribute("proDetail", proDetail);
			
			
			if(g_str_flag.equals("1")){//转向已停止项目界面
				request.getRequestDispatcher("page/manager/stopped_project_detail.jsp?pwt="+int_proWorkTime+"&pda="+int_proDailyAmount).forward(request, response);
			}
			else if(g_str_flag.equals("2")){//转向已暂停项目页面
				request.getRequestDispatcher("page/manager/suspend_project_detail.jsp?pwt="+int_proWorkTime+"&pda="+int_proDailyAmount).forward(request, response);
			}
			else if(g_str_flag.equals("3")){//转向正在运行项目界面
			request.getRequestDispatcher("page/manager/running_project_detail.jsp?id="+str_projectID+"&pwt="+int_proWorkTime+"&pda="+int_proDailyAmount).forward(request, response);
			}
	}

	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doGet(request,response);
	}

}
