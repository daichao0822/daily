<%@ page language="java" import="java.util.*" pageEncoding="gb2312"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>���ձ�ϵͳ</title>
<script type="text/javascript">
if (top.location != self.location){     
top.location=self.location;     
}   
</script>
<style>
body
{
  scrollbar-base-color:#C0D586;
  scrollbar-arrow-color:#FFFFFF;
  scrollbar-shadow-color:DEEFC6;
}
</style>
</head>
<frameset rows="60,*" cols="*" frameborder="no" border="0" framespacing="0">
  <frame src="page/administrator/top.jsp" name="topFrame" scrolling="no">
  <frameset cols="180,*" name="btFrame" frameborder="NO" border="0" framespacing="0">
    <frame src="page/administrator/menu.jsp" noresize name="menu" scrolling="yes">
    <frame src="page/administrator/main.jsp" noresize name="main" scrolling="yes">
  </frameset>
</frameset>
<noframes>
	<body>�����������֧�ֿ�ܣ�</body>
</noframes>
</html>