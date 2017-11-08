<%@ page contentType="text/html; charset=gb2312" language="java"
	import="java.sql.*,java.util.*,com.bean.*,com.dao.*" errorPage=""%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
		<title>日报填写</title>
		<link type="text/css" rel="stylesheet" href="page/css/tableBorder.css" />
		<base target="_self">
			<link rel="stylesheet" type="text/css"
				href="page/skin/css/base.css" />
			<link rel="stylesheet" type="text/css"
				href="page/skin/css/main.css" />
				
			<style type="text/css">
<!--
body {
	background-image: url(page/images/login_07.gif);
}
-->
</style>

<script type="text/javascript" src="${pageContext.request.contextPath }/My97DatePicker/WdatePicker.js"></script>
<script language="javascript">
function disableProject() {
    var $i = document.getElementById('dailyType').value;
    if($i == 0 ){
        document.getElementById('project').disabled='disabled';
        document.getElementById('projectName').value='';
        document.getElementById('projectName').disabled='disabled';
    }else{
        document.getElementById('project').disabled=false;
        document.getElementById('projectName').disabled=false;
    }
}

function check(){
	if(checkTask()==1){
	alert("请选择任务！");
	return false;
	}
	else if(checkTask()==2){
	alert("请通过选择按钮选择任务！");
	return false;
	}
	else if(checkTask()==3){
	alert("日报类型与任务类型不一致，请重新选择！");
	return false;
	}
	else if(checkTaskDesc()){
	alert("请填写任务描述！");
	return false;
	}
	else if(checkComplete()){
	alert("请填写完成情况！");
	return false;
	}
	else if(checkProject()==1){
	alert("您选择的是项目日报，请选择项目！");
	return false;
	}
	else if(checkProject()==2){
	alert("请通过选择按钮选择项目！");
	return false;
	}
	else if(checkTime()==1){
	alert("请选择开始时间！");
	return false;
	}
	else if(checkTime()==2){
	alert("请选择截止时间！");
	return false;
	}
	else if(checkTime()==3){
	alert("开始时间大于截止时间！");
	return false;
	}
	else if(checkTime()==4&&checkProblem()==true){
	    if(confirm("您的工时超过1天，且存在问题为空，确认提交吗？")){
	        return true;
	    }else{
	       return false;
	    }
	}
	else if(checkTime()==4){
		if(confirm("您的工时超过1天，确认提交吗？")){
			return true;
		}else{
			return false;
		}
	}
	else{
	    if(confirm("确认提交吗？")){
	        return true;
	    }
	    else{
	        return false;
	    }
	}
}

function checkTask(){
	var task=document.getElementById("taskName").value;
	var id=document.getElementById("taskID").value;
	var taskType=document.getElementById("taskType").value;
	var dailyType=document.getElementById("dailyType").value;
	if(task==""){
		return 1;
	}
	else if(id==""){
	    return 2;
	}
	else if(taskType!=dailyType){
	    return 3;
	}
	else{
		return false;
		}
}

function checkProject(){
	var project=document.getElementById("projectName").value;
	var type=document.getElementById("dailyType").value;
	var id=document.getElementById("projectID").value;
	if(type==1&&project==""){
		return 1;
	}
	else if(type==1&&id==""){
	    return 2;
	}
	else{
		return false;
	}
}

function checkTime(){
	var strdt1=document.getElementById("startTime").value.replace(/-/g,"/");
    var strdt2=document.getElementById("endTime").value.replace(/-/g,"/");            
    var dt1=new Date(Date.parse(strdt1));
    var dt2=new Date(Date.parse(strdt2));
    if(strdt1==""){
    return 1;
    }
    else if(strdt2==""){
    return 2
    }
    else if(dt1>dt2){
		return 3;<!--开始日期大于截止日期-->
	}
	else if(((dt2-dt1)/1000)>86400){
	    return 4;<!--截止日期减去开始日期大于1天-->
	}
	else if(((dt2-dt1)/1000)>604800){
	    return 5;<!--截止日期减去开始日期大于7天-->
	}
	else if(((dt2-dt1)/1000)>2592000){
	    return 6;<!--截止日期减去开始日期大于30天-->
	}
	else{
		return false;<!--日期符合要求-->
	}
}

function checkTaskDesc(){
	var taskDesc=document.getElementById("taskDescription").value;
	if(taskDesc==""){
		return true;
	}
	else{
		return false;
	}
}

function checkComplete(){
    var complete=document.getElementById("complete").value;
    if(complete==""){
    return true;
    }
    else{
    return false;
    }
}

function checkProblem(){
    var problem=document.getElementById("problem").value;
    if(problem==""){
    return true;
    }
    else{
    return false;
    }
}

function selectProject(uid){
	window.open("page/select_project.jsp?uid="+uid,"selectProject","directories=no,left=500,top=250,height=200,width=550,location=no,menubar=no,resizable=yes,scrollbars=yes,status=no,toolbar=no",false);
}

function selectTask(){
    var id=document.getElementById('projectID').value;
    var type=document.getElementById('dailyType').value;
    var user=document.getElementById('userID').value;
    if(type==1&&id==""){
    alert("填写项目日报请选择相应项目");
    exit;
    }
    window.open("page/select_task.jsp?u="+user+"&id="+id+"&type="+type,"selectTask","directories=no,left=500,top=250,height=200,width=550,location=no,menubar=no,resizable=yes,scrollbars=yes,status=no,toolbar=no",false);
}

