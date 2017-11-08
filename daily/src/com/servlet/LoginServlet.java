package com.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.List;

import com.bean.Memo;
import com.bean.User;
import com.dao.Connect;
import com.dao.Login;
import com.session.MySessionContext;

public class LoginServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 5285600116871825644L;

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		request.setCharacterEncoding("GBK");
		response.setCharacterEncoding("GBK");
		
		String g_strUserName = request.getParameter("username").trim();
		String g_strPassword = request.getParameter("password").trim();
		String g_strRole=request.getParameter("role");
		User user=new User();
		user.setG_strUserName(g_strUserName);
		user.setG_strPassword(g_strPassword);
		
		try {
			Connection con=Connect.getConnection();//打开数据库连接
			Login login=new Login();
			HttpSession session = request.getSession(true);
			session.setMaxInactiveInterval(24*60*60);
			User result = login.login(con, user);//获取登录结果
			if(result==null){//验证用户失败
				request.getRequestDispatcher("page/login_error.jsp").forward(request, response);
			}
			else{//验证用户成功
				
				//以下判断用户是否已登录并做相应处理
				ServletContext context=getServletContext();
				if((context.getAttribute(g_strUserName))!=null){//用户已登录
					String sessionID=context.getAttribute(g_strUserName).toString();
					
					MySessionContext sessionContext=new MySessionContext();
					HttpSession oldSession=sessionContext.getSession(sessionID);
					if(oldSession!=null){
						if(!oldSession.getId().equals(session.getId())){
							oldSession.invalidate();
						}
					}
					context.setAttribute(g_strUserName, session.getId());
				}
				else{//用户未登录，进行注册
					String str_userSessionID=session.getId();
					context.setAttribute(g_strUserName, str_userSessionID);
				}
				List<Memo> memo=login.getMemo(con,result);//获取备忘信息
				session.setAttribute("userInfo", result);
				session.setAttribute("memo", memo);
				con.close();//关闭数据库连接
				request.setAttribute("user", result);
				if(g_strRole.equals("1")){
					request.getRequestDispatcher("page/member/index.jsp").forward(request, response);
				}
				else if(g_strRole.equals("2")){
					request.getRequestDispatcher("page/manager/index.jsp").forward(request, response);
				}
				else if(g_strRole.equals("3")){
					request.getRequestDispatcher("page/head_of_department/index.jsp").forward(request, response);
				}
				else if(g_strRole.equals("4")){
					request.getRequestDispatcher("page/PMO/index.jsp").forward(request, response);
				}
				else if(g_strRole.equals("5")){
					request.getRequestDispatcher("page/administrator/index.jsp").forward(request, response);
				}
				else{
					//role值错误，暂不处理
				}
			}
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request,response);
	}

}
