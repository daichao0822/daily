<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*,com.bean.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>�ظ�</title>
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
		alert("�ظ����ݲ���Ϊ�գ�");
		exit;
	}
	else{
		if(confirm("ȷ���ύ��")){
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
			   alert("���ܴ���XMLHttpRequest����ʵ��");
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
				alert("�ظ�ʧ�ܣ�");
				window.close();
			} else if (http_request.responseText == 1) {
				alert("�ظ��ɹ������ȷ���鿴�ظ�");
				opener.location.reload();
				window.close();
			}else if(http_request.responseText == 2){
			    alert("���������ܼ�������������ԭ��1��session��ʱ  2�������˳�  3�������˺����ڱ𴦵�¼�������µ�¼");
			    window.close();
			    opener.top.location.replace("http://localhost/daily");
			}
			else{
			alert("�����쳣������ϵ����Ա������ҳ�棺daily_reply.jsp��78");
			}
		} else {
			alert("���������ҳ�����쳣");
			window.close();
		}
	}
}

function uploadImage(){
    window.open("upload.htm","uploadImge","directories=no,left=500,top=250,height=130,width=550,location=no,menubar=no,resizable=yes,scrollbars=yes,status=no,toolbar=no",false);
}

function closeWindow(){
	if(confirm("ȷ�������ظ����رմ�����")){
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
alert("���������ܼ�������������ԭ��1��session��ʱ  2�������˳�  3�������˺����ڱ𴦵�¼�������µ�¼");
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
java.util.Date currentTime = new java.util.Date();//�õ���ǰϵͳʱ�� 
String strDate = formatter.format(currentTime); //������ʱ���ʽ��
String str_Date=strDate.replaceAll(" ","_");//��strDate�ַ����еĿո��滻��_
 %>
<table width="100%">
<tr>
<td align="center">�ظ��ձ�</td>
</tr>
</table>
<br />
<table width="100%" border="1">
<tr>
<td width="12%" align="center">�ձ�ID</td>
<td width="18%" align="center">
<input type="hidden" name="dailyID" id="dailyID" value="<%=str_id %>" /><!-- �����ύ�ձ�ID -->
<input type="hidden" name="image" id="image" value="" /><!-- �����ύͼƬ���� -->
<%=str_id%>
</td>
<td width="12%" align="center">����</td>
<td width="19%" align="center">
<input type="hidden" name="userID" id="userID" value="<%=int_userID%>" />
<%=str_userName%></td>
<td width="14%" align="center">�ظ�ʱ��</td>
<td width="25%" align="center">
<input type="hidden" name="time" id="time" value="<%=str_Date%>" />
<%=strDate%>
</td>
</tr>
</table>
<table width="100%" border="1">
<tr>
<td align="center">�ظ�����<br />(<font size="-1" color="#FF0000">2000�ַ�����</font>)</td>
<td><textarea name="reply" id="reply" cols="70" rows="5"></textarea></td>
</tr>
</table>
<table width="100%">
<tr>
<td align="center">
<input type="button" name="button" value="�ύ" onclick="check()"  />&nbsp;
<input type="button" name="button1" value="�ر�" onclick="closeWindow()" /></td>
</tr>
</table>
<table border="0">
<tr>
<td align="left"><input type="button" name="uploadImage" value="�ϴ�ͼƬ" onclick="uploadImage()" />&nbsp;<font color="red">ֻ֧��jpg��bmp��gif��ʽͼƬ����С������100KB</font></td>
</tr>
<tr>
<td><div id="div1"></div></td>
</tr>
</table>
</body>
</html>