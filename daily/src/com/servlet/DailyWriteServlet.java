package com.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Timestamp;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.bean.User;
import com.dao.ChangeIDForName;
import com.dao.Connect;
import com.dao.DailyQuery;
import com.dao.DailyWrite;

public class DailyWriteServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = -6468933198319392079L;

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		request.setCharacterEncoding("GBK");
		response.setCharacterEncoding("GBK");
		
		HttpSession session=request.getSession();
		if(session.getAttribute("userInfo")==null){
			response.sendRedirect("http://localhost/daily/page/session_error.jsp");
			return;
		}
		
		String flag=request.getParameter("flag");
		if(flag.equals("1")){//menu.jsp页面调用此servlet，进行日报填写前的数据初始化
			
			User userInfo=new User();
			if(session.getAttribute("userInfo")==null){
				response.sendRedirect("http://localhost/daily/page/session_error.jsp");
				return;
			}
				userInfo=(User)session.getAttribute("userInfo");
				ChangeIDForName changeIDForName=new ChangeIDForName();
				DailyQuery _daily=new DailyQuery();
				int dailyID=0;
				int userID=userInfo.getG_intUserId();
				String userName=null;
				try {
					Connection con=Connect.getConnection();
					dailyID=_daily.getNewDailyID(con);//获取新日报ID
					userName=changeIDForName.getUserName(con, userID);//获取用户名
					con.close();
				} catch (ClassNotFoundException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				request.getRequestDispatcher("page/daily_write.jsp?n="+userName+"&uid="+userID+"&did="+dailyID).forward(request, response);
		}
		else if(flag.equals("2")){//daily_write.jsp调用此servlet，进行日报提交
			
			int int_dailyID=Integer.parseInt(request.getParameter("dailyID"));
			int int_userID=Integer.parseInt(request.getParameter("userID"));
			String str_imageName=request.getParameter("image");
			String time=request.getParameter("submitTime").replaceAll("_", " ");
			Timestamp tim_submitTime=Timestamp.valueOf(time);
			int int_dailyType=Integer.parseInt(request.getParameter("dailyType"));
			String str_projectID=request.getParameter("projectID");
			int int_projectID=-1;
			if(str_projectID!=""){
				int_projectID=Integer.parseInt(str_projectID);
			}
			String taskID=request.getParameter("taskID");
			int int_taskID=Integer.parseInt(taskID);
			String str_taskDescription=request.getParameter("taskDescription");
			Timestamp tim_startTime=Timestamp.valueOf(request.getParameter("startTime"));
			Timestamp tim_endTime=Timestamp.valueOf(request.getParameter("endTime"));
			String str_complete=request.getParameter("complete");
			String str_problem=request.getParameter("problem");
			int int_timeCount=(int)((tim_endTime.getTime()-tim_startTime.getTime())/1000);
			Connection con=null;
			int result=-1;
			try {
				con=Connect.getConnection();
				DailyWrite dailyWrite=new DailyWrite();
				result=dailyWrite.WriteDaily(con, int_dailyID, int_userID, int_projectID, int_taskID, int_dailyType, int_timeCount, str_taskDescription, str_complete, str_problem, tim_submitTime, tim_startTime, tim_endTime ,str_imageName);
				con.close();
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			if(result==0){//填写日报不成功
				request.getRequestDispatcher("page/daily_write_fail.jsp").forward(request, response);
			}
			else if(result==1){//填写日报成功
				request.getRequestDispatcher("page/daily_write_success.jsp?id="+int_dailyID).forward(request, response);
			}
		}
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request,response);
	}

}
