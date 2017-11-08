<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*,java.util.*,com.bean.*,com.dao.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>在运行项目详细信息</title>
<base target="_self">
<link rel="stylesheet" type="text/css" href="page/manager/skin/css/base.css" />
<link rel="stylesheet" type="text/css" href="page/manager/skin/css/main.css" />
</head>
<script type="text/javascript">
function ChangeStatus(id){
	window.open("ChangeProjectStatusServlet?flag=1&id="+id,"ChangeProjectStatus","directories=no,left=200,top=250,height=200,width=750,location=no,menubar=no,resizable=yes,scrollbars=yes,status=no,toolbar=no",false);
}

function CheckMileStone(id){
	window.open("CheckMileStoneServlet?flag=2&id="+id,"CheckMileStone","directories=no,left=500,top=250,height=200,width=750,location=no,menubar=no,resizable=yes,scrollbars=yes,status=no,toolbar=no",false);
}

function CheckTask(tid,pid){
	window.open("TaskDetailForPMOServlet?tid="+tid+"&pid="+pid,"CheckTask"
,"directories=no,left=200,top=150,height=200,width=1000,location=no,menubar=no,resizable=yes,scrollbars=yes,status=no,toolbar=no",false);
}
</script>
<body>
<%
List<Project> proDetail=(List)request.getAttribute("project");
List<User> user=(List)request.getAttribute("user");
List<Task> task=(List)request.getAttribute("task");
List<PCB> pcb=(List)request.getAttribute("pcb");
ChangeIDForName change=new ChangeIDForName();
Connection con=Connect.getConnection();
 %>
<table width="98%" align="center" border="0" cellpadding="4" cellspacing="1" bgcolor="#CBD8AC"  style="margin-bottom:8px">
<tr bgcolor="#EEF4EA">
<td colspan="2" bgcolor="#CBD8AC"  class='title'><span>项目详细</span></td>
</tr>
<tr>
<td width="5%" align="center" background="page/PMO/skin/images/frame/wbg.gif">项目ID</td>
<td width="12%" align="center" background="page/PMO/skin/images/frame/wbg.gif">项目名称</td>
<td width="8%" align="center" background="page/PMO/skin/images/frame/wbg.gif">项目编号</td>
<td width="8%" align="center" background="page/PMO/skin/images/frame/wbg.gif">项目经理</td>
<td width="8%" align="center" background="page/PMO/skin/images/frame/wbg.gif">项目状态</td>
<td width="17%" align="center" background="page/PMO/skin/images/frame/wbg.gif">项目开始时间</td>
<td width="17%" align="center" background="page/PMO/skin/images/frame/wbg.gif">项目结束时间</td>
<td width="25%" align="center" background="page/PMO/skin/images/frame/wbg.gif">操作</td>
</tr>
<%
if(proDetail!=null){
    for(int i=0;i<proDetail.size();i++){
 %>
<tr bgcolor="#FFFFFF">
<td align="center"><%=proDetail.get(i).getG_intProjectId() %></td>
<td align="center"><%=proDetail.get(i).getG_strProjectName() %></td>
<td align="center"><%=proDetail.get(i).getG_strProjectNumber() %></td>
<td align="center"><%=change.getUserName(con,proDetail.get(i).getG_intProjectManager()) %></td>
<td align="center">已暂停</td>
<td align="center"><%=proDetail.get(i).getG_timProjectBeginTime() %></td>
<td align="center">
<%if(proDetail.get(i).getG_timProjectEndTime()==null){
%>&nbsp;
<%
}else{%><%=proDetail.get(i).getG_timProjectEndTime() %><%}%></td>
<td align="center">
<input type="button" name="edit" value="修改项目状态" onclick="ChangeStatus(<%=proDetail.get(i).getG_intProjectId() %>)" />&nbsp;
</td>
</tr>
 <%}
 }
 else{ %>
<tr bgcolor="#FFFFFF">
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td align="center"><font color="#FF0000">目前没有已停止运行项目</font></td>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>&nbsp;</td>
</tr>
 <%} %>
</table>

<table width="98%" align="center" border="0" cellpadding="4" cellspacing="1" bgcolor="#CBD8AC"  style="margin-bottom:8px">
<tr bgcolor="#EEF4EA">
<td colspan="2" bgcolor="#CBD8AC"  class='title'><span>项目PCB</span></td>
</tr>
<tr>
<td width="4%" align="center" background="page/PMO/skin/images/frame/wbg.gif">PCB-ID</td>
<td width="6%" align="center" background="page/PMO/skin/images/frame/wbg.gif">PCB名称</td>
<td width="8%" align="center" background="page/PMO/skin/images/frame/wbg.gif">所属项目</td>
<td width="6%" align="center" background="page/PMO/skin/images/frame/wbg.gif">备料数量</td>
<td width="6%" align="center" background="page/PMO/skin/images/frame/wbg.gif">样品数量</td>
<td width="6%" align="center" background="page/PMO/skin/images/frame/wbg.gif">发货数量</td>
<td width="6%" align="center" background="page/PMO/skin/images/frame/wbg.gif">生产方式</td>
<td width="7%" align="center" background="page/PMO/skin/images/frame/wbg.gif">确认人</td>
<td width="20%" align="center" background="page/PMO/skin/images/frame/wbg.gif">确认意见</td>
<td width="15%" align="center" background="page/PMO/skin/images/frame/wbg.gif">确认时间</td>
<td width="16%" align="center" background="page/PMO/skin/images/frame/wbg.gif">操作</td>

