<%@ page contentType="text/html; charset=gb2312" language="java"
	import="java.sql.*,java.util.*,com.bean.*,com.dao.*" errorPage=""%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
		<title>������û�</title>
		<base target="_self">
		<link rel="stylesheet" type="text/css"
			href="page/head_of_department/skin/css/base.css" />
		<link rel="stylesheet" type="text/css"
			href="page/head_of_department/skin/css/main.css" />
<script language="javascript">
function CloseWindow(){
	window.close();
}

function check(){
	var name=document.getElementById("userName").value;
	var password1=document.getElementById("userPassword").value;
	var password2=document.getElementById("userPassword1").value;
	var email=document.getElementById("email").value;
	if(name==""){
	    alert("��������Ϊ�գ�");
	    return false;
	}
	else if(name.length>20){
		alert("�������ܳ���20���ַ���");
		return false;
	}
	else if(password1==""||password2==""){
		alert("���벻��Ϊ�գ�");
		return false;
	}
	else if(password1!=password2){
		alert("�����������벻һ�£�");
		return false;
	}
	else if(password1.length>20){
		alert("���볤�Ȳ��ܳ���20���ַ���");
		return false;
	}
	else if(email.length>40){
	    alert("���䳤�Ȳ��ܳ���40���ַ���");
	    return false;
	}
	else if(email==""){
		if(confirm("����Ϊ�գ�ȷ������д��")){
			return true;
		}
		else{
			return false;
		}
	}
	else if(email!=""){
		var myreg=/^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/;
		if(!myreg.test(email)){
			alert("��������Ч��E_mail!");
			return false;
		}
		else{
			return true;
		}
	}
}

function checkUserName() {
	var loginname = document.getElementById("userName").value;
	if(loginname==""){
    document.getElementById("div1").innerHTML = "<font color='red'>���������û�����</font>";
    }else{
	var url = "AddNewUserServlet?flag=1&un=" + loginname;
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

function updatepage() {
	if (http_request.readyState == 4) {
		if (http_request.status == 200) {
			if (http_request.responseText == 0) {
			    var loginname = document.getElementById("userName").value;
			    document.getElementById("div1").innerHTML = "<font color='red'>���û���   "+loginname+"  �Ѵ��ڣ�</font>";
				alert("�û����Ѿ����ڣ�������û�����");
				document.getElementById("userName").focus();
			} else if (http_request.responseText == 1) {
				document.getElementById("div1").innerHTML = "<font color='green'>���û�������ע��</font>";
			}else if(http_request.responseText == 2){
			    alert("���������ܼ�������������ԭ��1��session��ʱ  2�������˳�  3�������˺����ڱ𴦵�¼�������µ�¼");
			    window.close();
			    opener.top.location.replace("http://localhost/daily");
			}
		} else {
			alert("���������ҳ�����쳣");
		}
	}
}
</script>
</head>

<body>
<%
String str_userID=request.getParameter("uid");
int int_departmentID=Integer.parseInt(request.getParameter("did"));
ChangeIDForName change=new ChangeIDForName();
Connection con=Connect.getConnection();
String str_departmentName=change.GetDepartmentName(con,int_departmentID);
con.close();
 %>
<form action="AddNewUserServlet?flag=12" method="post" onsubmit="return check()">
<table width="97%" align="center" border="0" cellpadding="4"
			cellspacing="1" bgcolor="#CBD8AC" style="margin-bottom: 8px">
			<tr bgcolor="#EEF4EA">
				<td colspan="2" bgcolor="#CBD8AC" class='title'>
					<span>������û�</span>
				</td>
			</tr>
			<tr>
				<td width="8%" align="center"background="page/head_of_department/skin/images/frame/wbg.gif">ID</td>              
                <td width="18%" align="center"background="page/head_of_department/skin/images/frame/wbg.gif">����</td>                         
                <td width="7%" align="center"background="page/head_of_department/skin/images/frame/wbg.gif">�Ա�</td>
                <td width="19%" align="center"background="page/head_of_department/skin/images/frame/wbg.gif">����</td>
                <td width="18%" align="center"background="page/head_of_department/skin/images/frame/wbg.gif">�ٴ���������</td>
                <td width="10%" align="center"background="page/head_of_department/skin/images/frame/wbg.gif">��������</td>
                <td width="20%" align="center"background="page/head_of_department/skin/images/frame/wbg.gif">����</td>
            </tr>

            <tr bgcolor="#FFFFFF">
				<td align="center"><%=str_userID %><br />(<font color="#FF0000">�Զ�����</font>)<input type="hidden" name="userID" id="userID" value="<%=str_userID %>" /></td>
                <td align="center"><input type="text" name="userName" id="userName" onblur="checkUserName()" /><br /><div id="div1"><font color="#FF0000">*20���ַ�����</font></div></td>
                <td align="center"><select name="sex">
                                       <option value="��">��</option>
                                       <option value="Ů">Ů</option>
                                   </select></td>
                <td align="center"><input type="password" name="userPassword" id="userPassword" /><br /><font color="#FF0000">*20���ַ�����</font></td>
                <td align="center"><input type="password" name="userPassword1" id="userPassword1" /><br /><font color="#FF0000">*20���ַ�����</font></td>
                <td align="center"><%=str_departmentName %><input type="hidden" name="departmentID" id="departmentID" value="<%=int_departmentID %>" /></td>
                <td align="center"><input type="text" name="email" id="email" /><br /><font color="#FF0000">*20���ַ�����</font></td>
            </tr>
</table>
<table width="98%" align="center">
<tr>
<td align="center"><input type="submit" value="���" />&nbsp;<input type="button" value="�ر�" onclick="CloseWindow()" /></td>
</tr>
</table>
</form>
</body>
</html>