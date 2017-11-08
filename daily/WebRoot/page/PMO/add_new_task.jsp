<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>创建新项目</title>
<base target="_self">
<link rel="stylesheet" type="text/css" href="./skin/css/base.css" />
<link rel="stylesheet" type="text/css" href="./skin/css/main.css" />
<style type="text/css">
<!--
body {
	background-image: url(../images/login_07.gif);
}
-->
</style>
<script type="text/javascript">
function check(){
	var taskName=document.getElementById("taskName").value;
	var taskType=document.getElementById("taskType").value;
	if(taskName==""){
		alert("任务名称不能为空！");
		exit;
	}
	else if(taskName.length>40){
		alert("任务名称不能超过40字符！");
		exit;
	}
	else{
		if(confirm("确认提交吗？")){
		    var url = "../../TaskManageServlet?flag=3&n=" + taskName + "&t="
			    	+ taskType;
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
			   http_request.open("POST", url, true);
			   http_request.onreadystatechange = updatepage;
			   http_request.send(null);
		   }
		}
	}
}

function updatepage() {
	if (http_request.readyState == 4) {
		if (http_request.status == 200) {
			if (http_request.responseText == 1) {
				alert("任务名称已经存在，请修改！");
				document.getElementById("projectName").focus();
			} else if(http_request.responseText == 2){
				alert("添加任务失败！");
				window.close();
			} else if (http_request.responseText == 3) {
				alert("添加任务成功！");
				opener.location.reload();
				window.close();
			}else if (http_request.responseText == 4) {
			    alert("程序异常，请联系管理员（错误页面：add_new_task.jsp）");
			}else if (http_request.responseText == 5){
			    alert("错误！您不能继续操作，可能原因：1、session超时  2、您已退出  3、您的账号已在别处登录，请重新登录");
			    window.close();
			    opener.top.location.replace("http://localhost/daily");
			}
		} else {
			alert("您所请求的页面有异常");
			window.close();
		}
	}
}

function closeWindow(){
	if(confirm("确定放弃创建新任务并关闭窗口吗？")){
		window.close();
	}
}
</script>
</head>

<body>
<%
if(session.getAttribute("userInfo")==null){
	%>
	<script type="text/javascript">
	alert("session超时或您已退出，请重新登录");
	opener.top.location.replace("http://localhost/daily");
	window.close();
	</script>
	<%
	return;
}
 %>
<table width="100%">
<tr>
<td align="center"><font size="+2">创建新任务</font></td>
</tr>
</table>
<br />
<table width="100%" border="1">
<tr>
<td width="7%" align="center">任务名称</td>
<td width="15%" align="center"><input type="text" name="taskName" id="taskName" /></td>
<td width="11%" align="center">任务类型</td>
<td width="15%" align="center">
<select name="taskType" id="taskType">
<option value="1">项目任务</option>
<option value="0">临时任务</option>
</select>
</td>
</tr>
</table>
<table width="100%">
<tr>
<td align="center">
<input type="button" name="button" value="提交" onclick="check()"  />&nbsp;
<input type="button" name="button1" value="关闭" onclick="closeWindow()" /></td>
</tr>
</table>
</body>
</html>