<%@ page language="java" import="java.util.*" import="java.sql.*,com.bean.*,com.dao.*"  pageEncoding="gb2312"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>部门信息</title>
<base target="_self">
<link rel="stylesheet" type="text/css" href="page/head_of_department/skin/css/base.css" />
<link rel="stylesheet" type="text/css" href="page/head_of_department/skin/css/main.css" />
<script type="text/javascript">
function newLocation(url)
{
		window.location=url
}

function check() {
	var s = document.getElementById("hidden").value;
	var obj = document.getElementsByName("userid");
	for (i = 0; i < obj.length; i++) {
		if (obj[i].checked && obj[i].value == s) {
			alert("不能删除自己！");
			return false;
		} else if (obj[i].checked && obj[i].value != s) {
			if (confirm("删除后，用户所有信息将从系统删除，确定删除？")) {
				return true;
			} else {
				return false;
			}
		}
	}
	window.alert("至少选中一个人员！");
	return false;
}

function AddNewUser(did){
	window.open("AddNewUserServlet?flag=11&did="+did,"addNewUser","directories=no,left=200,top=250,height=180,width=920,location=no,menubar=no,resizable=yes,scrollbars=yes,status=yes,toolbar=no",false);
}
</script>
</head>
<body leftmargin="8" topmargin='8'>
<%

List<User> list=(List<User>)request.getAttribute("user");
String str_departmentName=request.getParameter("dn");
String str_departmentID=request.getParameter("did");
 %>
<br >
<form name="form" action="UserMngForDepServlet?flag=2" method="post" onSubmit="return check()">
<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td><div style='float:left'> <img height="14" src="page/head_of_department/skin/images/frame/book1.gif" width="20" />&nbsp;部门人员信息。 </div>
      </td>
  </tr>
  <tr>
    <td height="1" background="page/head_of_department/skin/images/frame/sp_bg.gif" style='padding:0px'></td>
  </tr>
</table>

<table width="98%" align="center" border="0" cellpadding="4" cellspacing="1" bgcolor="#CBD8AC" >
  <tr bgcolor="#EEF4EA">
    <td colspan="2" background="page/head_of_department/skin/images/frame/wbg.gif" class='title'><span>用户基本信息</span></td>
  </tr>
  </table>
<table width="98%" align="center" border="0" cellpadding="4" cellspacing="1" bgcolor="#CBD8AC" style="margin-bottom:8px">
  <tr bgcolor="#FFFFFF">
    <td width="7%" align="center">选择
    <input type="hidden" name="hidden" id="hidden" value="${sessionScope.userInfo.g_intUserId}" />
    </td>
    <td width="10%" align="center">ID</td>
    <td width="9%" align="center">姓名</td>
    <td width="7%" align="center">性别</td>
    <td width="12%" align="center">所属部门</td>
    <td width="18%" align="center">邮箱</td>
    <td width="37%" align="center">拥有权限</td>
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
    <td align="center"><%=str_departmentName %></td>
    <td align="center"><%=list.get(i).getG_strEmail() %></td>
    <td align="center">普通用户&nbsp;
    <%
    if(list.get(i).getG_intRole2()==1){%>项目经理&nbsp;
    <%
    }
    if(list.get(i).getG_intRole3()==1){%>部门长&nbsp;
    <%
    }
    if(list.get(i).getG_intRole4()==1){%>PMO&nbsp;
    <%
    }
    if(list.get(i).getG_intRole5()==1){%>管理员&nbsp;
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
     <td><font color="#FF0000">没有部门人员</font></td>
  </tr>
  <%
  }
   %>
  
</table>

<table width="98%" align="center" border="0" cellpadding="4" cellspacing="1" bgcolor="#CBD8AC">
  <tr bgcolor="#FFFFFF">
    <td align="center" height="32"><input type="submit" value="删除人员" />
      &nbsp;
    <input type="button" name="button" value="添加新用户" onClick="AddNewUser(<%=str_departmentID %>)" />
    <input type='button' class="coolbg np" onClick="newLocation('page/head_of_department/main.jsp')" value='返回主页' /></td>
  </tr>
</table>
</form>
</body>
</html>
