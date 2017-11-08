<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*,com.bean.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>回复</title>
		<base target="_self">
			<link rel="stylesheet" type="text/css"
				href="./skin/css/base.css" />
			<link rel="stylesheet" type="text/css"
				href="./skin/css/main.css" />
			<style type="text/css">
<!--
body {
	background-image: url(images/login_07.gif);
}
-->
</style>
<script type="text/javascript">
function check(){
	var dailyID=document.getElementById("dailyID").value;
	var userID=document.getElementById("userID").value;
	var time=document.getElementById("time").value;
	var reply=document.getElementById("reply").value;
	var image=document.getElementById("image").value;
	if(reply==""){
		alert("回复内容不能为空！");
		exit;
	}
	else{
		if(confirm("确认提交吗？")){
		    var url = "../DailyReplyServlet?userID=" + userID + "&dailyID="
			    	+ dailyID + "&time=" + time+"&reply="+reply+"&image="+image;
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
			if (http_request.responseText == 0) {
				alert("回复失败！");
				window.close();
			} else if (http_request.responseText == 1) {
				alert("回复成功！点击确定查看回复");
				opener.location.reload();
				window.close();
			}else if(http_request.responseText == 2){
			    alert("错误！您不能继续操作，可能原因：1、session超时  2、您已退出  3、您的账号已在别处登录，请重新登录");
			    window.close();
			    opener.top.location.replace("http://localhost/daily");
			}
			else{
			alert("程序异常，请联系管理员（错误页面：daily_reply.jsp：78");
			}
		} else {
			alert("您所请求的页面有异常");
			window.close();
		}
	}
}

function uploadImage(){
    window.open("upload.htm","uploadImge","directories=no,left=500,top=250,height=130,width=550,location=no,menubar=no,resizable=yes,scrollbars=yes,status=no,toolbar=no",false);
}

function closeWindow(){
	if(confirm("确定放弃回复并关闭窗口吗？")){
		window.close();
	}
}
</script>
</head>

<body>
<%
String str_id=request.getParameter("id");
User user= new User();
if(session.getAttribute("userInfo")==null){
%>
<script type="text/javascript">
alert("错误！您不能继续操作，可能原因：1、session超时  2、您已退出  3、您的账号已在别处登录，请重新登录");
opener.top.location.replace("http://localhost/daily");
window.close();
</script>
<%
return;
}
user=(User)session.getAttribute("userInfo");
String str_userName=user.getG_strUserName();
int int_userID=user.getG_intUserId();

java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 
java.util.Date currentTime = new java.util.Date();//得到当前系统时间 
String strDate = formatter.format(currentTime); //将日期时间格式化
String str_Date=strDate.replaceAll(" ","_");//将strDate字符串中的空格替换成_
 %>
<table width="100%">
<tr>
<td align="center">回复日报</td>
</tr>
</table>
<br />
<table width="100%" border="1">
<tr>
<td width="12%" align="center">日报ID</td>
<td width="18%" align="center">
<input type="hidden" name="dailyID" id="dailyID" value="<%=str_id %>" /><!-- 隐藏提交日报ID -->
<input type="hidden" name="image" id="image" value="" /><!-- 隐藏提交图片名称 -->
<%=str_id%>
</td>
<td width="12%" align="center">作者</td>
<td width="19%" align="center">
<input type="hidden" name="userID" id="userID" value="<%=int_userID%>" />
<%=str_userName%></td>
<td width="14%" align="center">回复时间</td>
<td width="25%" align="center">
<input type="hidden" name="time" id="time" value="<%=str_Date%>" />
<%=strDate%>
</td>
</tr>
</table>
<table width="100%" border="1">
<tr>
<td align="center">回复内容<br />(<font size="-1" color="#FF0000">2000字符以内</font>)</td>
<td><textarea name="reply" id="reply" cols="70" rows="5"></textarea></td>
</tr>
</table>
<table width="100%">
<tr>
<td align="center">
<input type="button" name="button" value="提交" onclick="check()"  />&nbsp;
<input type="button" name="button1" value="关闭" onclick="closeWindow()" /></td>
</tr>
</table>
<table border="0">
<tr>
<td align="left"><input type="button" name="uploadImage" value="上传图片" onclick="uploadImage()" />&nbsp;<font color="red">只支持jpg、bmp、gif格式图片，大小不超过100KB</font></td>
</tr>
<tr>
<td><div id="div1"></div></td>
</tr>
</table>
</body>
</html>