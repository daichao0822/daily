<%@ page language="java" import="java.util.*" import="java.sql.*,com.bean.*,com.dao.*"  pageEncoding="gb2312"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>������Ϣ</title>
<base target="_self">
<link rel="stylesheet" type="text/css" href="page/head_of_department/skin/css/base.css" />
<link rel="stylesheet" type="text/css" href="page/head_of_department/skin/css/main.css" />
<script type="text/javascript">
function newLocation(url)
{
		window.location=url
}
</script>
</head>
<body leftmargin="8" topmargin='8'>
<%
List<User> list=(List<User>)request.getAttribute("user");
Department dep=(Department)request.getAttribute("departmentInfo");
 %>
 <br>
<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td><div style='float:left'> <img height="14" src="page/head_of_department/skin/images/frame/book1.gif" width="20" />&nbsp;�������Ż�����Ϣ�� </div>
      </td>
  </tr>
  <tr>
    <td height="1" background="page/head_of_department/skin/images/frame/sp_bg.gif" style='padding:0px'></td>
  </tr>
</table>

<table width="98%" align="center" border="0" cellpadding="4" cellspacing="1" bgcolor="#CBD8AC" style="margin-bottom:8px">
  <tr bgcolor="#EEF4EA">
    <td colspan="2" background="page/head_of_department/skin/images/frame/wbg.gif" class='title'><span>���Ż�����Ϣ</span></td>
  </tr>
  <%
  if(dep!=null){
   %>
  <tr bgcolor="#FFFFFF">
    <td>����ID��</td>
    <td><%=dep.getG_intDepartmentId() %></td>
  </tr>
    <tr bgcolor="#FFFFFF">
    <td width="25%" bgcolor="#FFFFFF">�������ƣ�</td>
    <td width="75%" bgcolor="#FFFFFF"><%=dep.getG_strDepartmentName() %></td>
  </tr>
    <tr bgcolor="#FFFFFF">
    <td>���ų���</td>
    <td>${sessionScope.userInfo.g_strUserName}</td>
  </tr>
  <tr bgcolor="#FFFFFF">
    <td>����������</td>
    <td><%=dep.getG_strDepartmentDescription() %></td>
  </tr>
  <%}
  else{
  %>
  <tr bgcolor="#FFFFFF">
      <td>&nbsp;</td>
      <td align="center"><font color="#FF0000">û�в�����Ϣ</font></td>
  </tr>
  <%
  } %>
</table>
<br >
<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td><div style='float:left'> <img height="14" src="page/head_of_department/skin/images/frame/book1.gif" width="20" />&nbsp;������Ա��Ϣ�� </div>
      </td>
  </tr>
  <tr>
    <td height="1" background="page/head_of_department/skin/images/frame/sp_bg.gif" style='padding:0px'></td>
  </tr>
</table>

<table width="98%" align="center" border="0" cellpadding="4" cellspacing="1" bgcolor="#CBD8AC" >
  <tr bgcolor="#EEF4EA">
    <td colspan="2" background="page/head_of_department/skin/images/frame/wbg.gif" class='title'><span>�û�������Ϣ</span></td>
  </tr>
  </table>
<table width="98%" align="center" border="0" cellpadding="4" cellspacing="1" bgcolor="#CBD8AC" style="margin-bottom:8px">
  <tr bgcolor="#FFFFFF">
    <td width="8%" align="center">ID</td>
    <td width="10%" align="center">����</td>
    <td width="8%" align="center">�Ա�</td>
    <td width="12%" align="center">��������</td>
    <td width="14%" align="center">����</td>
    <td width="48%" align="center">ӵ��Ȩ��</td>
  </tr>
  <%
  if(list!=null){
      for(int i=0;i<list.size();i++){
      %>
  <tr bgcolor="#FFFFFF">
    <td align="center"><%=list.get(i).getG_intUserId() %></td>
    <td align="center"><%=list.get(i).getG_strUserName() %></td>
    <td align="center"><%=list.get(i).getG_strSex() %></td>
    <td align="center"><%=dep.getG_strDepartmentName()%></td>
    <td align="center"><%=list.get(i).getG_strEmail() %></td>
    <td align="center">��ͨ�û�&nbsp;
    <%
    if(list.get(i).getG_intRole2()==1){%>��Ŀ����&nbsp;
    <%
    }
    if(list.get(i).getG_intRole3()==1){%>���ų�&nbsp;
    <%
    }
    if(list.get(i).getG_intRole4()==1){%>PMO&nbsp;
    <%
    }
    if(list.get(i).getG_intRole5()==1){%>����Ա&nbsp;
    <%
    }
     %>
    </td>
  </tr>
      <%
      }
  }
  else{
  %>
  <tr bgcolor="#FFFFFF">
     <td>&nbsp;</td>
     <td>&nbsp;</td>
     <td>&nbsp;</td>
     <td>&nbsp;</td>
     <td>&nbsp;</td>
     <td><font color="#FF0000">û�в�����Ա</font></td>
  </tr>
  <%
  }
   %>
  
</table>

<table width="98%" align="center" border="0" cellpadding="4" cellspacing="1" bgcolor="#CBD8AC">
  <tr bgcolor="#FFFFFF">
    <td align="center" height="32">
    <input type='button' class="coolbg np" onClick="newLocation('page/head_of_department/main.jsp')" value='������ҳ' /></td>
  </tr>
</table>
</body>
</html>
