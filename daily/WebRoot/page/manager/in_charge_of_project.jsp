<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*,java.util.*,com.bean.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>������Ŀ</title>
<base target="_self">
<link rel="stylesheet" type="text/css" href="page/manager/skin/css/base.css" />
<link rel="stylesheet" type="text/css" href="page/manager/skin/css/main.css" />
</head>
<body>
<%
List<Project> list=(List)request.getAttribute("list");
String g_str_userName=request.getParameter("n");
 %>
<table width="98%" align="center" border="0" cellpadding="4" cellspacing="1" bgcolor="#CBD8AC"  style="margin-bottom:8px">
<tr bgcolor="#EEF4EA">
<td colspan="2" bgcolor="#CBD8AC"  class='title'><span>��ֹͣ��Ŀ</span></td>
</tr>
<tr>
<td width="8%" align="center" background="page/manager/skin/images/frame/wbg.gif">��ĿID</td>
<td width="12%" align="center" background="page/manager/skin/images/frame/wbg.gif">��Ŀ����</td>
<td width="11%" align="center" background="page/manager/skin/images/frame/wbg.gif">��Ŀ���</td>
<td width="11%" align="center" background="page/manager/skin/images/frame/wbg.gif">��Ŀ����</td>
<td width="10%" align="center" background="page/manager/skin/images/frame/wbg.gif">��Ŀ״̬</td>
<td width="21%" align="center" background="page/manager/skin/images/frame/wbg.gif">��Ŀ��ʼʱ��</td>
<td width="20%" align="center" background="page/manager/skin/images/frame/wbg.gif">��Ŀֹͣʱ��</td>
<td width="7%" align="center" background="page/manager/skin/images/frame/wbg.gif">����</td>
</tr>
<%
if(list!=null){
for(int i=0;i<list.size();i++){
if(list.get(i).getG_intProjectStatus()==0){

 %>
<tr bgcolor="#FFFFFF">
<td align="center"><%=list.get(i).getG_intProjectId() %></td>
<td align="center"><%=list.get(i).getG_strProjectName() %></td>
<td align="center"><%=list.get(i).getG_strProjectNumber() %></td>
<td align="center"><%=g_str_userName %></td>
<td align="center">��ֹͣ</td>
<td align="center"><%=list.get(i).getG_timProjectBeginTime() %></td>
<td align="center"><%=list.get(i).getG_timProjectEndTime() %></td>
<td align="center"><a href="ProjectDetailForMngServlet?flag=1&id=<%=list.get(i).getG_intProjectId() %>">��ϸ</a></td>
</tr>
<%}
} 
}
%>
</table>
<br />
<table width="98%" align="center" border="0" cellpadding="4" cellspacing="1" bgcolor="#CBD8AC"  style="margin-bottom:8px">
<tr bgcolor="#EEF4EA">
<td colspan="2" bgcolor="#CBD8AC"  class='title'><span>����ͣ��Ŀ</span></td>
</tr>
<tr>
<td width="8%" align="center" background="page/manager/skin/images/frame/wbg.gif">��ĿID</td>
<td width="12%" align="center" background="page/manager/skin/images/frame/wbg.gif">��Ŀ����</td>
<td width="11%" align="center" background="page/manager/skin/images/frame/wbg.gif">��Ŀ���</td>
<td width="11%" align="center" background="page/manager/skin/images/frame/wbg.gif">��Ŀ����</td>
<td width="10%" align="center" background="page/manager/skin/images/frame/wbg.gif">��Ŀ״̬</td>
<td width="21%" align="center" background="page/manager/skin/images/frame/wbg.gif">��Ŀ��ʼʱ��</td>
<td width="20%" align="center" background="page/manager/skin/images/frame/wbg.gif">��Ŀֹͣʱ��</td>
<td width="7%" align="center" background="page/manager/skin/images/frame/wbg.gif">����</td>
</tr>
<%
if(list!=null){
for(int i=0;i<list.size();i++){
if(list.get(i).getG_intProjectStatus()==1){

 %>
<tr bgcolor="#FFFFFF">
<td align="center"><%=list.get(i).getG_intProjectId() %></td>
<td align="center"><%=list.get(i).getG_strProjectName() %></td>
<td align="center"><%=list.get(i).getG_strProjectNumber() %></td>
<td align="center"><%=g_str_userName %></td>
<td align="center">����ͣ</td>
<td align="center"><%=list.get(i).getG_timProjectBeginTime() %></td>
<td align="center">��</td>
<td align="center"><a href="ProjectDetailForMngServlet?flag=2&id=<%=list.get(i).getG_intProjectId() %>">��ϸ</a></td>
</tr>
<%}
} 
}
%>
</table>
<br />
<table width="98%" align="center" border="0" cellpadding="4" cellspacing="1" bgcolor="#CBD8AC"  style="margin-bottom:8px">
<tr bgcolor="#EEF4EA">
<td colspan="2" bgcolor="#CBD8AC"  class='title'><span>���ڽ�����Ŀ</span></td>
</tr>
<tr>
<td width="8%" align="center" background="page/manager/skin/images/frame/wbg.gif">��ĿID</td>
<td width="12%" align="center" background="page/manager/skin/images/frame/wbg.gif">��Ŀ����</td>
<td width="11%" align="center" background="page/manager/skin/images/frame/wbg.gif">��Ŀ���</td>
<td width="11%" align="center" background="page/manager/skin/images/frame/wbg.gif">��Ŀ����</td>
<td width="10%" align="center" background="page/manager/skin/images/frame/wbg.gif">��Ŀ״̬</td>
<td width="21%" align="center" background="page/manager/skin/images/frame/wbg.gif">��Ŀ��ʼʱ��</td>
<td width="20%" align="center" background="page/manager/skin/images/frame/wbg.gif">��Ŀֹͣʱ��</td>
<td width="7%" align="center" background="page/manager/skin/images/frame/wbg.gif">����</td>
</tr>
<%
if(list!=null){
for(int i=0;i<list.size();i++){
if(list.get(i).getG_intProjectStatus()==2){

 %>
<tr bgcolor="#FFFFFF">
<td align="center"><%=list.get(i).getG_intProjectId() %></td>
<td align="center"><%=list.get(i).getG_strProjectName() %></td>
<td align="center"><%=list.get(i).getG_strProjectNumber() %></td>
<td align="center"><%=g_str_userName %></td>
<td align="center">���ڽ���</td>
<td align="center"><%=list.get(i).getG_timProjectBeginTime() %></td>
<td align="center">
<%if(list.get(i).getG_timProjectEndTime()==null){ %>��
<%}else{ %><%=list.get(i).getG_timProjectEndTime() %>
<%} %>
</td>
<td align="center"><a href="ProjectDetailForMngServlet?flag=3&id=<%=list.get(i).getG_intProjectId() %>">��ϸ</a></td>
</tr>
<%}
} 
}
%>
</table>
</body>
</html>