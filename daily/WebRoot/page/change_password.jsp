<%@ page language="java" import="java.util.*" import="com.bean.User"
	pageEncoding="gb2312"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>��������</title>
		<base target="_self">
			<link rel="stylesheet" type="text/css"
				href="page/skin/css/base.css" />
			<link rel="stylesheet" type="text/css"
				href="page/skin/css/main.css" />
			<style type="text/css">
<!--
body {
	background-image: url(page/images/login_07.gif);
}
-->
</style>
	</head>
	<script type="text/javascript">
function changePassword() {
	var userId = document.getElementById("userId").value;
	var password = document.getElementById("password").value;
	var newPassword = document.getElementById("newPassword").value;
	var newPassword1 = document.getElementById("newPassword1").value;

	if (password == "") {
		alert("ԭ���벻��Ϊ�գ�");
		exit;
	} else if (newPassword == "") {
		alert("�����벻��Ϊ�գ�");
		exit;
	} else if (newPassword1 == "") {
		alert("�����벻��Ϊ�գ�");
		exit;
	} else if (newPassword != newPassword1) {
		alert("�����������벻һ�£����������룡");
		exit;
	} else {
	   if(confirm("ȷ���޸����룿")){
		   var url = "ChangePasswordServlet?userId=" + userId + "&password="
			    	+ password + "&newPassword=" + newPassword;
		   if (window.XMLHttpRequest) {
			   http_request = new XMLHttpRequest();
			   if (http_request.overrideMimeType) {
				   http_request.overrideMimeType("text/xml");
			   }
		   } else if (window.ActiveXObject) {
			   try {
				   http_request = new ActiveXObject("Msxml2.XMLHTTP");
			   } catch (e) {
				   try {
					   http_request = new ActiveXObject("Microsoft.XMLHTTP");

				   } catch (e2) {
					   http_request = false;
				   }
			   }
		   }
		   if (!http_request) {
			   alert("���ܴ���XMLHttpRequest����ʵ��");
			   return false;
		   } else {
			   http_request.open("GET", url, true);
			   http_request.onreadystatechange = updatepage;
			   http_request.send(null);
		   }
	    }
	}
}

function updatepage() {
	if (http_request.readyState == 4) {
		if (http_request.status == 200) {
			if (http_request.responseText == 0) {
				alert("ԭ��������޸�����ʧ�ܣ�");
				window.close();
			} else if (http_request.responseText == 1) {
				alert("�޸�����ɹ���");
				window.close();
			}
		} else {
			alert("���������ҳ�����쳣");
			window.close();
		}
	}
}
</script>
	<body bgcolor="#D1DDAA">
		<%
			User user = new User();
			int userId = user.getG_intUserId();
		%>
		<table align="center">
			<tr>
				<td>
					<input type="hidden" id="userId" value=<%=userId%>>
				</td>
			</tr>
			<tr align="center">
				<td>
					<h2>
						&nbsp;&nbsp;�޸�����
					</h2>
				</td>
			</tr>
		</table>
		<form name="form">
			<table align="center">
				<tr>
					<td valign="top">
					ԭ���룺
					</td>
					<td valign="top">
						<input type="password" name="password" id="password" />
					</td>
				</tr>
				<tr>
					<td valign="top">
					�����룺
					</td>
					<td valign="top">
					<input type="password" name="newPassword" id="newPassword" />
					</td>
				</tr>
				<tr>
					<td valign="top">
					�����룺
					</td>
					<td valign="top">
					<input type="password" name="newPassword1" id="newPassword1" />
					</td>
				</tr>
				<tr>
					<td valign="top">
					&nbsp;
					</td>
					<td valign="top">
					&nbsp;&nbsp;
						<input type="button" name="button" id="button" value="ȷ��"
							onClick="changePassword();" />
						&nbsp;
						<input type="reset" value="����">
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>
