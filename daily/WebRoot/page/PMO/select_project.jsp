<%@ page language="java" import="java.util.*,java.sql.*,com.bean.*,com.dao.*" pageEncoding="gb2312"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>ѡ����Ŀ</title>
<base target="_self">
<link rel="stylesheet" type="text/css" href="skin/css/base.css" />
<link rel="stylesheet" type="text/css" href="skin/css/main.css" />
<style type="text/css">
<!--
body {
	background-image: url(../images/login_07.gif);
}
-->
</style>
<script type="text/javascript">
function check(){
var obj=document.getElementsByName("projectName");
var i=0;
for(i=0;i<obj.length;i++){
if(obj[i].checked==true){
opener.document.getElementById('projectName').value=obj[i].value;
opener.document.getElementById('projectID').value=document.getElementsByName("hidden")[i].value;
window.close();
exit;
}
}
if(i=obj.length){
alert("����ѡ��һ����Ŀ��");
}
}

function closeWindow(){
window.close();
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
Connection con=Connect.getConnection();
ProjectQuery query=new ProjectQuery();
ChangeIDForName name=new ChangeIDForName();
String strName=null;
List<Project> list=query.GetAllProject(con);
 %>
<table width="100%" border="0">
<tr>
<td align="center"><font size="+2">��ѡ����Ŀ</font></td>
</tr>
</table>
<table width="100%" border="1">
<tr>
<td width="12%" align="center">��ĿID</td>

<td width="21%" align="center">��Ŀ����</td>

<td width="20%" align="center">��Ŀ����</td>

<td width="34%" align="center">����ʱ��</td>

<td width="13%" align="center">ѡ��</td>
</tr>
<%
if(list!=null){
for(int i=0;i<list.size();i++){
 %>
 <tr>
 <td align="center"><%=list.get(i).getG_intProjectId() %></td>

 <td align="center"><%=list.get(i).getG_strProjectName() %></td>

 <td align="center"><%
 int intProjectManager=list.get(i).getG_intProjectManager();
strName=name.getUserName(con,intProjectManager);//���û�IDת�����û���%>
<%=strName %></td>

 <td align="center"><%=list.get(i).getG_timProjectBeginTime() %></td>

 <td align="center">
 <input type="hidden" name="hidden" value=<%=list.get(i).getG_intProjectId() %> />
 <input type="radio" name="projectName" value="<%=list.get(i).getG_strProjectName() %>" /></td>
 </tr>
 <%}
 %>
 </table>
   <br/>
 <table width="100%">
<tr>
<td align="center">
<input type="button" name="button" value="ȷ��" onClick="check()" />&nbsp;
<input type="button" value="�رմ���" onClick="closeWindow()"/></td>
</tr>
</table>
 <%
 con.close();
 }else{ %>
 <table width="100%">
 <tr>
 <td align="center"><font size="+1" color="#FF0000">û����Ŀ��ѡ��</font></td>
 </tr>
 </table>
 <br/>
 <table width="100%">
 <tr>
 <td align="center"><input type="button" value="�رմ���" onClick="closeWindow()"/></td>
 </tr>
 </table>
 <%}%>
</body>
</html>
