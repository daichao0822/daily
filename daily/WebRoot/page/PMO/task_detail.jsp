<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*,java.util.*,com.bean.*,com.dao.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>������ϸ</title>
<base target="_self">
<link rel="stylesheet" type="text/css" href="page/PMO/skin/css/base.css" />
<link rel="stylesheet" type="text/css" href="page/PMO/skin/css/main.css" />
</head>
<body>
<%
ProjectTaskAssign list=(ProjectTaskAssign)request.getAttribute("assign");
Task task=(Task)request.getAttribute("task");
int int_projectID=Integer.parseInt(request.getParameter("pid"));
ChangeIDForName change=new ChangeIDForName();
Connection con=Connect.getConnection();
String str_projectName=change.getProjectName(con,int_projectID);
 %>
<table width="98%" align="center" border="0" cellpadding="4" cellspacing="1" bgcolor="#CBD8AC"  style="margin-bottom:8px">
<tr bgcolor="#EEF4EA">
<td colspan="2" bgcolor="#CBD8AC"  class='title'><span>������ϸ</span></td>
</tr>
<tr>
<td width="5%" align="center" background="page/PMO/skin/images/frame/wbg.gif">����ID</td>
<td width="8%" align="center" background="page/PMO/skin/images/frame/wbg.gif">��������</td>
<td width="10%" align="center" background="page/PMO/skin/images/frame/wbg.gif">������Ŀ</td>
<td width="6%" align="center" background="page/PMO/skin/images/frame/wbg.gif">ִ����</td>
<td width="14%" align="center" background="page/PMO/skin/images/frame/wbg.gif">��ʼʱ��</td>
<td width="15%" align="center" background="page/PMO/skin/images/frame/wbg.gif">�������ʱ��</td>
<td width="14%" align="center" background="page/PMO/skin/images/frame/wbg.gif">��ʱ</td>
<td width="6%" align="center" background="page/PMO/skin/images/frame/wbg.gif">ȷ����</td>
<td width="22%" align="center" background="page/PMO/skin/images/frame/wbg.gif">ȷ�����</td>
</tr>
<%
if(task!=null){
    if(list!=null){
 %>
<tr bgcolor="#FFFFFF">
<td align="center"><%=list.getG_int_task() %></td>
<td align="center"><%=change.getTaskName(con,list.getG_int_task()) %></td>
<td align="center"><%=change.getProjectName(con,list.getG_int_project()) %></td>
<td align="center"><%=change.getUserName(con,list.getG_int_exec_user()) %></td>
<td align="center"><%=list.getG_tim_begin_time() %></td>
<td align="center"><%=list.getG_tim_end_time() %></td>
<td align="center">
<%=list.getG_int_work_time()/86400 %>��&nbsp;
<%=(list.getG_int_work_time()%86400)/3600 %>ʱ&nbsp;
<%=(list.getG_int_work_time()%3600)/60 %>��&nbsp;
<%=list.getG_int_work_time()%60 %>��
</td>
<td align="center"><%=change.getUserName(con,list.getG_int_confirm_user()) %>
</td>
<td align="center"><%=list.getG_str_opinion() %></td>
</tr>
<% 
    }
    else{
    %>
<tr bgcolor="#FFFFFF">
<td align="center"><%=task.getG_intTaskId() %></td>
<td align="center"><%=task.getG_strTaskName() %></td>
<td align="center"><%=str_projectName %></td>
<td align="center">&nbsp;</td>
<td align="center">&nbsp;</td>
<td align="center">&nbsp;</td>
<td align="center">&nbsp;</td>
<td align="center">&nbsp;</td>
<td align="center">&nbsp;</td>
</tr>
    <%
    }
}
else{
%>
<tr bgcolor="#FFFFFF">
<td align="center">&nbsp;</td>
<td align="center">&nbsp;</td>
<td align="center">&nbsp;</td>
<td align="center">&nbsp;</td>
<td align="center">&nbsp;</td>
<td align="center">&nbsp;</td>
<td align="center">&nbsp;</td>
<td align="center">&nbsp;</td>
<td align="center"><font color="red">�����񲻴��ڣ�</font></td>
</tr>
<%
}
con.close();
%>
</table>
<table width="98%" align="center" border="0" cellpadding="4" cellspacing="1"  style="margin-bottom:8px">
<tr>
<td align="center"><input type="button" value="�ر�" onclick="window.close()" /></td>
</tr>
</table>
</body>
</html>