package com.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Timestamp;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dao.Connect;
import com.dao.DailyReply;

public class DailyReplyServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 8040953423492249708L;

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("GBK");
		response.setCharacterEncoding("GBK");
		
		PrintWriter out=response.getWriter();
		
		HttpSession session=request.getSession();
		if(session.getAttribute("userInfo")==null){
			out.print(2);
			return;
		}
		
		int int_result=-1;
		int int_replyID=-1;
		int int_dailyID=Integer.parseInt(request.getParameter("dailyID"));
		int int_userID=Integer.parseInt(request.getParameter("userID"));
		String str_image=request.getParameter("image");
		String str_reply=request.getParameter("reply");
		String str_time=request.getParameter("time").replaceAll("_", " ");
		
		Timestamp tim_time=Timestamp.valueOf(str_time);
		
		DailyReply dailyReply=new DailyReply();
		try {
			Connection con=Connect.getConnection();
			int_replyID=dailyReply.getDailyReplyID(con);
			int_result=dailyReply.ReplyDaily(con, int_replyID, int_dailyID, int_userID, tim_time, str_reply ,str_image);
			con.close();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		out.print(int_result);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request,response);
	}
}
