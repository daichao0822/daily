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
import com.bean.User;
import com.dao.Connect;
import com.dao.DepartmentManage;
import com.dao.DepartmentQuery;
import com.dao.UserManageForAdministrator;

public class DepartmentManageServlet extends HttpServlet {

	
	/**
	 * 
	 */
	private static final long serialVersionUID = 346371207280027948L;


	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("GBK");
		response.setCharacterEncoding("GBK");
		
		HttpSession session=request.getSession();
		
		PrintWriter out=response.getWriter();
		String str_flag=request.getParameter("flag");
		Connection con;
		if(str_flag.equals("1")){//查询所有部门
			
			if(session.getAttribute("userInfo")==null){//session超时或用户已退出
				response.sendRedirect("http://localhost/daily/page/session_error.jsp");
				return;
			}
			
			UserManageForAdministrator dep=new UserManageForAdministrator();
			List<Department> list=new ArrayList<Department>();
			try {
				con=Connect.getConnection();
				list=dep.GetAllDepartment(con);
				con.close();
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			request.setAttribute("dep", list);
			request.getRequestDispatcher("page/administrator/all_department.jsp").forward(request, response);
		}
		else if(str_flag.equals("2")){//删除部门
			
			if(session.getAttribute("userInfo")==null){//session超时或用户已退出
				response.sendRedirect("http://localhost/daily/page/administrator/session_error.jsp");
				return;
			}
			
			String[] strs_departmentID=request.getParameterValues("departmentID");
			int int_result=0;
			int int_departmentID=0;
			DepartmentManage depManage=new DepartmentManage();
			try {
				con=Connect.getConnection();
				for(int i=0;i<strs_departmentID.length;i++){
					int_departmentID=Integer.parseInt(strs_departmentID[i]);
					int_result=depManage.DeleteDepartment(con, int_departmentID);
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
				request.getRequestDispatcher("page/administrator/delete_department_fail.jsp").forward(request, response);
			}
			else if(int_result==1){
				request.getRequestDispatcher("page/administrator/delete_department_success.jsp").forward(request, response);
			}
		}
		else if(str_flag.equals("3")){//查询部门长候选人
			
			if(session.getAttribute("userInfo")==null){//session超时或用户已退出
				response.sendRedirect("http://localhost/daily/page/administrator/session_error.jsp");
				return;
			}
			
			DepartmentManage user=new DepartmentManage();
			List<User> list=new ArrayList<User>();
			try {
				con=Connect.getConnection();
				list=user.GetNewHeadOfDepartment(con);
				con.close();
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			request.setAttribute("user", list);
			request.getRequestDispatcher("page/administrator/add_new_department.jsp").forward(request, response);
		}
		else if(str_flag.equals("4")){//查询部门名称是否存在
			
			
			if(session.getAttribute("userInfo")==null){//session超时或用户已退出
				out.print(2);
				return;
			}
			
			String str_departmentName=request.getParameter("dn");
			DepartmentManage depMng=new DepartmentManage();
			int int_result=0;
			try {
				con=Connect.getConnection();
				int_result=depMng.CheckDepartmentName(con, str_departmentName);
				con.close();
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			out.print(int_result);
		}
		else if(str_flag.equals("5")){//新建部门
			
			if(session.getAttribute("userInfo")==null){//session超时或用户已退出
				response.sendRedirect("http://localhost/daily/page/administrator/session_error.jsp");
				return;
			}
			
			DepartmentManage depMng=new DepartmentManage();
			String str_departmentName=request.getParameter("departmentName");
			String str_departmentDes=request.getParameter("description");
			int int_head=Integer.parseInt(request.getParameter("head"));
			int int_result=0;
			try {
				con=Connect.getConnection();
				int_result=depMng.CreateNewDepartment(con, int_head, str_departmentName, str_departmentDes);
				con.close();
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			if(int_result==0){
				request.getRequestDispatcher("page/administrator/add_new_department_fail.jsp").forward(request, response);
			}
			else if(int_result==1){
				request.getRequestDispatcher("page/administrator/add_new_department_success.jsp").forward(request, response);
			}
		}
		else if(str_flag.equals("6")){//删除部门长
			
			if(session.getAttribute("userInfo")==null){//session超时或用户已退出
				out.print(2);
				return;
			}
			
			int int_departmentID=Integer.parseInt(request.getParameter("did"));
			int int_userID=Integer.parseInt(request.getParameter("uid"));
			DepartmentManage depMng=new DepartmentManage();
			int int_result=0;
			try {
				con=Connect.getConnection();
				int_result=depMng.DeleteHeadOfDepartment(con, int_departmentID, int_userID);
				con.close();
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			out.print(int_result);
		}
		else if(str_flag.equals("7")){//为指定部门长查询候选人员
			
			if(session.getAttribute("userInfo")==null){//session超时或用户已退出
				response.sendRedirect("http://localhost/daily/page/administrator/session_error.jsp");
				return;
			}
			
			int int_departmentID=Integer.parseInt(request.getParameter("id"));
			DepartmentQuery depQuery=new DepartmentQuery();
			DepartmentManage depMng=new DepartmentManage();
			Department department=new Department();
			List<User> user=new ArrayList<User>();
			try {
				con=Connect.getConnection();
				department=depQuery.GetDepartmentalInfo(con, int_departmentID);
				user=depMng.GetNewHeadOfDepartment(con);
				con.close();
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			request.setAttribute("user", user);
			request.setAttribute("dep", department);
			request.getRequestDispatcher("page/administrator/add_department_head.jsp").forward(request, response);
		}
		else if(str_flag.equals("8")){//指定部门长
			
			if(session.getAttribute("userInfo")==null){//session超时或用户已退出
				response.sendRedirect("http://localhost/daily/page/administrator/session_error.jsp");
				return;
			}
			
			int int_departmentID=Integer.parseInt(request.getParameter("departmentID"));
			int int_userID=Integer.parseInt(request.getParameter("head"));
			int int_result=0;
			DepartmentManage depMng=new DepartmentManage();
			try {
				con=Connect.getConnection();
				int_result=depMng.AddHeadOfDepartment(con, int_departmentID, int_userID);
				con.close();
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			if(int_result==0){
				request.getRequestDispatcher("page/administrator/add_department_head_fail.jsp").forward(request, response);
			}
			else if(int_result==1){
				request.getRequestDispatcher("page/administrator/add_department_head_success.jsp").forward(request, response);
			}
		}
		else if(str_flag.equals("9")){//为更改部门长查询候选人员
			
			if(session.getAttribute("userInfo")==null){//session超时或用户已退出
				response.sendRedirect("http://localhost/daily/page/administrator/session_error.jsp");
				return;
			}
			
			int int_departmentID=Integer.parseInt(request.getParameter("did"));
			String str_oldHead=request.getParameter("uid");
			DepartmentQuery depQuery=new DepartmentQuery();
			DepartmentManage depMng=new DepartmentManage();
			Department department=new Department();
			List<User> user=new ArrayList<User>();
			try {
				con=Connect.getConnection();
				department=depQuery.GetDepartmentalInfo(con, int_departmentID);
				user=depMng.GetNewHeadOfDepartment(con);
				con.close();
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			request.setAttribute("dep", department);
			request.setAttribute("user", user);
			request.getRequestDispatcher("page/administrator/change_department_head.jsp?uid="+str_oldHead).forward(request, response);
		}
		else if(str_flag.equals("10")){//更改部门长
			
			if(session.getAttribute("userInfo")==null){//session超时或用户已退出
				response.sendRedirect("http://localhost/daily/page/administrator/session_error.jsp");
				return;
			}
			
			int int_oldHead=Integer.parseInt(request.getParameter("oldHead"));
			int int_newHead=Integer.parseInt(request.getParameter("head"));
			int int_departmentID=Integer.parseInt(request.getParameter("departmentID"));
			int int_result=0;
			DepartmentManage depMng=new DepartmentManage();
			try {
				con=Connect.getConnection();
				int_result=depMng.ChangeHeadOfDepartment(con, int_newHead, int_oldHead, int_departmentID);
				con.close();
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			if(int_result==0){
				request.getRequestDispatcher("page/administrator/change_department_head_fail.jsp").forward(request, response);
			}
			else if(int_result==1){
				request.getRequestDispatcher("page/administrator/change_department_head_success.jsp").forward(request, response);
			}
		}
	}

	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doGet(request,response);
	}

}
