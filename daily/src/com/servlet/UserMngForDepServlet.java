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
import com.dao.ChangeIDForName;
import com.dao.Connect;
import com.dao.DeleteUserFromSystem;
import com.dao.DepartmentQuery;

public class UserMngForDepServlet extends HttpServlet {

	
	/**
	 * 
	 */
	private static final long serialVersionUID = 255157387938127182L;


	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("GBK");
		response.setCharacterEncoding("GBK");
		
		String str_flag=request.getParameter("flag");
		HttpSession session=request.getSession();
		if(session.getAttribute("userInfo")==null){
			response.sendRedirect("http://localhost/daily/page/session_error.jsp");
			return;
		}
		User user=(User)session.getAttribute("userInfo");
		int int_departmentID=user.getG_intDepartment();
		String str_departmentName="";
		ChangeIDForName change=new ChangeIDForName();
		Connection con;
		if(str_flag.equals("1")){
			DepartmentQuery query=new DepartmentQuery();
			List<User> userInDep=new ArrayList<User>();
			try {
				con=Connect.getConnection();
				userInDep=query.GetUserInDepartment(con, int_departmentID);
				str_departmentName=change.GetDepartmentName(con, int_departmentID);
				con.close();
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			request.setAttribute("user", userInDep);
			request.getRequestDispatcher("page/head_of_department/user_in_department.jsp?did="+int_departmentID+"&dn="+str_departmentName).forward(request, response);
		}
		else if(str_flag.equals("2")){
			String[] strs_userID=request.getParameterValues("userid");
			DeleteUserFromSystem delete=new DeleteUserFromSystem();
			int int_userID=-1;
			int int_result=-1;
			if(strs_userID!=null){
				try {
					con=Connect.getConnection();
					for(int i=0;i<strs_userID.length;i++){
					int_userID=Integer.parseInt(strs_userID[i]);
					int_result=delete.DeleteUser(con, int_userID);
					if(int_result==0){
						break;
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
				if(int_result==0){
					request.getRequestDispatcher("page/head_of_department/delete_user_fail.jsp").forward(request, response);
				}
				else if(int_result==1){
					request.getRequestDispatcher("page/head_of_department/delete_user_success.jsp").forward(request, response);
				}
			}
		}
	}

	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doGet(request,response);
	}

}
