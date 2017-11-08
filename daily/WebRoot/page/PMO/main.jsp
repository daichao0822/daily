<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*,com.bean.*" import="java.util.List" import="com.bean.Memo" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>main</title>
<base target="_self">
<link rel="stylesheet" type="text/css" href="skin/css/base.css" />
<link rel="stylesheet" type="text/css" href="skin/css/main.css" />
<script type="text/javascript" src="${pageContext.request.contextPath }/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
function check(){
var date= document.getElementById("time").value;
var content= document.getElementById("content").value;
if(date==""){
alert("请选择提醒日期");
exit;
}
else if(content==""){
alert("请填写提醒内容");
exit;
}
else{
if(confirm("确认提交吗？")){
		   var url = "../../SubmitMemoServlet?date=" + date + "&content="
			    	+ content;
		   if (window.XMLHttpRequest) {
			   http_request = new XMLHttpRequest();
			   if (http_request.overrideMimeType) {
				   http_request.overrideMimeType("text/xml");
			   }
		   } else if (window.ActiveXObject) {
			   try {
				   http_request = new ActiveXObject("Msxml2.XMLHTTP");
			   } catch (e) {
				   try {
					   http_request = new ActiveXObject("Microsoft.XMLHTTP");

				   } catch (e2) {
					   http_request = false;
				   }
			   }
		   }
		   if (!http_request) {
			   alert("不能创建XMLHttpRequest对象实例");
			   return false;
		   } else {
			   http_request.open("POST", url, true);
			   http_request.onreadystatechange = updatepage;
			   http_request.send(null);
		   }
	    }
}
}

function updatepage() {
	if (http_request.readyState == 4) {
		if (http_request.status == 200) {
			if (http_request.responseText == 0) {
				alert("提交失败！");
			} else if (http_request.responseText == 1) {
				alert("提交成功！");
				document.getElementById("content").value="";
				document.getElementById("time").value="";
			}else if(http_request.responseText == 2){
			    alert("错误！您不能继续操作，可能原因：1、session超时  2、您已退出  3、您的账号已在别处登录，请重新登录");
			    top.location.replace("http://localhost/daily");
			} else {
				alert("返回值="+http_request.responseText);
			}
		} else {
			alert("您所请求的页面有异常");
		}
	}
}

</script>
</head>
<body leftmargin="8" topmargin='8'>
<%
if(session.getAttribute("userInfo")==null){
	response.sendRedirect("http://localhost/daily/page/session_error.jsp");
	return;
}
List<Memo> memo=(List)session.getAttribute("memo");
User user=(User)session.getAttribute("userInfo");
 %>
<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td><div style='float:left'> <img height="14" src="skin/images/frame/book1.gif" width="20" />&nbsp;欢迎使用万创日报系统 </div>
      <div style='float:right;padding-right:8px;'>
        <!--  //保留接口  -->
      </div></td>
  </tr>
  <tr>
    <td height="1" background="skin/images/frame/sp_bg.gif" style='padding:0px'></td>
  </tr>
</table>
<table width="98%" align="center" border="0" cellpadding="3" cellspacing="1" bgcolor="#CBD8AC" style="margin-bottom:8px;margin-top:8px;">
  <tr>
    <td background="skin/images/frame/wbg.gif" bgcolor="#EEF4EA" class='title'><span>今日提醒（<font size="-1" color="#FF0000"><%=memo.size() %></font>）</span></td>
  </tr>
  <tr bgcolor="#FFFFFF">
    <td><table width="98%" align="center" border="1" cellpadding="3" cellspacing="1"  style="margin-bottom:8px;margin-top:8px;">
         <tr>
         <td width="10%" align="center"><strong>备忘ID</strong></td>
         <td width="15%" align="center"><strong>提醒日期</strong></td>
         <td width="10%" align="center"><strong>提醒人</strong></td>
         <td width="65%" align="center"><strong>备忘内容</strong></td>
         </tr>
         <%
		 for(int i=0;i<memo.size();i++){
			 %>
             <tr>
         <td width="10%" align="center"><%=memo.get(i).getG_intMemoId()%></td>
         <td width="15%" align="center"><%=memo.get(i).getG_datMemoDate()%></td>
         <td width="10%" align="center"><%=user.getG_strUserName() %></td>
         <td width="65%" align="left"><%=memo.get(i).getG_strMemoContent()%></td>
         </tr>
             <%
		 }
		 %>
        </table>
    </td>
  </tr>
</table>
<table width="98%" align="center" border="0" cellpadding="4" cellspacing="1" bgcolor="#CBD8AC" style="margin-bottom:8px">
  <tr>
    <td colspan="2" background="skin/images/frame/wbg.gif" bgcolor="#EEF4EA" class='title'>
    	<div style='float:left'><span>填写提醒日志</span></div>
    	<div style='float:right;padding-right:10px;'></div>
   </td>
  </tr>
  <tr bgcolor="#FFFFFF">
    <td height="30" colspan="2" align="center" valign="bottom"><table width="100%" border="0" cellspacing="1" cellpadding="1">
        <tr>
          <td width="8%" height="31" align="center"><img src="skin/images/frame/qc.gif" width="90" height="30" /></td>
          <td width="8%" valign="middle">
          	提醒日期：
            </td>
            <td width="13%" valign="middle">
            <input type="text" name="time" id="time" class="Wdate" onClick="WdatePicker({minDate:'%y-%M-{%d+1}'})"  />
            </td>
             <td width="8%" valign="middle" >            
          	提醒内容：
            </td>
            <td width="42%" valign="middle">
              <textarea name="content" cols="75" rows="3" id="content"></textarea>
            </td>
            <td width="9%" valign="middle">           
            <font size="-1" color="#FF0000">*400字符以内</font>           
            </td>
            <td width="12%">
            <input type="button" value="确定" onclick="check()" />
            </td>
        </tr>
      </table>
      </td>
  </tr>
</table>
<table width="98%" align="center" border="0" cellpadding="4" cellspacing="1" bgcolor="#CBD8AC" style="margin-bottom:8px">
  <tr bgcolor="#EEF4EA">
    <td colspan="2" background="skin/images/frame/wbg.gif" class='title'><span>系统基本信息</span></td>
  </tr>
  <tr bgcolor="#FFFFFF">
    <td width="25%" bgcolor="#FFFFFF">您的登录角色：</td>
    <td width="75%" bgcolor="#FFFFFF">PMO</td>
  </tr>
  <tr bgcolor="#FFFFFF">
    <td>软件版本信息：</td>
    <td>Version_3.0</td>
  </tr>
</table>
<table width="98%" align="center" border="0" cellpadding="4" cellspacing="1" bgcolor="#CBD8AC">
  <tr bgcolor="#EEF4EA">
    <td colspan="2" background="skin/images/frame/wbg.gif" class='title'><span>公司网址</span></td>
  </tr>
  <tr bgcolor="#FFFFFF">
    <td width="25%" height="32">公司网站：</td>
    <td width="75%"><a href="http://www.vantrontech.com.cn" target="_blank"><u>http://www.vantrontech.com.cn</u></a></td>
  </tr>
</table>
</body>
</html>