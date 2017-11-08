package com.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.Date;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.bean.User;
import com.dao.Connect;
import com.dao.MemoWrite;

public class SubmitMemoServlet extends HttpServlet {

	
	/**
	 * 
	 */
	private static final long serialVersionUID = -6262952784872858313L;


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
		
		String str_date=request.getParameter("date");
		String str_content=request.getParameter("content");
		Date dat_date=Date.valueOf(str_date);
		MemoWrite memoWrite=new MemoWrite();
		User user=(User)session.getAttribute("userInfo");
		int int_userID=user.getG_intUserId();
		int result=-1;
		try {
			Connection con=Connect.getConnection();
			int int_memoID=memoWrite.getMemoID(con);
			result=memoWrite.WriteMemo(con, int_memoID, int_userID, dat_date, str_content);
			con.close();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		out.print(result);
	}

	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doGet(request,response);
	}

}
