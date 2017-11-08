package com.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.bean.Daily;
import com.bean.User;
import com.dao.Connect;
import com.dao.DailyQuery;

public class DailyListServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = -6708375911267321369L;

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		request.setCharacterEncoding("GBK");
		response.setCharacterEncoding("GBK");
		
		String g_strRole=request.getParameter("role");
		HttpSession session = request.getSession();
		if(session.getAttribute("userInfo")==null){
			response.sendRedirect("http://localhost/daily/page/session_error.jsp");
			return;
		}
		User userInfo=(User)session.getAttribute("userInfo");
		int userID=userInfo.getG_intUserId();
		
		try {
			Connection con=Connect.getConnection();
			DailyQuery list=new DailyQuery();
			List<Daily> dailys=list.AllDaily(con, userID);
			con.clearWarnings();
			request.setAttribute("dailys", dailys);
			if(g_strRole.equals("1")){
				request.getRequestDispatcher("page/member/dailys.jsp").forward(request, response);
			}
			else if(g_strRole.equals("2")){
				request.getRequestDispatcher("").forward(request, response);
			}
			else if(g_strRole.equals("3")){
				request.getRequestDispatcher("").forward(request, response);
			}
			else if(g_strRole.equals("4")){
				request.getRequestDispatcher("").forward(request, response);
			}
			else if(g_strRole.equals("5")){
				request.getRequestDispatcher("").forward(request, response);
			}
			
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}//打开数据库连接
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request,response);
	}

}
