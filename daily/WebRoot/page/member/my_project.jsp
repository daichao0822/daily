<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*,java.util.*,com.bean.*,com.dao.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>我的项目</title>
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
  <td align="left" valign="middle">参与项目</td>
 </tr>
</table>
</td>
</tr>
</table>
<table width="98%" border="0" cellpadding="2" cellspacing="1" bgcolor="#D1DDAA" align="center" style="margin-top:8px" >
	<tr align="center" bgcolor="#FAFAF1" height="22">
	<td width="7%">项目ID</td>
	<td width="9%">项目编号</td>
	<td width="14%">项目名称</td>
	<td width="9%">项目经理</td>
	<td width="19%">立项日期</td>
	<td width="19%">截止日期</td>
	<td width="9%">项目状态</td>
	<td width="14%">操作</td>
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
if(project.get(i).getG_timProjectEndTime()==null){%>无
<%}else{ %>
<%=project.get(i).getG_timProjectEndTime() %>
<%} %>
</td>
<td align="center">
<%if(project.get(i).getG_intProjectStatus()==0){ %>停止<%}
  else if(project.get(i).getG_intProjectStatus()==1){ %>暂停<%}
  else if(project.get(i).getG_intProjectStatus()==2){ %>正在进行<%}
  else{ %><font color="#FF0000">错误</font><%} %></td>
<td align="center"><a href="DailyQueryForMemberServlet?flag=3&projectName=<%=project.get(i).getG_strProjectName() %>"><font color="#0033FF">查看日报</font></a>|<a href="ProjectStaForMemberServlet?id=<%=project.get(i).getG_intProjectId() %>"><font color="#0033FF">查看统计</font></a></td>
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
<td align="center"><font color="#FF0000">您还未参与任何项目</font></td>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>&nbsp;</td>

</tr>
<tr align="center">
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td align="center"><input type="button" value="返回" onclick="window.history.back()" /></td>
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