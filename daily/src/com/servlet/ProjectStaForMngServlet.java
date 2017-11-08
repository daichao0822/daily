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

public class ProjectStaForMngServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 901541277209703656L;

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("GBK");
		response.setCharacterEncoding("GBK");

		String g_str_flag = request.getParameter("flag");
		HttpSession session = request.getSession();
		if(session.getAttribute("userInfo")==null){
			response.sendRedirect("http://localhost/daily/page/session_error.jsp");
			return;
		}
		User user = (User) session.getAttribute("userInfo");
		int g_int_userID = user.getG_intUserId();
		String g_str_userName = user.getG_strUserName();
		ProjectQuery query = new ProjectQuery();
		ProjectStatistics statistics = new ProjectStatistics();
		ChangeIDForName change = new ChangeIDForName();
		Connection con;
		try {
			con = Connect.getConnection();
			if (g_str_flag.equals("1")) {
				List<Project> list = query.GetProjectOfMng(con, g_int_userID);
				con.close();
				request.setAttribute("list", list);
				request.getRequestDispatcher(
						"page/manager/project_statistics.jsp?n="
								+ g_str_userName).forward(request, response);
			} else if (g_str_flag.equals("2")) {
				String str_status = request.getParameter("s");
				int int_projectID = Integer
						.parseInt(request.getParameter("id"));
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
                     request.getRequestDispatcher("page/manager/stopped_project_statistics.jsp?pwt="+ int_projectWorkTime + "&prt="+ int_projectRunTime + "&pda="+ int_projectDailyAmount).forward(request,response);
				} else if (str_status.equals("2")) {
					request.getRequestDispatcher("page/manager/suspend_project_statistics.jsp?pwt="+ int_projectWorkTime + "&prt="+ int_projectRunTime + "&pda="+ int_projectDailyAmount).forward(request,response);
				} else if (str_status.equals("3")) {
					request.getRequestDispatcher("page/manager/running_project_statistics.jsp?pwt="+ int_projectWorkTime + "&prt="+ int_projectRunTime + "&pda="+ int_projectDailyAmount).forward(request, response);
							
				}
			}
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

		doGet(request, response);
	}

}
