<%@ page contentType="text/html; charset=gb2312" language="java"
	import="java.sql.*,java.util.*,com.bean.*,com.dao.*" errorPage=""%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
		<title>�ձ���д</title>
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
	alert("��ѡ������");
	return false;
	}
	else if(checkTask()==2){
	alert("��ͨ��ѡ��ťѡ������");
	return false;
	}
	else if(checkTask()==3){
	alert("�ձ��������������Ͳ�һ�£�������ѡ��");
	return false;
	}
	else if(checkTaskDesc()){
	alert("����д����������");
	return false;
	}
	else if(checkComplete()){
	alert("����д��������");
	return false;
	}
	else if(checkProject()==1){
	alert("��ѡ�������Ŀ�ձ�����ѡ����Ŀ��");
	return false;
	}
	else if(checkProject()==2){
	alert("��ͨ��ѡ��ťѡ����Ŀ��");
	return false;
	}
	else if(checkTime()==1){
	alert("��ѡ��ʼʱ�䣡");
	return false;
	}
	else if(checkTime()==2){
	alert("��ѡ���ֹʱ�䣡");
	return false;
	}
	else if(checkTime()==3){
	alert("��ʼʱ����ڽ�ֹʱ�䣡");
	return false;
	}
	else if(checkTime()==4&&checkProblem()==true){
	    if(confirm("���Ĺ�ʱ����1�죬�Ҵ�������Ϊ�գ�ȷ���ύ��")){
	        return true;
	    }else{
	       return false;
	    }
	}
	else if(checkTime()==4){
		if(confirm("���Ĺ�ʱ����1�죬ȷ���ύ��")){
			return true;
		}else{
			return false;
		}
	}
	else{
	    if(confirm("ȷ���ύ��")){
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
		return 3;<!--��ʼ���ڴ��ڽ�ֹ����-->
	}
	else if(((dt2-dt1)/1000)>86400){
	    return 4;<!--��ֹ���ڼ�ȥ��ʼ���ڴ���1��-->
	}
	else if(((dt2-dt1)/1000)>604800){
	    return 5;<!--��ֹ���ڼ�ȥ��ʼ���ڴ���7��-->
	}
	else if(((dt2-dt1)/1000)>2592000){
	    return 6;<!--��ֹ���ڼ�ȥ��ʼ���ڴ���30��-->
	}
	else{
		return false;<!--���ڷ���Ҫ��-->
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
    alert("��д��Ŀ�ձ���ѡ����Ӧ��Ŀ");
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
java.util.Date currentTime = new java.util.Date();//�õ���ǰϵͳʱ�� 
String strDate = formatter.format(currentTime); //������ʱ���ʽ��
String submit=strDate.replaceAll(" ","_");
 %>
 <form name="form" action="DailyWriteServlet?flag=2" method="post" onsubmit="return check();">
<br/>
<table width="100%" border="1" cellpadding="1" cellspacing="1">

  <tr>
    <td width="10%"><div align="center">�ձ�ID</div></td>
    <td width="17%"><%=dailyID %>
                    <input type="hidden" name="dailyID" id="dailyID" value="<%=dailyID %>" /><!-- �����ύ�ձ�ID -->
                    <input type="hidden" name="image" id="image" value="" /><!-- �����ύ�ϴ�ͼƬ������ -->
    </td>
    <td width="10%"><div align="center">����</div></td>
    <td width="22%"><%=userName %><input type="hidden" name="userID" id="userID" value="<%=userID %>" /></td>
    <td width="10%"><div align="center">�ύ����</div></td>
    <td width="28%"><%=strDate %><input type="hidden" name="submitTime" value=<%=submit %> /></td>
  </tr>
</table>
<table width="100%" border="1" cellspacing="1" cellpadding="1">
  <tr>
    <td width="15%" height="28"><div align="center">�ձ�����</div></td>
    <td width="35%"><label>
      <select name="dailyType" id="dailyType" onchange="disableProject();">
        <option value="1">��Ŀ�ձ�</option>
        <option value="0">����Ŀ�ձ�</option>
      </select>
    </label></td>
    <td width="15%"><div align="center">������Ŀ</div></td>
    <td width="35%">
    <input type="hidden" name="projectID" id="projectID" /><!-- �����ύ��ĿID -->
    <input type="text" name="projectName" id="projectName" />
    <input type="button" name="project" id="project" value="ѡ��" onClick="selectProject(<%=userID %>)" /></td>
  </tr>
</table>
<table width="100%" border="1" cellspacing="1" cellpadding="1">
  <tr>
    <td width="15%" height="28"><div align="center">��������</div></td>
    <td width="85%">
    <input type="hidden" name="taskType" id="taskType"/><!-- �����������͹���ҳ���ж��û�ѡ���Ƿ�����ձ����� -->
    <input type="hidden" name="taskID" id="taskID" /><!-- �����ύ����ID -->
    <input type="text" name="taskName" id="taskName" />
    <input type="button" name="task" value="ѡ��" onClick="selectTask()" /></td>
  </tr>
</table>
<table width="100%" border="1" cellspacing="1" cellpadding="1">
  <tr>
    <td width="15%" height="28"><div align="center">��������</div></td>
    <td width="85%"><label>
      <textarea name="taskDescription" cols="120" rows="5" id="taskDescription"></textarea></label><font color="#FF0000">*4000�ַ�����</font></td>
  </tr>
</table>
<table width="100%" border="1" cellspacing="1" cellpadding="1">
  <tr>
    <td width="15%" height="28"><div align="center">��ʼʱ��</div></td>
    <td width="35%"><input type="text" name="startTime" id="startTime" class="Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',maxDate:'%y-%M-%d %H:%m:%s'})" /></td>
    <td width="15%"><div align="center">��ֹʱ��</div></td>
    <td width="35%"><input type="text" name="endTime" id="endTime" class="Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',maxDate:'%y-%M-%d %H:%m:%s'})" /></td>
  </tr>
</table>
<table width="100%" border="1" cellspacing="1" cellpadding="1">
  <tr>
    <td width="15%" height="28"><div align="center">������</div></td>
    <td width="85%"><label>
      <textarea name="complete" cols="120" rows="5" id="complete"></textarea></label><font color="#FF0000">*4000�ַ�����</font></td>
  </tr>
</table>
<table width="100%" border="1" cellspacing="1" cellpadding="1">
  <tr>
    <td width="15%" height="28"><div align="center">��������</div></td>
    <td width="85%"><label>
      <textarea name="problem" cols="120" rows="5" id="problem"></textarea></label><font color="#FF0000">*2000�ַ�����</font></td>
  </tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="1">
  <tr>
    <td>
      <div align="center">
        <input type="submit" name="submit" value="�ύ" />
        <input type="button" value="����" onclick="goBack()" />
      </div>
      <div align="left"><input type="button" name="upload" value="�ϴ�ͼƬ" onclick="uploadImge()" /></div>
      <font color="red">ֻ֧��jpg��bmp��gif��ʽ,ͼƬ��С������100KB</font>
      </td>
    </tr>
</table>
<table border="0"><tr><td><div id="div1"></div></td></tr></table>
</form>
</body>
</html>