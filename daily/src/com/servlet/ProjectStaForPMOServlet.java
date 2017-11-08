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
import com.bean.Task;
import com.bean.TaskStatisticsForMng;
import com.bean.User;
import com.bean.UserStatisticsForMng;
import com.dao.ChangeIDForName;
import com.dao.Connect;
import com.dao.ProjectQuery;
import com.dao.ProjectStatistics;

public class ProjectStaForPMOServlet extends HttpServlet {

	
	/**
	 * 
	 */
	private static final long serialVersionUID = 455254744605642937L;


	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("GBK");
		response.setCharacterEncoding("GBK");
		
		HttpSession session = request.getSession();
		if(session.getAttribute("userInfo")==null){
			response.sendRedirect("http://localhost/daily/page/session_error.jsp");
			return;
		}
		
		String str_flag=request.getParameter("flag");
		Connection con;
		ProjectQuery query=new ProjectQuery();
		if(str_flag.equals("1")){//查询所有项目
			
			List<Project> project=new ArrayList<Project>();
			try {
				con=Connect.getConnection();
				project=query.GetAllProject(con);
				con.close();
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			request.setAttribute("project", project);
			request.getRequestDispatcher("page/PMO/project_statistics.jsp").forward(request, response);
		}
		else if(str_flag.equals("2")){//统计项目信息
			int int_projectID=Integer.parseInt(request.getParameter("id"));
			String str_status=request.getParameter("status");
			ProjectStatistics statistics = new ProjectStatistics();
			ChangeIDForName change = new ChangeIDForName();
			try {
				con=Connect.getConnection();
				String str_projectName = change.getProjectName(con,
						int_projectID);

				// 以下获得该项目详细信息
				int int_projectWorkTime = statistics.GetProjectWorkTime(con,
						int_projectID);
				int int_projectRunTime = statistics.GetProjectRunTime(con,
						int_projectID);
				int int_projectDailyAmount = statistics.GetDailyAmtOfPro(con,
						int_projectID);
				List<Project> stoppedProject = query.GetProjectDetail(con,
						int_projectID);
				// 以下获得该项目所有任务及任务详细统计信息
				List<Task> taskOfProject = query.GetProTask(con, int_projectID);
				List<TaskStatisticsForMng> taskList = new ArrayList<TaskStatisticsForMng>();
				if(taskOfProject!=null){
				for (int i = 0; i < taskOfProject.size(); i++) {
					TaskStatisticsForMng task = new TaskStatisticsForMng();
					
					task.setG_int_taskDailyAmt(statistics
							.GetDailyAmtOfTaskForPro(con, int_projectID,
									taskOfProject.get(i).getG_intTaskId()));
					task.setG_int_taskWorkTime(statistics.GetTaskWorkTime(con,
							taskOfProject.get(i).getG_intTaskId(),
							int_projectID));
					
					task.setG_str_projectName(str_projectName);
					task.setG_str_taskName(change.getTaskName(con, taskOfProject.get(i)
							.getG_intTaskId()));
					taskList.add(task);
				 }
				}
				else{
					taskList=null;
				}
				// 以下获得该项目所有参与人员及人员详细统计信息。
				List<User> userInProject = query.GetUsersInPro(con,
						int_projectID);
				List<UserStatisticsForMng> userStatisticsForMng = new ArrayList<UserStatisticsForMng>();
				int int_userWorkTimeInPro = 0;
				int int_userWorkTimePercentForPro = 0;
				if (userInProject != null) {
					for (int i = 0; i < userInProject.size(); i++) {

						UserStatisticsForMng userStatistics = new UserStatisticsForMng();
						int_userWorkTimeInPro = statistics
								.GetPerUserPjectWorkTime(con, int_projectID,
										userInProject.get(i).getG_intUserId());
						int_userWorkTimePercentForPro = (int) (((double) int_userWorkTimeInPro * 1.0)
								/ ((double) int_projectWorkTime * 1.0) * 100);

						userStatistics
								.setG_int_userWorkTimeInPro(int_userWorkTimeInPro);
						userStatistics.setG_int_dailyAmtInPro(statistics
								.GetProjectDailyAmountForUser(con,
										userInProject.get(i).getG_intUserId(),
										int_projectID));
						userStatistics
								.setG_int_projectPercent(int_userWorkTimePercentForPro);
						userStatistics.setG_int_userID(userInProject.get(i)
								.getG_intUserId());
						userStatistics.setG_str_userName(userInProject.get(i)
								.getG_strUserName());
						userStatisticsForMng.add(userStatistics);
					}
				}
				con.close();
				
				request.setAttribute("task", taskList);
				request.setAttribute("user", userStatisticsForMng);
				request.setAttribute("project", stoppedProject);

				if (str_status.equals("1")) {
                     request.getRequestDispatcher("page/PMO/stopped_project_statistics.jsp?pwt="+ int_projectWorkTime + "&prt="+ int_projectRunTime + "&pda="+ int_projectDailyAmount).forward(request,response);
				} else if (str_status.equals("2")) {
					request.getRequestDispatcher("page/PMO/suspend_project_statistics.jsp?pwt="+ int_projectWorkTime + "&prt="+ int_projectRunTime + "&pda="+ int_projectDailyAmount).forward(request,response);
				} else if (str_status.equals("3")) {
					request.getRequestDispatcher("page/PMO/running_project_statistics.jsp?pwt="+ int_projectWorkTime + "&prt="+ int_projectRunTime + "&pda="+ int_projectDailyAmount).forward(request, response);
							
				}
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
