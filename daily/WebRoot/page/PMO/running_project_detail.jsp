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
	window.open("CheckMileStoneServlet?flag=3&id="+id,"CheckMileStone","directories=no,left=500,top=250,height=200,width=750,location=no,menubar=no,resizable=yes,scrollbars=yes,status=no,toolbar=no",false);
}

function AddManager(id){
	window.open("AddManagerServlet?flag=1&id="+id,"AddManager","directories=no,left=500,top=250,height=200,width=750,location=no,menubar=no,resizable=yes,scrollbars=yes,status=no,toolbar=no",false);
}

function ChangeManager(id,old_manager){
	window.open("ChangeManagerServlet?o_mng="+old_manager+"&flag=1&id="+id,"ChangeManager","directories=no,left=500,top=250,height=200,width=750,location=no,menubar=no,resizable=yes,scrollbars=yes,status=no,toolbar=no",false);
}

function AddPCB(id){
	window.open("page/PMO/add_new_pcb.jsp?id="+id,"AddPCB","directories=no,left=200,top=150,height=260,width=1070,location=no,menubar=no,resizable=yes,scrollbars=yes,status=no,toolbar=no",false);
}

function DeleteManger(pid,uid){
	if(confirm("删除后，该用户关于此项目的所有信息将被删除，确认删除吗？")){
		var url = "DeleteManagerServlet?pid=" + pid + "&uid="+ uid;
		   if (window.XMLHttpRequest) {
			   http_request = new XMLHttpRequest();
			   if (http_request.overrideMimeType) {
				   http_request.overrideMimeType("text/xml");
			   }
		   } else if (window.ActiveXObject) {
			   try {
				   http_request = new ActiveXObject("Msxml2.XMLHTTP");
			   } catch (e) {
				   try {
					   http_request = new ActiveXObject("Microsoft.XMLHTTP");

				   } catch (e2) {
					   http_request = false;
				   }
			   }
		   }
		   if (!http_request) {
			   alert("不能创建XMLHttpRequest对象实例");
			   return false;
		   } else {
			   http_request.open("POST", url, true);
			   http_request.onreadystatechange = updatepage1;
			   http_request.send(null);
		   }
	}
}

function updatepage1() {
	if (http_request.readyState == 4) {
		if (http_request.status == 200) {
			if (http_request.responseText == 0) {
				alert("删除项目经理失败！");
			} else if (http_request.responseText == 1) {
				alert("删除项目经理成功！");
				window.location.reload();
			} else if(http_request.responseText == 2){
			    alert("您已将自己的项目经理角色删除，请重新登录！");
			    window.top.location.replace("LogoutServlet");
			}else if(http_request.responseText == 4){
			    alert("错误！您不能继续操作，可能原因：1、session超时  2、您已退出  3、您的账号已在别处登录，请重新登录");
			    top.location.replace("http://localhost/daily");
			}
			else{
			alert("程序异常，请联系管理员（错误页面：page/PMO/running_project_detail.jsp：76）");
			}
		} else {
			alert("您所请求的页面有异常");
		}
	}
}

function DeletePCB(pid){
	if(confirm("确认删除PCB_ID="+pid+" 的PCB吗？")){
		var url = "DeletePCBServlet?pid=" + pid;
		   if (window.XMLHttpRequest) {
			   http_request = new XMLHttpRequest();
			   if (http_request.overrideMimeType) {
				   http_request.overrideMimeType("text/xml");
			   }
		   } else if (window.ActiveXObject) {
			   try {
				   http_request = new ActiveXObject("Msxml2.XMLHTTP");
			   } catch (e) {
				   try {
					   http_request = new ActiveXObject("Microsoft.XMLHTTP");

				   } catch (e2) {
					   http_request = false;
				   }
			   }
		   }
		   if (!http_request) {
			   alert("不能创建XMLHttpRequest对象实例");
			   return false;
		   } else {
			   http_request.open("POST", url, true);
			   http_request.onreadystatechange = updatepage2;
			   http_request.send(null);
		   }
	}
}

function updatepage2() {
	if (http_request.readyState == 4) {
		if (http_request.status == 200) {
			if (http_request.responseText == 0) {
				alert("删除PCB失败！");
			} else if (http_request.responseText == 1) {
				alert("删除PCB成功！");
				window.location.reload();
			} else if(http_request.responseText == 2){
			    alert("session超时或您已退出，请重新登录");
			    opener.top.location.replace("http://localhost/daily");
			}
			else{
			alert("程序异常，请联系管理员（错误页面：page/PMO/running_project_detail.jsp：125）");
			}
		} else {
			alert("您所请求的页面有异常");
		}
	}
}

