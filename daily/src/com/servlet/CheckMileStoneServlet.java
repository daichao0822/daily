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

import com.bean.MileStoneConf;
import com.dao.Connect;
import com.dao.ProjectQuery;

public class CheckMileStoneServlet extends HttpServlet {

	
	/**
	 * 
	 */
	private static final long serialVersionUID = 924754793913404023L;


	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("GBK");
		response.setCharacterEncoding("GBK");
		
		HttpSession session=request.getSession();
		if(session.getAttribute("userInfo")==null){
			response.sendRedirect("http://localhost/daily/page/PMO/session_error.jsp");
			return;
		}
		
		String str_flag=request.getParameter("flag");
		int int_PCBID=Integer.parseInt(request.getParameter("id"));
		ProjectQuery query=new ProjectQuery();
		List<MileStoneConf> list=new ArrayList<MileStoneConf>();
		try {
			Connection con=Connect.getConnection();
			list=query.GetMileStoneConf(con, int_PCBID);
			con.close();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		request.setAttribute("milestoneConf", list);
		if(str_flag.equals("1")||str_flag.equals("2")){//停止项目PCB板的里程碑
			request.getRequestDispatcher("page/PMO/stopped_or_suspend_project_milestone.jsp").forward(request, response);
		}
		else if(str_flag.equals("3")){//正在运行项目PCB板的里程碑
			request.getRequestDispatcher("page/PMO/running_project_milestone.jsp?pid="+int_PCBID).forward(request, response);
		}
	}

	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doGet(request,response);
	}

}
