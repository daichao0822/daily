<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>��������̱�</title>
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
	var milestoneName=document.getElementById("milestoneName").value;
	var milestoneDesc=document.getElementById("milestoneDesc").value;
	if(milestoneName==""){
		alert("��̱����Ʋ���Ϊ�գ�");
		exit;
	}
	else if(milestoneName.length>40){
		alert("��̱����Ʋ��ܳ���40�ַ���");
		exit;
	}
	else if(milestoneDesc.length>200){
		alert("��̱��������ܳ���200���ַ�");
		exit;
	}
	else{
		if(confirm("ȷ���ύ��")){
		    var url = "../../MilestoneManageServlet?flag=3&n=" + milestoneName + "&d="
			    	+ milestoneDesc;
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
				alert("��̱������Ѿ����ڣ����޸ģ�");
				document.getElementById("projectName").focus();
			} else if(http_request.responseText == 2){
				alert("�½���̱�ʧ�ܣ�");
				window.close();
			} else if (http_request.responseText == 3) {
				alert("�½���̱��ɹ���");
				opener.location.reload();
				window.close();
			}
			else if (http_request.responseText == 4) {
			    alert("�����쳣������ϵ����Ա������ҳ�棺add_new_milestone.jsp��");
			}else if (http_request.responseText == 5){
			    alert("���������ܼ�������������ԭ��1��session��ʱ  2�������˳�  3�������˺����ڱ𴦵�¼�������µ�¼");
			    window.close();
			    opener.top.location.replace("http://localhost/daily");
			}
		} else {
			alert("���������ҳ�����쳣");
			window.close();
		}
	}
}

function closeWindow(){
	if(confirm("ȷ�������½���̱����رմ�����")){
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
 %>
<table width="100%">
<tr>
<td align="center"><font size="+2">��������̱�</font></td>
</tr>
</table>
<br />
<table width="100%" border="1">
<tr>
<td width="10%" align="center">��̱�����</td>
<td width="27%" align="center"><input type="text" size="40" name="milestoneName" id="milestoneName" /><br /><font color="#FF0000">*40�ַ�����</font></td>
<td width="12%" align="center">��̱�����</td>
<td width="51%" align="center"><textarea name="milestoneDesc" id="milestoneDesc" cols="50" rows="2"></textarea><font color="#FF0000">*200�ַ�����</font></td>
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