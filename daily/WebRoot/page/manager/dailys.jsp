<%@ page contentType="text/html; charset=gb2312" language="java"
	import="java.sql.*,java.util.*,com.bean.*,com.dao.*" errorPage=""%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
		<title>�ձ���ѯ</title>
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
    	<div align="center"><strong><font size="+2">�û��ձ�</font></strong></div>
   </td>
  </tr>
  <%if(dailys!=null){%><!--����ձ��б�ΪNULL-->
  <tr >
    <td height="30" colspan="2" align="center" ><table width="100%" border="1" cellspacing="1" cellpadding="1" >
        <tr>
		  <td width="15%" height="20" align="center" class="style1">�ձ�ID</td>
          <td width="15%" height="20" align="center" class="style1">�ձ�����</td>
          <td width="15%" height="20" align="center" class="style1">����</td>
          <td width="30%" height="20" align="center" class="style1">�ύ����</td>
          <td width="15%" height="20" align="center" class="style1">�Ƿ�����</td>
          <td width="10%" height="20" align="center" class="style1">����</td>
        </tr>
        <%
        for(int i=0;i<dailys.size();i++){
         %>
            <tr>
		  <td><div align="center"><%=dailys.get(i).getG_intDailyId() %></div></td>
		  <td><div align="center"><%if(dailys.get(i).getG_intDailyType()==1){ %>��Ŀ�ձ�<%}
		                            else if(dailys.get(i).getG_intDailyType()==0){ %>����Ŀ�ձ�<%}
		                            else{ %><font color="#FF0000">δ֪����</font><%} %></div></td>
		  <td><div align="center"><%=change.getUserName(con,dailys.get(i).getG_intDailyUser()) %></div></td>
		  <td><div align="center"><%=dailys.get(i).getG_timDailySubmitTime() %></div></td>
		  <td><div align="center"><%if(dailys.get(i).getG_intDailyCheckup()==0){ %><font color="#FF0000">δ����</font><%}
		                            else if(dailys.get(i).getG_intDailyCheckup()==1){ %>������<%}
		                            else{ %><font color="#FF00FF">δ֪����</font><%} %></div></td>
		  <td><div align="center"><a href="/daily/DailyQueryForMngServlet?flag=6&did=<%=dailys.get(i).getG_intDailyId() %>">��ϸ</a></div></td>
		</tr>
        <%} 
		%>
      </table></td>
  </tr>
  <%}
  else{%><!--���listΪNULL�����������Ϣ-->
  <tr>
    <td height="30" colspan="2" align="center" ><table width="100%" border="1" cellspacing="1" cellpadding="1" >
        <tr>
		  <td width="15%" height="20" align="center" class="style1">�ձ�ID</td>
          <td width="15%" height="20" align="center" class="style1">�ձ�����</td>
          <td width="15%" height="20" align="center" class="style1">����</td>
          <td width="30%" height="20" align="center" class="style1">�ύ����</td>
          <td width="15%" height="20" align="center" class="style1">�Ƿ�����</td>
          <td width="10%" height="20" align="center" class="style1">����</td>
        </tr>
        </table></td>
   </tr>
   <tr>
   <td align="center"><font size="+1" color="#FF0000">û���κ��ձ��������ѯ����</font></td>
   </tr>
  <%
  }%>
</table>
<table width="100%" border="0" >
	    <tr>
	      <td align="center"><input name="button" type="button" id="button" value="����" onClick="goback()" /></td>
	    </tr>
	  </table>
</body>
</html>