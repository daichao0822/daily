<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*,java.util.*,com.bean.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>��ʱ����ͳ����Ϣ</title>
<base target="_self">
<link rel="stylesheet" type="text/css" href="page/member/skin/css/base.css" />
<link rel="stylesheet" type="text/css" href="page/member/skin/css/main.css" />
</head>

<body>
<%
List<TempTaskStatistics> list=(List)request.getAttribute("list");
 %>
<table width="98%" align="center" border="0" cellpadding="4" cellspacing="1" bgcolor="#CBD8AC"  style="margin-bottom:8px">
<tr bgcolor="#EEF4EA">
<td colspan="2" bgcolor="#CBD8AC"  class='title'><span>��ʱ����ͳ����Ϣ</span>
(<font size="-1" color="#FF0000">��Ŀ����ͳ�ƿɵ� ������Ŀ �в�ѯ</font>)
</td>
</tr>
<tr>
<td align="center" background="page/member/skin/images/frame/wbg.gif">��������</td>
<td align="center" background="page/member/skin/images/frame/wbg.gif">����ʱ</td>
<td align="center" background="page/member/skin/images/frame/wbg.gif">�ύ�ձ�����</td>
</tr>
<%
if(list!=null){
for(int i=0;i<list.size();i++){
 %>
<tr bgcolor="#FFFFFF">
<td align="center">
<%=list.get(i).getG_str_taskName() %>
</td>
<td align="center">
<%=list.get(i).getG_int_taskWorkTime()/86400 %>&nbsp;��
<%=(list.get(i).getG_int_taskWorkTime()%86400)/3600 %>&nbsp;ʱ
<%=(list.get(i).getG_int_taskWorkTime()%360)/60 %>&nbsp;��
<%=list.get(i).getG_int_taskWorkTime()%60 %>&nbsp;��
</td>
<td align="center">
<%=list.get(i).getG_int_taskDailyAmount() %>
</td>
</tr>
<%}
}
else{ %>
<tr>
<td align="center">����δ�ύ�κ���ʱ�����ձ�
</td>
<td>&nbsp;</td>
<td>&nbsp;</td>
</tr>
<%} %>
</table>
<table width="98%" align="center">
  <tr>
<td align="center"><input type="button" value="����" onclick="window.history.go(-1)" /></td>
</tr>
</table>
</body>
</html>