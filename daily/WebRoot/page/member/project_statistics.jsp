<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*,java.util.*,com.bean.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>��Ŀͳ����Ϣ</title>
<base target="_self">
<link rel="stylesheet" type="text/css" href="page/member/skin/css/base.css" />
<link rel="stylesheet" type="text/css" href="page/member/skin/css/main.css" />
</head>

<body>
<%
String str_userProjectDailyAmount=request.getParameter("da");
int int_projectWorkTime=Integer.parseInt(request.getParameter("pwt"));//��Ŀ�ܹ�ʱ
int int_projectRunTime=Integer.parseInt(request.getParameter("prt"));//��Ŀ����ʱ��
int int_userProjectWorkTime=Integer.parseInt(request.getParameter("upwt"));//�û�������Ŀ�ܹ�ʱ
int int_taskWorkTime;//�����ܹ�ʱ
int int_userTaskWorkTime;//�û����������ܹ�ʱ
int int_projectPercent=0;
if(int_projectWorkTime!=0){
double dou_projectWorkTime=int_projectWorkTime*1.0;
double dou_userProjectWorkTime=int_userProjectWorkTime*1.0;
int_projectPercent=(int)(dou_userProjectWorkTime/dou_projectWorkTime*100);
}
List<TaskStatistics> list=(List)request.getAttribute("taskStatistics");
 %>
<table width="98%" align="center" border="0" cellpadding="4" cellspacing="1" bgcolor="#CBD8AC"  style="margin-bottom:8px">
<tr bgcolor="#EEF4EA">
<td colspan="2" bgcolor="#CBD8AC"  class='title'><span>��Ŀ����Ϣ</span></td>
</tr>
<tr>
<td align="center" background="page/member/skin/images/frame/wbg.gif">��Ŀ����ʱ��</td>
<td align="center" background="page/member/skin/images/frame/wbg.gif">Ŀǰ��Ŀ�ܹ�ʱ</td>
<td align="center" background="page/member/skin/images/frame/wbg.gif">��������Ŀ�ܹ�ʱ</td>
<td align="center" background="page/member/skin/images/frame/wbg.gif">��ռ��Ŀ��ʱ�ٷֱ�</td>
<td align="center" background="page/member/skin/images/frame/wbg.gif">Ŀǰ�ύ�ձ�����</td>
</tr>
<tr bgcolor="#FFFFFF">
<td align="center">
<%=int_projectRunTime/86400000 %>&nbsp;��
<%=(int_projectRunTime%86400000)/3600000 %>&nbsp;ʱ
<%=(int_projectRunTime%3600000)/60000 %>&nbsp;��
<%=(int_projectRunTime%60000)/1000 %>&nbsp;��
</td>
<td align="center">
<%=int_projectWorkTime/86400 %>&nbsp;��
<%=(int_projectWorkTime%86400)/3600 %>&nbsp;ʱ
<%=(int_projectWorkTime%360)/60 %>&nbsp;��
<%=(int_projectWorkTime%60)/1 %>&nbsp;��
</td>
<td align="center">
<%=int_userProjectWorkTime/86400 %>&nbsp;��
<%=(int_userProjectWorkTime%86400)/3600 %>&nbsp;ʱ
<%=(int_userProjectWorkTime%360)/60 %>&nbsp;��
<%=(int_userProjectWorkTime%60)/1 %>&nbsp;��
</td>
<td align="center"><%=int_projectPercent %>&nbsp;%</td>
<td align="center"><%=str_userProjectDailyAmount %></td>
</tr>
</table>
<table width="98%" align="center" border="0" cellpadding="4" cellspacing="1" bgcolor="#CBD8AC"  style="margin-bottom:8px">
<tr>
<td width="19%" class='title'>�ύ��Ŀ����ͳ�ƽ��</td>
</tr>
<tr>
<td align="center" background="page/member/skin/images/frame/wbg.gif">������������</td>
<td width="15%" align="center" background="page/member/skin/images/frame/wbg.gif">Ŀǰ�����ܹ�ʱ</td>
<td width="19%" align="center" background="page/member/skin/images/frame/wbg.gif">Ŀǰ������������ܹ�ʱ</td>
<td width="16%" align="center" background="page/member/skin/images/frame/wbg.gif">��ռ������ʱ�ٷֱ�</td>
<td width="15%" align="center" background="page/member/skin/images/frame/wbg.gif">��ռ��Ŀ��ʱ�ٷֱ�</td>
<td width="16%" align="center" background="page/member/skin/images/frame/wbg.gif">�ύ�������ձ�����</td>
</tr>
<%if(list!=null){ 
    for(int i=0;i<list.size();i++){%>
<tr bgcolor="#FFFFFF">
<td align="center">
<%=list.get(i).getG_str_taskName() %></td>
<td align="center">
<%=list.get(i).getG_int_taskWorkTime()/86400 %>&nbsp;��
<%=(list.get(i).getG_int_taskWorkTime()%86400)/3600 %>&nbsp;ʱ
<%=(list.get(i).getG_int_taskWorkTime()%360)/60 %>&nbsp;��
<%=(list.get(i).getG_int_taskWorkTime()%60)/1 %>&nbsp;��
</td>
<td align="center">
<%=list.get(i).getG_int_userTaskWorkTime()/86400 %>&nbsp;��
<%=(list.get(i).getG_int_userTaskWorkTime()%86400)/3600 %>&nbsp;ʱ
<%=(list.get(i).getG_int_userTaskWorkTime()%360)/60 %>&nbsp;��
<%=(list.get(i).getG_int_userTaskWorkTime()%60)/1 %>&nbsp;��
</td>
<td align="center"><%=list.get(i).getG_int_taskPercent() %>&nbsp;%</td>
<td align="center"><%=list.get(i).getG_int_projectPercent() %>&nbsp;%</td>
<td align="center"><%=list.get(i).getG_int_dailyAmount() %></td>
</tr>
<%  }
}else{%>
<tr bgcolor="#FFFFFF">
<td align="center"><font color="#FF0000">����δ�ύ����Ŀ�����ձ�</font></td>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>&nbsp;</td>
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