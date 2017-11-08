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

public class AddPCBServlet extends HttpServlet {

	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1780405327844364218L;


	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("GBK");
		response.setCharacterEncoding("GBK");
		
		PrintWriter out = response.getWriter();
		HttpSession session=request.getSession();
		if(session.getAttribute("userInfo")==null){
			out.print(2);
			return;
		}
		String str_PCBName=request.getParameter("name");
		int int_produceStyle=Integer.parseInt(request.getParameter("prodSty"));
		String str_confirmTime=request.getParameter("time").replaceAll("_"," ");
		String str_opinion=request.getParameter("opin");
		int int_confirmUser=Integer.parseInt(request.getParameter("u"));
		int int_projectID=Integer.parseInt(request.getParameter("pid"));
		String str_deliver=request.getParameter("delv");
		String str_sample=request.getParameter("samp");
		String str_amount=request.getParameter("amnt");
		Timestamp tim_confirmTime=Timestamp.valueOf(str_confirmTime);
		int int_deliver=0;
		int int_sample=0;
		int int_amount=0;
		
		if(str_deliver!=""){
			int_deliver=Integer.parseInt(str_deliver);
		}
		if(str_sample!=""){
			int_sample=Integer.parseInt(str_sample);
		}
		if(str_amount!=""){
			int_amount=Integer.parseInt(str_amount);
		}
		
		ProjectSet set=new ProjectSet();
		int int_result=0;
		try {
			Connection con=Connect.getConnection();
			int_result=set.AddPCB(con, str_PCBName, int_projectID, int_amount, int_sample, int_deliver, int_produceStyle, int_confirmUser, tim_confirmTime, str_opinion);
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


	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doGet(request,response);
	}

}
