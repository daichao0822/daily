<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*,java.util.*,com.bean.*,com.dao.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>添加项目任务</title>
<base target="_self">
<link rel="stylesheet" type="text/css" href="page/manager/skin/css/base.css" />
<link rel="stylesheet" type="text/css" href="page/manager/skin/css/main.css" />
</head>
<script type="text/javascript">
function ConfirmAdd(){
	var s=document.getElementsByName("taskID");
	var i=0;
	for(i=0;i<s.length;i++){
		if(s[i].checked){
			if(confirm("确认添加任务吗？")){
				return true;
			}
			else{
				return false;
			}
		}
	}
	if(i==s.length){
		alert("至少选择一个任务！");
		return false;
	}
}

function CloseWindow(){
	window.close();
}
</script>
<body>
<%
List<Task> list=(List<Task>)request.getAttribute("task");
int int_projectID=Integer.parseInt(request.getParameter("pid"));
ChangeIDForName change=new ChangeIDForName();
Connection con=Connect.getConnection();
String str_projectName=change.getProjectName(con,int_projectID);
 %>
 <form name="form" action="AddTaskForProjectServlet?flag=2" method="post" onsubmit="return ConfirmAdd()">
<table width="98%" align="center" border="0" cellpadding="4" cellspacing="1" bgcolor="#CBD8AC"  style="margin-bottom:8px">
<tr bgcolor="#EEF4EA">
<td colspan="2" bgcolor="#CBD8AC"  class='title'><span>项目详细</span></td>
</tr>
<tr>
<td width="9%" align="center" background="page/PMO/skin/images/frame/wbg.gif">选择</td>
<td width="19%" align="center" background="page/PMO/skin/images/frame/wbg.gif">任务ID</td>
<td width="25%" align="center" background="page/PMO/skin/images/frame/wbg.gif">任务名称</td>
<td width="24%" align="center" background="page/PMO/skin/images/frame/wbg.gif">任务类型</td>
<td width="23%" align="center" background="page/PMO/skin/images/frame/wbg.gif">添加项目<input type="hidden" name="projectID" id="projectID" value="<%=int_projectID %>" /></td>
</tr>
<%
if(list!=null){
    for(int i=0;i<list.size();i++){
 %>
<tr bgcolor="#FFFFFF">
<td align="center"><input type="checkbox" name="taskID" id="taskID" value="<%=list.get(i).getG_intTaskId() %>" /></td>
<td align="center"><%=list.get(i).getG_intTaskId() %></td>
<td align="center"><%=list.get(i).getG_strTaskName() %></td>
<td align="center">项目任务</td>
<td align="center"><%=str_projectName %></td>
</tr>
<%
    }
}
else{
 %>
<tr bgcolor="#FFFFFF">
<td>&nbsp;</td>
<td>&nbsp;</td>
<td align="center"><font color="#FF0000">没有后备任务供选择，请先添加任务！</font></td>
<td align="center">&nbsp;</td>
<td align="center">&nbsp;</td>
</tr>
<%} %>
</table>
<%con.close(); %>
<table width="98%" align="center">
  <tr>
<td align="center">
<input type="submit" value="确定" />&nbsp;<input type="button" name="button" value="关闭" onclick="CloseWindow()" />
</td>
</tr>
</table>
</form>
</body>
</html>