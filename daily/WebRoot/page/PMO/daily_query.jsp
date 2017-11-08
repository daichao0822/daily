<%@ page contentType="text/html; charset=gb2312" language="java"
	import="java.sql.*,java.util.*,com.bean.*,com.dao.*" errorPage=""%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
		<title>日报查询</title>
		<link type="text/css" rel="stylesheet" href="../page/css/tableBorder.css" />
		<base target="_self">
			<link rel="stylesheet" type="text/css"
				href="page/manager/skin/css/base.css" />
			<link rel="stylesheet" type="text/css"
				href="page/manager/skin/css/main.css" />
			<style type="text/css">
<!--
body {
	background-image: url(page/images/login_07.gif);
}
-->
</style>
<script type="text/javascript" src="${pageContext.request.contextPath }/My97DatePicker/WdatePicker.js"> </script>
<script type="text/javascript">
function checkDate() {
	try {
		var startTime = document.getElementById("startTime").value;
		var endTime = document.getElementById("endTime").value;
		if (startTime == "") {
			alert("请选择开始时间！");
			return false;
		} else if (endTime == "") {
			alert("请选择截止时间！");
			return false;
		}
		var strdt1 = startTime.replace(/-/g, "/");
		var strdt2 = endTime.replace(/-/g, "/");
		var dt1 = new Date(Date.parse(strdt1));
		var dt2 = new Date(Date.parse(strdt2));
		if (dt1 > dt2) {
			alert("开始日期大于截止日期！");
			return false;
		} else {
			return true;
		}
	} catch (e) {
		alert("格式错误" + e);
	}
}

function CheckTask() {
	var projectName = document.getElementById("projectName").value;
	var projectID = document.getElementById("projectID").value;
	var taskName = document.getElementById("taskName").value;
	var taskID = document.getElementById("taskID").value;

	if (projectName == "") {
		alert("请选择项目！");
		return false;
	} else if (taskName == "") {
		alert("请选择任务！");
		return false;
	} else if (projectID == "") {
		alert("请通过按钮选择项目！");
		return false;
	} else if (taskID == "") {
		alert("请通过按钮选择任务！");
		return false;
	} else {
		return true;
	}
}

function SelectProject() {
	window
			.open(
					"page/PMO/select_project.jsp",
					"selectProject",
					"directories=no,left=500,top=250,height=250,width=550,location=yes,menubar=no,resizable=yes,scrollbars=yes,status=yes,toolbar=no",
					false);
}

function SelectTask() {
	var projectName = document.getElementById("projectName").value;
	var projectID = document.getElementById("projectID").value;
if(projectName==""){
		alert("请选择项目");
		exit;
	}
	else if(projectID==""){
		alert("请通过按钮选择项目");
		exit;
	}
	else{
		window.open("page/PMO/select_task.jsp?pid="+projectID,"selectTask","directories=no,left=500,top=250,height=250,width=550,location=yes,menubar=no,resizable=yes,scrollbars=yes,status=yes,toolbar=no",false);
	}
}

function CheckProject(){
	var project=document.getElementById("project").value;
	if(project==-1){
		alert("没有项目供选择，不能查询");
		return false;
	}
	else{
		return true;
	}
}

function CheckProjectUser(){
	var user=document.getElementById("projectUser").value;
	if(user==-1){
		alert("没有人员供选择，不能查询");
		return false;
	}
	else{
		return true;
	}
}

function goBack(){
	window.history.back();
}
</script>
	</head>
	<body>
		<%
List<Project> project=(List<Project>)request.getAttribute("project");
List<User> user=(List<User>)request.getAttribute("user");
%>
		<br />
		<table width="100%">
			<tr>
				<td align="center">
					<strong>日报查询</strong>
				</td>
			</tr>
		</table>
		<br />
		<form id="form1" name="form1"
			action="DailyQueryForPMOServlet" method="post" onsubmit="return CheckProject()">
			<table width="100%" border="1">
				<tr>
					<td align="center" width="19%">
						<font size="+1" color="#669900"><strong>按项目查询</strong> </font>
					</td>
					<td width="81%" align="left">
						请选择项目：&nbsp;
						<select name="project" id="project">
							<%
