<%@ page contentType="text/html; charset=gb2312" language="java"
	import="java.sql.*,java.util.*,com.bean.DailyReply,com.bean.Daily,com.dao.*" errorPage=""%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
		<title>�ձ�����</title>
<base target="_self">
<link rel="stylesheet" type="text/css" href="page/member/skin/css/base.css" />
<link rel="stylesheet" type="text/css" href="page/member/skin/css/main.css" />
<style type="text/css">
<!--
body {
	background-image: url(page/images/login_07.gif);
}
-->
</style>
<script type="text/javascript">
function dailyReply(id){
	window.open("/daily/page/daily_reply.jsp?id="+id,"DailyReply","directories=no,left=300,top=150,height=247,width=650,location=no,menubar=no,resizable=yes,scrollbars=yes,status=no,toolbar=no",false);
}

function goBack(){
	window.history.back();
}

function check(){
	var opinion=document.getElementById("checkOpinion").value;
	if(opinion==""){
		alert("�����������Ϊ�գ�");
		return false;
	}
	else{
		if(confirm("�ύ�󲻿��޸ģ�ȷ���ύ������")){
			return true;
		}
		else{
			return false;
		}
	}
}

</script>
</head>

<body>
<%
Daily DailyDetail=(Daily)request.getAttribute("dailyDetail");
int int_headOfDepID=Integer.parseInt(request.getParameter("u"));
if(DailyDetail!=null){
List<DailyReply> _DailyReply=(List<DailyReply>)request.getAttribute("dailyReply");
ChangeIDForName Change=new ChangeIDForName();
Connection con=Connect.getConnection();

//���ձ��û�IDת�����û���
int g_intUserID=DailyDetail.getG_intDailyUser();
String g_strUserName=Change.getUserName(con,g_intUserID);

//��������IDת�����������û���
int g_intDailyCheckUser=int_headOfDepID;
String g_strDailyCheckUser=null;
if(g_intDailyCheckUser!=-1){//����ձ�Ϊ���ģ���������ID=-1��Ϊ��ֹ���ݿ��ѯ���������ж�
g_strDailyCheckUser=Change.getUserName(con,g_intDailyCheckUser);
}

//����ĿIDת������Ŀ��
int g_intProjectID=DailyDetail.getG_intDailyProject();
String g_strProjectName=null;
if(g_intProjectID!=-1){//������ձ�Ϊ����Ŀ�ձ������ձ�ID=-1��Ϊ��ֹ���ݿ��ѯ���������ж�
g_strProjectName=Change.getProjectName(con,g_intProjectID);
}

//������IDת����������
int g_intTaskID=DailyDetail.getG_intDailyTask();
String g_strTaskName=Change.getTaskName(con,g_intTaskID);

//����ʱ��ȡ�������������ת��Ϊ�ա�ʱ����
int workCount=DailyDetail.getG_intDailyCount();
 %>
 <form name="form" action="DailyCheckServlet?flag=3" method="post" onsubmit="return check()">
<table width="100%" border="0" cellspacing="1" cellpadding="1">
  <tr>
    <td><div align="center"><strong><font size="+2">�ձ���ϸ��Ϣ</font></strong></div></td>
  </tr>
</table>
<table width="100%" height="34" border="1" cellpadding="1" cellspacing="1">
  <tr>
    <td width="10%"><div align="center">�ձ�ID</div></td>
    <td width="17%"><%=DailyDetail.getG_intDailyId() %><input type="hidden" name="dailyID" value="<%=DailyDetail.getG_intDailyId() %>"/></td>
    <td width="10%"><div align="center">����</div></td>
    <td width="22%"><%=g_strUserName %></td>
    <td width="10%"><div align="center">�ύ����</div></td>
    <td width="28%"><%=DailyDetail.getG_timDailySubmitTime() %></td>
  </tr>
</table>
<table width="100%" height="34" border="1" cellspacing="1" cellpadding="1">
  <tr>
    <td width="15%" height="28"><div align="center">�ձ�����</div></td>
    <td width="35%"><%if(DailyDetail.getG_intDailyType()==0){%>����Ŀ�ձ�<%}else{%>��Ŀ�ձ�<%} %></td>
    <td width="15%"><div align="center">������Ŀ</div></td>
    <td width="35%"><%if(g_strProjectName==null){%>��<%}else{%><%=g_strProjectName %><%} %></td>
  </tr>
</table>
<table width="100%" height="34" border="1" cellspacing="1" cellpadding="1">
  <tr>
    <td width="15%" height="28"><div align="center">��������</div></td>
    <td width="35%"><%=g_strTaskName %></td>
    <td width="15%"><div align="center">��ʱ</div></td>
    <td width="35%">
    <%=workCount/86400 %>&nbsp;��
    <%=(workCount%86400)/3600 %>&nbsp;ʱ
    <%=(workCount%3600)/60 %>&nbsp;��
    <%=(workCount%60) %>&nbsp;��
    </td>
  </tr>
</table>
<table width="100%" height="34" border="1" cellspacing="1" cellpadding="1">
  <tr>
    <td width="15%" height="28"><div align="center">��������</div></td>
    <td width="85%"><label>
      <textarea name="taskDescription" cols="150" rows="5" readonly="readonly" id="taskDescription"><%=DailyDetail.getG_strDailyTaskDescription() %></textarea>
    </label></td>
  </tr>
</table>
<table width="100%" height="34" border="1" cellspacing="1" cellpadding="1">
  <tr>
    <td width="15%" height="28"><div align="center">��ʼʱ��</div></td>
    <td width="35%"><%=DailyDetail.getG_timDailyBeginTime() %></td>
    <td width="15%"><div align="center">��ֹʱ��</div></td>
    <td width="35%"><%=DailyDetail.getG_timDailyEndTime() %></td>
  </tr>
</table>
<table width="100%" height="34" border="1" cellspacing="1" cellpadding="1">
  <tr>
    <td width="15%" height="28"><div align="center">������</div></td>
    <td width="85%"><label>
      <textarea name="taskDescription" cols="150" rows="5" readonly="readonly" id="taskDescription"><%=DailyDetail.getG_strDailyTaskStatus() %></textarea>
    </label></td>
  </tr>
</table>
<table width="100%" height="34" border="1" cellspacing="1" cellpadding="1">
  <tr>
    <td width="15%" height="28"><div align="center">��������</div></td>
    <td width="85%"><label>
      <textarea name="taskDescription" cols="150" rows="5" readonly="readonly" id="taskDescription"><%=DailyDetail.getG_strDailyProblem() %></textarea>
    </label></td>
  </tr>
</table>
<table width="100%" height="34" border="1" cellspacing="1" cellpadding="1">
  <tr>
    <td width="15%" height="28"><div align="center">�Ƿ�����</div></td>
    <td width="35%">
    <font color="#FF0000">δ����</font>
    </td>
    <td width="15%"><div align="center">������</div></td>
    <td width="35%"><%=g_strDailyCheckUser %><input type="hidden" name="checkUser" value="<%=int_headOfDepID%>" /></td>
  </tr>
</table>
<table width="100%" height="34" border="1" cellspacing="1" cellpadding="1">
  <tr>
    <td width="15%" height="28"><div align="center">�������</div></td>
    <td width="85%"><label>
      <textarea name="checkOpinion" cols="150" rows="5" id="checkOpinion"></textarea><font color="red">*2000�ַ�����</font>
    </label></td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="1">
  <tr>
    <td><div align="center"><input type="submit" value="�ύ����" />
    <input type="button" value="����" onclick="goBack()" />
    </div></td>
    </tr>
</table>
</form>
<br />

<%if(DailyDetail.getG_strDailyImage()!=null){ %>
<table>
<tr>
<td align="left">����(����鿴ԭͼ)��</td>
</tr>
<tr>
<td><a href="http://localhost/daily/upload/<%=DailyDetail.getG_strDailyImage() %>" target="_blank"><img width="40%" height="40%" alt="����鿴ԭͼ" src="upload/<%=DailyDetail.getG_strDailyImage() %>"/></a></td>
</tr>
</table>
<%} %>

<table width="100%" border="0" cellspacing="0" cellpadding="1">
  <tr>
    <td><div align="left"><font size="+2">�ظ���Ϣ:</font></div></td>
  </tr>
</table>
<br />
<!--��������java�����forѭ����ӡ�ظ����-->
<%if(_DailyReply!=null){
for(int i=0;i<_DailyReply.size();i++){
 %>
<table width="100%" height="34" border="1" cellpadding="1" cellspacing="1">
  <tr>
    <td width="15%"><div align="center">��<font color="#FF0000"><%=i %></font>¥</div></td>
    <td width="15%"><div align="center">����</div></td>
    <td width="20%"><%
    int g_intUserID_1=_DailyReply.get(i).getG_intDailyReplyUser();
    String g_strUserName_1=Change.getUserName(con,g_intUserID_1);//������IDת������������
     %><%=g_strUserName_1 %></td>
    <td width="15%"><div align="center">�ظ�ʱ��</div></td>
    <td width="20%"><%=_DailyReply.get(i).getG_timDailyReplyTime() %></td>
    <td width="15%">&nbsp;</td>
  </tr>
</table>
<table width="100%" height="34" border="1" cellspacing="1" cellpadding="1">
  <tr>
    <td width="15%" height="28"><div align="center">�ظ�����</div></td>
    <td width="85%">
        <table>
            <tr>
                <td><textarea name="taskDescription" cols="150" rows="5" readonly="readonly" id="taskDescription"><%=_DailyReply.get(i).getG_strDailyReplyContent() %></textarea></td>
            </tr>
            <%if(_DailyReply.get(i).getG_strDailyReplyImage()!=null){ %>
            <tr>
                <td>����(����鿴ԭͼ)��</td>
            </tr>
            <tr>
                <td><a href="http://localhost/daily/upload/<%=_DailyReply.get(i).getG_strDailyReplyImage() %>" target="_blank"><img width="40%" height="40%" alt="����鿴ԭͼ" src="upload/<%=_DailyReply.get(i).getG_strDailyReplyImage() %>" /></a></td>
            </tr>
            <%} %>
        </table>
    </td>
  </tr>
</table>
<br />
<%} }%>
<!--ѭ�����˽���-->
<%con.close(); //�ر����ݿ����� 
}else{%><!-- ��ѯ���Ϊ�� -->
<br />
<br />
<br />
<br />
<table width="100%">
<tr>
<td align="center"><font size="+2" color="#FF0000">�޲�ѯ�����������Ȩ�鿴</font></td>
</tr>
<tr><td>&nbsp;</td></tr>
<tr>
<td align="center"><input type="button" value="����" onClick="window.history.back();"/></td>
</tr>
</table>
<%}%>
</body>
</html>