<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*,java.util.*,com.bean.*,com.dao.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>������Ŀ</title>
<base target="_self">
<link rel="stylesheet" type="text/css" href="page/PMO/skin/css/base.css" />
<link rel="stylesheet" type="text/css" href="page/PMO/skin/css/main.css" />
<script type="text/javascript">
function check(){
	var task=document.getElementsByName("taskID");
	var i=0;
	for(i=0;i<task.length;i++){
		if(task[i].checked){
			if(confirm("ɾ�����������������ŵ�����Ϣ����ɾ���������ձ�����������,�ò��������棬ȷ��ɾ����")){
				return true;
				exit;
			}
			else{
				return false;
				exit;
			}
		}
	}
	if(i==task.length){
		alert("����ѡ��һ������");
		return false;
	}
}

function CreateNewTask(){
	window.open("page/PMO/add_new_task.jsp","AddNewTask","directories=no,left=300,top=250,height=200,width=600,location=no,menubar=no,resizable=yes,scrollbars=yes,status=no,toolbar=no",false);
}
</script>
</head>
<body>
<%
List<Task> list=(List)request.getAttribute("task");
 %>
<form name="form" action="TaskManageServlet?flag=2" method="post" onsubmit="return check()">
  <table width="98%" align="center" border="0" cellpadding="4" cellspacing="1" bgcolor="#CBD8AC"  style="margin-bottom:8px">
<tr bgcolor="#EEF4EA">
<td colspan="2" bgcolor="#CBD8AC"  class='title'>
��������&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input type="button" value="�½�����" onclick="CreateNewTask()" /></td>
</tr>
<tr>
<td width="15%" align="center" background="page/PMO/skin/images/frame/wbg.gif">ѡ��</td>
<td width="20%" align="center" background="page/PMO/skin/images/frame/wbg.gif">����ID</td>
<td width="38%" align="center" background="page/PMO/skin/images/frame/wbg.gif">��Ŀ����</td>
<td width="27%" align="center" background="page/PMO/skin/images/frame/wbg.gif">��������</td>
</tr>
<%
if(list!=null){
for(int i=0;i<list.size();i++){
 %>
<tr bgcolor="#FFFFFF">
<td align="center"><input type="checkbox" name="taskID" id="taskID" value="<%=list.get(i).getG_intTaskId() %>" /></td>
<td align="center"><%=list.get(i).getG_intTaskId() %></td>
<td align="center"><%=list.get(i).getG_strTaskName() %></td>
<td align="center">
<%if(list.get(i).getG_intTaskType()==0){
%>��ʱ����
<%}else if(list.get(i).getG_intTaskType()==1){
%>��Ŀ����
<%}else{
%><font color="red">�������ʹ���</font>
<%} %></td>
</tr>
<%
}
} 
%>
</table>
<table width="98%" align="center" border="0" cellpadding="4" cellspacing="1"  style="margin-bottom:8px">
 <tr>
  <td align="center"><input type="submit" value="ɾ������" /></td>
 </tr>
</table>
</form>
</body>
</html>