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

		<title>����Email</title>
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
		alert("����дE_mail��");
		exit;
	} else if (email.length>40) {
		alert("E_mail�ܳ��Ȳ��ܳ���40���ַ���");
		exit;
	} else if (!myreg.test(email)) {
		alert("��������Ч��E_mail!");
		exit;
	} else {
	   if(confirm("ȷ���ύ�룿")){
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
				alert("����E_mailʧ�ܣ�����ϵ����Ա��");
				window.close();
			} else if (http_request.responseText == 1) {
				alert("����E_mail�ɹ���");
				opener.location.reload();
				window.close();
			} else if(http_request.responseText == 2){
			    alert("���������ܼ�������������ԭ��1��session��ʱ  2�������˳�  3�������˺����ڱ𴦵�¼�������µ�¼");
				window.close();
				opener.top.location.href="http://localhost/daily";
			}
			  else{
				alert("ϵͳ��������ϵ����Ա��add_email.jsp:90��");
			}
		} else {
			alert("���������ҳ�����쳣");
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
					&nbsp;&nbsp;����Email </h2>
				</td>
			</tr>
		</table>
		<form name="form">
			<table align="center">
				<tr>
					<td valign="top">
					������Email��
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
						<input type="button" name="button" id="button" value="ȷ��"
							onClick="addEmail();" />
						&nbsp;
						<input type="reset" value="����">
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>
