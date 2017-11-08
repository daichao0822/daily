package com.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.bean.User;

public class ChangeRoleServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 6238031587727761664L;

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("GBK");
		response.setCharacterEncoding("GBK");

		String g_strRole=request.getParameter("role");
		HttpSession _session=request.getSession();
		if(_session.getAttribute("userInfo")==null){
			response.sendRedirect("http://localhost/daily/page/session_error.jsp");
			return;
		}
		User _user=(User)_session.getAttribute("userInfo");
		String g_strUserName=_user.getG_strUserName();
		String g_strPassword=_user.getG_strPassword();
		_session.removeAttribute("userInfo");//删除session保存的用户信息
		request.getRequestDispatcher("login?username="+g_strUserName+"&password="+g_strPassword+"&role"+g_strRole).forward(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request,response);
	}

}
