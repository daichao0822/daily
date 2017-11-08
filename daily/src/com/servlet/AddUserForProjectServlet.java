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
import com.dao.AddUserForProject;
import com.dao.Connect;
import com.dao.ProjectQuery;

public class AddUserForProjectServlet extends HttpServlet {

	
	/**
	 * 
	 */
	private static final long serialVersionUID = -6990616722982769114L;


	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("GBK");
		response.setCharacterEncoding("GBK");
		
		HttpSession session=request.getSession();
		if(session.getAttribute("userInfo")==null){
			response.sendRedirect("http://localhost/daily/page/manager/session_error.jsp");
			return;
		}
		
		String flag=request.getParameter("flag");
		try {
			Connection con=Connect.getConnection();
			if(flag.equals("1")){
				String str_projectID=request.getParameter("id");
				ProjectQuery proQuery=new ProjectQuery();
				List<User> list=new ArrayList<User>();
				list=proQuery.GetUsersForPro(con);
				request.setAttribute("user", list);
				request.getRequestDispatcher("page/manager/add_user.jsp?id="+str_projectID).forward(request, response);
			}
			else if(flag.equals("2")){
				int int_projectID=Integer.parseInt(request.getParameter("id"));
				String[] user=request.getParameterValues("userid");
				AddUserForProject add=new AddUserForProject();
				int int_result=-1;
				int i=0;
				for(i=0;i<user.length;i++){
					int int_userID=Integer.parseInt(user[i]);
					int_result=add.AddUser(con, int_userID, int_projectID);
					if(int_result==0){//添加用户失败
						request.getRequestDispatcher("page/manager/add_user_fail.jsp").forward(request, response);
						break;
					}
				}
				if(i==user.length){//添加用户成功
					request.getRequestDispatcher("page/manager/add_user_success.jsp").forward(request, response);
				}
			}
			con.close();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doGet(request,response);
	}

}
