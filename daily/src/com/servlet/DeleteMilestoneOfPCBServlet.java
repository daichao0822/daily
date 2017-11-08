package com.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dao.Connect;
import com.dao.ProjectSet;

public class DeleteMilestoneOfPCBServlet extends HttpServlet {

	
	/**
	 * 
	 */
	private static final long serialVersionUID = -2775552373851183472L;


	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("GBK");
		response.setCharacterEncoding("GBK");
		
		HttpSession session=request.getSession();
		if(session.getAttribute("userInfo")==null){
			response.sendRedirect("http://localhost/daily/page/PMO/session_error.jsp");
			return;
		}
		
		String[] id=request.getParameterValues("milestoneConfID");
		ProjectSet set=new ProjectSet();
		int int_result=-1;
		int int_milestoneConfID=-1;
		try {
			Connection con=Connect.getConnection();
			int i=0;
			for(i=0;i<id.length;i++){
				int_milestoneConfID=Integer.parseInt(id[i]);
				int_result=set.DeleteMilestoneOfPCB(con, int_milestoneConfID);
				if(int_result==0){
					request.getRequestDispatcher("page/PMO/delete_milestone_conf_fail.jsp").forward(request, response);
					break;
				}
			}
			if(i==id.length){
				request.getRequestDispatcher("page/PMO/delete_milestone_conf_success.jsp").forward(request, response);
			}
			con.close();
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
