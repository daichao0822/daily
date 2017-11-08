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

import com.dao.Connect;
import com.dao.ProjectSet;

public class DeletePCBServlet extends HttpServlet {

	
	/**
	 * 
	 */
	private static final long serialVersionUID = -1753980150435344352L;


	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("GBK");
		response.setCharacterEncoding("GBK");
		
		PrintWriter out = response.getWriter();
		HttpSession session=request.getSession();
		if(session.getAttribute("userInfo")==null){
			out.print(2);//session超时或用户已退出
			return;
		}
		
		
		int int_PCBID=Integer.parseInt(request.getParameter("pid"));
		ProjectSet set=new ProjectSet();
		int int_result=0;
		try {
			Connection con=Connect.getConnection();
			int_result=set.DeletePCB(con, int_PCBID);
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

	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doGet(request,response);
	}

}
