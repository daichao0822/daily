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

		<title>更改密码</title>
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
		alert("原密码不能为空！");
		exit;
	} else if (newPassword == "") {
		alert("新密码不能为空！");
		exit;
	} else if (newPassword1 == "") {
		alert("再输入不能为空！");
		exit;
	} else if (newPassword != newPassword1) {
		alert("两次输入密码不一致，请重新输入！");
		exit;
	} else {
	   if(confirm("确认修改密码？")){
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
			   alert("不能创建XMLHttpRequest对象实例");
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
				alert("原密码错误，修改密码失败！");
				window.close();
			} else if (http_request.responseText == 1) {
				alert("修改密码成功！");
				window.close();
			}
		} else {
			alert("您所请求的页面有异常");
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
						&nbsp;&nbsp;修改密码
					</h2>
				</td>
			</tr>
		</table>
		<form name="form">
			<table align="center">
				<tr>
					<td valign="top">
					原密码：
					</td>
					<td valign="top">
						<input type="password" name="password" id="password" />
					</td>
				</tr>
				<tr>
					<td valign="top">
					新密码：
					</td>
					<td valign="top">
					<input type="password" name="newPassword" id="newPassword" />
					</td>
				</tr>
				<tr>
					<td valign="top">
					再输入：
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
						<input type="button" name="button" id="button" value="确定"
							onClick="changePassword();" />
						&nbsp;
						<input type="reset" value="重置">
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>
