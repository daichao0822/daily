<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*,java.util.*,com.bean.*,com.dao.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>������Ŀ</title>
<base target="_self">
<link rel="stylesheet" type="text/css" href="page/PMO/skin/css/base.css" />
<link rel="stylesheet" type="text/css" href="page/PMO/skin/css/main.css" />
<script type="text/javascript">
function check(){
	var project=document.getElementsByName("projectID");
	var i=0;
	for(i=0;i<project.length;i++){
		if(project[i].checked){
			if(confirm("ɾ����Ŀ������Ŀ���������Ϣ������ɾ��,�ò��������棬ȷ��ɾ����")){
				return true;
				exit;
			}
			else{
				return false;
				exit;
			}
		}
	}
	if(i==project.length){
		alert("����ѡ��һ����Ŀ��");
		return false;
	}
}

function CreateProject(){
	window.open("page/PMO/add_new_project.jsp","AddNewProject","directories=no,left=200,top=250,height=250,width=955,location=no,menubar=no,resizable=yes,scrollbars=yes,status=no,toolbar=no",false);
}
</script>
</head>
<body>
<%
List<Project> list=(List)request.getAttribute("list");
ChangeIDForName change=new ChangeIDForName();
Connection con=Connect.getConnection();
 %>
 <table width="98%" align="center" border="0" cellpadding="4" cellspacing="1"  style="margin-bottom:8px">
<tr>
<td align="left"><input type="button" name="button" value="��������Ŀ" onclick="CreateProject()" /></td>
</tr>
</table>
 <form name="form" action="DeleteProjectServlet" method="post" onsubmit="return check()">
