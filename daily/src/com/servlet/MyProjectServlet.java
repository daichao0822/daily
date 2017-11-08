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

import com.bean.Project;
import com.bean.User;
import com.dao.Connect;
import com.dao.ProjectSet;

public class MyProjectServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 3587790147434702138L;


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
int int_userID=user.getG_intUserId();
List<Project> project=new ArrayList<Project>();
try {
	Connection con=Connect.getConnection();
	ProjectSet getProject=new ProjectSet();
	project=getProject.getUserProject(con, int_userID);
	con.close();
} catch (ClassNotFoundException e) {
	// TODO Auto-generated catch block
	e.printStackTrace();
} catch (SQLException e) {
	// TODO Auto-generated catch block
	e.printStackTrace();
}
request.setAttribute("project", project);
request.getRequestDispatcher("page/member/my_project.jsp").forward(request, response);
}


public void doPost(HttpServletRequest request, HttpServletResponse response)
	throws ServletException, IOException {

doGet(request,response);
}

}