</tr>
<%
if(pcb!=null){
    for(int i=0;i<pcb.size();i++){
 %>
<tr bgcolor="#FFFFFF">
<td align="center"><%=pcb.get(i).getG_intPCBId() %></td>
<td align="center"><%=pcb.get(i).getG_strPCBName() %></td>
<td align="center"><%=change.getProjectName(con,pcb.get(i).getG_intPCBProject()) %></td>
<td align="center"><%=pcb.get(i).getG_intPCBAmount() %></td>
<td align="center"><%=pcb.get(i).getG_intPCBSample() %></td>
<td align="center"><%=pcb.get(i).getG_intPCBDeliver() %></td>
<td align="center"><%if(pcb.get(i).getG_intPCBProduceStyle()==0){
                         %>自主
                         <%
                         }else{
                         %>外协
                         <%
                         } %></td>
<td align="center"><%=change.getUserName(con,pcb.get(i).getG_intPCBConfirmUser()) %></td>
<td align="center"><%=pcb.get(i).getG_strPCBConfirmOpinion() %></td>
<td align="center"><%=pcb.get(i).getG_timPCBConfirmTime() %></td>
<td align="center">
<input type="button" value="查看里程碑" onclick="CheckMileStone(<%=pcb.get(i).getG_intPCBId() %>)" />
</td>
</tr>
 <%}
 }
 else{%>
<tr bgcolor="#FFFFFF">
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td align="center"></td>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td align="center">&nbsp;</td>
<td align="center"><font color="#FF0000">目前该项目没有PCB</font></td>
<td align="center">&nbsp;</td>
<td align="center">&nbsp;</td>
</tr>
 <%} %>
 </table>


<table width="98%" align="center" border="0" cellpadding="4" cellspacing="1" bgcolor="#CBD8AC"  style="margin-bottom:8px">
<tr bgcolor="#EEF4EA">
<td colspan="2" bgcolor="#CBD8AC"  class='title'><span>项目任务</span></td>
</tr>
<tr>
<td width="11%" align="center" background="page/PMO/skin/images/frame/wbg.gif">任务ID</td>
<td width="29%" align="center" background="page/PMO/skin/images/frame/wbg.gif">任务名称</td>
<td width="18%" align="center" background="page/PMO/skin/images/frame/wbg.gif">任务类型</td>
<td width="20%" align="center" background="page/PMO/skin/images/frame/wbg.gif">所属项目</td>
<td width="22%" align="center" background="page/PMO/skin/images/frame/wbg.gif">操作</td>
</tr>
<%
if(task!=null){
    for(int i=0;i<task.size();i++){
 %>
 <tr bgcolor="#FFFFFF">
<td align="center"><%=task.get(i).getG_intTaskId() %></td>
<td align="center"><%=change.getTaskName(con,task.get(i).getG_intTaskId()) %></td>
<td align="center">项目任务</td>
<td align="center"><%=proDetail.get(0).getG_strProjectName() %></td>
<td align="center">
<input type="button" name="taskDetail" value="详细" onclick="CheckTask(<%=task.get(i).getG_intTaskId() %>,<%=proDetail.get(0).getG_intProjectId() %>)" /></td>
</tr>
 <%}
 }
 else{ %>
 <tr bgcolor="#FFFFFF">
 <td align="center">&nbsp;</td>
 <td align="center"><font color="#FF0000">目前该项目没有任务</font></td>
 <td align="center">&nbsp;</td>
 <td>&nbsp;</td>
 <td>&nbsp;</td>
 </tr>
 <%} %>
</table>

<table width="98%" align="center" border="0" cellpadding="4" cellspacing="1" bgcolor="#CBD8AC"  style="margin-bottom:8px">
<tr bgcolor="#EEF4EA">
<td colspan="2" bgcolor="#CBD8AC"  class='title'><span>项目人员</span></td>
</tr>
<tr>
<td width="11%" align="center" background="page/PMO/skin/images/frame/wbg.gif">ID</td>
<td width="22%" align="center" background="page/PMO/skin/images/frame/wbg.gif">姓名</td>
<td width="16%" align="center" background="page/PMO/skin/images/frame/wbg.gif">性别</td>
<td width="29%" align="center" background="page/PMO/skin/images/frame/wbg.gif">所属部门</td>
<td width="22%" align="center" background="page/PMO/skin/images/frame/wbg.gif">E-mail</td>
</tr>
<%
if(user!=null){
    for(int i=0;i<user.size();i++){
 %>
<tr bgcolor="#FFFFFF">
<td align="center"><%=user.get(i).getG_intUserId() %></td>
<td align="center"><%=user.get(i).getG_strUserName() %></td>
<td align="center"><%=user.get(i).getG_strSex()%></td>
<td align="center"><%=change.GetDepartmentName(con,user.get(i).getG_intDepartment()) %></td>
<td align="center"><%=user.get(i).getG_strEmail() %></td>
</tr>
<%}
}else{ %>
<tr bgcolor="#FFFFFF">
<td align="center">&nbsp;</td>
<td align="center">&nbsp;</td>
<td align="center">&nbsp;</td>
<td align="center"><font color="#FF0000">目前该项目没有项目人员</font></td>
<td align="center">&nbsp;</td>
</tr>
<%}%>
</table>
<%con.close(); %>
<table width="98%" align="center">
  <tr>
<td align="center">
<input type="button" value="返回" onclick="window.history.go(-1)" />
</td>
</tr>
</table>
</body>
</html>