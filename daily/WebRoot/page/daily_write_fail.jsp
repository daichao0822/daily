<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>�ύʧ��</title>
<style type="text/css">
<!--
body {
	background-image: url(images/login_07.gif);
}
-->
</style>
<script type="text/javascript">
function rewrite(){
location.href="DailyWriteServlet?flag=1";
}

function mainPage(){
location.href="page/member/main.jsp";
}
</script>
</head>

<body>
<table width="100%">
<tr><td>&nbsp;</td></tr>
<tr><td>&nbsp;</td></tr>
<tr><td>&nbsp;</td></tr>
<tr>
<td align="center"><font size="+3" ><strong>�ύʧ�ܣ�����ϵ����Ա</strong></font></td>
</tr>
<tr>
<td align="center">
<input type="button" name="button" value="��������" onclick="rewrite()"/>&nbsp;
<input type="button" name="button1" value="������ҳ" onclick="mainPage()"/>
</td>
</tr>
</table>
</body>
</html>