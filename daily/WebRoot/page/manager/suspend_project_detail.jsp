<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*,java.util.*,com.bean.*,com.dao.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>停止运行项目详细信息</title>
<base target="_self">
<link rel="stylesheet" type="text/css" href="page/manager/skin/css/base.css" />
<link rel="stylesheet" type="text/css" href="page/manager/skin/css/main.css" />
</head>

<body>
<%
List<Project> proDetail=(List)request.getAttribute("proDetail");
List<User> user=(List)request.getAttribute("user");
List<ProjectTaskAssign> task=(List<ProjectTaskAssign>)request.getAttribute("taskAssign");
int int_proWorkTime=Integer.parseInt(request.getParameter("pwt"));
String projectDailyAmount=request.getParameter("pda");
String str_execUserName=null;
			String str_confirmUserName=null;
			ChangeIDForName change = new ChangeIDForName();
			Connection con = Connect.getConnection();
 %>
<table width="98%" align="center" border="0" cellpadding="4" cellspacing="1" bgcolor="#CBD8AC"  style="margin-bottom:8px">
<tr bgcolor="#EEF4EA">
<td colspan="2" bgcolor="#CBD8AC"  class='title'><span>项目详细</span></td>
</tr>
<tr>
<td width="4%" align="center" background="page/manager/skin/images/frame/wbg.gif">项目ID</td>
<td width="11%" align="center" background="page/manager/skin/images/frame/wbg.gif">项目名称</td>
<td width="7%" align="center" background="page/manager/skin/images/frame/wbg.gif">项目编号</td>
<td width="10%" align="center" background="page/manager/skin/images/frame/wbg.gif">项目经理</td>
<td width="6%" align="center" background="page/manager/skin/images/frame/wbg.gif">项目状态</td>
<td width="18%" align="center" background="page/manager/skin/images/frame/wbg.gif">项目开始时间</td>
<td width="18%" align="center" background="page/manager/skin/images/frame/wbg.gif">项目结束时间</td>
<td width="16%" align="center" background="page/manager/skin/images/frame/wbg.gif">项目工时</td>
<td width="10%" align="center" background="page/manager/skin/images/frame/wbg.gif">项目总日报数</td>
</tr>
<%
if(proDetail!=null){
    for(int i=0;i<proDetail.size();i++){
 %>
<tr bgcolor="#FFFFFF">
<td align="center"><%=proDetail.get(i).getG_intProjectId() %></td>
<td align="center"><%=proDetail.get(i).getG_strProjectName() %></td>
<td align="center"><%=proDetail.get(i).getG_strProjectNumber() %></td>
<td align="center">${sessionScope.userInfo.g_strUserName}</td>
<td align="center">已暂停</td>
<td align="center"><%=proDetail.get(i).getG_timProjectBeginTime() %></td>
<td align="center">&nbsp;</td>
<td align="center">
<%=int_proWorkTime/86400 %>&nbsp;日
<%=(int_proWorkTime%86400)/3600 %>&nbsp;时
<%=(int_proWorkTime%3600)/60 %>&nbsp;分
<%=(int_proWorkTime%60) %>&nbsp;秒
</td>
<td align="center"><%=projectDailyAmount %></td>
</tr>
 <%}
 }
 else{ %>
<tr bgcolor="#FFFFFF">
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td align="center"><font color="#FF0000">目前没有已停止运行项目</font></td>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>&nbsp;</td>
</tr>
 <%} %>
