<%@ page language="java" import="java.util.*" import="java.sql.*,com.bean.*,com.dao.*"  pageEncoding="gb2312"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>main</title>
<base target="_self">
<link rel="stylesheet" type="text/css" href="skin/css/base.css" />
<link rel="stylesheet" type="text/css" href="skin/css/main.css" />
<script type="text/javascript">
function newLocation(url)
{
		window.location=url
}

function addEmail(){
    	window.open("../add_email.jsp","AddEmail","directories=no,left=500,top=250,height=150,width=550,location=no,menubar=no,resizable=yes,scrollbars=no,status=no,toolbar=no",false);
}

function changeEmail(){
       	window.open("../change_email.jsp","AddEmail","directories=no,left=500,top=250,height=150,width=550,location=no,menubar=no,resizable=yes,scrollbars=no,status=no,toolbar=no",false);
    
}
</script>
</head>
<body leftmargin="8" topmargin='8'>
<%
Connection con=Connect.getConnection();
ChangeIDForName name=new ChangeIDForName();
HttpSession sessions=request.getSession();
if(session.getAttribute("userInfo")==null){
	response.sendRedirect("http://localhost/daily/page/session_error.jsp");
	return;
}
User user=(User)session.getAttribute("userInfo");
 %>
<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td><div style='float:left'> <img height="14" src="skin/images/frame/book1.gif" width="20" />&nbsp;您的个人基本信息。 </div>
      <div style='float:right;padding-right:8px;'>
      </div></td>
  </tr>
  <tr>
    <td height="1" background="skin/images/frame/sp_bg.gif" style='padding:0px'></td>
  </tr>
</table>

<table width="98%" align="center" border="0" cellpadding="4" cellspacing="1" bgcolor="#CBD8AC" style="margin-bottom:8px">
  <tr bgcolor="#EEF4EA">
    <td colspan="2" background="skin/images/frame/wbg.gif" class='title'><span>用户基本信息</span></td>
  </tr>
  <tr bgcolor="#FFFFFF">
    <td>您的用户名：</td>
    <td id="userId">${sessionScope.userInfo.g_strUserName}</td>
  </tr>
    <tr bgcolor="#FFFFFF">
    <td width="25%" bgcolor="#FFFFFF">您拥有的权限：</td>
    <td width="75%" bgcolor="#FFFFFF" id="clas">
    普通用户&nbsp;<%
	if(user.getG_intRole2()==1){%>项目经理&nbsp;&nbsp;<%
	}
    if(user.getG_intRole3()==1){%>部门长&nbsp;&nbsp;<%
    }
    if(user.getG_intRole4()==1){%>PMO&nbsp;&nbsp;<%
    }
    if(user.getG_intRole5()==1){%>管理员&nbsp;&nbsp;<%
    }
	%></td>
  </tr>
    <tr bgcolor="#FFFFFF">
    <td>您的性别：</td>
    <td id="sex">
 <%=user.getG_strSex() %>
    </td>
  </tr>
  <tr bgcolor="#FFFFFF">
    <td>您所属部门：</td>
    <td id="team">
    <%=name.GetDepartmentName(con,user.getG_intDepartment()) %>
    </td>
  </tr>
    <tr bgcolor="#FFFFFF">
    <td>您的email：</td>
    <td id="email">
	<%
	if(user.getG_strEmail()==null){%>无&nbsp;<input type="button" value="添加" onclick="addEmail()" /><%
	}else{%>
        <%=user.getG_strEmail()%> &nbsp;<input type="button" value="修改" onclick="changeEmail()" />  <%
	}
	con.close();
	%></td>
  </tr>
</table>
<table width="98%" align="center" border="0" cellpadding="4" cellspacing="1" bgcolor="#CBD8AC">
  <tr bgcolor="#FFFFFF">
    <td align="center" height="32">
    <input type='button' class="coolbg np" onClick="newLocation('main.jsp')" value='返回主页' /></td>
  </tr>
</table>
<table width="98%" align="center" border="0" cellpadding="4" cellspacing="1" bgcolor="#CBD8AC">
  <tr bgcolor="#EEF4EA">
    <td colspan="2" background="skin/images/frame/wbg.gif" class='title'><span>公司网址</span></td>
  </tr>
  <tr bgcolor="#FFFFFF">
    <td width="25%" height="32">网址：</td>
    <td width="75%"><a href="http://www.vantrontech.com.cn" target="_blank"><u>http://www.vantrontech.com.cn</u></a></td>
  </tr>
</table>
</body>
</html>
