<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*,com.bean.*,com.dao.*,java.util.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
		<title>ѡ������</title>
		<base target="_self">
			<link rel="stylesheet" type="text/css"
				href="./skin/css/base.css" />
			<link rel="stylesheet" type="text/css"
				href="./skin/css/main.css" />
			<style type="text/css">
<!--
body {
	background-image: url(images/login_07.gif);
}
-->
</style>
<script type="text/javascript">
function check(){
var obj=document.getElementsByName("radio");
var id=document.getElementsByName("hidden");
var type=document.getElementsByName("type");
var i=0;
for(i=0;i<obj.length;i++){
if(obj[i].checked==true){
opener.document.getElementById('taskName').value=obj[i].value;
opener.document.getElementById('taskID').value=id[i].value;
opener.document.getElementById('taskType').value=type[i].value;
window.close();
exit;
}
}
if(i=obj.length){
alert("����ѡ��һ������");
}
}

function closeWindow(){
window.close();
}

function AddTempTask(){
	window.open("add_temp_task.jsp","AddTempTask","directories=no,left=200,top=250,height=200,width=550,location=no,menubar=no,resizable=yes,scrollbars=yes,status=no,toolbar=no",false);
}
</script>
</head>

<body>
<%
if(session.getAttribute("userInfo")==null){
	%>
	<script type="text/javascript">
	alert("���������ܼ�������������ԭ��1��session��ʱ  2�������˳�  3�������˺����ڱ𴦵�¼�������µ�¼");
	opener.top.location.replace("http://localhost/daily");
	window.close();
	</script>
	<%
	return;
}
String projectID=request.getParameter("id");
String dailyType=request.getParameter("type");
String userID=request.getParameter("u");
int int_userID=Integer.parseInt(userID);
DailyWrite task=new DailyWrite();
Connection con=Connect.getConnection();
List<Task> list=task.getTask(con,projectID,dailyType,int_userID);
con.close();
 %>
 <table width="100%">
 <tr>
 <td align="center">��ѡ������</td>
 </tr>
 <tr>
 <td align="right">û���ʺϵ�ѡ�<input type="button" name="button1" value="�����ʱ����" onclick="AddTempTask()" /></td>
 </tr>
 </table>
 <table width="100%" border="1">
 <tr>
 <td align="center">����ID</td>
 <td align="center">��������</td>
 <td align="center">��������</td>
 <td align="center">����</td>
 </tr>
 <%
 if(list!=null){
	 for(int i=0;i<list.size();i++){
 %>
 <tr>
 <td align="center"><%=list.get(i).getG_intTaskId() %></td>
 <td align="center"><%=list.get(i).getG_strTaskName() %></td>
 <td align="center">
 <%if(list.get(i).getG_intTaskType()==1){ %>�ƻ�����<%}else{ %>��ʱ����<%} %>
 <input type="hidden" name="type" value="<%=list.get(i).getG_intTaskType() %>" /><!-- �ύ�����������͹���ҳ������ж� -->
 </td>
 <td align="center">
 <input type="hidden" name="hidden" value="<%=list.get(i).getG_intTaskId()%>" />
 <input type="radio" name="radio" value="<%=list.get(i).getG_strTaskName() %>" />
 </td>
 </tr>
 <%
       }
 %>
  </table>
 <table width="100%" border="0">
 <tr>
 <td align="center"><input type="button" value="ȷ��" onclick="check()" />&nbsp;<input type="button" value="�ر�" onclick="window.close()" /></td>
 </tr>
 </table>
 <%
 }else{ %>
 <table width="100%" border="0">
 <tr>
 <td align="center"><font size="+1" color="#FF0000">û������ѡ��</font></td>
 </tr>
 <tr>
 <td align="center"><input type="button" value="�رմ���" onclick="closeWindow()" /></td>
 </tr>
 <%
 }
 %>
  </table>
</body>
</html>