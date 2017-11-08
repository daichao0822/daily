<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*,java.util.*,com.bean.*,com.dao.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>负责项目</title>
<base target="_self">
<link rel="stylesheet" type="text/css" href="page/PMO/skin/css/base.css" />
<link rel="stylesheet" type="text/css" href="page/PMO/skin/css/main.css" />
<script type="text/javascript">
function check(){
	var ms=document.getElementsByName("milestoneID");
	var i=0;
	for(i=0;i<ms.length;i++){
		if(ms[i].checked){
			if(confirm("删除里程碑后，与与之相关的项目里程碑确认也将被删除，确认删除？")){
				return true;
				exit;
			}
			else{
				return false;
				exit;
			}
		}
	}
	if(i==ms.length){
		alert("至少选择一个里程碑！");
		return false;
	}
}

function CreateNewMilestone(){
	window.open("page/PMO/add_new_milestone.jsp","AddNewMilestone","directories=no,left=200,top=250,height=200,width=1000,location=no,menubar=no,resizable=yes,scrollbars=yes,status=no,toolbar=no",false);
}
</script>
</head>
<body>
<%
List<Milestone> list=(List<Milestone>)request.getAttribute("milestone");
 %>
<form name="form" action="MilestoneManageServlet?flag=2" method="post" onsubmit="return check()">
  <table width="98%" align="center" border="0" cellpadding="4" cellspacing="1" bgcolor="#CBD8AC"  style="margin-bottom:8px">
<tr bgcolor="#EEF4EA">
<td colspan="2" bgcolor="#CBD8AC"  class='title'>
所有里程碑&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input type="button" value="新建里程碑" onclick="CreateNewMilestone()" /></td>
</tr>
<tr>
<td width="12%" align="center" background="page/PMO/skin/images/frame/wbg.gif">选择</td>
<td width="15%" align="center" background="page/PMO/skin/images/frame/wbg.gif">里程碑ID</td>
<td width="21%" align="center" background="page/PMO/skin/images/frame/wbg.gif">里程碑名称</td>
<td width="52%" align="center" background="page/PMO/skin/images/frame/wbg.gif">里程碑描述</td>
</tr>
<%
if(list!=null){
for(int i=0;i<list.size();i++){
 %>
<tr bgcolor="#FFFFFF">
<td align="center"><input type="checkbox" name="milestoneID" id="milestoneID" value="<%=list.get(i).getG_intMileStoneId() %>" /></td>
<td align="center"><%=list.get(i).getG_intMileStoneId() %></td>
<td align="center"><%=list.get(i).getG_strMileStoneName() %></td>
<td align="center"><%=list.get(i).getG_strMileStoneDescription() %></td>
</tr>
<%
}
}else{
%>
<tr bgcolor="#FFFFFF">
<td align="center">&nbsp;</td>
<td align="center">&nbsp;</td>
<td align="center">&nbsp;</td>
<td align="center"><font color="red">没有里程碑</font></td>
</tr>
<%
} 
%>
</table>
<table width="98%" align="center" border="0" cellpadding="4" cellspacing="1"  style="margin-bottom:8px">
 <tr>
  <td align="center"><input type="submit" value="删除里程碑" /></td>
 </tr>
</table>
</form>
</body>
</html>