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

import com.bean.Project;
import com.bean.User;
import com.dao.Connect;
import com.dao.ProjectQuery;
import com.dao.ProjectSet;

public class AddManagerServlet extends HttpServlet {

	
	/**
	 * 
	 */
	private static final long serialVersionUID = -2595298464311393957L;


	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("GBK");
		response.setCharacterEncoding("GBK");
		
		HttpSession session=request.getSession();
		if(session.getAttribute("userInfo")==null){
			response.sendRedirect("http://localhost/daily/page/PMO/session_error.jsp");
			return;
		}
		
		String str_flag=request.getParameter("flag");
		if(str_flag.equals("1")){
			ProjectQuery query=new ProjectQuery();
			ProjectSet set=new ProjectSet();
			int int_projectID=Integer.parseInt(request.getParameter("id"));
			List<Project> project=new ArrayList<Project>();
			List<User> user=new ArrayList<User>();
			try {
				Connection con=Connect.getConnection();
				project=query.GetProjectDetail(con, int_projectID);
				user=set.GetManagerForProject(con);
				con.close();
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			request.setAttribute("project", project);
			request.setAttribute("user", user);
			request.getRequestDispatcher("page/PMO/add_manager.jsp").forward(request, response);
		}
		else if(str_flag.equals("2")){
			int int_projectID=Integer.parseInt(request.getParameter("projectID"));
			int int_manager=Integer.parseInt(request.getParameter("manager"));
			ProjectSet set=new ProjectSet();
			
			User user=(User)session.getAttribute("userInfo");
			int int_userID=user.getG_intUserId();
			int int_result=0;
			try {
				Connection con=Connect.getConnection();
				int_result=set.SetManagerForProject(con, int_projectID, int_manager);
				con.close();
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			if(int_result==0){
				request.getRequestDispatcher("page/PMO/add_manager_fail.jsp").forward(request, response);
			}
			else if(int_result==1){
				if(int_manager==int_userID){//PMO为自己添加项目经理角色，转入add_manager_success_1.jsp页面进行重新登录
				request.getRequestDispatcher("page/PMO/add_manager_success_1.jsp").forward(request, response);
				}
				else{//添加项目经理与现在登录的PMO无关，转入add_manager_success_2.jsp页面
					request.getRequestDispatcher("page/PMO/add_manager_success_2.jsp").forward(request, response);
				}
			}
		}
	}

	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doGet(request,response);
	}

}
