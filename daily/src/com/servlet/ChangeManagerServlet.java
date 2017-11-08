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

public class ChangeManagerServlet extends HttpServlet {

	
	/**
	 * 
	 */
	private static final long serialVersionUID = 5964058741508521826L;


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
		ProjectSet set=new ProjectSet();
		
		if(str_flag.equals("1")){
			int int_projectID=Integer.parseInt(request.getParameter("id"));
			int int_oldProjectMng=Integer.parseInt(request.getParameter("o_mng"));
			List<User> user=new ArrayList<User>();
			List<Project> project=new ArrayList<Project>();
			ProjectQuery query=new ProjectQuery();
			try {
				Connection con=Connect.getConnection();
				user=set.GetManagerForProject(con);
				project=query.GetProjectDetail(con, int_projectID);
				con.close();
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			request.setAttribute("user", user);
			request.setAttribute("project", project);
			request.getRequestDispatcher("page/PMO/change_manager.jsp?o_mng="+int_oldProjectMng).forward(request, response);
		}
		else if(str_flag.equals("2")){
			int int_projectID=Integer.parseInt(request.getParameter("projectID"));
			int int_manager=Integer.parseInt(request.getParameter("manager"));
			int int_oldManager=Integer.parseInt(request.getParameter("o_mng"));
			
			User user=(User)session.getAttribute("userInfo");
			int int_userID=user.getG_intUserId();
			int int_result=0;
			try {
				Connection con=Connect.getConnection();
				int_result=set.ChangeManagerForProject(con, int_projectID, int_manager,int_oldManager);
				con.close();
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			if(int_result==0){//更改项目经理失败
				request.getRequestDispatcher("page/PMO/change_manager_fail.jsp").forward(request, response);
			}
			else if(int_result==1){//更改项目经理成功
				if(int_oldManager==int_userID){//PMO将自己的项目经理角色交给别人转到success_1页面进行重新登录
					request.getRequestDispatcher("page/PMO/change_manager_success_1.jsp").forward(request, response);
				}
				else if((int_oldManager!=int_userID)&&(int_userID==int_manager)){//PMO将自己添加为项目经理，转到success_2页面进行重新登录
					request.getRequestDispatcher("page/PMO/change_manager_success_2.jsp").forward(request, response);
				}
				else{//更改的项目经理与现在登录的PMO无关，转到success_3页面
				request.getRequestDispatcher("page/PMO/change_manager_success_3.jsp").forward(request, response);
				}
			}
		}
	}

	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doGet(request,response);
	}

}
