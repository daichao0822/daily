<%@ page language="java" import="java.util.*,java.sql.*,com.bean.User" pageEncoding="gb2312"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>���ձ�ϵͳ</title>
<style>
body { padding:0px; margin:0px; }
#tpa {
	color: #009933;
	margin:0px;
	padding:0px;
	float:right;
	padding-right:10px;
}

#tpa dd {
	margin:0px;
	padding:0px;
	float:left;
	margin-right:2px;
}

#tpa dd.ditem {
	margin-right:8px;
}

#tpa dd.img {
  padding-top:6px;
}

div.item
{
  text-align:center;
	background:url(skin/images/frame/topitembg.gif) 0px 3px no-repeat;
	width:82px;
	height:26px;
	line-height:28px;
}

.itemsel {
  width:80px;
  text-align:center;
  background:#226411;
	border-left:1px solid #c5f097;
	border-right:1px solid #c5f097;
	border-top:1px solid #c5f097;
	height:26px;
	line-height:28px;
}

*html .itemsel {
	height:26px;
	line-height:26px;
}

a:link,a:visited {
 text-decoration: underline;
}

.item a:link, .item a:visited {
	font-size: 12px;
	color: #ffffff;
	text-decoration: none;
	font-weight: bold;
}

.itemsel a:hover {
	color: #ffffff;
	font-weight: bold;
	border-bottom:2px solid #E9FC65;
}

.itemsel a:link, .itemsel a:visited {
	font-size: 12px;
	color: #ffffff;
	text-decoration: none;
	font-weight: bold;
}

.itemsel a:hover {
	color: #ffffff;
	border-bottom:2px solid #E9FC65;
}

.rmain {
  padding-left:10px;
  /* background:url(skin/images/frame/toprightbg.gif) no-repeat; */
}
</style>
</head>
<script type="text/javascript">
function changePassword(id){
	window.open("../change_password.jsp","ChangePassword","directories=no,left=500,top=250,height=250,width=350,location=no,menubar=no,resizable=yes,scrollbars=no,status=no,toolbar=no",false);
}

function logout(){
    if(confirm("ȷ��ע���˳���")){
        top.location.href="../../LogoutServlet"
    }
}

function changeRole(role){
	if(confirm("ȷ��ע�����ε�¼��ת����ɫ��")){
		top.location.href="../../ChangeRoleServlet?role="+role;
	}
}
</script>
<body bgColor='#ffffff'>
<%
User user=new User();
if(session.getAttribute("userInfo")==null){
response.sendRedirect("http://localhost/daily/page/session_error.jsp");
return;
}
user=(User)session.getAttribute("userInfo");
String user_name=user.getG_strUserName();
int user_id=user.getG_intUserId();
int role1=user.getG_intRole1();
int role2=user.getG_intRole2();
int role3=user.getG_intRole3();
int role4=user.getG_intRole4();
int role5=user.getG_intRole5();
//���»������
int year=0;
int month=0;
int day=0;
Calendar c=Calendar.getInstance();
year=c.get(Calendar.YEAR);
month=c.get(Calendar.MONTH)+1;
day=c.get(Calendar.DAY_OF_MONTH);
//���µõ�����
java.util.Date dt=new java.util.Date();
String[] weekDays={"������","����һ","���ڶ�","������","������","������","������"};
Calendar cal=Calendar.getInstance();
cal.setTime(dt);
int w=cal.get(Calendar.DAY_OF_WEEK)-1;
if(w<0)
w=0;
String dayOfWeek=weekDays[w];
 %>
<table width="100%" border="0" cellpadding="0" cellspacing="0" background="skin/images/frame/topbg.gif">
  <tr>
    <td width='15%' height="60"><img src="skin/images/frame/logo.gif" /></td>
    <td width='85%' align="right" valign="bottom">
    	<table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
      <td width="60%" height="26" align="right" style="padding-right:10px;line-height:26px;">
        	<font size="-1">���ã�<%=user_name %>����ӭʹ�����ձ�ϵͳ,������ <%=year %>�� <%=month %>�� <%=day %>�� <%=dayOfWeek %></font>&nbsp;&nbsp;&nbsp;
        	<input type="button" style="background-color:#9C3" value="�޸�����" onClick="changePassword()" />
        	<input type="button" style="background-color:#9C3" value="ע���˳�" onClick="logout()">
      </td>
      </tr>
      <tr>
        <td align="right" height="34" class="rmain">
        <font size="-1">���ٵ�¼������ɫ��</font><%
		if(role1==1){
			%>
            <input type="button" style="width:62px; height:21px;background-color:#9C3" name="button1" id="button1" value="��Ŀ��Ա" onClick="changeRole(1)" />
			<%
		}
		if(role3==1){
			%>
			<input type="button" style="width:62px; height:21px;background-color:#9C3" name="button2" id="button2" value="���ų�" onClick="changeRole(3)" />
			<%
		}
		if(role4==1){
			%>
            <input type="button" style="width:62px; height:21px;background-color:#9C3" name="button3" id="button3" value="PMO" onClick="changeRole(4)" />
			<%
		}
		if(role5==1){
			%>
            <input type="button" style="width:62px; height:21px;background-color:#9C3" name="button4" id="button4" value="����Ա" onClick="changeRole(5)" />
			<%
		}
		%>
		</td>
      </tr>
    </table></td>
  </tr>
</table>
</body>
</html>
