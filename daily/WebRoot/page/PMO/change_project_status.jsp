<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*,java.util.*,com.bean.*,com.dao.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>��������Ŀ��ϸ��Ϣ</title>
<base target="_self">
<link rel="stylesheet" type="text/css" href="page/manager/skin/css/base.css" />
<link rel="stylesheet" type="text/css" href="page/manager/skin/css/main.css" />
</head>
<script type="text/javascript">
function ConfirmChange(){
	var s=document.getElementById("status").value;
	if(s==0){
		if(confirm("ȷ��Ҫ����Ŀ״̬��Ϊ  ֹͣ  �𣿸ò��������棬���������")){
			return true;
		}
		else{
			return false;
		}
	}
	else if(s==1){
	    if(confirm("ȷ��Ҫ����Ŀ״̬��Ϊ  ��ͣ  ��")){
	        return true;
	    }
	    else{
	        return false;
	    }
	}
	else if(s==2){
		if(confirm("ȷ��Ҫ����Ŀ״̬��Ϊ  ���� ��")){
			return true;
		}
		else{
			return false;
		}
	}
}

function CloseWindow(){
	window.close();
}
</script>
<body>
<%
List<Project> proDetail=(List)request.getAttribute("project");
ChangeIDForName change=new ChangeIDForName();
Connection con=Connect.getConnection();
 %>
 <form name="form" action="ChangeProjectStatusServlet?flag=2" method="post" onsubmit="return ConfirmChange()">
<table width="98%" align="center" border="0" cellpadding="4" cellspacing="1" bgcolor="#CBD8AC"  style="margin-bottom:8px">
<tr bgcolor="#EEF4EA">
<td colspan="2" bgcolor="#CBD8AC"  class='title'><span>��Ŀ��ϸ</span></td>
</tr>
<tr>
<td width="10%" align="center" background="page/PMO/skin/images/frame/wbg.gif">��ĿID</td>
<td width="11%" align="center" background="page/PMO/skin/images/frame/wbg.gif">��Ŀ����</td>
<td width="11%" align="center" background="page/PMO/skin/images/frame/wbg.gif">��Ŀ���</td>
<td width="14%" align="center" background="page/PMO/skin/images/frame/wbg.gif">��Ŀ����</td>
<td width="22%" align="center" background="page/PMO/skin/images/frame/wbg.gif">��Ŀ��ʼʱ��</td>
<td width="22%" align="center" background="page/PMO/skin/images/frame/wbg.gif">��Ŀ����ʱ��</td>
<td width="10%" align="center" background="page/PMO/skin/images/frame/wbg.gif">��Ŀ״̬</td>
</tr>
<%
if(proDetail!=null){
    for(int i=0;i<proDetail.size();i++){
 %>
<tr bgcolor="#FFFFFF">
<td align="center">
<%=proDetail.get(i).getG_intProjectId() %>
<input type="hidden" name="projectID" id="projectID" value="<%=proDetail.get(i).getG_intProjectId() %>" /></td><!--  �����ύ��ĿID -->
<td align="center"><%=proDetail.get(i).getG_strProjectName() %></td>
<td align="center"><%=proDetail.get(i).getG_strProjectNumber() %></td>
<td align="center"><%=change.getUserName(con,proDetail.get(i).getG_intProjectManager()) %></td>
<td align="center"><%=proDetail.get(i).getG_timProjectBeginTime() %></td>
<td align="center">
<%if(proDetail.get(i).getG_timProjectEndTime()==null){
%>&nbsp;
<%
}else{%><%=proDetail.get(i).getG_timProjectEndTime() %><%}%></td>
<td align="center"><select name="status" id="status">
                         <%
                         if(proDetail.get(i).getG_intProjectStatus()==1){
                         %>
                         <option value="0">ֹͣ</option>                  
                         <option value="2">����</option>
                         <%
                         }else if(proDetail.get(i).getG_intProjectStatus()==2){
                         %>
                         <option value="0">ֹͣ</option>                  
                         <option value="1">��ͣ</option>
                         <%
                         }
                          %>
                         
                   </select></td>
</tr>
 <%}
 }
 else{ %>
<tr bgcolor="#FFFFFF">
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td align="center"><font color="#FF0000">Ŀǰû����ֹͣ������Ŀ</font></td>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>&nbsp;</td>
</tr>
 <%} %>
</table>
<%con.close(); %>
<table width="98%" align="center">
  <tr>
<td align="center">
<input type="submit" value="ȷ��" />&nbsp;<input type="button" name="button" value="�ر�" onclick="CloseWindow()" />
</td>
</tr>
</table>
</form>
</body>
</html>