function CheckTask(tid,pid){
	window.open("TaskDetailForPMOServlet?tid="+tid+"&pid="+pid,"CheckTask"
,"directories=no,left=200,top=150,height=200,width=1000,location=no,menubar=no,resizable=yes,scrollbars=yes,status=no,toolbar=no",false);
}
function DeleteTask(tid,pid){
	if(confirm("删除后，任务分配及相关日报也将被删除，确认删除该任务吗？")){
		var url = "DeleteTaskFromProjectServlet?tid=" + tid+"&pid="+pid;
		   if (window.XMLHttpRequest) {
			   http_request = new XMLHttpRequest();
			   if (http_request.overrideMimeType) {
				   http_request.overrideMimeType("text/xml");
			   }
		   } else if (window.ActiveXObject) {
			   try {
				   http_request = new ActiveXObject("Msxml2.XMLHTTP");
			   } catch (e) {
				   try {
					   http_request = new ActiveXObject("Microsoft.XMLHTTP");

				   } catch (e2) {
					   http_request = false;
				   }
			   }
		   }
		   if (!http_request) {
			   alert("不能创建XMLHttpRequest对象实例");
			   return false;
		   } else {
			   http_request.open("POST", url, true);
			   http_request.onreadystatechange = updatepage3;
			   http_request.send(null);
		   }
	}
}

function updatepage3() {
	if (http_request.readyState == 4) {
		if (http_request.status == 200) {
			if (http_request.responseText == 0) {
				alert("删除任务失败！");
			} else if (http_request.responseText == 1) {
				alert("删除任务成功！");
				window.location.reload();
			}else if(http_request.responseText == 2){
			    alert("session超时或您已退出，请重新登录");
			    top.location.replace("http://localhost/daily");
			}
			else{
			alert("程序异常，请联系管理员（错误页面：page/PMO/running_project_detail.jsp：187）");
			}
		} else {
			alert("您所请求的页面有异常");
		}
	}
}

function AddTask(pid){
	window.open("AddTaskForProjectServlet?flag=1&pid="+pid,"AddTask"
,"directories=no,left=200,top=150,height=220,width=950,location=no,menubar=no,resizable=yes,scrollbars=yes,status=no,toolbar=no",false);
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
<td align="center">正在运行</td>
<td align="center"><%=proDetail.get(i).getG_timProjectBeginTime() %></td>
<td align="center">
<%if(proDetail.get(i).getG_timProjectEndTime()==null){
%>&nbsp;
<%
}else{%><%=proDetail.get(i).getG_timProjectEndTime() %><%}%></td>
<td align="center">
<input type="button" name="edit" value="修改项目状态" onclick="ChangeStatus(<%=proDetail.get(i).getG_intProjectId() %>)" />&nbsp;
<%
if(change.getUserName(con,proDetail.get(i).getG_intProjectManager()).equals("无")){
	%>
    <input type="button" name="AddManager" value="添加项目经理" onclick="AddManager(<%=proDetail.get(i).getG_intProjectId() %>)" />
	<%
}
else{
	%>
    <input type="button" name="ChangeManager" value="更改项目经理" onclick="ChangeManager(<%=proDetail.get(i).getG_intProjectId() %>,<%=proDetail.get(i).getG_intProjectManager() %>)" />&nbsp;
    <input type="button" name="DeleteManager" value="删除项目经理" onclick="DeleteManger(<%=proDetail.get(i).getG_intProjectId() %>,<%=proDetail.get(i).getG_intProjectManager()%>)" />
	<%
}
%>
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
<td colspan="2" bgcolor="#CBD8AC"><input type="button" value="添加PCB" onclick="AddPCB(<%=proDetail.get(0).getG_intProjectId() %>)" /></td>
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
<input type="button" value="查看里程碑" onclick="CheckMileStone(<%=pcb.get(i).getG_intPCBId() %>)" />&nbsp;
<input type="button" value="删除该PCB" onclick="DeletePCB(<%=pcb.get(i).getG_intPCBId() %>)" />
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
<td colspan="2" bgcolor="#CBD8AC"  class='title'><span>项目任务&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input type="button" value="添加任务" onclick="AddTask(<%=proDetail.get(0).getG_intProjectId() %>)" /></span></td>
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
<input type="button" name="taskDetail" value="详细" onclick="CheckTask(<%=task.get(i).getG_intTaskId() %>,<%=proDetail.get(0).getG_intProjectId() %>)" />&nbsp;
<input type="button" name="delete" value="删除" onclick="DeleteTask(<%=task.get(i).getG_intTaskId() %>,<%=proDetail.get(0).getG_intProjectId() %>)" /></td>
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