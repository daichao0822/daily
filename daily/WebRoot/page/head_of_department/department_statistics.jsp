<%@ page language="java" import="java.util.*" import="java.sql.*,com.bean.*,com.dao.*"  pageEncoding="gb2312"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>����ͳ��</title>
<base target="_self">
<link rel="stylesheet" type="text/css" href="page/head_of_department/skin/css/base.css" />
<link rel="stylesheet" type="text/css" href="page/head_of_department/skin/css/main.css" />
<script type="text/javascript">
function newLocation()
{
		window.history.back();
}
</script>
</head>
<body leftmargin="8" topmargin='8'>
<%
List<DailyStatisticsForDep> dailySta=(List<DailyStatisticsForDep>)request.getAttribute("dailySta");
List<WorkTimeStaForDep> workTimeSta=(List<WorkTimeStaForDep>)request.getAttribute("workTimeSta");
 %>
<br >
<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td><div style='float:left'> <img height="14" src="page/head_of_department/skin/images/frame/book1.gif" width="20" />&nbsp;������Ա�ձ�ͳ����Ϣ�� </div>
      </td>
  </tr>
  <tr>
    <td height="1" background="page/head_of_department/skin/images/frame/sp_bg.gif" style='padding:0px'></td>
  </tr>
</table>

<table width="98%" align="center" border="0" cellpadding="4" cellspacing="1" bgcolor="#CBD8AC" >
  <tr bgcolor="#EEF4EA">
    <td colspan="2" background="page/head_of_department/skin/images/frame/wbg.gif" class='title'><span>�ձ�ͳ����Ϣ</span></td>
  </tr>
  </table>
<table width="98%" align="center" border="0" cellpadding="4" cellspacing="1" bgcolor="#CBD8AC" style="margin-bottom:8px">
  <tr bgcolor="#FFFFFF">
    <td width="6%" align="center">�û�ID</td>
    <td width="7%" align="center">�û�����</td>
    <td width="13%" align="center">�����ύ��Ŀ�����ձ�����</td>
    <td width="13%" align="center">�����ύ��ʱ�����ձ�����</td>
    <td width="15%" align="center">���һ���ύ��Ŀ�����ձ�����</td>
    <td width="15%" align="center">���һ���ύ��ʱ�����ձ�����</td>
    <td width="16%" align="center">���һ���ύ��Ŀ�����ձ�����</td>
    <td width="15%" align="center">���һ���ύ��ʱ�����ձ�����</td>
  </tr>
  <%
  if(dailySta!=null){
      for(int i=0;i<dailySta.size();i++){
      %>
  <tr bgcolor="#FFFFFF">
    <td align="center"><%=dailySta.get(i).getG_int_useID() %></td>
    <td align="center"><%=dailySta.get(i).getG_str_userName() %></td>
    <td align="center"><%=dailySta.get(i).getG_int_proDailyCount() %></td>
    <td align="center"><%=dailySta.get(i).getG_int_tempDailyCount() %></td>
    <td align="center"><%=dailySta.get(i).getG_int_proMonthDaily() %></td>
    <td align="center"><%=dailySta.get(i).getG_int_tempMonthDaily() %></td>
    <td align="center"><%=dailySta.get(i).getG_int_proWeekDaily() %></td>
    <td align="center"><%=dailySta.get(i).getG_int_tempWeekDaily() %> </td>
  </tr>
      <%
      }
  }
  else{
  %>
  <tr bgcolor="#FFFFFF">
     <td>&nbsp;</td>
     <td>&nbsp;</td>
     <td>&nbsp;</td>
     <td><font color="#FF0000">û����Ŀ��Ա</font></td>
     <td>&nbsp;</td>
     <td>&nbsp;</td>
     <td>&nbsp;</td>
     <td>&nbsp;</td>
  </tr>
  <%
  }
   %>
  
</table>

<p>&nbsp;</p>
<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td><div style='float:left'> <img height="14" src="page/head_of_department/skin/images/frame/book1.gif" width="20" />&nbsp;������Ա��ʱͳ����Ϣ�� </div></td>
  </tr>
  <tr>
    <td height="1" background="page/head_of_department/skin/images/frame/sp_bg.gif" style='padding:0px'></td>
  </tr>
</table>
<table width="98%" align="center" border="0" cellpadding="4" cellspacing="1" bgcolor="#CBD8AC" >
  <tr bgcolor="#EEF4EA">
    <td colspan="2" background="page/head_of_department/skin/images/frame/wbg.gif" class='title'><span>��ʱ��Ϣ</span></td>
  </tr>
