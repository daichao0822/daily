<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*,com.dao.*,com.bean.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>���PCB</title>
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
		if(confirm("ȷ���ύ��")){
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
			   alert("���ܴ���XMLHttpRequest����ʵ��");
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
		alert("PCB���Ʋ���Ϊ�գ�");
		return true;
	}
	else if(PCBName.length>40){
		alert("PCB���Ƴ��Ȳ��ܳ���40���ַ���");
		return true;
	}
	else {
		return false;
	}
}

function CheckAmount(){
	var amount=document.getElementById("amount").value;
	if(isNaN(amount)){
		alert("��������ֻ��Ϊ���֣�");
		return true;
	}
	else if(amount.length>8){
		alert("�����������ܳ���99999999");
		return true;
	}
	else if(amount==""){
		if(confirm("��������Ϊ�գ������ύ��")){
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
		alert("��Ʒ����ֻ��Ϊ���֣�");
		return true;
	}
	else if(sample.length>4){
		alert("��Ʒ�������ܳ���9999��");
		return true;
	}
	else if(sample==""){
		if(confirm("��Ʒ����Ϊ�գ������ύ��")){
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
		alert("��������ֻ��Ϊ���֣�");
		return true;
	}
	else if(deliver.length>8){
		alert("��Ʒ�������ܳ���99999999��");
		return true;
	}
	else if(deliver==""){
		if(confirm("��������Ϊ�գ������ύ��")){
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
		alert("ȷ��������Ȳ��ܳ���200���ַ���");
		return true;
	}
	else if(opinion==""){
		if(confirm("ȷ�����Ϊ�գ������ύ��")){
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
				alert("���PCBʧ�ܣ�");
				window.close();
			} else if (http_request.responseText == 1) {
				alert("���PCB�ɹ���");
				opener.location.reload();
				window.close();
			} else if (http_request.responseText == 2){
			    alert("���������ܼ�������������ԭ��1��session��ʱ  2�������˳�  3�������˺����ڱ𴦵�¼�������µ�¼");
			    window.close();
			    opener.top.location.replace("http://localhost/daily");
			}
			else{
			alert("�����쳣������ϵ����Ա������ҳ�棺add_new_pcb.jsp��");
			}
		} else {
			alert("���������ҳ�����쳣");
			window.close();
		}
	}
}

function closeWindow(){
	if(confirm("ȷ�����������PCB���رմ�����")){
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
	alert("session��ʱ�������˳��������µ�¼");
	opener.top.location.replace("http://localhost/daily");
	window.close();
	</script>
	<%
	return;
}
int int_projectID=Integer.parseInt(request.getParameter("id"));
java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 
java.util.Date currentTime = new java.util.Date();//�õ���ǰϵͳʱ�� 
String strDate = formatter.format(currentTime); //������ʱ���ʽ��
String str_Date=strDate.replaceAll(" ","_");//��strDate�ַ����еĿո��滻��_
ChangeIDForName change=new ChangeIDForName();
Connection con=Connect.getConnection();
 %>
<table width="100%">
<tr>
<td align="center"><font size="+2">�����PCB</font></td>
</tr>
</table>
<br />
<table width="100%" border="1">
<tr>
<td width="7%" align="center">PCB����</td>
<td width="11%" align="center">������Ŀ</td>
<td width="11%" align="center">��������</td>
<td width="11%" align="center">��Ʒ����</td>
<td width="11%" align="center">��������</td>
<td width="11%" align="center">������ʽ</td>
<td width="11%" align="center">ȷ����</td>
<td width="12%" align="center">ȷ��ʱ��</td>
</tr>
<tr>
<td width="7%" align="center"><input type="text" name="PCBName" id="PCBName" /></td>
<td width="11%" align="center"><%=change.getProjectName(con,int_projectID) %><input type="hidden" name="projectID" id="projectID" value="<%=int_projectID %>" /></td>
<td width="11%" align="center"><input type="text" name="amount" id="amount" /></td>
<td width="11%" align="center"><input type="text" name="sample" id="sample" /></td>
<td width="11%" align="center"><input type="text" name="deliver" id="deliver" /></td>
<td width="11%" align="center"><select name="produceStyle" id="produceStyle"><option value="0">����</option><option value="1">��Э</option></select></td>
<td width="11%" align="center">${sessionScope.userInfo.g_strUserName}
<input type="hidden" name="confirmUser" id="confirmUser" value="${sessionScope.userInfo.g_intUserId}" /></td>
<td width="12%" align="center"><input type="hidden" name="time" id="time" value="<%=str_Date%>" /><%=strDate %></td>
</tr>
</table>
<table width="100%">
<tr>
<td width="13%" valign="middle" align="center">ȷ�����</td>
<td width="87%"><textarea name="confirmOpinion" id="confirmOpinion" cols="100" rows="5"></textarea><font color="red">200�ַ�����</font></td>
</tr>
</table>
<table width="100%">
<tr>
<td align="center">
<input type="button" name="button" value="�ύ" onclick="check()"  />&nbsp;
<input type="button" name="button1" value="�ر�" onclick="closeWindow()" /></td>
</tr>
</table>
<%con.close(); %>
</body>
</html>