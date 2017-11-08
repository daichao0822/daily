<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*,java.util.*,com.bean.*,com.dao.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>在运行项目统计信息</title>
<base target="_self">
<link rel="stylesheet" type="text/css" href="page/manager/skin/css/base.css" />
<link rel="stylesheet" type="text/css" href="page/manager/skin/css/main.css" />
</head>

<body>
<%
List<Project> proDetail=(List)request.getAttribute("project");
List<UserStatisticsForMng> user=(List)request.getAttribute("user");
List<TaskStatisticsForMng> task=(List)request.getAttribute("task");
int int_proWorkTime=Integer.parseInt(request.getParameter("pwt"));
String projectDailyAmount=request.getParameter("pda");
 %>
<table width="98%" align="center" border="0" cellpadding="4" cellspacing="1" bgcolor="#CBD8AC"  style="margin-bottom:8px">
<tr bgcolor="#EEF4EA">
<td colspan="2" bgcolor="#CBD8AC"  class='title'><span>项目详细</span></td>
</tr>
<tr>
<td width="7%" align="center" background="page/manager/skin/images/frame/wbg.gif">项目ID</td>
<td width="11%" align="center" background="page/manager/skin/images/frame/wbg.gif">项目名称</td>
<td width="10%" align="center" background="page/manager/skin/images/frame/wbg.gif">项目编号</td>
<td width="21%" align="center" background="page/manager/skin/images/frame/wbg.gif">项目经理</td>
<td width="8%" align="center" background="page/manager/skin/images/frame/wbg.gif">项目状态</td>
<td width="19%" align="center" background="page/manager/skin/images/frame/wbg.gif">项目开始时间</td>
<td width="16%" align="center" background="page/manager/skin/images/frame/wbg.gif">项目工时</td>
<td width="8%" align="center" background="page/manager/skin/images/frame/wbg.gif">项目总日报数</td>
</tr>
<%
if(proDetail!=null){
    for(int i=0;i<proDetail.size();i++){
 %>
<tr bgcolor="#FFFFFF">
<td align="center"><%=proDetail.get(i).getG_intProjectId() %></td>
<td align="center"><%=proDetail.get(i).getG_strProjectName() %></td>
<td align="center"><%=proDetail.get(i).getG_strProjectNumber() %></td>
<td align="center">
${sessionScope.userInfo.g_strUserName}
</td>
<td align="center">正在运行</td>
<td align="center"><%=proDetail.get(i).getG_timProjectBeginTime() %></td>
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
<td align="center"><font color="#FF0000">目前没有正在运行项目</font></td>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>&nbsp;</td>
</tr>
 <%} %>
</table>
<table width="98%" align="center" border="0" cellpadding="4" cellspacing="1" bgcolor="#CBD8AC"  style="margin-bottom:8px">
  <tr bgcolor="#EEF4EA">
    <td colspan="2" bgcolor="#CBD8AC"  class='title'><span>项目任务</span></td>
  </tr>
  <tr>
    <td width="11%" align="center" background="page/manager/skin/images/frame/wbg.gif">任务名称</td>
    <td width="19%" align="center" background="page/manager/skin/images/frame/wbg.gif">所属项目</td>
    <td width="21%" align="center" background="page/manager/skin/images/frame/wbg.gif">任务总工时</td>
    <td width="16%" align="center" background="page/manager/skin/images/frame/wbg.gif">任务总日报数</td>
  </tr>
  <%
if(task!=null){
    for(int i=0;i<task.size();i++){
 %>
  <tr bgcolor="#FFFFFF">
    <td align="center"><%=task.get(i).getG_str_taskName() %></td>
    <td align="center"><%=task.get(i).getG_str_projectName() %></td>
    <td align="center">
    <%int int_workTime=task.get(i).getG_int_taskWorkTime(); %>
    <%=int_workTime/86400 %>&nbsp;日
    <%=(int_workTime%86400)/3600 %>&nbsp;时
    <%=(int_workTime%3600)/60 %>&nbsp;分
    <%=int_workTime%60 %>&nbsp;秒
    </td>
    <td align="center"><%=task.get(i).getG_int_taskDailyAmt() %></td>
  </tr>
  <%}
 }
 else{ %>
  <tr bgcolor="#FFFFFF">
    <td align="center">&nbsp;</td>
    <td align="center"><font color="#FF0000">目前该项目没有任务</font></td>
    <td align="center">&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <%} %>
</table>
<table width="98%" align="center" border="0" cellpadding="4" cellspacing="1" bgcolor="#CBD8AC"  style="margin-bottom:8px">
  <tr bgcolor="#EEF4EA">
  <td colspan="2" bgcolor="#CBD8AC"  class='title'><span>项目人员</span></td>
  </tr>
  <tr>
  <td width="8%" align="center" background="page/manager/skin/images/frame/wbg.gif">ID</td>
  <td width="13%" align="center" background="page/manager/skin/images/frame/wbg.gif">姓名</td>
  <td width="18%" align="center" background="page/manager/skin/images/frame/wbg.gif">在项目中的总工时</td>
  <td width="12%" align="center" background="page/manager/skin/images/frame/wbg.gif">占项目总工时百分比</td>
  <td width="16%" align="center" background="page/manager/skin/images/frame/wbg.gif">在项目总提交日报数</td>
  </tr>
  <%
if(user!=null){
    for(int i=0;i<user.size();i++){
 %>
  <tr bgcolor="#FFFFFF">
  <td align="center"><%=user.get(i).getG_int_userID() %></td>
  <td align="center"><%=user.get(i).getG_str_userName() %></td>
  <td align="center">
  <%int workTimeInPro=user.get(i).getG_int_userWorkTimeInPro(); %>
  <%=workTimeInPro/86400 %>&nbsp;日
    <%=(workTimeInPro%86400)/3600 %>&nbsp;时
    <%=(workTimeInPro%3600)/60 %>&nbsp;分
    <%=workTimeInPro%60 %>&nbsp;秒
  </td>
  <td align="center"><%=user.get(i).getG_int_projectPercent() %>&nbsp;%</td>
  <td align="center"><%=user.get(i).getG_int_dailyAmtInPro() %></td>
  </tr>
  <%}
}else{ %>
  <tr bgcolor="#FFFFFF">
  <td align="center">&nbsp;</td>
  <td align="center"><font color="#FF0000">目前该项目没有项目人员</font></td>
  <td align="center">&nbsp;</td>
  <td align="center">&nbsp;</td>
  <td align="center">&nbsp;</td>
  </tr>
  <%}%>
</table>
<table width="98%" align="center">
  <tr>
<td align="center">
<input type="button" value="返回" onclick="window.history.go(-1)" />
</td>
</tr>
</table>
</body>
</html>