</table>
<table width="98%" align="center" border="0" cellpadding="4" cellspacing="1" bgcolor="#CBD8AC" style="margin-bottom:8px">
  <tr bgcolor="#FFFFFF">
    <td width="6%" align="center">�û�ID</td>
    <td width="7%" align="center">�û�����</td>
    <td width="13%" align="center">������Ŀ�����ܹ�ʱ</td>
    <td width="13%" align="center">������ʱ�����ܹ�ʱ</td>
    <td width="15%" align="center">���һ����Ŀ����ʱ</td>
    <td width="15%" align="center">���һ����ʱ����ʱ</td>
    <td width="16%" align="center">���һ����Ŀ����ʱ</td>
    <td width="15%" align="center">���һ����ʱ����ʱ</td>
  </tr>
  <%
  if(workTimeSta!=null){
      for(int i=0;i<workTimeSta.size();i++){
      %>
  <tr bgcolor="#FFFFFF">
    <td align="center">
    <%=workTimeSta.get(i).getG_int_userID() %>
    </td>
    <td align="center">
    <%=workTimeSta.get(i).getG_str_userName() %>
    </td>
    <td align="center">
	<%
	if(workTimeSta.get(i).getG_int_proWorkTimeCount()==0){
	%>&nbsp;
	<%
	}else{
	%>
    <%=workTimeSta.get(i).getG_int_proWorkTimeCount()/86400 %>&nbsp;��
    <%=(workTimeSta.get(i).getG_int_proWorkTimeCount()%86400)/3600 %>&nbsp;ʱ
    <%=(workTimeSta.get(i).getG_int_proWorkTimeCount()%3600)/60 %>&nbsp;��
    <%=(workTimeSta.get(i).getG_int_proWorkTimeCount()%60) %>&nbsp;��
    <%} %>
    </td>
    <td align="center">
    <%
	if(workTimeSta.get(i).getG_int_tempWorkTimeCount()==0){
	%>&nbsp;
	<%
	}else{
	%>
    <%=workTimeSta.get(i).getG_int_tempWorkTimeCount()/86400 %>&nbsp;��
    <%=(workTimeSta.get(i).getG_int_tempWorkTimeCount()%86400)/3600 %>&nbsp;ʱ
    <%=(workTimeSta.get(i).getG_int_tempWorkTimeCount()%3600)/60 %>&nbsp;��
    <%=(workTimeSta.get(i).getG_int_tempWorkTimeCount()%60) %>&nbsp;��
    <%} %>
    </td>
    <td align="center">
    <%
	if(workTimeSta.get(i).getG_int_proMonthWorkTime()==0){
	%>&nbsp;
	<%
	}else{
	%>
    <%=workTimeSta.get(i).getG_int_proMonthWorkTime()/86400 %>&nbsp;��
    <%=(workTimeSta.get(i).getG_int_proMonthWorkTime()%86400)/3600 %>&nbsp;ʱ
    <%=(workTimeSta.get(i).getG_int_proMonthWorkTime()%3600)/60 %>&nbsp;��
    <%=(workTimeSta.get(i).getG_int_proMonthWorkTime()%60) %>&nbsp;��
    <%} %>
    </td>
    <td align="center">
    <%
	if(workTimeSta.get(i).getG_int_tempMonthWorkTime()==0){
	%>&nbsp;
	<%
	}else{
	%>
    <%=workTimeSta.get(i).getG_int_tempMonthWorkTime()/86400 %>&nbsp;��
    <%=(workTimeSta.get(i).getG_int_tempMonthWorkTime()%86400)/3600 %>&nbsp;ʱ
    <%=(workTimeSta.get(i).getG_int_tempMonthWorkTime()%3600)/60 %>&nbsp;��
    <%=(workTimeSta.get(i).getG_int_tempMonthWorkTime()%60) %>&nbsp;��
    <%} %>
    </td>
    <td align="center">
    <%
	if(workTimeSta.get(i).getG_int_proWeekWorkTime()==0){
	%>&nbsp;
	<%
	}else{
	%>
    <%=workTimeSta.get(i).getG_int_proWeekWorkTime()/86400 %>&nbsp;��
    <%=(workTimeSta.get(i).getG_int_proWeekWorkTime()%86400)/3600 %>&nbsp;ʱ
    <%=(workTimeSta.get(i).getG_int_proWeekWorkTime()%3600)/60 %>&nbsp;��
    <%=(workTimeSta.get(i).getG_int_proWeekWorkTime()%60) %>&nbsp;��
    <%} %>
    </td>
    <td align="center">
    <%
	if(workTimeSta.get(i).getG_int_tempWeekWorkTime()==0){
	%>&nbsp;
	<%
	}else{
	%>
    <%=workTimeSta.get(i).getG_int_tempWeekWorkTime()/86400 %>&nbsp;��
    <%=(workTimeSta.get(i).getG_int_tempWeekWorkTime()%86400)/3600 %>&nbsp;ʱ
    <%=(workTimeSta.get(i).getG_int_tempWeekWorkTime()%3600)/60 %>&nbsp;��
    <%=(workTimeSta.get(i).getG_int_tempWeekWorkTime()%60) %>&nbsp;��
    <%} %>
    </td>
  </tr>
  <%
      }
  }
  else{
  %>
  <tr bgcolor="#FFFFFF">
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td align="center"><font color="#FF0000">û�в�����Ա</font></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <%
  }
   %>
</table>
<table width="98%" align="center" border="0" cellpadding="4" cellspacing="1" bgcolor="#CBD8AC">
  <tr bgcolor="#FFFFFF">
    <td align="center" height="32">
    <input type='button' class="coolbg np" onClick="newLocation()" value='����' /></td>
  </tr>
</table>
</body>
</html>
