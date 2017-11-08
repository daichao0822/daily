<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*,java.util.*,com.bean.*,com.dao.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>PCB里程碑</title>
<base target="_self">
<link rel="stylesheet" type="text/css" href="page/manager/skin/css/base.css" />
<link rel="stylesheet" type="text/css" href="page/manager/skin/css/main.css" />
<script type="text/javascript">
function checkConfirm(){
	var id=document.getElementsByName("milestoneConfID");
	var i=0;
	for(i=0;i<id.length;i++){
		if(id[i].checked){
			if(confirm("删除后不可恢复，确认要删除该PCB里程碑吗？")){
				return true;
				exit;
			}
			else{
				return false;
				exit;
			}
		}
	}
	if(i==id.length){
		alert("至少选择一个里程碑！");
		return false;
	}
}

function AddMilestoneConf(id){
	window.open("AddMilestoneConfServlet?flag=1&pid="+id,"AddMilestoneConf","directories=no,left=500,top=250,height=200,width=750,location=no,menubar=no,resizable=yes,scrollbars=yes,status=no,toolbar=no",false);
}
</script>
</head>

<body>
<%
List<MileStoneConf> list=(List)request.getAttribute("milestoneConf");
String str_PCBID=request.getParameter("pid");
ChangeIDForName change=new ChangeIDForName();
Connection con=Connect.getConnection();
 %>
 <form name="form" action="DeleteMilestoneOfPCBServlet" method="post" onsubmit="return checkConfirm()">
<table width="98%" align="center" border="0" cellpadding="4" cellspacing="1" bgcolor="#CBD8AC"  style="margin-bottom:8px">
<tr bgcolor="#EEF4EA">
<td colspan="2" bgcolor="#CBD8AC"  class='title'><span>PCB里程碑</span></td>
</tr>
<tr>
<td width="8%" align="center" background="page/PMO/skin/images/frame/wbg.gif">确认ID</td>
<td width="12%" align="center" background="page/PMO/skin/images/frame/wbg.gif">里程碑名称</td>
<td width="13%" align="center" background="page/PMO/skin/images/frame/wbg.gif">所属PCB</td>
<td width="13%" align="center" background="page/PMO/skin/images/frame/wbg.gif">里程碑确认人</td>
<td width="26%" align="center" background="page/PMO/skin/images/frame/wbg.gif">里程碑确认意见</td>
<td width="21%" align="center" background="page/PMO/skin/images/frame/wbg.gif">里程碑确认时间</td>
<td width="7%" align="center" background="page/PMO/skin/images/frame/wbg.gif">选择</td>
</tr>
<%
if(list!=null){
    for(int i=0;i<list.size();i++){
 %>
<tr bgcolor="#FFFFFF">
<td align="center"><%=list.get(i).getG_int_mileStoneConfID() %></td>
<td align="center"><%=change.GetMilestoneName(con,list.get(i).getG_int_mileStoneID()) %></td>
<td align="center"><%=change.GetPCBName(con,list.get(i).getG_int_mileStoneConfPCB()) %></td>
<td align="center"><%=change.getUserName(con,list.get(i).getG_int_mileStoneConfUser()) %></td>
<td align="center"><%=list.get(i).getG_str_mileStoneConfOpinion() %></td>
<td align="center"><%=list.get(i).getG_tim_mileStoneConfTime() %></td>
<td align="center"><input type="checkbox" name="milestoneConfID" value="<%=list.get(i).getG_int_mileStoneConfID() %>" /></td>

</tr>
 <%}
 }
 else{ %>
<tr bgcolor="#FFFFFF">
<td>&nbsp;</td>
<td align="center">&nbsp;</td>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td align="center"><font color="#FF0000">没有里程碑确认</font></td>
<td>&nbsp;</td>
<td>&nbsp;</td>

</tr>
 <%} %>
</table>
<%con.close(); %>
<table width="98%" align="center">
  <tr>
<td align="center">
<input type="submit" value="删除里程碑" />&nbsp;
<input type="button" value="添加里程碑" onclick="AddMilestoneConf(<%=str_PCBID %>)" />&nbsp;
<input type="button" value="关闭" onclick="window.close()" />
</td>
</tr>
</table>
</form>
</body>
</html>