<%@ page contentType="text/html; charset=gb2312" language="java"
	import="java.sql.*,java.util.*,com.bean.*,com.dao.*" errorPage=""%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
		<title>�ձ���ѯ</title>
		<base target="_self">
			<link rel="stylesheet" type="text/css"
				href="page/head_of_department/skin/css/base.css" />
			<link rel="stylesheet" type="text/css"
				href="page/head_of_department/skin/css/main.css" />
			<style type="text/css">
<!--
body {
	background-image: url(page/images/login_07.gif);
}
-->
</style>
<script type="text/javascript" src="${pageContext.request.contextPath }/My97DatePicker/WdatePicker.js"> </script>
<script type="text/javascript">
function checkDate1() {
	try {
		var startTime = document.getElementById("startTime").value;
		var endTime = document.getElementById("endTime").value;
		if (startTime == "") {
			alert("��ѡ��ʼʱ�䣡");
			return false;
		} else if (endTime == "") {
			alert("��ѡ���ֹʱ�䣡");
			return false;
		}
		var strdt1 = startTime.replace(/-/g, "/");
		var strdt2 = endTime.replace(/-/g, "/");
		var dt1 = new Date(Date.parse(strdt1));
		var dt2 = new Date(Date.parse(strdt2));
		if (dt1 > dt2) {
			alert("��ʼ���ڴ��ڽ�ֹ���ڣ�");
			return false;
		} else {
			return true;
		}
	} catch (e) {
		alert("��ʽ����" + e);
	}
}

function CheckDate2() {
	try {
	    var selected=document.getElementById("user1").value;
	    if(selected==-1){
	        alert("û�в�����Ա�����ܽ��в�ѯ��");
	        return false;
	    }
		var startTime = document.getElementById("startTime1").value;
		var endTime = document.getElementById("endTime1").value;
		if (startTime == "") {
			alert("��ѡ��ʼʱ�䣡");
			return false;
		} else if (endTime == "") {
			alert("��ѡ���ֹʱ�䣡");
			return false;
		}
		var strdt1 = startTime.replace(/-/g, "/");
		var strdt2 = endTime.replace(/-/g, "/");
		var dt1 = new Date(Date.parse(strdt1));
		var dt2 = new Date(Date.parse(strdt2));
		if (dt1 > dt2) {
			alert("��ʼ���ڴ��ڽ�ֹ���ڣ�");
			return false;
		} else {
			return true;
		}
	} catch (e) {
		alert("��ʽ����" + e);
	}
}

function CheckSelectUser(){
    var user=document.getElementById("user").value;
    if(user==-1){
        alert("û�в�����Ա�����ܽ��в�ѯ��");
        return false;
        exit;
    }
    else{
        return true;
    }
}

function goBack(){
	window.history.back();
}
</script>
	</head>
	<body>
		<%