function uploadImge(){
	 window.open("page/upload.htm","uploadImge","directories=no,left=500,top=250,height=130,width=550,location=no,menubar=no,resizable=yes,scrollbars=yes,status=no,toolbar=no",false);
}

function goBack(){
    window.history.back();
}
</script>
</head>
<body>
<%
String userName=request.getParameter("n");
String userID=request.getParameter("uid");
String dailyID=request.getParameter("did");
java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 
java.util.Date currentTime = new java.util.Date();//得到当前系统时间 
String strDate = formatter.format(currentTime); //将日期时间格式化
String submit=strDate.replaceAll(" ","_");
 %>
 <form name="form" action="DailyWriteServlet?flag=2" method="post" onsubmit="return check();">
<br/>
<table width="100%" border="1" cellpadding="1" cellspacing="1">

  <tr>
    <td width="10%"><div align="center">日报ID</div></td>
    <td width="17%"><%=dailyID %>
                    <input type="hidden" name="dailyID" id="dailyID" value="<%=dailyID %>" /><!-- 隐藏提交日报ID -->
                    <input type="hidden" name="image" id="image" value="" /><!-- 隐藏提交上传图片的名称 -->
    </td>
    <td width="10%"><div align="center">作者</div></td>
    <td width="22%"><%=userName %><input type="hidden" name="userID" id="userID" value="<%=userID %>" /></td>
    <td width="10%"><div align="center">提交日期</div></td>
    <td width="28%"><%=strDate %><input type="hidden" name="submitTime" value=<%=submit %> /></td>
  </tr>
</table>
<table width="100%" border="1" cellspacing="1" cellpadding="1">
  <tr>
    <td width="15%" height="28"><div align="center">日报类型</div></td>
    <td width="35%"><label>
      <select name="dailyType" id="dailyType" onchange="disableProject();">
        <option value="1">项目日报</option>
        <option value="0">非项目日报</option>
      </select>
    </label></td>
    <td width="15%"><div align="center">所属项目</div></td>
    <td width="35%">
    <input type="hidden" name="projectID" id="projectID" /><!-- 隐藏提交项目ID -->
    <input type="text" name="projectName" id="projectName" />
    <input type="button" name="project" id="project" value="选择" onClick="selectProject(<%=userID %>)" /></td>
  </tr>
</table>
<table width="100%" border="1" cellspacing="1" cellpadding="1">
  <tr>
    <td width="15%" height="28"><div align="center">任务名称</div></td>
    <td width="85%">
    <input type="hidden" name="taskType" id="taskType"/><!-- 隐藏任务类型供本页面判断用户选择是否符合日报类型 -->
    <input type="hidden" name="taskID" id="taskID" /><!-- 隐藏提交任务ID -->
    <input type="text" name="taskName" id="taskName" />
    <input type="button" name="task" value="选择" onClick="selectTask()" /></td>
  </tr>
</table>
<table width="100%" border="1" cellspacing="1" cellpadding="1">
  <tr>
    <td width="15%" height="28"><div align="center">任务描述</div></td>
    <td width="85%"><label>
      <textarea name="taskDescription" cols="120" rows="5" id="taskDescription"></textarea></label><font color="#FF0000">*4000字符以内</font></td>
  </tr>
</table>
<table width="100%" border="1" cellspacing="1" cellpadding="1">
  <tr>
    <td width="15%" height="28"><div align="center">开始时间</div></td>
    <td width="35%"><input type="text" name="startTime" id="startTime" class="Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',maxDate:'%y-%M-%d %H:%m:%s'})" /></td>
    <td width="15%"><div align="center">截止时间</div></td>
    <td width="35%"><input type="text" name="endTime" id="endTime" class="Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',maxDate:'%y-%M-%d %H:%m:%s'})" /></td>
  </tr>
</table>
<table width="100%" border="1" cellspacing="1" cellpadding="1">
  <tr>
    <td width="15%" height="28"><div align="center">完成情况</div></td>
    <td width="85%"><label>
      <textarea name="complete" cols="120" rows="5" id="complete"></textarea></label><font color="#FF0000">*4000字符以内</font></td>
  </tr>
</table>
<table width="100%" border="1" cellspacing="1" cellpadding="1">
  <tr>
    <td width="15%" height="28"><div align="center">存在问题</div></td>
    <td width="85%"><label>
      <textarea name="problem" cols="120" rows="5" id="problem"></textarea></label><font color="#FF0000">*2000字符以内</font></td>
  </tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="1">
  <tr>
    <td>
      <div align="center">
        <input type="submit" name="submit" value="提交" />
        <input type="button" value="返回" onclick="goBack()" />
      </div>
      <div align="left"><input type="button" name="upload" value="上传图片" onclick="uploadImge()" /></div>
      <font color="red">只支持jpg、bmp、gif格式,图片大小不超过100KB</font>
      </td>
    </tr>
</table>
<table border="0"><tr><td><div id="div1"></div></td></tr></table>
</form>
</body>
</html>