<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>�ձ���ѯ</title>
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
            alert("��ѡ��ʼʱ�䣡");
            return false;
            }
            else if(endTime==""){
            alert("��ѡ���ֹʱ�䣡");
            return false;
            }
            var strdt1=startTime.replace(/-/g,"/");
            var strdt2=endTime.replace(/-/g,"/");            
            var dt1=new Date(Date.parse(strdt1));
            var dt2=new Date(Date.parse(strdt2));
            if(dt1>dt2){
				alert("��ʼ���ڴ��ڽ�ֹ���ڣ�");
				return false;
			}
			else{
				return true;
			}
        }
        catch(e)
        {
            alert("��ʽ����"+e);
        }
    }

function checkDailyID(){
	var dailyID=document.getElementById("dailyID").value;
	if(dailyID==""){
		alert("�ձ�ID����Ϊ�գ�");
		return false;
	}
	else if(dailyID.length>10){
		alert("�ձ�ID���ܴ���10λ��");
		return false;
	}
	else if(isNaN(dailyID)){
		alert("�ձ�IDֻ��Ϊ���֣�");
		return false;
	}
	else{
		return true;
	}
}

function checkProjectName(){
    var projectName=document.getElementById("projectName").value;
    if(projectName==""){
    alert("��Ŀ���Ʋ���Ϊ�գ�");
    return false;
    }
    else if(projectName.length>40){
    alert("��Ŀ���Ʋ��ܳ���40���ַ���");
    return false;
    }
    return true;
}
 
function checkTaskName(){
    var taskName=document.getElementById("taskName").value;
    if(taskName==""){
    alert("�������Ʋ���Ϊ�գ�");
    return false;
    }
    else if(taskName.length>40){
    alert("�������Ʋ��ܳ���40���ַ���");
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
<tr><td align="center"><strong><font color="#669900" size="+2">�ձ���ѯ</font></strong></td>
</tr>
</table>
<form id="from5" name="form5" action="../../DailyQueryForMemberServlet" method="post">
<table width="100%" border="1">
<tr>
<td align="left" width="98%">
<input type="hidden" name="flag" value="5" /><!--���̨����flagֵ�Ա���ѯ��ʽ-->
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<font size="+1" color="#669900"><strong>��ѯ���������ձ�</strong></font>&nbsp;&nbsp;<input type="hidden" name="role" value="1" />
<input type="submit" value="��ѯ" /></td>
</tr>
</table>
</form>
<br />
<form id="form1" name="form1" action="../../DailyQueryForMemberServlet" onsubmit="return checkDailyID();" method="post">
<table width="100%" border="1">
<tr>
<td align="center" width="19%"><font size="+1" color="#669900"><strong>��ID��ѯ</strong></font></td>
<td width="81%" align="left">
�������ձ�ID��&nbsp;<input type="text" id="dailyID" name="dailyID" />&nbsp;
<input type="hidden" id="flag1" name="flag" value="1" /><!--���̨����flagֵ�Ա���ѯ��ʽ-->
<input type="submit" value="��ѯ" />&nbsp;&nbsp;<font color="#FF0000" size="-1">10λ���ڵ�������</font></td>
</tr>
</table>
</form>
<br />
<form id="form2" name="form2" action="../../DailyQueryForMemberServlet" onsubmit="return checkDate();" method="post">
<table width="100%" border="1">
<tr>
<td width="19%" align="center"><font size="+1" color="#669900"><strong>���ύ���ڲ�ѯ</strong></font></td>

<td width="81%" align="left">
��ʼ���ڣ�&nbsp;<input type="text" id="startTime" name="startTime" class="Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',maxDate:'%y-%M-%d %H:%m:%s'})"  />&nbsp;
<!--WdatePicker()�����пɼ���{dateFmt:'yyyy-MM-dd HH:mm'}���ƶ�ʱ���ʽ-->
��ֹ���ڣ�&nbsp;<input type="text" id="endTime" name="endTime" class="Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',maxDate:'%y-%M-%d %H:%m:%s'})"  />&nbsp;
<input type="hidden" id="flag2" name="flag" value="2" /><!--���̨����flagֵ�Ա���ѯ��ʽ-->
<input type="submit" value="��ѯ" />&nbsp;&nbsp;<font color="#FF0000" size="-1">��ʼ���ڲ��ܴ��ڽ�ֹ����</font>
</td>
</tr>
</table>
</form>
<br />
<form id="form3" name="form3" action="../../DailyQueryForMemberServlet" onsubmit="return checkProjectName()" method="post">
<table width="100%" border="1">
<tr>
<td width="19%" align="center"><font size="+1" color="#669900"><strong>����Ŀ��ѯ</strong></font></td>

<td width="81%" align="left">
������Ŀ���ƣ�&nbsp;<input type="text" id="projectName" name="projectName" />&nbsp;
<input type="hidden" id="flag3" name="flag" value="3" /><!--���̨����flagֵ�Ա���ѯ��ʽ-->
<input type="submit" value="��ѯ" />&nbsp;&nbsp;<font color="#FF0000" size="-1">40���ַ�����</font>
</td>
</tr>
</table>
</form>
<br />
<form id="form4" name="form4" action="../../DailyQueryForMemberServlet" onsubmit="return checkTaskName()" method="post">
<table width="100%" border="1">
<tr>
<td width="19%" align="center"><font size="+1" color="#669900"><strong>�������ѯ</strong></font></td>

<td width="81%" align="left">
�����������ƣ�&nbsp;<input type="text" id="taskName" name="taskName" />&nbsp;
<input type="hidden" id="flag4" name="flag" value="4" /><!--���̨����flagֵ�Ա���ѯ��ʽ-->
<input type="submit" value="��ѯ" />&nbsp;&nbsp;<font color="#FF0000" size="-1">40���ַ�����</font>
</td>
</tr>
</table>
<br />
<table width="100%" border="0" cellspacing="1" cellpadding="1">
  <tr>
    <td><div align="center"><input type="button" value="����" onclick="goBack()" /></div></td>
  </tr>
</table>

</form>
</body>
</html>