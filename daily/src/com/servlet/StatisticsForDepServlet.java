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

import com.bean.Daily;
import com.bean.DailyStatisticsForDep;
import com.bean.User;
import com.bean.WorkTimeStaForDep;
import com.dao.Connect;
import com.dao.DailyQuery;
import com.dao.DepartmentQuery;

public class StatisticsForDepServlet extends HttpServlet {

	
	/**
	 * 
	 */
	private static final long serialVersionUID = 4104359410362883566L;


	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("GBK");
		response.setCharacterEncoding("GBK");
		
		HttpSession session=request.getSession();
		if(session.getAttribute("userInfo")==null){
			response.sendRedirect("http://localhost/daily/page/session_error.jsp");
			return;
		}
		User head=(User)session.getAttribute("userInfo");
		int int_departmentID=head.getG_intDepartment();
		DepartmentQuery depQuery=new DepartmentQuery();
		DailyQuery dlyQuery=new DailyQuery();
		List<DailyStatisticsForDep> dailySta=new ArrayList<DailyStatisticsForDep>();
		List<WorkTimeStaForDep> workTimeSta=new ArrayList<WorkTimeStaForDep>();
		List<User> userInDep=new ArrayList<User>();
		List<Daily> dailys=new ArrayList<Daily>();
		
		int int_proDailyCount;//�û������ύ��Ŀ�����ձ�����
		int int_tempDailyCount;//�û������ύ��ʱ�����ձ�����
		int int_proMonthDaily;//�û����һ�����ύ��Ŀ�����ձ�����
		int int_tempMonthDaily;//�û����һ�����ύ��ʱ�����ձ�����
		int int_proWeekDaily;//�û����һ���ύ��Ŀ�����ձ�����
		int int_tempWeekDaily;//�û����һ���ύ��ʱ�����ձ�����
		int int_proWorkTimeCount;//�û�������Ŀ�����ܹ�ʱ
		int int_tempWorkTimeCount;//�û�������ʱ�����ܹ�ʱ
		int int_proMonthWorkTime;//�û����һ������Ŀ�����ܹ�ʱ
		int int_tempMonthWorkTime;//�û����һ������ʱ�����ܹ�ʱ
		int int_proWeekWorkTime;//�û����һ����Ŀ�����ܹ�ʱ
		int int_tempWeekWorkTime;//�û����һ����ʱ�����ܹ�ʱ
		
