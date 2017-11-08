package com.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.bean.User;
import com.dao.ChangeUserInfo;
import com.dao.Connect;

public class ChangeEmailServlet extends HttpServlet {

	
	/**
	 * 
	 */
	private static final long serialVersionUID = -2334384762587781849L;


	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("GBK");
		response.setCharacterEncoding("GBK");
		
		String str_flag=request.getParameter("flag");
		ChangeUserInfo change=new ChangeUserInfo();
		Connection con;
		if(str_flag.equals("1")){//添加Email
			PrintWriter out=response.getWriter();
			String str_email=request.getParameter("e");
			HttpSession session=request.getSession(false);
			User user=(User)session.getAttribute("userInfo");
			if(user==null){//获取sessino失败
				out.print(2);
				return;
			}
			int int_userID=user.getG_intUserId();
			int int_result=0;
			try {
				con=Connect.getConnection();
				int_result=change.addEmail(con, str_email, int_userID);
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			if(int_result==1){//修改session中的email值
				user.setG_strEmail(str_email);
				session.removeAttribute("userInfo");
				session.setAttribute("userInfo", user);
			}
			out.print(int_result);
		}
	}

	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doGet(request,response);
	}

}
