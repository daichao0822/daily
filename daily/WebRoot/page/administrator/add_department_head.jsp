<%@ page contentType="text/html; charset=gb2312" language="java"
	import="java.sql.*,java.util.*,com.bean.*,com.dao.*" errorPage=""%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
		<title>ָ�����ų�</title>
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
	    alert("û�к󱸲��ų���������ӣ�");
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
%>
<form action="DepartmentManageServlet?flag=8" method="post" onsubmit="return check()">
<table width="97%" align="center" border="0" cellpadding="4"
			cellspacing="1" bgcolor="#CBD8AC" style="margin-bottom: 8px">
			<tr bgcolor="#EEF4EA">
				<td colspan="2" bgcolor="#CBD8AC" class='title'>
					<span>ָ�����ų�</span>
				</td>
			</tr>
			<tr>              
                <td width="14%" align="center"background="page/head_of_department/skin/images/frame/wbg.gif"> ����ID</td>                         
                <td width="26%" align="center"background="page/head_of_department/skin/images/frame/wbg.gif"> ��������</td>                         
                <td width="15%" align="center"background="page/head_of_department/skin/images/frame/wbg.gif">���ų�</td>
                <td width="45%" align="center"background="page/head_of_department/skin/images/frame/wbg.gif">��������</td>
             
            </tr>

            <tr bgcolor="#FFFFFF">
                <td align="center"><%=dep.getG_intDepartmentId() %><input type="hidden" name="departmentID" value="<%=dep.getG_intDepartmentId() %>" /></td>
                <td align="center"><%=dep.getG_strDepartmentName() %></td>
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
                                      <option value="-1">û�к󱸲��ų�</option>
                                      <%
                                      }
                                       %>
                                   </select></td>
                <td align="center"><%=dep.getG_strDepartmentDescription() %></td>
                
            </tr>
</table>
<table width="98%" align="center">
<tr>
<td align="center"><input type="submit" value="ȷ��" />&nbsp;<input type="button" value="�ر�" onclick="CloseWindow()" /></td>
</tr>
</table>
</form>
</body>
</html>