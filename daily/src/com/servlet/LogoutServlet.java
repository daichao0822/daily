package com.servlet;

import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.bean.User;

public class LogoutServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 7901852643072766923L;

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session=request.getSession(false);
		if(session==null){
			response.sendRedirect("http://localhost/daily");//转向登陆页面
			return;
		}
		else if(session.getAttribute("userInfo")==null){
			response.sendRedirect("http://localhost/daily");//转向登陆页面
			return;
		}
		else{
			String str_userName=((User)session.getAttribute("userInfo")).getG_strUserName();
			ServletContext context=getServletContext();
			context.removeAttribute(str_userName);
			session.invalidate();//销毁session
			response.sendRedirect("http://localhost/daily");//转向登陆页面
		}
		
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request,response);
	}

}
