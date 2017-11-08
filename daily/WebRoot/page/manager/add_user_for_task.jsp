<%@ page contentType="text/html; charset=gb2312" language="java"
	import="java.sql.*,java.util.*,com.bean.*,com.dao.*" errorPage=""%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
		<title>分配任务</title>
		<base target="_self">
		<link rel="stylesheet" type="text/css"
			href="page/manager/skin/css/base.css" />
		<link rel="stylesheet" type="text/css"
			href="page/manager/skin/css/main.css" />
            <script type="text/javascript" src="${pageContext.request.contextPath }/My97DatePicker/WdatePicker.js"></script>
<script language="javascript">
function CloseWindow(){
	window.close();
}

function check(){
	if(checkDate()==true){
		if(checkOpinion()==true){
			return ture;
		}
		else {
			return false;
		}
	}
	else{
		return false;
	}
}

function checkOpinion(){
	var opinion=document.getElementById("opinion").value;
	if(opinion==""){
		if(confirm("确认意见为空，确认不填写吗？")){
			return true;
		}
		else{
			return false;
		}
	}
	else{
		return true;
	}
}

function checkDate(){
	 try
        {
            var startTime=document.getElementById("startTime").value;
            var endTime=document.getElementById("endTime").value;
            if(startTime==""){
            alert("请选择开始时间！");
            return false;
            }
            else if(endTime==""){
            alert("请选择截止时间！");
            return false;
            }
            var strdt1=startTime.replace(/-/g,"/");
            var strdt2=endTime.replace(/-/g,"/");            
            var dt1=new Date(Date.parse(strdt1));
            var dt2=new Date(Date.parse(strdt2));
            if(dt1>dt2){
				alert("开始日期大于截止日期！");
				return false;
			}
			else{
				return true;
			}
        }
        catch(e)
        {
            alert("没有后备人员供选择，不能添加！");
        }
}

</script>
</head>

<body>
<%
List<User> list=(List<User>)request.getAttribute("user");
int int_taskID=Integer.parseInt(request.getParameter("tid"));
int int_projectID=Integer.parseInt(request.getParameter("pid"));
ChangeIDForName change=new ChangeIDForName();
Connection con=Connect.getConnection();
 %>
<form action="AddUserForTaskServlet?flag=2&tid=<%=int_taskID %>&pid=<%=int_projectID %>" method="post" onsubmit="return check()">
<table width="98%" align="center" border="0" cellpadding="4"
			cellspacing="1" bgcolor="#CBD8AC" style="margin-bottom: 8px">
			<tr bgcolor="#EEF4EA">
				<td colspan="2" bgcolor="#CBD8AC" class='title'>
					<span>待选人员</span>
				</td>
			</tr>
			<tr>
				<td width="8%" align="center"background="page/manager/skin/images/frame/wbg.gif">任务ID</td>
                <td width="10%" align="center"background="page/manager/skin/images/frame/wbg.gif">任务名称</td>
                <td width="10%" align="center"background="page/manager/skin/images/frame/wbg.gif">所属项目</td>
                <td width="17%" align="center"background="page/manager/skin/images/frame/wbg.gif">开始时间</td>
                <td width="18%" align="center"background="page/manager/skin/images/frame/wbg.gif">截止时间</td>
                <td width="10%" align="center"background="page/manager/skin/images/frame/wbg.gif">执行人</td>
                <td width="10%" align="center"background="page/manager/skin/images/frame/wbg.gif">确认人</td>
                <td width="17%" align="center"background="page/manager/skin/images/frame/wbg.gif">确认意见</td>
            </tr>
            <%
            if(list!=null){
             %>
            <tr bgcolor="#FFFFFF">
				<td align="center"><%=int_taskID %></td>
                <td align="center"><%=change.getTaskName(con,int_taskID) %></td>
                <td align="center"><%=change.getProjectName(con,int_projectID) %></td>
                <td align="center"><input type="text" id="startTime" name="startTime" class="Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'%y-%M-%d %H:%m:%s'})"  /></td>
                <td align="center"><input type="text" id="endTime" name="endTime" class="Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'%y-%M-%d %H:%m:%s'})"  /></td>
                <td>
                <select id="selectUser" name="selectUser">
                <%
                for(int i=0;i<list.size();i++){
                %>               
                <option value="<%=list.get(i).getG_intUserId() %>"><%=list.get(i).getG_strUserName() %></option>
				<%
                }
                 %>
                 </select>
                </td>
                <td>${sessionScope.userInfo.g_strUserName}<input type="hidden" name="confirmUser" value="${sessionScope.userInfo.g_intUserId}"/></td>
                <td><input type="text" id="opinion" name="opinion" /></td>
            </tr>
            <%
            }
            else{
            %>
            <tr bgcolor="#FFFFFF">
                <td align="center">&nbsp;</td>
                <td align="center">&nbsp;</td>
                <td align="center">&nbsp;</td>
                <td align="center"><font color="red">没有人员供选择，请先为项目添加人员</font></td>
                <td align="center">&nbsp;</td>
                <td align="center">&nbsp;</td>
                <td align="center">&nbsp;</td>
                <td align="center">&nbsp;</td>
            </tr>
            <%
            }
             %>
</table>
<table width="98%" align="center">
<tr>
<td align="center"><input type="submit" value="添加" />&nbsp;<input type="button" value="关闭" onclick="CloseWindow()" /></td>
</tr>
</table>
</form>
</body>
</html>