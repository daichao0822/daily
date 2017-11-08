<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*,java.util.*,com.bean.*,com.dao.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>负责项目</title>
<base target="_self">
<link rel="stylesheet" type="text/css" href="page/PMO/skin/css/base.css" />
<link rel="stylesheet" type="text/css" href="page/PMO/skin/css/main.css" />
</head>
<body>
<%
List<Project> list=(List)request.getAttribute("project");
ChangeIDForName change=new ChangeIDForName();
Connection con=Connect.getConnection();
 %>
<table width="98%" align="center" border="0" cellpadding="4" cellspacing="1" bgcolor="#CBD8AC"  style="margin-bottom:8px">
<tr bgcolor="#EEF4EA">
<td colspan="2" bgcolor="#CBD8AC"  class='title'><span>已停止项目</span></td>
</tr>
<tr>
<td width="9%" align="center" background="page/PMO/skin/images/frame/wbg.gif">项目ID</td>
<td width="10%" align="center" background="page/PMO/skin/images/frame/wbg.gif">项目名称</td>
<td width="10%" align="center" background="page/PMO/skin/images/frame/wbg.gif">项目编号</td>
<td width="10%" align="center" background="page/PMO/skin/images/frame/wbg.gif">项目经理</td>
<td width="9%" align="center" background="page/PMO/skin/images/frame/wbg.gif">项目状态</td>
<td width="19%" align="center" background="page/PMO/skin/images/frame/wbg.gif">项目开始时间</td>
<td width="18%" align="center" background="page/PMO/skin/images/frame/wbg.gif">项目停止时间</td>
<td width="10%" align="center" background="page/PMO/skin/images/frame/wbg.gif">操作</td>
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
<td align="center"><%=change.getUserName(con,list.get(i).getG_intProjectManager()) %></td>
<td align="center">已停止</td>
<td align="center"><%=list.get(i).getG_timProjectBeginTime() %></td>
<td align="center"><%=list.get(i).getG_timProjectEndTime() %></td>
<td align="center"><a href="ProjectStaForPMOServlet?flag=2&status=1&id=<%=list.get(i).getG_intProjectId() %>">详细</a></td>
</tr>
<%}
}
} 
%>
</table>
<br />
<table width="98%" align="center" border="0" cellpadding="4" cellspacing="1" bgcolor="#CBD8AC"  style="margin-bottom:8px">
<tr bgcolor="#EEF4EA">
<td colspan="2" bgcolor="#CBD8AC"  class='title'><span>已暂停项目</span></td>
</tr>
<tr>
<td width="9%" align="center" background="page/PMO/skin/images/frame/wbg.gif">项目ID</td>
<td width="10%" align="center" background="page/PMO/skin/images/frame/wbg.gif">项目名称</td>
<td width="10%" align="center" background="page/PMO/skin/images/frame/wbg.gif">项目编号</td>
<td width="10%" align="center" background="page/PMO/skin/images/frame/wbg.gif">项目经理</td>
<td width="9%" align="center" background="page/PMO/skin/images/frame/wbg.gif">项目状态</td>
<td width="19%" align="center" background="page/PMO/skin/images/frame/wbg.gif">项目开始时间</td>
<td width="18%" align="center" background="page/PMO/skin/images/frame/wbg.gif">项目停止时间</td>
<td width="10%" align="center" background="page/PMO/skin/images/frame/wbg.gif">操作</td>
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
<td align="center"><%=change.getUserName(con,list.get(i).getG_intProjectManager()) %></td>
<td align="center">已暂停</td>
<td align="center"><%=list.get(i).getG_timProjectBeginTime() %></td>
<td align="center">无</td>
<td align="center"><a href="ProjectStaForPMOServlet?flag=2&status=2&id=<%=list.get(i).getG_intProjectId() %>">详细</a></td>
</tr>
<%}
} 
}
%>
</table>
<br />
<table width="98%" align="center" border="0" cellpadding="4" cellspacing="1" bgcolor="#CBD8AC"  style="margin-bottom:8px">
<tr bgcolor="#EEF4EA">
<td colspan="2" bgcolor="#CBD8AC"  class='title'><span>正在进行项目</span></td>
</tr>
<tr>
<td width="9%" align="center" background="page/PMO/skin/images/frame/wbg.gif">项目ID</td>
<td width="10%" align="center" background="page/PMO/skin/images/frame/wbg.gif">项目名称</td>
<td width="10%" align="center" background="page/PMO/skin/images/frame/wbg.gif">项目编号</td>
<td width="10%" align="center" background="page/PMO/skin/images/frame/wbg.gif">项目经理</td>
<td width="9%" align="center" background="page/PMO/skin/images/frame/wbg.gif">项目状态</td>
<td width="19%" align="center" background="page/PMO/skin/images/frame/wbg.gif">项目开始时间</td>
<td width="18%" align="center" background="page/PMO/skin/images/frame/wbg.gif">项目停止时间</td>
<td width="10%" align="center" background="page/PMO/skin/images/frame/wbg.gif">操作</td>
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
<td align="center"><%=change.getUserName(con,list.get(i).getG_intProjectManager()) %></td>
<td align="center">正在进行</td>
<td align="center"><%=list.get(i).getG_timProjectBeginTime() %></td>
<td align="center">
<%if(list.get(i).getG_timProjectEndTime()==null){ %>无
<%}else{ %><%=list.get(i).getG_timProjectEndTime() %>
<%} %>
</td>
<td align="center"><a href="ProjectStaForPMOServlet?flag=2&status=3&id=<%=list.get(i).getG_intProjectId() %>">详细</a></td>
</tr>
<%}
} 
}
con.close();
%>
</table>
</body>
</html>