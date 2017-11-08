<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*,com.dao.*,com.bean.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>添加PCB</title>
<base target="_self">
<link rel="stylesheet" type="text/css" href="./skin/css/base.css" />
<link rel="stylesheet" type="text/css" href="./skin/css/main.css" />
<style type="text/css">
<!--
body {
	background-image: url(../images/login_07.gif);
}
-->
</style>
<script type="text/javascript">
function check(){
	if(CheckPCBName()){
		return false;
	}
	else if(CheckAmount()){
		return false;
	}
	else if(CheckSample()){
		return false;
	}
	else if(CheckDeliver()){
		return false;
	}
	else if(CheckOpinion()){
		return false;
	}
	else{
		if(confirm("确认提交吗？")){
	var produceStyle=document.getElementById("produceStyle").value;
	var time=document.getElementById("time").value;
	var opinion=document.getElementById("confirmOpinion").value;
	var user=document.getElementById("confirmUser").value;
	var projectID=document.getElementById("projectID").value;
	var deliver=document.getElementById("deliver").value;
	var sample=document.getElementById("sample").value;
	var PCBName=document.getElementById("PCBName").value;
	var amount=document.getElementById("amount").value;
	
		    var url = "../../AddPCBServlet?prodSty=" + produceStyle + "&name="
			    	+ PCBName + "&time=" + time+"&opin="+opinion+"&u="+user+"&pid="+projectID+"&delv="+deliver+"&samp="+sample+"&amnt="+amount;
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
			   http_request.onreadystatechange = updatepage;
			   http_request.send(null);
		   }
		}
	}
}

function CheckPCBName(){
	var PCBName=document.getElementById("PCBName").value;
	if(PCBName==""){
		alert("PCB名称不能为空！");
		return true;
	}
	else if(PCBName.length>40){
		alert("PCB名称长度不能超过40个字符！");
		return true;
	}
	else {
		return false;
	}
}

function CheckAmount(){
	var amount=document.getElementById("amount").value;
	if(isNaN(amount)){
		alert("备料数量只能为数字！");
		return true;
	}
	else if(amount.length>8){
		alert("备料数量不能超过99999999");
		return true;
	}
	else if(amount==""){
		if(confirm("备料数量为空，继续提交吗？")){
			return false;
		}
		else{
			return true;
		}
	}
	else{
		return false;
	}
}

function CheckSample(){
	var sample=document.getElementById("sample").value;
	 if(isNaN(sample)){
		alert("样品数量只能为数字！");
		return true;
	}
	else if(sample.length>4){
		alert("样品数量不能超过9999！");
		return true;
	}
	else if(sample==""){
		if(confirm("样品数量为空，继续提交吗？")){
			return false;
		}
		else{
			return true;
		}
	}
	else{
		return false;
	}
}

function CheckDeliver(){
	var deliver=document.getElementById("deliver").value;
	if(isNaN(deliver)){
		alert("发货数量只能为数字！");
		return true;
	}
	else if(deliver.length>8){
		alert("样品数量不能超过99999999！");
		return true;
	}
	else if(deliver==""){
		if(confirm("发货数量为空，继续提交吗？")){
			return false;
		}
		else{
			return true;
		}
	}
	else{
		false;
	}
}

function CheckOpinion(){
	var opinion=document.getElementById("confirmOpinion").value;
	if(opinion.lenght>200){
		alert("确认意见长度不能超过200个字符！");
		return true;
	}
	else if(opinion==""){
		if(confirm("确认意见为空，继续提交吗？")){
			return false;
		}
		else{
			return true;
		}
	}
	else {
		return false;
	}
}

function updatepage() {
	if (http_request.readyState == 4) {
		if (http_request.status == 200) {
			if (http_request.responseText == 0) {
				alert("添加PCB失败！");
				window.close();
			} else if (http_request.responseText == 1) {
				alert("添加PCB成功！");
				opener.location.reload();
				window.close();
			} else if (http_request.responseText == 2){
			    alert("错误！您不能继续操作，可能原因：1、session超时  2、您已退出  3、您的账号已在别处登录，请重新登录");
			    window.close();
			    opener.top.location.replace("http://localhost/daily");
			}
			else{
			alert("程序异常，请联系管理员（错误页面：add_new_pcb.jsp）");
			}
		} else {
			alert("您所请求的页面有异常");
			window.close();
		}
	}
}

function closeWindow(){
	if(confirm("确定放弃添加新PCB并关闭窗口吗？")){
		window.close();
	}
}
</script>
</head>

<body>
<%
if(session.getAttribute("userInfo")==null){
	%>
	<script type="text/javascript">
	alert("session超时或您已退出，请重新登录");
	opener.top.location.replace("http://localhost/daily");
	window.close();
	</script>
	<%
	return;
}
int int_projectID=Integer.parseInt(request.getParameter("id"));
java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 
java.util.Date currentTime = new java.util.Date();//得到当前系统时间 
String strDate = formatter.format(currentTime); //将日期时间格式化
String str_Date=strDate.replaceAll(" ","_");//将strDate字符串中的空格替换成_
ChangeIDForName change=new ChangeIDForName();
Connection con=Connect.getConnection();
 %>
<table width="100%">
<tr>
<td align="center"><font size="+2">添加新PCB</font></td>
</tr>
</table>
<br />
<table width="100%" border="1">
<tr>
<td width="7%" align="center">PCB名称</td>
<td width="11%" align="center">所属项目</td>
<td width="11%" align="center">备料数量</td>
<td width="11%" align="center">样品数量</td>
<td width="11%" align="center">发货数量</td>
<td width="11%" align="center">生产方式</td>
<td width="11%" align="center">确认人</td>
<td width="12%" align="center">确认时间</td>
</tr>
<tr>
<td width="7%" align="center"><input type="text" name="PCBName" id="PCBName" /></td>
<td width="11%" align="center"><%=change.getProjectName(con,int_projectID) %><input type="hidden" name="projectID" id="projectID" value="<%=int_projectID %>" /></td>
<td width="11%" align="center"><input type="text" name="amount" id="amount" /></td>
<td width="11%" align="center"><input type="text" name="sample" id="sample" /></td>
<td width="11%" align="center"><input type="text" name="deliver" id="deliver" /></td>
<td width="11%" align="center"><select name="produceStyle" id="produceStyle"><option value="0">自主</option><option value="1">外协</option></select></td>
<td width="11%" align="center">${sessionScope.userInfo.g_strUserName}
<input type="hidden" name="confirmUser" id="confirmUser" value="${sessionScope.userInfo.g_intUserId}" /></td>
<td width="12%" align="center"><input type="hidden" name="time" id="time" value="<%=str_Date%>" /><%=strDate %></td>
</tr>
</table>
<table width="100%">
<tr>
<td width="13%" valign="middle" align="center">确认意见</td>
<td width="87%"><textarea name="confirmOpinion" id="confirmOpinion" cols="100" rows="5"></textarea><font color="red">200字符以内</font></td>
</tr>
</table>
<table width="100%">
<tr>
<td align="center">
<input type="button" name="button" value="提交" onclick="check()"  />&nbsp;
<input type="button" name="button1" value="关闭" onclick="closeWindow()" /></td>
</tr>
</table>
<%con.close(); %>
</body>
</html>