<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*,java.util.*,com.bean.*,com.dao.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>�ҵ���Ŀ</title>
<base target="_self">
<link rel="stylesheet" type="text/css" href="page/member/skin/css/base.css" />
<link rel="stylesheet" type="text/css" href="page/member/skin/css/main.css" />
</head>

<body>
<%
List<Project> project=(List)request.getAttribute("project");
Connection con=Connect.getConnection();
ChangeIDForName name=new ChangeIDForName();
 %>
<table width="98%" align="center" border="0" cellpadding="4" cellspacing="1" bgcolor="#CBD8AC" style="margin-bottom:8px">
<tr>
 <td height="26" >
  <table width="98%" border="0" cellspacing="0" cellpadding="0">
  <tr>
  <td align="left" valign="middle">������Ŀ</td>
 </tr>
</table>
</td>
</tr>
</table>
<table width="98%" border="0" cellpadding="2" cellspacing="1" bgcolor="#D1DDAA" align="center" style="margin-top:8px" >
	<tr align="center" bgcolor="#FAFAF1" height="22">
	<td width="7%">��ĿID</td>
	<td width="9%">��Ŀ���</td>
	<td width="14%">��Ŀ����</td>
	<td width="9%">��Ŀ����</td>
	<td width="19%">��������</td>
	<td width="19%">��ֹ����</td>
	<td width="9%">��Ŀ״̬</td>
	<td width="14%">����</td>
</tr>
<%
if(project!=null){
for(int i=0;i<project.size();i++){
 %>
<tr bgcolor="#FFFFFF">
<td align="center"><%=project.get(i).getG_intProjectId() %></td>
<td align="center"><%=project.get(i).getG_strProjectNumber() %></td>
<td align="center"><%=project.get(i).getG_strProjectName() %></td>
<td align="center"><%=name.getUserName(con,project.get(i).getG_intProjectManager()) %></td>
<td align="center"><%=project.get(i).getG_timProjectBeginTime() %></td>
<td align="center"><%
if(project.get(i).getG_timProjectEndTime()==null){%>��
<%}else{ %>
<%=project.get(i).getG_timProjectEndTime() %>
<%} %>
</td>
<td align="center">
<%if(project.get(i).getG_intProjectStatus()==0){ %>ֹͣ<%}
  else if(project.get(i).getG_intProjectStatus()==1){ %>��ͣ<%}
  else if(project.get(i).getG_intProjectStatus()==2){ %>���ڽ���<%}
  else{ %><font color="#FF0000">����</font><%} %></td>
<td align="center"><a href="DailyQueryForMemberServlet?flag=3&projectName=<%=project.get(i).getG_strProjectName() %>"><font color="#0033FF">�鿴�ձ�</font></a>|<a href="ProjectStaForMemberServlet?id=<%=project.get(i).getG_intProjectId() %>"><font color="#0033FF">�鿴ͳ��</font></a></td>
</tr>
<%} 
}
else{
%>
<tr align="center" bgcolor="white">
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td align="center"><font color="#FF0000">����δ�����κ���Ŀ</font></td>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>&nbsp;</td>

</tr>
<tr align="center">
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td align="center"><input type="button" value="����" onclick="window.history.back()" /></td>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>&nbsp;</td>

</tr>
<%}
con.close();
 %>
</table>
</body>
</html>