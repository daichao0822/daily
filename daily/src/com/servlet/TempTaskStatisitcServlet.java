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

import com.bean.User;
import com.dao.ChangeIDForName;
import com.dao.Connect;
import com.dao.TempTaskStatisticsDao;
import com.bean.TempTaskStatistics;

public class TempTaskStatisitcServlet extends HttpServlet {

	
	/**
	 * 
	 */
	private static final long serialVersionUID = -3747697117579186533L;


	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("GBK");
		response.setCharacterEncoding("GBK");
		
		HttpSession session = request.getSession();
		if(session.getAttribute("userInfo")==null){
			response.sendRedirect("http://localhost/daily/page/session_error.jsp");
			return;
		}
		User user = (User) session.getAttribute("userInfo");
		int int_userID = user.getG_intUserId();
		TempTaskStatisticsDao tempTask=new TempTaskStatisticsDao();
		List<TempTaskStatistics> list=new ArrayList<TempTaskStatistics>();
		ChangeIDForName name=new ChangeIDForName();
		String str_taskName=null;
		int int_taskWorkTime=0;
		int int_taskDaily=0;
		int[] id=null;
		try {
			Connection con=Connect.getConnection();
			id=tempTask.GetUserTempTaskID(con, int_userID);
			if(id!=null){
				for(int i=0;i<id.length;i++){
					TempTaskStatistics temp=new TempTaskStatistics();
					str_taskName=name.getTaskName(con, id[i]);
					int_taskWorkTime=tempTask.GetTempTaskWorkTime(con, int_userID, id[i]);
					int_taskDaily=tempTask.GetTempTaskDailyAmount(con, int_userID, id[i]);
					temp.setG_int_taskDailyAmount(int_taskDaily);
					temp.setG_int_taskWorkTime(int_taskWorkTime);
					temp.setG_str_taskName(str_taskName);
					list.add(temp);
				}
			}
			else{
				list=null;
			}
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		request.setAttribute("list", list);
		request.getRequestDispatcher("page/member/temp_task_statistics.jsp").forward(request, response);
		
	}

	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

	doGet(request,response);
	}

}
