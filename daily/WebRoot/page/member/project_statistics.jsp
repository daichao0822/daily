<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*,java.util.*,com.bean.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>项目统计信息</title>
<base target="_self">
<link rel="stylesheet" type="text/css" href="page/member/skin/css/base.css" />
<link rel="stylesheet" type="text/css" href="page/member/skin/css/main.css" />
</head>

<body>
<%
String str_userProjectDailyAmount=request.getParameter("da");
int int_projectWorkTime=Integer.parseInt(request.getParameter("pwt"));//项目总工时
int int_projectRunTime=Integer.parseInt(request.getParameter("prt"));//项目运行时间
int int_userProjectWorkTime=Integer.parseInt(request.getParameter("upwt"));//用户参与项目总工时
int int_taskWorkTime;//任务总工时
int int_userTaskWorkTime;//用户参与任务总工时
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
<td colspan="2" bgcolor="#CBD8AC"  class='title'><span>项目总信息</span></td>
</tr>
<tr>
<td align="center" background="page/member/skin/images/frame/wbg.gif">项目运行时间</td>
<td align="center" background="page/member/skin/images/frame/wbg.gif">目前项目总工时</td>
<td align="center" background="page/member/skin/images/frame/wbg.gif">您参与项目总工时</td>
<td align="center" background="page/member/skin/images/frame/wbg.gif">所占项目工时百分比</td>
<td align="center" background="page/member/skin/images/frame/wbg.gif">目前提交日报数量</td>
</tr>
<tr bgcolor="#FFFFFF">
<td align="center">
<%=int_projectRunTime/86400000 %>&nbsp;日
<%=(int_projectRunTime%86400000)/3600000 %>&nbsp;时
<%=(int_projectRunTime%3600000)/60000 %>&nbsp;分
<%=(int_projectRunTime%60000)/1000 %>&nbsp;秒
</td>
<td align="center">
<%=int_projectWorkTime/86400 %>&nbsp;日
<%=(int_projectWorkTime%86400)/3600 %>&nbsp;时
<%=(int_projectWorkTime%360)/60 %>&nbsp;分
<%=(int_projectWorkTime%60)/1 %>&nbsp;秒
</td>
<td align="center">
<%=int_userProjectWorkTime/86400 %>&nbsp;日
<%=(int_userProjectWorkTime%86400)/3600 %>&nbsp;时
<%=(int_userProjectWorkTime%360)/60 %>&nbsp;分
<%=(int_userProjectWorkTime%60)/1 %>&nbsp;秒
</td>
<td align="center"><%=int_projectPercent %>&nbsp;%</td>
<td align="center"><%=str_userProjectDailyAmount %></td>
</tr>
</table>
<table width="98%" align="center" border="0" cellpadding="4" cellspacing="1" bgcolor="#CBD8AC"  style="margin-bottom:8px">
<tr>
<td width="19%" class='title'>提交项目任务统计结果</td>
</tr>
<tr>
<td align="center" background="page/member/skin/images/frame/wbg.gif">参与任务名称</td>
<td width="15%" align="center" background="page/member/skin/images/frame/wbg.gif">目前任务总工时</td>
<td width="19%" align="center" background="page/member/skin/images/frame/wbg.gif">目前您参与该任务总工时</td>
<td width="16%" align="center" background="page/member/skin/images/frame/wbg.gif">所占该任务工时百分比</td>
<td width="15%" align="center" background="page/member/skin/images/frame/wbg.gif">所占项目工时百分比</td>
<td width="16%" align="center" background="page/member/skin/images/frame/wbg.gif">提交该任务日报数量</td>
</tr>
<%if(list!=null){ 
    for(int i=0;i<list.size();i++){%>
<tr bgcolor="#FFFFFF">
<td align="center">
<%=list.get(i).getG_str_taskName() %></td>
<td align="center">
<%=list.get(i).getG_int_taskWorkTime()/86400 %>&nbsp;日
<%=(list.get(i).getG_int_taskWorkTime()%86400)/3600 %>&nbsp;时
<%=(list.get(i).getG_int_taskWorkTime()%360)/60 %>&nbsp;分
<%=(list.get(i).getG_int_taskWorkTime()%60)/1 %>&nbsp;秒
</td>
<td align="center">
<%=list.get(i).getG_int_userTaskWorkTime()/86400 %>&nbsp;日
<%=(list.get(i).getG_int_userTaskWorkTime()%86400)/3600 %>&nbsp;时
<%=(list.get(i).getG_int_userTaskWorkTime()%360)/60 %>&nbsp;分
<%=(list.get(i).getG_int_userTaskWorkTime()%60)/1 %>&nbsp;秒
</td>
<td align="center"><%=list.get(i).getG_int_taskPercent() %>&nbsp;%</td>
<td align="center"><%=list.get(i).getG_int_projectPercent() %>&nbsp;%</td>
<td align="center"><%=list.get(i).getG_int_dailyAmount() %></td>
</tr>
<%  }
}else{%>
<tr bgcolor="#FFFFFF">
<td align="center"><font color="#FF0000">您尚未提交过项目任务日报</font></td>
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
<td align="center"><input type="button" value="返回" onclick="window.history.go(-1)" /></td>
</tr>
</table>
</body>
</html>