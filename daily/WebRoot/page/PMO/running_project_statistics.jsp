<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*,java.util.*,com.bean.*,com.dao.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>��������Ŀͳ����Ϣ</title>
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
Connection con=Connect.getConnection();
ChangeIDForName change=new ChangeIDForName();
 %>
<table width="98%" align="center" border="0" cellpadding="4" cellspacing="1" bgcolor="#CBD8AC"  style="margin-bottom:8px">
<tr bgcolor="#EEF4EA">
<td colspan="2" bgcolor="#CBD8AC"  class='title'><span>��Ŀ��ϸ</span></td>
</tr>
<tr>
<td width="7%" align="center" background="page/manager/skin/images/frame/wbg.gif">��ĿID</td>
<td width="11%" align="center" background="page/manager/skin/images/frame/wbg.gif">��Ŀ����</td>
<td width="10%" align="center" background="page/manager/skin/images/frame/wbg.gif">��Ŀ���</td>
<td width="21%" align="center" background="page/manager/skin/images/frame/wbg.gif">��Ŀ����</td>
<td width="8%" align="center" background="page/manager/skin/images/frame/wbg.gif">��Ŀ״̬</td>
<td width="19%" align="center" background="page/manager/skin/images/frame/wbg.gif">��Ŀ��ʼʱ��</td>
<td width="16%" align="center" background="page/manager/skin/images/frame/wbg.gif">��Ŀ��ʱ</td>
<td width="8%" align="center" background="page/manager/skin/images/frame/wbg.gif">��Ŀ���ձ���</td>
</tr>
<%
if(proDetail!=null){
    for(int i=0;i<proDetail.size();i++){
 %>
<tr bgcolor="#FFFFFF">
<td align="center"><%=proDetail.get(i).getG_intProjectId() %></td>
<td align="center"><%=proDetail.get(i).getG_strProjectName() %></td>
<td align="center"><%=proDetail.get(i).getG_strProjectNumber() %></td>
<td align="center"><%=change.getUserName(con,proDetail.get(i).getG_intProjectManager()) %></td>
<td align="center">��������</td>
<td align="center"><%=proDetail.get(i).getG_timProjectBeginTime() %></td>
<td align="center">
<%=int_proWorkTime/86400 %>&nbsp;��
<%=(int_proWorkTime%86400)/3600 %>&nbsp;ʱ
<%=(int_proWorkTime%3600)/60 %>&nbsp;��
<%=(int_proWorkTime%60) %>&nbsp;��
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
<td align="center"><font color="#FF0000">Ŀǰû������������Ŀ</font></td>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>&nbsp;</td>
</tr>
 <%} con.close();%>
</table>
<table width="98%" align="center" border="0" cellpadding="4" cellspacing="1" bgcolor="#CBD8AC"  style="margin-bottom:8px">
  <tr bgcolor="#EEF4EA">
    <td colspan="2" bgcolor="#CBD8AC"  class='title'><span>��Ŀ����</span></td>
  </tr>
  <tr>
    <td width="11%" align="center" background="page/manager/skin/images/frame/wbg.gif">��������</td>
    <td width="19%" align="center" background="page/manager/skin/images/frame/wbg.gif">������Ŀ</td>
    <td width="21%" align="center" background="page/manager/skin/images/frame/wbg.gif">�����ܹ�ʱ</td>
    <td width="16%" align="center" background="page/manager/skin/images/frame/wbg.gif">�������ձ���</td>
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
    <%=int_workTime/86400 %>&nbsp;��
    <%=(int_workTime%86400)/3600 %>&nbsp;ʱ
    <%=(int_workTime%3600)/60 %>&nbsp;��
    <%=int_workTime%60 %>&nbsp;��
    </td>
    <td align="center"><%=task.get(i).getG_int_taskDailyAmt() %></td>
  </tr>
  <%}
 }
 else{ %>
  <tr bgcolor="#FFFFFF">
    <td align="center">&nbsp;</td>
    <td align="center"><font color="#FF0000">Ŀǰ����Ŀû������</font></td>
    <td align="center">&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <%} %>
</table>
<table width="98%" align="center" border="0" cellpadding="4" cellspacing="1" bgcolor="#CBD8AC"  style="margin-bottom:8px">
  <tr bgcolor="#EEF4EA">
  <td colspan="2" bgcolor="#CBD8AC"  class='title'><span>��Ŀ��Ա</span></td>
  </tr>
  <tr>
  <td width="8%" align="center" background="page/manager/skin/images/frame/wbg.gif">ID</td>
  <td width="13%" align="center" background="page/manager/skin/images/frame/wbg.gif">����</td>
  <td width="18%" align="center" background="page/manager/skin/images/frame/wbg.gif">����Ŀ�е��ܹ�ʱ</td>
  <td width="12%" align="center" background="page/manager/skin/images/frame/wbg.gif">ռ��Ŀ�ܹ�ʱ�ٷֱ�</td>
  <td width="16%" align="center" background="page/manager/skin/images/frame/wbg.gif">����Ŀ���ύ�ձ���</td>
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
  <%=workTimeInPro/86400 %>&nbsp;��
    <%=(workTimeInPro%86400)/3600 %>&nbsp;ʱ
    <%=(workTimeInPro%3600)/60 %>&nbsp;��
    <%=workTimeInPro%60 %>&nbsp;��
  </td>
  <td align="center"><%=user.get(i).getG_int_projectPercent() %>&nbsp;%</td>
  <td align="center"><%=user.get(i).getG_int_dailyAmtInPro() %></td>
  </tr>
  <%}
}else{ %>
  <tr bgcolor="#FFFFFF">
  <td align="center">&nbsp;</td>
  <td align="center"><font color="#FF0000">Ŀǰ����Ŀû����Ŀ��Ա</font></td>
  <td align="center">&nbsp;</td>
  <td align="center">&nbsp;</td>
  <td align="center">&nbsp;</td>
  </tr>
  <%}%>
</table>
<table width="98%" align="center">
  <tr>
<td align="center">
<input type="button" value="����" onclick="window.history.go(-1)" />
</td>
</tr>
</table>
</body>
</html>