</table>
<table width="98%" align="center" border="0" cellpadding="4"
			cellspacing="1" bgcolor="#CBD8AC" style="margin-bottom: 8px">
			<tr bgcolor="#EEF4EA">
				<td colspan="2" bgcolor="#CBD8AC" class='title'>
					<span>项目任务</span>
				</td>
			</tr>
			<tr>
				<td width="4%" align="center"
					background="page/manager/skin/images/frame/wbg.gif">
					任务ID
				</td>
				<td width="8%" align="center"
					background="page/manager/skin/images/frame/wbg.gif">
					任务名称
				</td>
				<td width="7%" align="center"
					background="page/manager/skin/images/frame/wbg.gif">
					所属项目
				</td>
                <td width="13%" align="center"
					background="page/manager/skin/images/frame/wbg.gif">开始时间</td>
                <td width="14%" align="center"
					background="page/manager/skin/images/frame/wbg.gif">
					截止时间
				</td>
                <td width="13%" align="center"
					background="page/manager/skin/images/frame/wbg.gif">
					工期
				</td>
                <td width="8%" align="center"
					background="page/manager/skin/images/frame/wbg.gif">
					执行人
				</td>
				<td width="6%" align="center"
					background="page/manager/skin/images/frame/wbg.gif">
					确认人
				</td>
                <td width="14%" align="center"
					background="page/manager/skin/images/frame/wbg.gif">
					确认意见
				</td>
			</tr>
             
			<%
				if (task != null) {
					for (int i = 0; i < task.size(); i++) {
			%>
			<tr bgcolor="#FFFFFF">
				<td width="4%" align="center"><%=task.get(i).getG_int_task() %></td>
				<td width="8%" align="center"><%=change.getTaskName(con,task.get(i).getG_int_task()) %></td>
				<td width="7%" align="center"><%=change.getProjectName(con,task.get(i).getG_int_project()) %></td>
				<td width="13%" align="center">
				<%
				if(task.get(i).getG_tim_begin_time()==null){
				%>&nbsp;
				<%
				}
				else{
				%>
				<%=task.get(i).getG_tim_begin_time() %>
				<%
				}
				 %></td>
                <td width="14%" align="center">
                <%
				if(task.get(i).getG_tim_end_time()==null){
				%>&nbsp;
				<%
				}
				else{
				%>
				<%=task.get(i).getG_tim_end_time() %>
				<%
				}
				 %>
                </td>
                <td width="13%" align="center">
                <%
                int int_workTime=task.get(i).getG_int_work_time();
                if(int_workTime!=0){
                 %>
                <%=int_workTime/86400 %>日
                <%=(int_workTime%86400)/3600 %>时
                <%=(int_workTime%3600)/60 %>分
                <%=(int_workTime%60) %>秒
                <%}
                else{
                %>&nbsp;
                <%
                } %>
                </td>
                <td width="8%" align="center">
                <%
                str_execUserName=change.getUserName(con,task.get(i).getG_int_exec_user());
                if(str_execUserName.equals("无")){ %>
                &nbsp;
                <%}else{
                %>
                <%=str_execUserName %>
                <%
                } %>
                </td>
                <td width="6%" align="center">
                <%
                str_confirmUserName=change.getUserName(con,task.get(i).getG_int_confirm_user());
                if(str_confirmUserName.equals("无")){
                %>
                &nbsp;
                <%
                }else{
                %>
                <%=str_confirmUserName %>
                <%
                }
                 %>
                </td>
				<td width="14%" align="center"><%=task.get(i).getG_str_opinion() %></td>
			</tr>
           
			<%
				}
				} else {
			%>
           
			<tr bgcolor="#FFFFFF">
				<td align="center">&nbsp;
					
				</td>
				<td align="center">
					<font color="#FF0000">目前该项目还没有任务</font>
				</td>
				<td align="center">&nbsp;
					
				</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
				<td align="center">&nbsp;
					
				</td>
				<td align="center">&nbsp;
					
				</td>
                <td>&nbsp;</td>
			</tr>
            </table>
			<%
				}
			%>

<table width="98%" align="center" border="0" cellpadding="4" cellspacing="1" bgcolor="#CBD8AC"  style="margin-bottom:8px">
<tr bgcolor="#EEF4EA">
<td colspan="2" bgcolor="#CBD8AC"  class='title'><span>项目人员</span></td>
</tr>
<tr>
<td width="11%" align="center" background="page/manager/skin/images/frame/wbg.gif">ID</td>
<td width="19%" align="center" background="page/manager/skin/images/frame/wbg.gif">姓名</td>
<td width="14%" align="center" background="page/manager/skin/images/frame/wbg.gif">性别</td>
<td width="27%" align="center" background="page/manager/skin/images/frame/wbg.gif">所属部门</td>
<td width="20%" align="center" background="page/manager/skin/images/frame/wbg.gif">E-mail</td>
</tr>
<%
if(user!=null){
    for(int i=0;i<user.size();i++){
 %>
<tr bgcolor="#FFFFFF">
<td align="center"><%=user.get(i).getG_intUserId() %></td>
<td align="center"><%=user.get(i).getG_strUserName() %></td>
<td align="center"><%=user.get(i).getG_strSex()%></td>
<td align="center"><%=change.GetDepartmentName(con,user.get(i).getG_intDepartment()) %></td>
<td align="center"><%=user.get(i).getG_strEmail() %></td>
</tr>
<%}
}else{ %>
<tr bgcolor="#FFFFFF">
<td align="center">&nbsp;</td>
<td align="center">&nbsp;</td>
<td align="center">&nbsp;</td>
<td align="center"><font color="#FF0000">目前该项目没有项目人员</font></td>
<td align="center">&nbsp;</td>
</tr>
<%}%>
</table>
<%con.close(); %>
<table width="98%" align="center">
  <tr>
<td align="center">
<input type="button" value="返回" onclick="window.history.go(-1)" />
</td>
</tr>
</table>
</body>
</html>