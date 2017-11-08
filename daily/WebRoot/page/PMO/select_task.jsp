<%@ page language="java" import="java.util.*,java.sql.*,com.bean.*,com.dao.*" pageEncoding="gb2312"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>选择任务</title>
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
var obj=document.getElementsByName("radio");
var id=document.getElementsByName("hidden");
var i=0;
for(i=0;i<obj.length;i++){
if(obj[i].checked==true){
opener.document.getElementById('taskName').value=obj[i].value;
opener.document.getElementById('taskID').value=id[i].value;
window.close();
exit;
}
}
if(i=obj.length){
alert("至少选择一个任务！");
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
	alert("错误！您不能继续操作，可能原因：1、session超时  2、您已退出  3、您的账号已在别处登录，请重新登录");
	opener.top.location.replace("http://localhost/daily");
	window.close();
	</script>
	<%
	return;
}
int int_projectID=Integer.parseInt(request.getParameter("pid"));
Connection con=Connect.getConnection();
ProjectQuery query=new ProjectQuery();
ChangeIDForName change=new ChangeIDForName();
String str_projectName=change.getProjectName(con,int_projectID);
List<Task> list=query.GetProTask(con,int_projectID);

 %>
 <table width="100%">
 <tr>
 <td align="center"><font size="+2">请选择任务</font></td>
 </tr>
 </table>
 <br />
 <table width="100%" border="1">
 <tr>
 <td align="center">任务ID</td>
 <td align="center">任务名称</td>
 <td align="center">所属项目</td>
 <td align="center">操作</td>
 </tr>
 <%
 if(list!=null){
	 for(int i=0;i<list.size();i++){
 %>
 <tr>
 <td align="center"><%=list.get(i).getG_intTaskId() %></td>
 <td align="center"><%=change.getTaskName(con,list.get(i).getG_intTaskId()) %></td>
 <td align="center">
 <%=str_projectName %>
 </td>
 <td align="center">
 <input type="hidden" name="hidden" value="<%=list.get(i).getG_intTaskId()%>" />
 <input type="radio" name="radio" value="<%=change.getTaskName(con,list.get(i).getG_intTaskId()) %>" />
 </td>
 </tr>
 <%
       }
 %>
  </table>
 <table width="100%" border="0">
 <tr>
 <td align="center"><input type="button" value="确定" onclick="check()" /></td>
 </tr>
 </table>
 <%
 con.close();
 }else{ %>
 <table width="100%" border="0">
 <tr>
 <td align="center"><font size="+1" color="#FF0000">没有任务供选择</font></td>
 </tr>
 <tr>
 <td align="center"><input type="button" value="关闭窗口" onclick="closeWindow()" /></td>
 </tr>
 <%
 }
 %>
  </table>
</body>
</html>