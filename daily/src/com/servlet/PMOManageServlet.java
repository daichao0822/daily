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
import com.dao.Connect;
import com.dao.UserManageForAdministrator;

public class PMOManageServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 2276478685981885537L;


	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("GBK");
		response.setCharacterEncoding("GBK");
		
		HttpSession session=request.getSession();
		
		
		String str_flag=request.getParameter("flag");
		Connection con;
		UserManageForAdministrator userMng=new UserManageForAdministrator();
		if(str_flag.equals("1")){//查询所有PMO
			
			if(session.getAttribute("userInfo")==null){//session超时或用户已退出
				response.sendRedirect("http://localhost/daily/page/session_error.jsp");
				return;
			}
			
			List<User> user=new ArrayList<User>();
			try {
				con=Connect.getConnection();
				user=userMng.GetAllPMO(con);
				con.close();
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			request.setAttribute("user", user);
			request.getRequestDispatcher("page/administrator/all_PMO.jsp").forward(request, response);
		}
		else if(str_flag.equals("2")){
			
			if(session.getAttribute("userInfo")==null){//session超时或用户已退出
				response.sendRedirect("http://localhost/daily/page/session_error.jsp");
				return;
			}
			
			String[] strs_userID=request.getParameterValues("userid");
			int int_userID=0;
			int int_result=0;
			try {
				con=Connect.getConnection();
				for(int i=0;i<strs_userID.length;i++){
					int_userID=Integer.parseInt(strs_userID[i]);
					int_result=userMng.DeletePMO(con, int_userID);
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
				request.getRequestDispatcher("page/administrator/delete_PMO_fail.jsp").forward(request, response);
			}
			else if(int_result==1){
				request.getRequestDispatcher("page/administrator/delete_PMO_success.jsp").forward(request, response);
			}
		}
		else if(str_flag.equals("3")){//为添加新PMO查询候选人员
			
			if(session.getAttribute("userInfo")==null){//session超时或用户已退出
				response.sendRedirect("http://localhost/daily/page/administrator/session_error.jsp");
				return;
			}
			
			List<User> user=new ArrayList<User>();
			try {
				con=Connect.getConnection();
				user=userMng.GetNewPMO(con);
				con.close();
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			request.setAttribute("user", user);
			request.getRequestDispatcher("page/administrator/add_new_PMO.jsp").forward(request, response);
		}
		else if(str_flag.equals("4")){
			
			if(session.getAttribute("userInfo")==null){//session超时或用户已退出
				response.sendRedirect("http://localhost/daily/page/administrator/session_error.jsp");
				return;
			}
			
			String[] strs_userID=request.getParameterValues("userid");
			int int_userID=0;
			int int_result=0;
			try {
				con=Connect.getConnection();
				for(int i=0;i<strs_userID.length;i++){
					int_userID=Integer.parseInt(strs_userID[i]);
					int_result=userMng.AddNewPMO(con, int_userID);
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
				request.getRequestDispatcher("page/administrator/add_new_PMO_fail.jsp").forward(request, response);
			}
			else if(int_result==1){
				request.getRequestDispatcher("page/administrator/add_new_PMO_success.jsp").forward(request, response);
			}
		}
	}

	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doGet(request,response);
	}

}
