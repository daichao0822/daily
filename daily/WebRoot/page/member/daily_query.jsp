<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>日报查询</title>
<base target="_self">
<link rel="stylesheet" type="text/css" href="../member/skin/css/base.css" />
<link rel="stylesheet" type="text/css" href="../member/skin/css/main.css" />
<style type="text/css">
<!--
body {
	background-image: url(../images/login_07.gif);
}
-->
</style>
<script type="text/javascript" src="${pageContext.request.contextPath }/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
function checkDate()
    {
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
            alert("格式错误"+e);
        }
    }

function checkDailyID(){
	var dailyID=document.getElementById("dailyID").value;
	if(dailyID==""){
		alert("日报ID不能为空！");
		return false;
	}
	else if(dailyID.length>10){
		alert("日报ID不能大于10位！");
		return false;
	}
	else if(isNaN(dailyID)){
		alert("日报ID只能为数字！");
		return false;
	}
	else{
		return true;
	}
}

function checkProjectName(){
    var projectName=document.getElementById("projectName").value;
    if(projectName==""){
    alert("项目名称不能为空！");
    return false;
    }
    else if(projectName.length>40){
    alert("项目名称不能超过40个字符！");
    return false;
    }
    return true;
}
 
function checkTaskName(){
    var taskName=document.getElementById("taskName").value;
    if(taskName==""){
    alert("任务名称不能为空！");
    return false;
    }
    else if(taskName.length>40){
    alert("任务名称不能超过40个字符！");
    return false;
    }
    return true;
}
 
function goBack(){
	window.history.back();
}
</script>
</head>
<body>
<br />
<table width="100%">
<tr><td align="center"><strong><font color="#669900" size="+2">日报查询</font></strong></td>
</tr>
</table>
<form id="from5" name="form5" action="../../DailyQueryForMemberServlet" method="post">
<table width="100%" border="1">
<tr>
<td align="left" width="98%">
<input type="hidden" name="flag" value="5" /><!--向后台传递flag值以辨别查询方式-->
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<font size="+1" color="#669900"><strong>查询个人所有日报</strong></font>&nbsp;&nbsp;<input type="hidden" name="role" value="1" />
<input type="submit" value="查询" /></td>
</tr>
</table>
</form>
<br />
<form id="form1" name="form1" action="../../DailyQueryForMemberServlet" onsubmit="return checkDailyID();" method="post">
<table width="100%" border="1">
<tr>
<td align="center" width="19%"><font size="+1" color="#669900"><strong>按ID查询</strong></font></td>
<td width="81%" align="left">
请输入日报ID：&nbsp;<input type="text" id="dailyID" name="dailyID" />&nbsp;
<input type="hidden" id="flag1" name="flag" value="1" /><!--向后台传递flag值以辨别查询方式-->
<input type="submit" value="查询" />&nbsp;&nbsp;<font color="#FF0000" size="-1">10位以内的正整数</font></td>
</tr>
</table>
</form>
<br />
<form id="form2" name="form2" action="../../DailyQueryForMemberServlet" onsubmit="return checkDate();" method="post">
<table width="100%" border="1">
<tr>
<td width="19%" align="center"><font size="+1" color="#669900"><strong>按提交日期查询</strong></font></td>

<td width="81%" align="left">
开始日期：&nbsp;<input type="text" id="startTime" name="startTime" class="Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',maxDate:'%y-%M-%d %H:%m:%s'})"  />&nbsp;
<!--WdatePicker()括号中可加入{dateFmt:'yyyy-MM-dd HH:mm'}来制定时间格式-->
截止日期：&nbsp;<input type="text" id="endTime" name="endTime" class="Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',maxDate:'%y-%M-%d %H:%m:%s'})"  />&nbsp;
<input type="hidden" id="flag2" name="flag" value="2" /><!--向后台传递flag值以辨别查询方式-->
<input type="submit" value="查询" />&nbsp;&nbsp;<font color="#FF0000" size="-1">开始日期不能大于截止日期</font>
</td>
</tr>
</table>
</form>
<br />
<form id="form3" name="form3" action="../../DailyQueryForMemberServlet" onsubmit="return checkProjectName()" method="post">
<table width="100%" border="1">
<tr>
<td width="19%" align="center"><font size="+1" color="#669900"><strong>按项目查询</strong></font></td>

<td width="81%" align="left">
输入项目名称：&nbsp;<input type="text" id="projectName" name="projectName" />&nbsp;
<input type="hidden" id="flag3" name="flag" value="3" /><!--向后台传递flag值以辨别查询方式-->
<input type="submit" value="查询" />&nbsp;&nbsp;<font color="#FF0000" size="-1">40个字符以内</font>
</td>
</tr>
</table>
</form>
<br />
<form id="form4" name="form4" action="../../DailyQueryForMemberServlet" onsubmit="return checkTaskName()" method="post">
<table width="100%" border="1">
<tr>
<td width="19%" align="center"><font size="+1" color="#669900"><strong>按任务查询</strong></font></td>

<td width="81%" align="left">
输入任务名称：&nbsp;<input type="text" id="taskName" name="taskName" />&nbsp;
<input type="hidden" id="flag4" name="flag" value="4" /><!--向后台传递flag值以辨别查询方式-->
<input type="submit" value="查询" />&nbsp;&nbsp;<font color="#FF0000" size="-1">40个字符以内</font>
</td>
</tr>
</table>
<br />
<table width="100%" border="0" cellspacing="1" cellpadding="1">
  <tr>
    <td><div align="center"><input type="button" value="返回" onclick="goBack()" /></div></td>
  </tr>
</table>

</form>
</body>
</html>