if(project!=null){
for(int i=0;i<project.size();i++){
%>
							<option value="<%=project.get(i).getG_intProjectId() %>"><%=project.get(i).getG_strProjectName() %></option>
							<%
 }
}
else{
%><option value="-1">没有项目供选择</option><%
}
 %>
						</select>
						&nbsp;
						<input type="hidden" id="flag1" name="flag" value="2" />
						<!--向后台传递flag值以辨别查询方式-->
						<input type="submit" value="查询" />
						&nbsp;&nbsp;
					</td>
				</tr>
			</table>
		</form>
		<br />
		<form id="form2" name="form2"
			action="DailyQueryForPMOServlet"
			onsubmit="return checkDate();" method="post">
			<table width="100%" border="1">
				<tr>
					<td width="19%" align="center">
						<font size="+1" color="#669900"><strong>按提交日期查询</strong> </font>
					</td>

					<td width="81%" align="left">
						开始日期：&nbsp;
						<input type="text" id="startTime" name="startTime" class="Wdate"
							onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',maxDate:'%y-%M-%d %H:%m:%s'})" />
						&nbsp;
						<!--WdatePicker()括号中可加入{dateFmt:'yyyy-MM-dd HH:mm'}来制定时间格式-->
						截止日期：&nbsp;
						<input type="text" id="endTime" name="endTime" class="Wdate"
							onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',maxDate:'%y-%M-%d %H:%m:%s'})" />
						&nbsp;
						<input type="hidden" id="flag2" name="flag" value="3" />
						<!--向后台传递flag值以辨别查询方式-->
						<input type="submit" value="查询" />
						&nbsp;&nbsp;
						<font color="#FF0000" size="-1">开始日期不能大于截止日期</font>
					</td>
				</tr>
			</table>
		</form>
		<br />
		<form id="form3" name="form3"
			action="DailyQueryForPMOServlet"
			onsubmit="return CheckTask()" method="post">
			<table width="100%" border="1">
				<tr>
					<td width="19%" align="center">
						<font size="+1" color="#669900"><strong>按任务查询</strong> </font>
					</td>
					<td width="81%" align="left">
						请选择项目：&nbsp;
						<input type="text" name="projectName" id="projectName" />
						&nbsp;
						<input type="hidden" name="projectID" id="projectID" />
						<input type="button" value="选择项目"
							onclick="SelectProject()" />
						&nbsp;
						<input type="text" name="taskName" id="taskName" />
						&nbsp;
						<input type="hidden" name="taskID" id="taskID" />
						<input type="button" value="选择任务" onclick="SelectTask()" />
						&nbsp;
						<input type="hidden" id="flag3" name="flag" value="4" />
						<!--向后台传递flag值以辨别查询方式-->
						<input type="submit" value="查询" />
					</td>
				</tr>
			</table>
		</form>
		<br />
		<form id="form4" name="form4"
			action="DailyQueryForPMOServlet"
			onsubmit="return CheckProjectUser()" method="post">
			<table width="100%" border="1">
				<tr>
					<td width="19%" align="center">
						<font size="+1" color="#669900"><strong>按人员查询</strong> </font>
					</td>

					<td width="81%" align="left">
						请选择项目人员：&nbsp;
						<select name="projectUser" id="projectUser">
							<%
if(user!=null){
for(int i=0;i<user.size();i++){
%>
							<option value="<%=user.get(i).getG_intUserId() %>"><%=user.get(i).getG_strUserName() %></option>
							<%
}
}
else{
%><option value="-1">没有项目人员供选择</option><%
}
 %>

						</select>
						&nbsp;
						<input type="hidden" id="flag4" name="flag" value="5" />
						<!--向后台传递flag值以辨别查询方式-->
						<input type="submit" value="查询" />&nbsp;
						<font color="red" size="-1">只能查询该用户项目日报</font>
					</td>
				</tr>
			</table>
			<br />
			<table width="100%" border="0" cellspacing="1" cellpadding="1">
				<tr>
					<td>
						<div align="center">
							<input type="button" value="返回" onclick="goBack()" />
						</div>
					</td>
				</tr>
			</table>

		</form>
	</body>
</html>