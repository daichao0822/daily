<%@ page contentType="text/html; charset=gb2312" language="java"
	import="java.sql.*,java.util.*,com.bean.*,com.dao.*" errorPage=""%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
		<title>�ձ���ѯ</title>
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
			alert("��ѡ��ʼʱ�䣡");
			return false;
		} else if (endTime == "") {
			alert("��ѡ���ֹʱ�䣡");
			return false;
		}
		var strdt1 = startTime.replace(/-/g, "/");
		var strdt2 = endTime.replace(/-/g, "/");
		var dt1 = new Date(Date.parse(strdt1));
		var dt2 = new Date(Date.parse(strdt2));
		if (dt1 > dt2) {
			alert("��ʼ���ڴ��ڽ�ֹ���ڣ�");
			return false;
		} else {
			return true;
		}
	} catch (e) {
		alert("��ʽ����" + e);
	}
}

function CheckTask() {
	var projectName = document.getElementById("projectName").value;
	var projectID = document.getElementById("projectID").value;
	var taskName = document.getElementById("taskName").value;
	var taskID = document.getElementById("taskID").value;

	if (projectName == "") {
		alert("��ѡ����Ŀ��");
		return false;
	} else if (taskName == "") {
		alert("��ѡ������");
		return false;
	} else if (projectID == "") {
		alert("��ͨ����ťѡ����Ŀ��");
		return false;
	} else if (taskID == "") {
		alert("��ͨ����ťѡ������");
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
		alert("��ѡ����Ŀ");
		exit;
	}
	else if(projectID==""){
		alert("��ͨ����ťѡ����Ŀ");
		exit;
	}
	else{
		window.open("page/PMO/select_task.jsp?pid="+projectID,"selectTask","directories=no,left=500,top=250,height=250,width=550,location=yes,menubar=no,resizable=yes,scrollbars=yes,status=yes,toolbar=no",false);
	}
}

function CheckProject(){
	var project=document.getElementById("project").value;
	if(project==-1){
		alert("û����Ŀ��ѡ�񣬲��ܲ�ѯ");
		return false;
	}
	else{
		return true;
	}
}

function CheckProjectUser(){
	var user=document.getElementById("projectUser").value;
	if(user==-1){
		alert("û����Ա��ѡ�񣬲��ܲ�ѯ");
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
					<strong>�ձ���ѯ</strong>
				</td>
			</tr>
		</table>
		<br />
		<form id="form1" name="form1"
			action="DailyQueryForPMOServlet" method="post" onsubmit="return CheckProject()">
			<table width="100%" border="1">
				<tr>
					<td align="center" width="19%">
						<font size="+1" color="#669900"><strong>����Ŀ��ѯ</strong> </font>
					</td>
					<td width="81%" align="left">
						��ѡ����Ŀ��&nbsp;
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
%><option value="-1">û����Ŀ��ѡ��</option><%
}
 %>
						</select>
						&nbsp;
						<input type="hidden" id="flag1" name="flag" value="2" />
						<!--���̨����flagֵ�Ա���ѯ��ʽ-->
						<input type="submit" value="��ѯ" />
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
						<font size="+1" color="#669900"><strong>���ύ���ڲ�ѯ</strong> </font>
					</td>

					<td width="81%" align="left">
						��ʼ���ڣ�&nbsp;
						<input type="text" id="startTime" name="startTime" class="Wdate"
							onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',maxDate:'%y-%M-%d %H:%m:%s'})" />
						&nbsp;
						<!--WdatePicker()�����пɼ���{dateFmt:'yyyy-MM-dd HH:mm'}���ƶ�ʱ���ʽ-->
						��ֹ���ڣ�&nbsp;
						<input type="text" id="endTime" name="endTime" class="Wdate"
							onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',maxDate:'%y-%M-%d %H:%m:%s'})" />
						&nbsp;
						<input type="hidden" id="flag2" name="flag" value="3" />
						<!--���̨����flagֵ�Ա���ѯ��ʽ-->
						<input type="submit" value="��ѯ" />
						&nbsp;&nbsp;
						<font color="#FF0000" size="-1">��ʼ���ڲ��ܴ��ڽ�ֹ����</font>
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
						<font size="+1" color="#669900"><strong>�������ѯ</strong> </font>
					</td>
					<td width="81%" align="left">
						��ѡ����Ŀ��&nbsp;
						<input type="text" name="projectName" id="projectName" />
						&nbsp;
						<input type="hidden" name="projectID" id="projectID" />
						<input type="button" value="ѡ����Ŀ"
							onclick="SelectProject()" />
						&nbsp;
						<input type="text" name="taskName" id="taskName" />
						&nbsp;
						<input type="hidden" name="taskID" id="taskID" />
						<input type="button" value="ѡ������" onclick="SelectTask()" />
						&nbsp;
						<input type="hidden" id="flag3" name="flag" value="4" />
						<!--���̨����flagֵ�Ա���ѯ��ʽ-->
						<input type="submit" value="��ѯ" />
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
						<font size="+1" color="#669900"><strong>����Ա��ѯ</strong> </font>
					</td>

					<td width="81%" align="left">
						��ѡ����Ŀ��Ա��&nbsp;
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
%><option value="-1">û����Ŀ��Ա��ѡ��</option><%
}
 %>

						</select>
						&nbsp;
						<input type="hidden" id="flag4" name="flag" value="5" />
						<!--���̨����flagֵ�Ա���ѯ��ʽ-->
						<input type="submit" value="��ѯ" />&nbsp;
						<font color="red" size="-1">ֻ�ܲ�ѯ���û���Ŀ�ձ�</font>
					</td>
				</tr>
			</table>
			<br />
			<table width="100%" border="0" cellspacing="1" cellpadding="1">
				<tr>
					<td>
						<div align="center">
							<input type="button" value="����" onclick="goBack()" />
						</div>
					</td>
				</tr>
			</table>

		</form>
	</body>
</html>