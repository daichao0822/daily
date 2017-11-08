package com.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.bean.User;
import com.dao.Connect;
import com.dao.ProjectSet;

public class DeleteManagerServlet extends HttpServlet {

	
	/**
	 * 
	 */
	private static final long serialVersionUID = 7641346159706713941L;


	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("GBK");
		response.setCharacterEncoding("GBK");
		
		
		PrintWriter out = response.getWriter();
		HttpSession session=request.getSession();
		if(session.getAttribute("userInfo")==null){
			out.print(4);//session超时或用户已退出
			return;
		}
		User user=(User)session.getAttribute("userInfo");
		int int_id=user.getG_intUserId();//获得登录用户的用户ID，用于判断是否删除用户自己的项目经理角色
		int int_userID=Integer.parseInt(request.getParameter("uid"));
		int int_projectID=Integer.parseInt(request.getParameter("pid"));
		ProjectSet set=new ProjectSet();
		int int_result=0;
		try {
			Connection con=Connect.getConnection();
			int_result=set.DeleteManager(con, int_projectID, int_userID);
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
		else if((int_result==1)&&(int_id!=int_userID)){
			out.print(1);
		}
		else if((int_result==1)&&(int_id==int_userID)){//用户删除自己的项目经理角色
			out.print(2);
		}
		else {
			out.print(3);
		}
	}

	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doGet(request,response);
	}

}
