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
<link rel="stylesheet" type="text/css" href="page/administrator/skin/css/base.css" />
<link rel="stylesheet" type="text/css" href="page/administrator/skin/css/main.css" />
<script type="text/javascript">
function newLocation(url)
{
		window.location=url
}

function check() {
	var obj = document.getElementsByName("userid");
	var i=0;
	for (i = 0; i < obj.length; i++) {
		 if (obj[i].checked) {
			if (confirm("ȷ������û�PMOȨ�ޣ�")) {
				return true;
			} else {
				return false;
			}
		}
	}
	if(i==obj.length){
	window.alert("����ѡ��һ��PMO��");
	return false;
	}
}

</script>
</head>
<body leftmargin="8" topmargin='8'>
<%
List<User> list=(List<User>)request.getAttribute("user");
Connection con=Connect.getConnection();
ChangeIDForName change=new ChangeIDForName();
 %>
<br >
<form name="form" action="PMOManageServlet?flag=4" method="post" onSubmit="return check()">
<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td><div style='float:left'> <img height="14" src="page/head_of_department/skin/images/frame/book1.gif" width="20" />&nbsp;�����PMO��Ա </div>
      </td>
  </tr>
  <tr>
    <td height="1" background="page/head_of_department/skin/images/frame/sp_bg.gif" style='padding:0px'></td>
  </tr>
</table>

<table width="98%" align="center" border="0" cellpadding="4" cellspacing="1" bgcolor="#CBD8AC" >
  <tr bgcolor="#EEF4EA">
    <td colspan="2" background="page/head_of_department/skin/images/frame/wbg.gif" class='title'>
    <span>��ѡ��Ա������Ϣ</span></td>
  </tr>
  </table>
<table width="98%" align="center" border="0" cellpadding="4" cellspacing="1" bgcolor="#CBD8AC" style="margin-bottom:8px">
  <tr bgcolor="#FFFFFF">
    <td width="7%" align="center">ѡ��</td>
    <td width="10%" align="center">ID</td>
    <td width="9%" align="center">����</td>
    <td width="7%" align="center">�Ա�</td>
    <td width="12%" align="center">��������</td>
    <td width="18%" align="center">����</td>
    <td width="37%" align="center">ӵ��Ȩ��</td>
  </tr>
  <%
  if(list!=null){
      for(int i=0;i<list.size();i++){
      %>
  <tr bgcolor="#FFFFFF">
    <td align="center"><input type="checkbox" name="userid" value="<%=list.get(i).getG_intUserId() %>" /></td>
    <td align="center"><%=list.get(i).getG_intUserId() %></td>
    <td align="center"><%=list.get(i).getG_strUserName() %></td>
    <td align="center"><%=list.get(i).getG_strSex() %></td>
    <td align="center"><%=change.GetDepartmentName(con,list.get(i).getG_intDepartment()) %></td>
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
     <td>&nbsp;</td>
     <td><font color="#FF0000">û�в�����Ա</font></td>
  </tr>
  <%
  }
   %>
  
</table>

<table width="98%" align="center" border="0" cellpadding="4" cellspacing="1" bgcolor="#CBD8AC">
  <tr bgcolor="#FFFFFF">
    <td align="center" height="32"><input type="submit" value="���PMO" />
      &nbsp;
    <input type='button' class="coolbg np" onClick="window.close()" value='�ر�' /></td>
  </tr>
</table>
</form>
</body>
</html>
