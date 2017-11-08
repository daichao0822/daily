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
import com.bean.TaskStatistics;
import com.bean.User;
import com.dao.ChangeIDForName;
import com.dao.Connect;
import com.dao.ProjectStatistics;

public class ProjectStaForMemberServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = -1923952969515632890L;

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("GBK");
		response.setCharacterEncoding("GBK");
		
		HttpSession session = request.getSession();
		if(session.getAttribute("userInfo")==null){
			response.sendRedirect("http://localhost/daily/page/session_error.jsp");
			return;
		}
		
			String str_projectID = request.getParameter("id");
			int int_projectID = Integer.parseInt(str_projectID);
			
			User user = (User) session.getAttribute("userInfo");
			int int_userID = user.getG_intUserId();
			ProjectStatistics projectSta = new ProjectStatistics();
			ChangeIDForName name = new ChangeIDForName();
			int int_projectRunTime = -1;// 项目运行总时间
			int int_projectWorkTime = -1;// 项目总工时
			int int_userProjectWorkTime = -1;// 用户项目总工时
			int int_dailyAmount = -1;// 用户在该项目下提交日报总数
			int int_userTaskWorkTime = -1;
			int int_taskWorkTime = -1;
			int int_taskPercent = 0;
			int int_projectPercent = -1;
			int int_taskDailyAmount = -1;
			String str_taskName = null;

			List<TaskStatistics> taskStatistics = new ArrayList<TaskStatistics>();
			List<Task> task = new ArrayList<Task>();
			try {
				Connection con = Connect.getConnection();
				int_projectRunTime = projectSta.GetProjectRunTime(con,
						int_projectID);// 项目运行时间
				int_projectWorkTime = projectSta.GetProjectWorkTime(con,
						int_projectID);// 项目总工时
				int_userProjectWorkTime = projectSta.GetPerUserPjectWorkTime(
						con, int_projectID, int_userID);// 用户在该项目的总工时
				int_dailyAmount = projectSta.GetProjectDailyAmountForUser(con,
						int_userID, int_projectID);// 用户在该项目下提交的日报总数
				task = projectSta.GetProjectTaskForUser(con, int_projectID,
						int_userID);// 获得用户在某项目下的所有项目任务ID

				if (task != null) {// 下面循环获得项目任务的统计信息
					for (int i = 0; i < task.size(); i++) {
						TaskStatistics list = new TaskStatistics();
						int_userTaskWorkTime = projectSta.GetUserTaskWorkTime(
								con, task.get(i).getG_intTaskId(), int_userID,
								int_projectID);// 获得用户在某项目下的某任务总工时
						int_taskWorkTime = projectSta.GetTaskWorkTime(con, task
								.get(i).getG_intTaskId(), int_projectID);// 获得某项目下某任务总工时
						if (int_taskWorkTime != 0) {
							int_taskPercent = (int) ((int_userTaskWorkTime / int_taskWorkTime) * 100);// 获得所占该任务工时百分比
						} else {
							int_taskWorkTime = 0;
						}
						double dou_userTaskWorkTime = int_userTaskWorkTime * 1.0;
						double dou_projectWorkTime = int_projectWorkTime * 1.0;
						int_projectPercent = (int) (dou_userTaskWorkTime
								/ dou_projectWorkTime * 100);// 获得所占项目工时百分比
						int_taskDailyAmount = projectSta
								.GetTaskDailyAmountForUser(con, task.get(i)
										.getG_intTaskId(), int_userID,
										int_projectID);// 用户在该项目下的该任务提交的日报总数
						str_taskName = name.getTaskName(con, task.get(i)
								.getG_intTaskId());// 获得任务名称

						list.setG_int_dailyAmount(int_taskDailyAmount);
						list.setG_int_projectPercent(int_projectPercent);
						list.setG_int_taskPercent(int_taskPercent);
						list.setG_int_taskWorkTime(int_taskWorkTime);
						list.setG_int_userTaskWorkTime(int_userTaskWorkTime);
						list.setG_str_taskName(str_taskName);
						taskStatistics.add(list);
					}
				} else {
					taskStatistics = null;
				}

				con.close();
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			request.setAttribute("taskStatistics", taskStatistics);
			request.getRequestDispatcher(
					"page/member/project_statistics.jsp?prt="
							+ int_projectRunTime + "&pwt="
							+ int_projectWorkTime + "&upwt="
							+ int_userProjectWorkTime + "&da="
							+ int_dailyAmount).forward(request, response);
		} 

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doGet(request, response);
	}

}
