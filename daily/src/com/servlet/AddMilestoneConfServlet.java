package com.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.bean.Milestone;
import com.dao.Connect;
import com.dao.ProjectQuery;
import com.dao.ProjectSet;

public class AddMilestoneConfServlet extends HttpServlet {

	
	/**
	 * 
	 */
	private static final long serialVersionUID = 4263307685793265774L;


	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("GBK");
		response.setCharacterEncoding("GBK");
		
		HttpSession session=request.getSession();
		if(session.getAttribute("userInfo")==null){//session超时或用户已退出
			response.sendRedirect("http://localhost/daily/page/PMO/add_milestone_session_error.jsp");
			return;
		}
		
		String str_flag=request.getParameter("flag");
		
		if(str_flag.equals("1")){//添加里程碑前的数据初始化：查询里程碑
		int int_PCBID=Integer.parseInt(request.getParameter("pid"));
		ProjectQuery query=new ProjectQuery();
		List<Milestone> list=new ArrayList<Milestone>();
		try {
			Connection con=Connect.getConnection();
			list=query.GetMilestoneForPCB(con, int_PCBID);
			con.close();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		request.setAttribute("milestone", list);
		request.getRequestDispatcher("page/PMO/add_milestone_conf.jsp?pid="+int_PCBID).forward(request, response);
		}
		else if(str_flag.equals("2")){//为PCB添加新里程碑
			int int_milestoneConf=-1;
			int int_PCBID=Integer.parseInt(request.getParameter("PCBID"));
			int int_milestoneID=Integer.parseInt(request.getParameter("milestoneID"));
			int int_confirmUser=Integer.parseInt(request.getParameter("confirmUser"));
			String str_confirmOpinion=request.getParameter("confirmOpinion");
			String str_confirmTime=request.getParameter("confirmTime");
			Timestamp confirmTime=Timestamp.valueOf(str_confirmTime);
			ProjectSet set=new ProjectSet();
			int int_result=-1;
			try {
				Connection con=Connect.getConnection();
				int_milestoneConf=set.GetIDForMilestoneConf(con);
				int_result=set.AddMilestoneForPCB(con, int_milestoneConf, int_milestoneID, int_PCBID, int_confirmUser, str_confirmOpinion, confirmTime);
				con.close();
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			if(int_result==1){//添加成功
				request.getRequestDispatcher("page/PMO/add_milestone_conf_success.jsp").forward(request, response);
			}
			else if(int_result==0){//添加失败
				request.getRequestDispatcher("page/PMO/add_milestone_conf_fail.jsp").forward(request, response);
			}
		}
	}

	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doGet(request,response);
	}

}
