<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*,java.util.*,com.bean.*,com.dao.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>更改项目经理</title>
<base target="_self">
<link rel="stylesheet" type="text/css" href="page/manager/skin/css/base.css" />
<link rel="stylesheet" type="text/css" href="page/manager/skin/css/main.css" />
</head>
<script type="text/javascript">
function ConfirmChange(){
	var s=document.getElementById("manager").value;
	if(s==-1){
	    alert("没有后备人员供选择，不能更改项目经理");
	    return false;
	}
	else{
	    return true;
	}
}

function CloseWindow(){
	window.close();
}
</script>
<body>
<%
List<Project> proDetail=(List)request.getAttribute("project");
List<User> user=(List)request.getAttribute("user");
String str_oldManager=request.getParameter("o_mng");
ChangeIDForName change=new ChangeIDForName();
Connection con=Connect.getConnection();
 %>
 <form name="form" action="ChangeManagerServlet?flag=2&o_mng=<%=str_oldManager %>" method="post" onsubmit="return ConfirmChange()">
<table width="98%" align="center" border="0" cellpadding="4" cellspacing="1" bgcolor="#CBD8AC"  style="margin-bottom:8px">
<tr bgcolor="#EEF4EA">
<td colspan="2" bgcolor="#CBD8AC"  class='title'><span>项目详细</span></td>
</tr>
<tr>
<td width="10%" align="center" background="page/PMO/skin/images/frame/wbg.gif">项目ID</td>
<td width="11%" align="center" background="page/PMO/skin/images/frame/wbg.gif">项目名称</td>
<td width="11%" align="center" background="page/PMO/skin/images/frame/wbg.gif">项目编号</td>
<td width="14%" align="center" background="page/PMO/skin/images/frame/wbg.gif">项目经理</td>
<td width="22%" align="center" background="page/PMO/skin/images/frame/wbg.gif">项目开始时间</td>
<td width="22%" align="center" background="page/PMO/skin/images/frame/wbg.gif">项目结束时间</td>
<td width="10%" align="center" background="page/PMO/skin/images/frame/wbg.gif">项目状态</td>
</tr>
<%
if(proDetail!=null){
    for(int i=0;i<proDetail.size();i++){
 %>
<tr bgcolor="#FFFFFF">
<td align="center">
<%=proDetail.get(i).getG_intProjectId() %>
<input type="hidden" name="projectID" id="projectID" value="<%=proDetail.get(i).getG_intProjectId() %>" /></td><!--  隐藏提交项目ID -->
<td align="center"><%=proDetail.get(i).getG_strProjectName() %></td>
<td align="center"><%=proDetail.get(i).getG_strProjectNumber() %></td>
<td align="center">
<select name="manager" id="manager">
<%
if(user!=null){
    for(int m=0;m<user.size();m++){
    %>
    <option value="<%=user.get(m).getG_intUserId() %>"><%=user.get(m).getG_strUserName() %></option>
    <%
    }
}
else{
    %>
    <option value="-1">没有人员供选</option>
    <%
}
 %>

</select>

</td>
<td align="center"><%=proDetail.get(i).getG_timProjectBeginTime() %></td>
<td align="center"><%=proDetail.get(i).getG_timProjectEndTime() %></td>
<td align="center"> 
<%
if(proDetail.get(i).getG_intProjectStatus()==1){ %>暂停
<%
}else if(proDetail.get(i).getG_intProjectStatus()==2){%>正在运行
      <%
      }
%>
</td>
</tr>
 <%}
 }
 else{ %>
<tr bgcolor="#FFFFFF">
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td align="center"><font color="#FF0000">该项目不存在！</font></td>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>&nbsp;</td>
</tr>
 <%} %>
</table>
<%con.close(); %>
<table width="98%" align="center">
  <tr>
<td align="center">
<input type="submit" value="确定" />&nbsp;<input type="button" name="button" value="关闭" onclick="CloseWindow()" />
</td>
</tr>
</table>
</form>
</body>
</html>