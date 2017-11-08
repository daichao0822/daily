<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*,java.util.*,com.bean.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>临时任务统计信息</title>
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
<td colspan="2" bgcolor="#CBD8AC"  class='title'><span>临时任务统计信息</span>
(<font size="-1" color="#FF0000">项目任务统计可到 参与项目 中查询</font>)
</td>
</tr>
<tr>
<td align="center" background="page/member/skin/images/frame/wbg.gif">任务名称</td>
<td align="center" background="page/member/skin/images/frame/wbg.gif">任务工时</td>
<td align="center" background="page/member/skin/images/frame/wbg.gif">提交日报数量</td>
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
<%=list.get(i).getG_int_taskWorkTime()/86400 %>&nbsp;日
<%=(list.get(i).getG_int_taskWorkTime()%86400)/3600 %>&nbsp;时
<%=(list.get(i).getG_int_taskWorkTime()%360)/60 %>&nbsp;分
<%=list.get(i).getG_int_taskWorkTime()%60 %>&nbsp;秒
</td>
<td align="center">
<%=list.get(i).getG_int_taskDailyAmount() %>
</td>
</tr>
<%}
}
else{ %>
<tr>
<td align="center">您尚未提交任何临时任务日报
</td>
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