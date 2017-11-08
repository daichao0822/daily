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

import com.bean.Department;
import com.bean.User;
import com.dao.Connect;
import com.dao.DepartmentQuery;

public class DepartmentalInfoServlet extends HttpServlet {

	
	/**
	 * 
	 */
	private static final long serialVersionUID = 4648477562179688644L;


	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("GBK");
		response.setCharacterEncoding("GBK");
		
		HttpSession session=request.getSession();
		if(session.getAttribute("userInfo")==null){
			response.sendRedirect("http://localhost/daily/page/session_error.jsp");
			return;
		}
		User user=(User)session.getAttribute("userInfo");
		int int_departmentID=user.getG_intDepartment();
		DepartmentQuery query=new DepartmentQuery();
		Department department=new Department();
		List<User> userInDep=new ArrayList<User>();
		Connection con;
		try {
			con = Connect.getConnection();
			department=query.GetDepartmentalInfo(con, int_departmentID);
			userInDep=query.GetUserInDepartment(con, int_departmentID);
			con.close();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	
		request.setAttribute("departmentInfo", department);
		request.setAttribute("user", userInDep);
		request.getRequestDispatcher("page/head_of_department/information_of_department.jsp").forward(request, response);
	}
	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doGet(request,response);
	}

}
