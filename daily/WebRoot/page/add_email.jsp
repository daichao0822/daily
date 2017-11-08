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

		<title>添加Email</title>
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
function addEmail() {
	var email = document.getElementById("email").value;
	var myreg=/^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/;
	if (email == "") {
		alert("请填写E_mail！");
		exit;
	} else if (email.length>40) {
		alert("E_mail总长度不能超过40个字符！");
		exit;
	} else if (!myreg.test(email)) {
		alert("请输入有效的E_mail!");
		exit;
	} else {
	   if(confirm("确认提交码？")){
		   var url = "ChangeEmailServlet?e=" + email + "&flag=1";
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
				alert("添加E_mail失败，请联系管理员！");
				window.close();
			} else if (http_request.responseText == 1) {
				alert("添加E_mail成功！");
				opener.location.reload();
				window.close();
			} else{
				alert("系统错误，请联系管理员（add_email.jsp:85）");
			}
		} else {
			alert("您所请求的页面有异常");
			window.close();
		}
	}
}
</script>
	<body bgcolor="#D1DDAA">
		<table align="center">
			<tr align="center">
				<td>
					<h2>
					&nbsp;&nbsp;添加Email </h2>
				</td>
			</tr>
		</table>
		<form name="form">
			<table align="center">
				<tr>
					<td valign="top">
					输入Email：
					</td>
					<td valign="top">
					<input type="text" name="email" id="email" />
					</td>
				</tr>
				<tr>
					<td valign="top">&nbsp;
					
					</td>
					<td valign="top">
					&nbsp;&nbsp;
						<input type="button" name="button" id="button" value="确定"
							onClick="addEmail();" />
						&nbsp;
						<input type="reset" value="重置">
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>
