<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>��������Ŀ</title>
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
	var projectNumber=document.getElementById("projectNumber").value;
	var projectName=document.getElementById("projectName").value;
	var time=document.getElementById("time").value;
	var description=document.getElementById("description").value;
	if(projectNumber==""){
		alert("��Ŀ��Ų���Ϊ�գ�");
		exit;
	}
	else if(projectName==""){
		alert("��Ŀ���Ʋ���Ϊ�գ�");
	}
	else{
		if(confirm("ȷ���ύ��")){
		    var url = "../../AddNewProjectServlet?number=" + projectNumber + "&name="
			    	+ projectName + "&time=" + time+"&des="+description;
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
			if (http_request.responseText == 1) {
				alert("��Ŀ�����Ѿ����ڣ����޸ģ�");
				document.getElementById("projectName").focus();
			} else if (http_request.responseText == 2) {
				alert("��Ŀ����Ѿ����ڣ����޸ģ�");
				document.getElementById("projectNumber").focus();
			} else if (http_request.responseText == 3){
				alert("�����Ŀʧ�ܣ�����ϵ����Ա");
				window.close();
			} else if (http_request.responseText == 4) {
				alert("�����Ŀ�ɹ���");
				opener.location.reload();
				window.close();
			}else if (http_request.responseText == 5){
			    alert("���������ܼ�������������ԭ��1��session��ʱ  2�������˳�  3�������˺����ڱ𴦵�¼�������µ�¼");
			    window.close();
			    opener.top.location.replace("http://localhost/daily");
			}
			else{
			alert("�����쳣������ϵ����Ա������ҳ�棺add_new_project.jsp��");
			}
		} else {
			alert("���������ҳ�����쳣");
			window.close();
		}
	}
}

function closeWindow(){
	if(confirm("ȷ�������½���Ŀ���رմ�����")){
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
	alert("session��ʱ�������˳��������µ�¼");
	opener.top.location.replace("http://localhost/daily");
	window.close();
	</script>
	<%
	return;
}
java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 
java.util.Date currentTime = new java.util.Date();//�õ���ǰϵͳʱ�� 
String strDate = formatter.format(currentTime); //������ʱ���ʽ��
String str_Date=strDate.replaceAll(" ","_");//��strDate�ַ����еĿո��滻��_
 %>
<table width="100%">
<tr>
<td align="center"><font size="+2">��������Ŀ</font></td>
</tr>
</table>
<br />
<table width="100%" border="1">
<tr>
<td width="7%" align="center">��Ŀ���</td>
<td width="15%" align="center"><input type="text" name="projectNumber" id="projectNumber" /></td>
<td width="11%" align="center">��Ŀ����</td>
<td width="15%" align="center"><input type="text" name="projectName" id="projectName" /></td>
<td width="12%" align="center">����ʱ��</td>
<td width="19%" align="center">
<input type="hidden" name="time" id="time" value="<%=str_Date%>" />
<%=strDate%>
</td>
<td width="9%" align="center">��Ŀ״̬</td>
<td width="12%" align="center">�������У�<font size="-1" color="#FF0000">Ĭ��</font>��</td>
</tr>
</table>
<table width="100%" border="1">
<tr>
<td align="center">��Ŀ����<br />(<font size="-1" color="#FF0000">1000�ַ�����</font>)</td>
<td><textarea name="description" id="description" cols="90" rows="5"></textarea></td>
</tr>
</table>
<table width="100%">
<tr>
<td align="center">
<input type="button" name="button" value="�ύ" onclick="check()"  />&nbsp;
<input type="button" name="button1" value="�ر�" onclick="closeWindow()" /></td>
</tr>
</table>
</body>
</html>