<table width="98%" align="center" border="0" cellpadding="4" cellspacing="1" bgcolor="#CBD8AC"  style="margin-bottom:8px">
<tr bgcolor="#EEF4EA">
<td colspan="2" bgcolor="#CBD8AC"  class='title'><span>��ֹͣ��Ŀ</span></td>
</tr>
<tr>
<td width="5%" align="center" background="page/PMO/skin/images/frame/wbg.gif">ѡ��</td>
<td width="9%" align="center" background="page/PMO/skin/images/frame/wbg.gif">��ĿID</td>
<td width="10%" align="center" background="page/PMO/skin/images/frame/wbg.gif">��Ŀ����</td>
<td width="10%" align="center" background="page/PMO/skin/images/frame/wbg.gif">��Ŀ���</td>
<td width="10%" align="center" background="page/PMO/skin/images/frame/wbg.gif">��Ŀ����</td>
<td width="9%" align="center" background="page/PMO/skin/images/frame/wbg.gif">��Ŀ״̬</td>
<td width="19%" align="center" background="page/PMO/skin/images/frame/wbg.gif">��Ŀ��ʼʱ��</td>
<td width="18%" align="center" background="page/PMO/skin/images/frame/wbg.gif">��Ŀֹͣʱ��</td>
<td width="10%" align="center" background="page/PMO/skin/images/frame/wbg.gif">����</td>
</tr>
<%
if(list!=null){
for(int i=0;i<list.size();i++){
if(list.get(i).getG_intProjectStatus()==0){

 %>
<tr bgcolor="#FFFFFF">
<td align="center"><input type="checkbox" name="projectID" value="<%=list.get(i).getG_intProjectId() %>" /></td>
<td align="center"><%=list.get(i).getG_intProjectId() %></td>
<td align="center"><%=list.get(i).getG_strProjectName() %></td>
<td align="center"><%=list.get(i).getG_strProjectNumber() %></td>
<td align="center"><%=change.getUserName(con,list.get(i).getG_intProjectManager()) %></td>
<td align="center">��ֹͣ</td>
<td align="center"><%=list.get(i).getG_timProjectBeginTime() %></td>
<td align="center"><%=list.get(i).getG_timProjectEndTime() %></td>
<td align="center"><a href="ProjectDetailForPMOServlet?flag=1&id=<%=list.get(i).getG_intProjectId() %>">��ϸ</a></td>
</tr>
<%}
}
} 
%>
</table>
<br />
<table width="98%" align="center" border="0" cellpadding="4" cellspacing="1" bgcolor="#CBD8AC"  style="margin-bottom:8px">
<tr bgcolor="#EEF4EA">
<td colspan="2" bgcolor="#CBD8AC"  class='title'><span>����ͣ��Ŀ</span></td>
</tr>
<tr>
<td width="5%" align="center" background="page/PMO/skin/images/frame/wbg.gif">ѡ��</td>
<td width="9%" align="center" background="page/PMO/skin/images/frame/wbg.gif">��ĿID</td>
<td width="10%" align="center" background="page/PMO/skin/images/frame/wbg.gif">��Ŀ����</td>
<td width="10%" align="center" background="page/PMO/skin/images/frame/wbg.gif">��Ŀ���</td>
<td width="10%" align="center" background="page/PMO/skin/images/frame/wbg.gif">��Ŀ����</td>
<td width="9%" align="center" background="page/PMO/skin/images/frame/wbg.gif">��Ŀ״̬</td>
<td width="19%" align="center" background="page/PMO/skin/images/frame/wbg.gif">��Ŀ��ʼʱ��</td>
<td width="18%" align="center" background="page/PMO/skin/images/frame/wbg.gif">��Ŀֹͣʱ��</td>
<td width="10%" align="center" background="page/PMO/skin/images/frame/wbg.gif">����</td>
</tr>
<%
if(list!=null){
for(int i=0;i<list.size();i++){
if(list.get(i).getG_intProjectStatus()==1){
 %>
<tr bgcolor="#FFFFFF">
<td align="center"><input type="checkbox" name="projectID" value="<%=list.get(i).getG_intProjectId() %>" /></td>
<td align="center"><%=list.get(i).getG_intProjectId() %></td>
<td align="center"><%=list.get(i).getG_strProjectName() %></td>
<td align="center"><%=list.get(i).getG_strProjectNumber() %></td>
<td align="center"><%=change.getUserName(con,list.get(i).getG_intProjectManager()) %></td>
<td align="center">����ͣ</td>
<td align="center"><%=list.get(i).getG_timProjectBeginTime() %></td>
<td align="center">��</td>
<td align="center"><a href="ProjectDetailForPMOServlet?flag=2&id=<%=list.get(i).getG_intProjectId() %>">��ϸ</a></td>
</tr>
<%}
} 
}
%>
</table>
<br />
<table width="98%" align="center" border="0" cellpadding="4" cellspacing="1" bgcolor="#CBD8AC"  style="margin-bottom:8px">
<tr bgcolor="#EEF4EA">
<td colspan="2" bgcolor="#CBD8AC"  class='title'><span>���ڽ�����Ŀ</span></td>
</tr>
<tr>
<td width="5%" align="center" background="page/PMO/skin/images/frame/wbg.gif">ѡ��</td>
<td width="9%" align="center" background="page/PMO/skin/images/frame/wbg.gif">��ĿID</td>
<td width="10%" align="center" background="page/PMO/skin/images/frame/wbg.gif">��Ŀ����</td>
<td width="10%" align="center" background="page/PMO/skin/images/frame/wbg.gif">��Ŀ���</td>
<td width="10%" align="center" background="page/PMO/skin/images/frame/wbg.gif">��Ŀ����</td>
<td width="9%" align="center" background="page/PMO/skin/images/frame/wbg.gif">��Ŀ״̬</td>
<td width="19%" align="center" background="page/PMO/skin/images/frame/wbg.gif">��Ŀ��ʼʱ��</td>
<td width="18%" align="center" background="page/PMO/skin/images/frame/wbg.gif">��Ŀֹͣʱ��</td>
<td width="10%" align="center" background="page/PMO/skin/images/frame/wbg.gif">����</td>
</tr>
<%
if(list!=null){
for(int i=0;i<list.size();i++){
if(list.get(i).getG_intProjectStatus()==2){

 %>
<tr bgcolor="#FFFFFF">
<td align="center"><input type="checkbox" name="projectID" value="<%=list.get(i).getG_intProjectId() %>" /></td>
<td align="center"><%=list.get(i).getG_intProjectId() %></td>
<td align="center"><%=list.get(i).getG_strProjectName() %></td>
<td align="center"><%=list.get(i).getG_strProjectNumber() %></td>
<td align="center"><%=change.getUserName(con,list.get(i).getG_intProjectManager()) %></td>
<td align="center">���ڽ���</td>
<td align="center"><%=list.get(i).getG_timProjectBeginTime() %></td>
<td align="center">
<%if(list.get(i).getG_timProjectEndTime()==null){ %>��
<%}else{ %><%=list.get(i).getG_timProjectEndTime() %>
<%} %>
</td>
<td align="center"><a href="ProjectDetailForPMOServlet?flag=3&id=<%=list.get(i).getG_intProjectId() %>">��ϸ</a></td>
</tr>
<%}
} 
}
con.close();
%>
</table>
<table width="98%" align="center" border="0" cellpadding="4" cellspacing="1"  style="margin-bottom:8px">
<tr>
<td align="center"><input type="submit" value="ɾ����Ŀ" /></td>
</tr>
</table>
</form>
</body>
</html>