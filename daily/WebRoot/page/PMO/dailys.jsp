<%@ page contentType="text/html; charset=gb2312" language="java"
	import="java.sql.*,java.util.*,com.bean.*,com.dao.*" errorPage=""%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
		<title>日报查询</title>
		<base target="_self">
			<link rel="stylesheet" type="text/css"
				href="page/manager/skin/css/base.css" />
			<link rel="stylesheet" type="text/css"
				href="page/manager/skin/css/main.css" />
			<style type="text/css">
<!--
body {
	background-image: url(page/images/login_07.gif);
}
-->
</style>
<script language="javascript">
function goback(){
window.history.back();
}
</script>
</head>
<body>
<% List<Daily> dailys=(List)request.getAttribute("dailys");
Connection con=Connect.getConnection();
ChangeIDForName change=new ChangeIDForName();
%>
<table width="98%" align="center" border="0" cellpadding="4" cellspacing="1" >
  <tr>
    <td colspan="2">
    	<div align="center"><strong><font size="+2">用户日报</font></strong></div>
   </td>
  </tr>
  <%if(dailys!=null){%><!--如果日报列表不为NULL-->
  <tr >
    <td height="30" colspan="2" align="center" ><table width="100%" border="1" cellspacing="1" cellpadding="1" >
        <tr>
		  <td width="15%" height="20" align="center" class="style1">日报ID</td>
          <td width="15%" height="20" align="center" class="style1">日报类型</td>
          <td width="15%" height="20" align="center" class="style1">作者</td>
          <td width="30%" height="20" align="center" class="style1">提交日期</td>
          <td width="15%" height="20" align="center" class="style1">是否审阅</td>
          <td width="10%" height="20" align="center" class="style1">操作</td>
        </tr>
        <%
        for(int i=0;i<dailys.size();i++){
         %>
            <tr>
		  <td><div align="center"><%=dailys.get(i).getG_intDailyId() %></div></td>
		  <td><div align="center"><%if(dailys.get(i).getG_intDailyType()==1){ %>项目日报<%}
		                            else if(dailys.get(i).getG_intDailyType()==0){ %>非项目日报<%}
		                            else{ %><font color="#FF0000">未知错误！</font><%} %></div></td>
		  <td><div align="center"><%=change.getUserName(con,dailys.get(i).getG_intDailyUser()) %></div></td>
		  <td><div align="center"><%=dailys.get(i).getG_timDailySubmitTime() %></div></td>
		  <td><div align="center"><%if(dailys.get(i).getG_intDailyCheckup()==0){ %><font color="#FF0000">未审阅</font><%}
		                            else if(dailys.get(i).getG_intDailyCheckup()==1){ %>已审阅<%}
		                            else{ %><font color="#FF00FF">未知错误！</font><%} %></div></td>
		  <td><div align="center"><a href="/daily/DailyQueryForPMOServlet?flag=6&did=<%=dailys.get(i).getG_intDailyId() %>">详细</a></div></td>
		</tr>
        <%} 
		%>
      </table></td>
  </tr>
  <%}
  else{%><!--如果list为NULL，输出如下信息-->
  <tr>
    <td height="30" colspan="2" align="center" ><table width="100%" border="1" cellspacing="1" cellpadding="1" >
        <tr>
		  <td width="15%" height="20" align="center" class="style1">日报ID</td>
          <td width="15%" height="20" align="center" class="style1">日报类型</td>
          <td width="15%" height="20" align="center" class="style1">作者</td>
          <td width="30%" height="20" align="center" class="style1">提交日期</td>
          <td width="15%" height="20" align="center" class="style1">是否审阅</td>
          <td width="10%" height="20" align="center" class="style1">操作</td>
        </tr>
        </table></td>
   </tr>
   <tr>
   <td align="center"><font size="+1" color="#FF0000">没有任何日报，请检查查询条件</font></td>
   </tr>
  <%
  }%>
</table>
<table width="100%" border="0" >
	    <tr>
	      <td align="center"><input name="button" type="button" id="button" value="返回" onClick="goback()" /></td>
	    </tr>
	  </table>
</body>
</html>