<%@ page contentType="text/html; charset=gb2312" language="java"
	import="java.sql.*,java.util.*,com.bean.*,com.dao.*" errorPage=""%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
		<title>添加新用户</title>
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
	    alert("姓名不能为空！");
	    return false;
	}
	else if(name.length>20){
		alert("姓名不能超过20个字符！");
		return false;
	}
	else if(password1==""||password2==""){
		alert("密码不能为空！");
		return false;
	}
	else if(password1!=password2){
		alert("两次输入密码不一致！");
		return false;
	}
	else if(password1.length>20){
		alert("密码长度不能超过20个字符！");
		return false;
	}
	else if(email.length>40){
	    alert("邮箱长度不能超过40个字符！");
	    return false;
	}
	else if(email==""){
		if(confirm("邮箱为空，确定不填写吗？")){
			return true;
		}
		else{
			return false;
		}
	}
	else if(email!=""){
		var myreg=/^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/;
		if(!myreg.test(email)){
			alert("请输入有效的E_mail!");
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
    document.getElementById("div1").innerHTML = "<font color='red'>×请输入用户名！</font>";
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
		alert("不能创建XMLHttpRequest对象实例");
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
			    document.getElementById("div1").innerHTML = "<font color='red'>×用户名   "+loginname+"  已存在！</font>";
				alert("用户名已经存在，请更改用户名！");
				document.getElementById("userName").focus();
			} else if (http_request.responseText == 1) {
				document.getElementById("div1").innerHTML = "<font color='green'>√用户名可以注册</font>";
			}else if(http_request.responseText == 2){
			    alert("错误！您不能继续操作，可能原因：1、session超时  2、您已退出  3、您的账号已在别处登录，请重新登录");
			    window.close();
			    opener.top.location.replace("http://localhost/daily");
			}
		} else {
			alert("您所请求的页面有异常");
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
					<span>添加新用户</span>
				</td>
			</tr>
			<tr>
				<td width="8%" align="center"background="page/head_of_department/skin/images/frame/wbg.gif">ID</td>              
                <td width="18%" align="center"background="page/head_of_department/skin/images/frame/wbg.gif">姓名</td>                         
                <td width="7%" align="center"background="page/head_of_department/skin/images/frame/wbg.gif">性别</td>
                <td width="19%" align="center"background="page/head_of_department/skin/images/frame/wbg.gif">密码</td>
                <td width="18%" align="center"background="page/head_of_department/skin/images/frame/wbg.gif">再次输入密码</td>
                <td width="10%" align="center"background="page/head_of_department/skin/images/frame/wbg.gif">所属部门</td>
                <td width="20%" align="center"background="page/head_of_department/skin/images/frame/wbg.gif">邮箱</td>
            </tr>

            <tr bgcolor="#FFFFFF">
				<td align="center"><%=str_userID %><br />(<font color="#FF0000">自动生成</font>)<input type="hidden" name="userID" id="userID" value="<%=str_userID %>" /></td>
                <td align="center"><input type="text" name="userName" id="userName" onblur="checkUserName()" /><br /><div id="div1"><font color="#FF0000">*20个字符以内</font></div></td>
                <td align="center"><select name="sex">
                                       <option value="男">男</option>
                                       <option value="女">女</option>
                                   </select></td>
                <td align="center"><input type="password" name="userPassword" id="userPassword" /><br /><font color="#FF0000">*20个字符以内</font></td>
                <td align="center"><input type="password" name="userPassword1" id="userPassword1" /><br /><font color="#FF0000">*20个字符以内</font></td>
                <td align="center"><%=str_departmentName %><input type="hidden" name="departmentID" id="departmentID" value="<%=int_departmentID %>" /></td>
                <td align="center"><input type="text" name="email" id="email" /><br /><font color="#FF0000">*20个字符以内</font></td>
            </tr>
</table>
<table width="98%" align="center">
<tr>
<td align="center"><input type="submit" value="添加" />&nbsp;<input type="button" value="关闭" onclick="CloseWindow()" /></td>
</tr>
</table>
</form>
</body>
</html>