List<User> user=(List<User>)request.getAttribute("user");
%>
		<br />
		<table width="100%">
			<tr>
				<td align="center">
					<strong><font color="#669900">�ձ���ѯ</font> </strong>
				</td>
			</tr>
		</table>
		<br />
		<form id="form1" name="form1"
			action="DailyQueryForDepServlet" method="post">
			<table width="100%" border="1">
				<tr>
					<td align="center" width="22%"><strong>��ѯ�����������ձ�</strong></td>
					<td width="78%" align="left">&nbsp;
                    
					  <input type="hidden" id="flag2" name="flag" value="2" /><!--���̨����flagֵ�Ա���ѯ��ʽ-->
					  <input type="submit" value="��ѯ" />
						&nbsp;&nbsp;
					</td>
				</tr>
			</table>
		</form>
		<br />
		<form id="form2" name="form2"
			action="DailyQueryForDepServlet"
			onsubmit="return checkDate1();" method="post">
			<table width="100%" border="1">
				<tr>
					<td width="22%" align="center">
						<strong>���ύ���ڲ�ѯ���������ձ�</strong>
				  </td>

					<td width="78%" align="left">
						��ʼ���ڣ�&nbsp;
						<input type="text" id="startTime" name="startTime" class="Wdate"
							onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',maxDate:'%y-%M-%d %H:%m:%s'})" />
						&nbsp;
						<!--WdatePicker()�����пɼ���{dateFmt:'yyyy-MM-dd HH:mm'}���ƶ�ʱ���ʽ-->
						��ֹ���ڣ�&nbsp;
						<input type="text" id="endTime" name="endTime" class="Wdate"
							onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',maxDate:'%y-%M-%d %H:%m:%s'})" />
						&nbsp;
						<input type="hidden" id="flag3" name="flag" value="3" />
						<!--���̨����flagֵ�Ա���ѯ��ʽ-->
						<input type="submit" value="��ѯ" />
						&nbsp;&nbsp;
						<font color="#FF0000" size="-1">��ʼ���ڲ��ܴ��ڽ�ֹ����</font>
					</td>
				</tr>
			</table>
		</form>
		<br />
		<form id="form3" name="form3"
			action="DailyQueryForDepServlet"
			onsubmit="return CheckDate2()" method="post">
			<table width="100%" border="1">
				<tr>
					<td width="22%" align="center">
						<strong>���ύ���ڲ�ѯ���������ձ�</strong>
					</td>
					<td width="78%" align="left">
						��ʼ���ڣ�&nbsp;&nbsp;<input type="text" id="startTime1" name="startTime1" class="Wdate"
							onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',maxDate:'%y-%M-%d %H:%m:%s'})" />
						&nbsp;
						<!--WdatePicker()�����пɼ���{dateFmt:'yyyy-MM-dd HH:mm'}���ƶ�ʱ���ʽ-->
						��ֹ���ڣ�&nbsp;
						<input type="text" id="endTime1" name="endTime1" class="Wdate"
							onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',maxDate:'%y-%M-%d %H:%m:%s'})" />
						&nbsp;
                        <select name="user1" id="user1">
                        <%
                        if(user!=null){
                           for(int i=0;i<user.size();i++){
                         %>
                            <option value="<%=user.get(i).getG_intUserId() %>"><%=user.get(i).getG_strUserName() %></option>
                            <%} 
                           }
                         else{
                         %>
                         <option value="-1">û����Ա��ѡ��</option>
                         <%}%>
                        </select>
                        <input type="hidden" id="flag4" name="flag" value="4" /><!--���̨����flagֵ�Ա���ѯ��ʽ-->
						<input type="submit" value="��ѯ" />&nbsp;
                        <font color="#FF0000" size="-1">��ʼ���ڲ��ܴ��ڽ�ֹ����</font>
					</td>
				</tr>
			</table>
		</form>
		<br />
		<form id="form4" name="form4"
			action="DailyQueryForDepServlet"
			onsubmit="return CheckSelectUser()" method="post">
			<table width="100%" border="1">
				<tr>
					<td width="22%" align="center">
						<strong>��ѯ���������ձ�</strong>
					</td>

					<td width="78%" align="left">
						��ѡ����Ŀ��Ա��&nbsp;
						<select name="user" id="user">
							<%
if(user!=null){
for(int i=0;i<user.size();i++){
%>
							<option value="<%=user.get(i).getG_intUserId() %>"><%=user.get(i).getG_strUserName() %></option>
							<%
}
}
else{
%><option value="-1">û����Ŀ��Ա��ѡ��</option><%
}
 %>

						</select>
						&nbsp;
						<input type="hidden" id="flag5" name="flag" value="5" />
						<!--���̨����flagֵ�Ա���ѯ��ʽ-->
						<input type="submit" value="��ѯ" />
						&nbsp;&nbsp;
						<font color="#FF0000" size="-1">���ܲ�ѯ��������Ա�ձ�</font>
					</td>
				</tr>
			</table>
			<br />
			<table width="100%" border="0" cellspacing="1" cellpadding="1">
				<tr>
					<td>
						<div align="center">
							<input type="button" value="����" onclick="goBack()" />
						</div>
					</td>
				</tr>
			</table>

		</form>
	</body>
</html>