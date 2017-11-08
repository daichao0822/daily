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
			int int_projectRunTime = -1;// ��Ŀ������ʱ��
			int int_projectWorkTime = -1;// ��Ŀ�ܹ�ʱ
			int int_userProjectWorkTime = -1;// �û���Ŀ�ܹ�ʱ
			int int_dailyAmount = -1;// �û��ڸ���Ŀ���ύ�ձ�����
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
						int_projectID);// ��Ŀ����ʱ��
				int_projectWorkTime = projectSta.GetProjectWorkTime(con,
						int_projectID);// ��Ŀ�ܹ�ʱ
				int_userProjectWorkTime = projectSta.GetPerUserPjectWorkTime(
						con, int_projectID, int_userID);// �û��ڸ���Ŀ���ܹ�ʱ
				int_dailyAmount = projectSta.GetProjectDailyAmountForUser(con,
						int_userID, int_projectID);// �û��ڸ���Ŀ���ύ���ձ�����
				task = projectSta.GetProjectTaskForUser(con, int_projectID,
						int_userID);// ����û���ĳ��Ŀ�µ�������Ŀ����ID

				if (task != null) {// ����ѭ�������Ŀ�����ͳ����Ϣ
					for (int i = 0; i < task.size(); i++) {
						TaskStatistics list = new TaskStatistics();
						int_userTaskWorkTime = projectSta.GetUserTaskWorkTime(
								con, task.get(i).getG_intTaskId(), int_userID,
								int_projectID);// ����û���ĳ��Ŀ�µ�ĳ�����ܹ�ʱ
						int_taskWorkTime = projectSta.GetTaskWorkTime(con, task
								.get(i).getG_intTaskId(), int_projectID);// ���ĳ��Ŀ��ĳ�����ܹ�ʱ
						if (int_taskWorkTime != 0) {
							int_taskPercent = (int) ((int_userTaskWorkTime / int_taskWorkTime) * 100);// �����ռ������ʱ�ٷֱ�
						} else {
							int_taskWorkTime = 0;
						}
						double dou_userTaskWorkTime = int_userTaskWorkTime * 1.0;
						double dou_projectWorkTime = int_projectWorkTime * 1.0;
						int_projectPercent = (int) (dou_userTaskWorkTime
								/ dou_projectWorkTime * 100);// �����ռ��Ŀ��ʱ�ٷֱ�
						int_taskDailyAmount = projectSta
								.GetTaskDailyAmountForUser(con, task.get(i)
										.getG_intTaskId(), int_userID,
										int_projectID);// �û��ڸ���Ŀ�µĸ������ύ���ձ�����
						str_taskName = name.getTaskName(con, task.get(i)
								.getG_intTaskId());// �����������

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
