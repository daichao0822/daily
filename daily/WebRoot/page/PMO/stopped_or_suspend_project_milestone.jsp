<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*,java.util.*,com.bean.*,com.dao.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>里程碑</title>
<base target="_self">
<link rel="stylesheet" type="text/css" href="page/manager/skin/css/base.css" />
<link rel="stylesheet" type="text/css" href="page/manager/skin/css/main.css" />
<script type="text/javascript">

</script>
</head>

<body>
<%
List<MileStoneConf> list=(List)request.getAttribute("milestoneConf");
ChangeIDForName change=new ChangeIDForName();
Connection con=Connect.getConnection();
 %>
 <form name="form" action="" method="post" onsubmit="return checkConfirm()">
<table width="98%" align="center" border="0" cellpadding="4" cellspacing="1" bgcolor="#CBD8AC"  style="margin-bottom:8px">
<tr bgcolor="#EEF4EA">
<td colspan="2" bgcolor="#CBD8AC"  class='title'><span>PCB里程碑</span></td>
</tr>
<tr>
<td width="12%" align="center" background="page/PMO/skin/images/frame/wbg.gif">里程碑名称</td>
<td width="16%" align="center" background="page/PMO/skin/images/frame/wbg.gif">所属PCB</td>
<td width="16%" align="center" background="page/PMO/skin/images/frame/wbg.gif">里程碑确认人</td>
<td width="27%" align="center" background="page/PMO/skin/images/frame/wbg.gif">里程碑确认意见</td>
<td width="18%" align="center" background="page/PMO/skin/images/frame/wbg.gif">里程碑确认时间</td>
</tr>
<%
if(list!=null){
    for(int i=0;i<list.size();i++){
 %>
<tr bgcolor="#FFFFFF">
<td align="center"><%=change.GetMilestoneName(con,list.get(i).getG_int_mileStoneID()) %></td>
<td align="center"><%=change.GetPCBName(con,list.get(i).getG_int_mileStoneConfPCB()) %></td>
<td align="center"><%=change.getUserName(con,list.get(i).getG_int_mileStoneConfUser()) %></td>
<td align="center"><%=list.get(i).getG_str_mileStoneConfOpinion() %></td>
<td align="center"><%=list.get(i).getG_tim_mileStoneConfTime() %></td>

</tr>
 <%}
 }
 else{ %>
<tr bgcolor="#FFFFFF">
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td align="center"><font color="#FF0000">没有里程碑</font></td>
<td>&nbsp;</td>
</tr>
 <%} %>
</table>
<%con.close(); %>
<table width="98%" align="center">
  <tr>
<td align="center">
<input type="button" value="关闭" onclick="window.close()" />
</td>
</tr>
</table>
</body>
</html>