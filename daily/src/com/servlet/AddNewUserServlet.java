package com.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.bean.Department;
import com.dao.AddNewUser;
import com.dao.Connect;
import com.dao.UserManageForAdministrator;

public class AddNewUserServlet extends HttpServlet {

	
	/**
	 * 
	 */
	private static final long serialVersionUID = -578556365171012917L;


	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("GBK");
		response.setCharacterEncoding("GBK");
		
		HttpSession session=request.getSession();
		
		String str_flag=request.getParameter("flag");
		AddNewUser add=new AddNewUser();
		Connection con;
		PrintWriter out=response.getWriter();
		if(str_flag.equals("1")){//page/head_of_department/add_new_user.jsp页面中ajax调用此servlet
			
			if(session.getAttribute("userInfo")==null){//防止用户在父窗口退出后在新窗口继续添加新用户
				out.print(2);
				return;
			}
			String str_userName=request.getParameter("un");
			int int_result=-1;
			try {
				con=Connect.getConnection();
				int_result=add.CheckUserName(con, str_userName);
				con.close();
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			if(int_result==0){
				out.print(0);
			}
			else if(int_result==1){
				out.print(1);
			}
		}
		else if(str_flag.equals("11")){//page/head_of_department/user_in_department.jsp调用此servlet
			if(session.getAttribute("userInfo")==null){//如果用户已经退出或session超时，则转向如下页面（防止用户退出后点击浏览器返回按钮继续操作）
				response.sendRedirect("http://localhost/daily/page/head_of_department/session_error.jsp");
				return;
			}
		int int_userID=-1;
		String str_departmentID="";
		try {
			con=Connect.getConnection();
			int_userID=add.GetUserID(con);
			con.close();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		str_departmentID=request.getParameter("did");
		request.getRequestDispatcher("page/head_of_department/add_new_user.jsp?uid="+int_userID+"&did="+str_departmentID).forward(request, response);
		}
		else if(str_flag.equals("12")){//page/head_of_department/add_new_user.jsp调用此servlet
			
			if(session.getAttribute("userInfo")==null){//防止用户在父窗口退出后在新窗口继续添加新用户
				response.sendRedirect("http://localhost/daily/page/head_of_department/session_error.jsp");
				return;
			}
			int int_userID=Integer.parseInt(request.getParameter("userID"));
			String str_userName=request.getParameter("userName");
			String str_password=request.getParameter("userPassword");
			String str_sex=request.getParameter("sex");
			int int_departmentID=Integer.parseInt(request.getParameter("departmentID"));
			String str_email=request.getParameter("email");
			int int_result=-1;
			try {
				con=Connect.getConnection();
				int_result=add.AddNewUserForSys(con, int_userID, str_userName, str_password, str_sex, int_departmentID, str_email);
				con.close();
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			if(int_result==0){
				request.getRequestDispatcher("page/head_of_department/add_new_user_fail.jsp").forward(request, response);
			}
			else if(int_result==1){
				request.getRequestDispatcher("page/head_of_department/add_new_user_success.jsp").forward(request, response);
			}
		}
		else if(str_flag.equals("21")){//管理员添加新用户
			
			if(session.getAttribute("userInfo")==null){//防止用户在父窗口退出后在新窗口继续添加新用户
				response.sendRedirect("http://localhost/daily/page/administrator/session_error.jsp");
				return;
			}
			
			UserManageForAdministrator userManage=new UserManageForAdministrator();
			List<Department> list=new ArrayList<Department>();
			int int_userID=-1;
			try {
				con=Connect.getConnection();
				list=userManage.GetAllDepartment(con);
				int_userID=add.GetUserID(con);
				con.close();
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			request.setAttribute("dep", list);
			request.getRequestDispatcher("page/administrator/add_new_user.jsp?id="+int_userID).forward(request, response);
		}
		else if(str_flag.equals("22")){//管理员添加新用户
			
			if(session.getAttribute("userInfo")==null){//防止用户在父窗口退出后在新窗口继续添加新用户
				response.sendRedirect("http://localhost/daily/page/administrator/session_error.jsp");
				return;
			}
			
			int int_userID=Integer.parseInt(request.getParameter("userID"));
			String str_userName=request.getParameter("userName");
			String str_password=request.getParameter("userPassword");
			String str_sex=request.getParameter("sex");
			int int_departmentID=Integer.parseInt(request.getParameter("departmentID"));
			String str_email=request.getParameter("email");
			int int_result=-1;
			try {
				con=Connect.getConnection();
				int_result=add.AddNewUserForSys(con, int_userID, str_userName, str_password, str_sex, int_departmentID, str_email);
				con.close();
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			if(int_result==0){
				request.getRequestDispatcher("page/administrator/add_new_user_fail.jsp").forward(request, response);
			}
			else if(int_result==1){
				request.getRequestDispatcher("page/administrator/add_new_user_success.jsp").forward(request, response);
			}
		}
	}

	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doGet(request,response);
	}

}