		try {
			Connection con=Connect.getConnection();
			userInDep=depQuery.GetUserInDepartment(con, int_departmentID);
			if(userInDep!=null){
				for(int i=0;i<userInDep.size();i++){
					//��ʼ��ͳ������
					int_proDailyCount=0;
					int_tempDailyCount=0;
					int_proMonthDaily=0;
					int_tempMonthDaily=0;
					int_proWeekDaily=0;
					int_tempWeekDaily=0;
					int_proWorkTimeCount=0;
					int_tempWorkTimeCount = 0;
					int_proMonthWorkTime=0;
					int_tempMonthWorkTime=0;
					int_proWeekWorkTime=0;
					int_tempWeekWorkTime=0;
					
					//���»�ȡ�û��ձ�ͳ����Ϣ
					DailyStatisticsForDep dailyStatistics=new DailyStatisticsForDep();
					WorkTimeStaForDep workTimeStatistics=new WorkTimeStaForDep();
					dailys=dlyQuery.AllDaily(con, userInDep.get(i).getG_intUserId());
					if(dailys!=null){//�������û������ձ���Ϊ��
						for(int m=0;m<dailys.size();m++){
							if(dailys.get(m).getG_intDailyType()==0){//��ʱ�����ձ���+1
								int_tempDailyCount=int_tempDailyCount+1;
							}
							else{//��Ŀ�����ձ���+1
								int_proDailyCount=int_proDailyCount+1;
							}
						}
						dailys=depQuery.GetUserDailyInLastMonth(con, userInDep.get(i).getG_intUserId());
						if(dailys!=null){//�������û����һ�����ձ���Ϊ��
							for(int m=0;m<dailys.size();m++){
								if(dailys.get(m).getG_intDailyType()==0){
									int_tempMonthDaily=int_tempMonthDaily+1;
								}
								else{
									int_proMonthDaily=int_proMonthDaily+1;
								}
							}
						}
						dailys=depQuery.GetUserDailyInLastWeek(con, userInDep.get(i).getG_intUserId());
						if(dailys!=null){
							for(int m=0;m<dailys.size();m++){
								if(dailys.get(m).getG_intDailyType()==0){
									int_tempWeekDaily=int_tempWeekDaily+1;
								}
								else{
									int_proWeekDaily=int_proWeekDaily+1;
								}
							}
						}
						dailyStatistics.setG_int_proDailyCount(int_proDailyCount);
						dailyStatistics.setG_int_proMonthDaily(int_proMonthDaily);
						dailyStatistics.setG_int_proWeekDaily(int_proWeekDaily);
						dailyStatistics.setG_int_tempDailyCount(int_tempDailyCount);
						dailyStatistics.setG_int_tempMonthDaily(int_tempMonthDaily);
						dailyStatistics.setG_int_tempWeekDaily(int_tempWeekDaily);
						dailyStatistics.setG_int_useID(userInDep.get(i).getG_intUserId());
						dailyStatistics.setG_str_userName(userInDep.get(i).getG_strUserName());
					}
					else{
						dailyStatistics.setG_int_proDailyCount(0);
						dailyStatistics.setG_int_proMonthDaily(0);
						dailyStatistics.setG_int_proWeekDaily(0);
						dailyStatistics.setG_int_tempDailyCount(0);
						dailyStatistics.setG_int_tempMonthDaily(0);
						dailyStatistics.setG_int_tempWeekDaily(0);
						dailyStatistics.setG_int_useID(userInDep.get(i).getG_intUserId());
						dailyStatistics.setG_str_userName(userInDep.get(i).getG_strUserName());
					}
					
					//���»�ȡ�û���ʱͳ����Ϣ
					dailys=dlyQuery.AllDaily(con, userInDep.get(i).getG_intUserId());
					if(dailys!=null){//�������û������ձ���Ϊ��
						for(int m=0;m<dailys.size();m++){//ѭ���������û������ձ���ʱ
							if(dailys.get(m).getG_intDailyType()==0){//����ձ�����Ϊ��ʱ�ձ����������ʱ�ձ���ʱ
								int_tempWorkTimeCount=int_tempWorkTimeCount+dailys.get(m).getG_intDailyCount();
							}
							else{//����ձ�����Ϊ�����ձ�������������ձ���ʱ
								int_proWorkTimeCount=int_proWorkTimeCount+dailys.get(m).getG_intDailyCount();
							}
						}
						
						dailys=depQuery.GetUserDailyInLastMonth(con, userInDep.get(i).getG_intUserId());
						if(dailys!=null){//����û������ύ�ձ���Ϊ�գ�������û����¹�ʱ
							for(int m=0;m<dailys.size();m++){
								if(dailys.get(m).getG_intDailyType()==0){//�����û�������ʱ����ʱ
									int_tempMonthWorkTime=int_tempMonthWorkTime+dailys.get(m).getG_intDailyCount();
								}
								else{//�����û�������Ŀ����ʱ
									int_proMonthWorkTime=int_proMonthWorkTime+dailys.get(m).getG_intDailyCount();
								}
							}
						}
						
						dailys=depQuery.GetUserDailyInLastWeek(con, userInDep.get(i).getG_intUserId());
						if(dailys!=null){//����û������ύ�ձ���Ϊ�գ�������û����ܹ�ʱ
							for(int m=0;m<dailys.size();m++){
								if(dailys.get(m).getG_intDailyType()==0){//�����û�������ʱ����ʱ
									int_tempWeekWorkTime=int_tempWeekWorkTime+dailys.get(m).getG_intDailyCount();
								}
								else{//�����û�������Ŀ����ʱ
									int_proWeekWorkTime=int_proWeekWorkTime+dailys.get(m).getG_intDailyCount();
								}
							}
						}
						
						workTimeStatistics.setG_int_proMonthWorkTime(int_proMonthWorkTime);
						workTimeStatistics.setG_int_proWeekWorkTime(int_proWeekWorkTime);
						workTimeStatistics.setG_int_proWorkTimeCount(int_proWorkTimeCount);
						workTimeStatistics.setG_int_tempMonthWorkTime(int_tempMonthWorkTime);
						workTimeStatistics.setG_int_tempWeekWorkTime(int_tempWeekWorkTime);
						workTimeStatistics.setG_int_tempWorkTimeCount(int_tempWorkTimeCount);
						workTimeStatistics.setG_int_userID(userInDep.get(i).getG_intUserId());
						workTimeStatistics.setG_str_userName(userInDep.get(i).getG_strUserName());
					}
					else{
						workTimeStatistics.setG_int_proMonthWorkTime(int_proMonthWorkTime);
						workTimeStatistics.setG_int_proWeekWorkTime(int_proWeekWorkTime);
						workTimeStatistics.setG_int_proWorkTimeCount(int_proWorkTimeCount);
						workTimeStatistics.setG_int_tempMonthWorkTime(int_tempMonthWorkTime);
						workTimeStatistics.setG_int_tempWeekWorkTime(int_tempWeekWorkTime);
						workTimeStatistics.setG_int_tempWorkTimeCount(int_tempWorkTimeCount);
						workTimeStatistics.setG_int_userID(userInDep.get(i).getG_intUserId());
						workTimeStatistics.setG_str_userName(userInDep.get(i).getG_strUserName());
					}
					dailySta.add(dailyStatistics);
					workTimeSta.add(workTimeStatistics);
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
		request.setAttribute("dailySta", dailySta);
		request.setAttribute("workTimeSta", workTimeSta);
		request.getRequestDispatcher("page/head_of_department/department_statistics.jsp").forward(request, response);
	}

	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doGet(request,response);
	}

}
