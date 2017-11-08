<%@ page contentType="text/html; charset=gb2312" language="java"
	import="java.sql.*,java.util.*,com.bean.*,com.dao.*" errorPage=""%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
		<title>更改部门长</title>
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
	var head=document.getElementById("head").value;
	if(head==-1){
	    alert("没有后备部门长，不能更改！");
	    return false;
	}
	else{
			return true;
		}		
}
</script>
</head>

<body>
<%
Department dep=(Department)request.getAttribute("dep");
List<User> user=(List<User>)request.getAttribute("user");
int int_userID=Integer.parseInt(request.getParameter("uid"));
Connection con=Connect.getConnection();
ChangeIDForName change=new ChangeIDForName();
String str_oldHead=change.getUserName(con,int_userID);
con.close();
%>
<form action="DepartmentManageServlet?flag=10" method="post" onsubmit="return check()">
<table width="97%" align="center" border="0" cellpadding="4"
			cellspacing="1" bgcolor="#CBD8AC" style="margin-bottom: 8px">
			<tr bgcolor="#EEF4EA">
				<td colspan="2" bgcolor="#CBD8AC" class='title'>
					<span>更改部门长</span>
				</td>
			</tr>
			<tr>              
                <td width="11%" align="center"background="page/head_of_department/skin/images/frame/wbg.gif"> 部门ID</td>                         
                <td width="20%" align="center"background="page/head_of_department/skin/images/frame/wbg.gif"> 部门名称</td>                
                <td width="15%" align="center"background="page/head_of_department/skin/images/frame/wbg.gif"> 原部门长</td>                         
                <td width="17%" align="center"background="page/head_of_department/skin/images/frame/wbg.gif">新部门长</td>
                <td width="37%" align="center"background="page/head_of_department/skin/images/frame/wbg.gif">部门描述</td>
             
            </tr>

            <tr bgcolor="#FFFFFF">
                <td align="center"><%=dep.getG_intDepartmentId() %><input type="hidden" name="departmentID" value="<%=dep.getG_intDepartmentId() %>" /></td>
                <td align="center"><%=dep.getG_strDepartmentName() %></td>
                <td align="center"><%=str_oldHead %><input type="hidden" name="oldHead" value="<%=int_userID %>"/></td>
                <td align="center"><select name="head" id="head">
                                      <%
                                      if(user!=null){
                                         for(int i=0;i<user.size();i++){
                                         %>
                                           <option value="<%=user.get(i).getG_intUserId() %>"><%=user.get(i).getG_strUserName() %></option>
                                           <%
                                         }
                                      }else{
                                      %>
                                      <option value="-1">没有后备部门长</option>
                                      <%
                                      }
                                       %>
                                   </select></td>
                <td align="center"><%=dep.getG_strDepartmentDescription() %></td>
                
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