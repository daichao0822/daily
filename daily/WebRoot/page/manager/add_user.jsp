<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*,java.util.*,com.bean.*,com.dao.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>�����Ŀ��Ա</title>
<base target="_self">
<link rel="stylesheet" type="text/css" href="page/manager/skin/css/base.css" />
<link rel="stylesheet" type="text/css" href="page/manager/skin/css/main.css" />
<script language="javascript" >
function check(){
var obj=document.getElementsByName("userid");
if(confirm("ȷ�������Ŀ��Ա��")){
for(i=0;i<obj.length;i++){
   if(obj[i].checked){
   return true;
   }
}
window.alert("����ѡ��һ����Ա��");
return false;
}else{
return false;
}
}

</script>
</head>

<body>
<%
List<User> user=(List)request.getAttribute("user");
String str_projectID=request.getParameter("id");
ChangeIDForName change=new ChangeIDForName();
Connection con=Connect.getConnection();
 %>
<form name="form" action="AddUserForProjectServlet?flag=2&id=<%=str_projectID%>" method="post" onsubmit="return check()">
<table width="98%" align="center" border="0" cellpadding="4" cellspacing="1" bgcolor="#CBD8AC"  style="margin-bottom:8px">
<tr bgcolor="#EEF4EA">
<td colspan="2" bgcolor="#CBD8AC"  class='title'><span>��Ŀ��Ա</span></td>
</tr>
<tr>
<td width="9%" align="center" background="page/manager/skin/images/frame/wbg.gif">ID</td>
<td width="10%" align="center" background="page/manager/skin/images/frame/wbg.gif">����</td>
<td width="11%" align="center" background="page/manager/skin/images/frame/wbg.gif">�Ա�</td>
<td width="13%" align="center" background="page/manager/skin/images/frame/wbg.gif">��������</td>
<td width="31%" align="center" background="page/manager/skin/images/frame/wbg.gif">ӵ��Ȩ��</td>
<td width="15%" align="center" background="page/manager/skin/images/frame/wbg.gif">E-mail</td>
<td width="11%" align="center" background="page/manager/skin/images/frame/wbg.gif">ѡ��</td>
</tr>
<%
if(user!=null){
    for(int i=0;i<user.size();i++){
 %>
<tr bgcolor="#FFFFFF">
<td align="center"><%=user.get(i).getG_intUserId() %></td>
<td align="center"><%=user.get(i).getG_strUserName() %></td>
<td align="center"><%=user.get(i).getG_strSex()%></td>
<td align="center"><%=change.GetDepartmentName(con,user.get(i).getG_intDepartment()) %></td>
<td align="center">��Ŀ��Ա&nbsp;
<%if(user.get(i).getG_intRole2()==1){ %>��Ŀ����&nbsp;<%} %>
<%if(user.get(i).getG_intRole3()==1){ %>���ų�&nbsp;<%} %>
<%if(user.get(i).getG_intRole4()==1){ %>PMO&nbsp;<%} %>
<%if(user.get(i).getG_intRole5()==1){ %>����Ա<%} %>
</td>
<td align="center"><%=user.get(i).getG_strEmail() %></td>
<td align="center"><input type="checkbox" name="userid" value="<%=user.get(i).getG_intUserId()%>" /></td>
</tr>
<%}
}else{ %>
<tr bgcolor="#FFFFFF">
<td align="center">&nbsp;</td>
<td align="center">&nbsp;</td>
<td align="center">&nbsp;</td>
<td align="center"><font color="#FF0000">û����Ա��ѡ��</font></td>
<td align="center">&nbsp;</td>
<td align="center">&nbsp;</td>
<td align="center">&nbsp;</td>
</tr>
<%}%>
</table>
<table width="98%" align="center">
  <tr>
<td align="center">
<input type="submit" value="�����Ա" />&nbsp;
<input type="button" value="�رմ���" onclick="window.close()" />
</td>
</tr>
</table>
<%con.close(); %>
</form>
</body>
</html>