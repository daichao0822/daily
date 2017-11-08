<%@ page contentType="text/html; charset=gb2312" language="java"
	import="java.sql.*,java.util.*,com.bean.*,com.dao.*" errorPage=""%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
		<title>新建部门</title>
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
	var name=document.getElementById("departmentName").value;
	var desc=document.getElementById("description").value;
	var head=document.getElementById("head").value;
	if(name==""){
	    alert("部门名称不能为空！");
	    return false;
	}
	else if(name.length>40){
		alert("部门名称不能超过40个字符！");
		return false;
	}
	else if(head==-1){
	        if(confirm("部门长为空，确定不指定部门长吗？")){
	            if(desc==""){
		            if(confirm("部门描述为空，确定不填写吗？")){
			            return true;
					}
					else{
					    return false;
					}
		  		}
		  		else{
		  		    return true;
		  		}
		  	}
		  	else{
		  	    return false;
		  	}
	}
	else{
	    if(desc==""){
		    if(confirm("部门描述为空，确定不填写吗？")){
			    return true;
			}
			else{
			    return false;
			}
		}
		else{
		  	return true;
		}
	}
}

function CheckDepartmentName() {
	var loginname = document.getElementById("departmentName").value;
	if(loginname==""){
    document.getElementById("div1").innerHTML = "<font color='red'>×请输入部门名称！</font>";
    }else{
	var url = "DepartmentManageServlet?flag=4&dn=" + loginname;
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
			if (http_request.responseText == 1) {
				alert("部门名称已经存在，请更改！");
				document.getElementById("departmentName").focus();
			} else if (http_request.responseText == 0) {
				document.getElementById("div1").innerHTML = "<font color='green'>√部门名称可以注册</font>";
			}else if (http_request.responseText == 2){
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
List<Department> dep=(List<Department>)request.getAttribute("dep");
List<User> user=(List<User>)request.getAttribute("user");
%>
<form action="DepartmentManageServlet?flag=5" method="post" onsubmit="return check()">
<table width="97%" align="center" border="0" cellpadding="4"
			cellspacing="1" bgcolor="#CBD8AC" style="margin-bottom: 8px">
			<tr bgcolor="#EEF4EA">
				<td colspan="2" bgcolor="#CBD8AC" class='title'>
					<span>创建新部门</span>
				</td>
			</tr>
			<tr>              
                
                <td width="26%" align="center"background="page/head_of_department/skin/images/frame/wbg.gif"> 部门名称</td>                         
                <td width="16%" align="center"background="page/head_of_department/skin/images/frame/wbg.gif">部门长</td>
                <td width="58%" align="center"background="page/head_of_department/skin/images/frame/wbg.gif">部门描述</td>
             
            </tr>

            <tr bgcolor="#FFFFFF">
                <td align="center">
                <input type="text" size="40" name="departmentName" id="departmentName" onblur="CheckDepartmentName()" />
                <br /><div id="div1"><font color="#FF0000">*40个字符以内</font></div>
                </td>
                <td align="center"><select name="head" id="head">
                              	          <option value="-1">&nbsp;</option>
                                      <%
                                      if(user!=null){
                                         for(int i=0;i<user.size();i++){
                                         %>
                                           <option value="<%=user.get(i).getG_intUserId() %>"><%=user.get(i).getG_strUserName() %></option>
                                           <%
                                         }
                                      }
                                      %>
                                   </select></td>
                <td align="center"><textarea name="description" id="description" cols="60" rows="2" ></textarea></td>
                
            </tr>
</table>
<table width="98%" align="center">
<tr>
<td align="center"><input type="submit" value="确定" />&nbsp;<input type="button" value="关闭" onclick="CloseWindow()" /></td>
</tr>
</table>
</form>
</body>
</html>