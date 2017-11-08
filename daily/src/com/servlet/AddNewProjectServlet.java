package com.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Timestamp;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dao.Connect;
import com.dao.ProjectSet;

public class AddNewProjectServlet extends HttpServlet {

	
	/**
	 * 
	 */
	private static final long serialVersionUID = -824700676310458203L;


	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("GBK");
		response.setCharacterEncoding("GBK");
		
		PrintWriter out=response.getWriter();
		HttpSession session=request.getSession();
		if(session.getAttribute("userInfo")==null){
			out.print(5);//session超时或用户已退出登录
			return;
		}
		
		String str_projectNumber=request.getParameter("number");
		String str_projectName=request.getParameter("name");
		String str_beginTime=request.getParameter("time").replaceAll("_", " ");
		String str_description=request.getParameter("des");
		Timestamp tim_project_start_time=Timestamp.valueOf(str_beginTime);
		
		
		ProjectSet set=new ProjectSet();
		try {
			Connection con=Connect.getConnection();
			if(set.CheckProjectName(con, str_projectName)==1){
				out.print(1);//项目名称已经存在
			}
			else{
				if(set.CheckProjectNumber(con, str_projectNumber)==1){
					out.print(2);//项目编号已经存在
			    }
				else{
					if(set.AddNewProject(con, str_projectNumber, str_projectName, str_description, tim_project_start_time)==0){
						out.print(3);//添加项目失败
					}
					else{
						out.print(4);//添加项目成功
					}
				}
			}
			
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
