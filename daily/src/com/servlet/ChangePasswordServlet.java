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
import com.dao.ChangePassword;
import com.dao.Connect;

public class ChangePasswordServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 9048868398929425281L;

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("GBK");
		response.setCharacterEncoding("GBK");
		
		HttpSession session=request.getSession();
		if(session.getAttribute("userInfo")==null){
			response.sendRedirect("http://localhost/daily/page/session_error.jsp");
			return;
		}
		
		String password=request.getParameter("password");
		String newPassword=request.getParameter("newPassword");
		PrintWriter out=response.getWriter();
		int result=-1;

		ChangePassword _changePassword=new ChangePassword();
		Connection con;
		User user=new User();
		user=(User)session.getAttribute("userInfo");
		int userId=user.getG_intUserId();
		try {
			con=Connect.getConnection();
			result=_changePassword.changePassword(con, userId, password, newPassword);
			con.close();//关闭数据库连接
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		if(result==1){
			//修改session中保存的用户密码
			user.setG_strPassword(newPassword);
			session.removeAttribute("userInfo");
			session.setAttribute("userInfo", user);
			
			//输出结果返回值
			out.print(result);
		}else if(result==0){
			out.print(result);
		}
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doGet(request,response);
	}

}
