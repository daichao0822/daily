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
alert("��ѡ����������");
exit;
}
else if(content==""){
alert("����д��������");
exit;
}
else{
if(confirm("ȷ���ύ��")){
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
			   alert("���ܴ���XMLHttpRequest����ʵ��");
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
				alert("�ύʧ�ܣ�");
			} else if (http_request.responseText == 1) {
				alert("�ύ�ɹ���");
				document.getElementById("content").value="";
				document.getElementById("time").value="";
			}else if(http_request.responseText == 2){
			    alert("���������ܼ�������������ԭ��1��session��ʱ  2�������˳�  3�������˺����ڱ𴦵�¼�������µ�¼");
			    top.location.replace("http://localhost/daily");
			} else {
				alert("����ֵ="+http_request.responseText);
			}
		} else {
			alert("���������ҳ�����쳣");
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
    <td><div style='float:left'> <img height="14" src="skin/images/frame/book1.gif" width="20" />&nbsp;��ӭʹ�����ձ�ϵͳ </div>
      <div style='float:right;padding-right:8px;'>
        <!--  //�����ӿ�  -->
      </div></td>
  </tr>
  <tr>
    <td height="1" background="skin/images/frame/sp_bg.gif" style='padding:0px'></td>
  </tr>
</table>
<table width="98%" align="center" border="0" cellpadding="3" cellspacing="1" bgcolor="#CBD8AC" style="margin-bottom:8px;margin-top:8px;">
  <tr>
    <td background="skin/images/frame/wbg.gif" bgcolor="#EEF4EA" class='title'><span>�������ѣ�<font size="-1" color="#FF0000"><%=memo.size() %></font>��</span></td>
  </tr>
  <tr bgcolor="#FFFFFF">
    <td><table width="98%" align="center" border="1" cellpadding="3" cellspacing="1"  style="margin-bottom:8px;margin-top:8px;">
         <tr>
         <td width="10%" align="center"><strong>����ID</strong></td>
         <td width="15%" align="center"><strong>��������</strong></td>
         <td width="10%" align="center"><strong>������</strong></td>
         <td width="65%" align="center"><strong>��������</strong></td>
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
    	<div style='float:left'><span>��д������־</span></div>
    	<div style='float:right;padding-right:10px;'></div>
   </td>
  </tr>
  <tr bgcolor="#FFFFFF">
    <td height="30" colspan="2" align="center" valign="bottom"><table width="100%" border="0" cellspacing="1" cellpadding="1">
        <tr>
          <td width="8%" height="31" align="center"><img src="skin/images/frame/qc.gif" width="90" height="30" /></td>
          <td width="8%" valign="middle">
          	�������ڣ�
            </td>
            <td width="13%" valign="middle">
            <input type="text" name="time" id="time" class="Wdate" onClick="WdatePicker({minDate:'%y-%M-{%d+1}'})"  />
            </td>
             <td width="8%" valign="middle" >            
          	�������ݣ�
            </td>
            <td width="42%" valign="middle">
              <textarea name="content" cols="75" rows="3" id="content"></textarea>
            </td>
            <td width="9%" valign="middle">           
            <font size="-1" color="#FF0000">*400�ַ�����</font>           
            </td>
            <td width="12%">
            <input type="button" value="ȷ��" onclick="check()" />
            </td>
        </tr>
      </table>
      </td>
  </tr>
</table>
<table width="98%" align="center" border="0" cellpadding="4" cellspacing="1" bgcolor="#CBD8AC" style="margin-bottom:8px">
  <tr bgcolor="#EEF4EA">
    <td colspan="2" background="skin/images/frame/wbg.gif" class='title'><span>ϵͳ������Ϣ</span></td>
  </tr>
  <tr bgcolor="#FFFFFF">
    <td width="25%" bgcolor="#FFFFFF">���ĵ�¼��ɫ��</td>
    <td width="75%" bgcolor="#FFFFFF">���ų�</td>
  </tr>
  <tr bgcolor="#FFFFFF">
    <td>����汾��Ϣ��</td>
    <td>Version_3.0</td>
  </tr>
</table>
<table width="98%" align="center" border="0" cellpadding="4" cellspacing="1" bgcolor="#CBD8AC">
  <tr bgcolor="#EEF4EA">
    <td colspan="2" background="skin/images/frame/wbg.gif" class='title'><span>��˾��ַ</span></td>
  </tr>
  <tr bgcolor="#FFFFFF">
    <td width="25%" height="32">��˾��վ��</td>
    <td width="75%"><a href="http://www.vantrontech.com.cn" target="_blank"><u>http://www.vantrontech.com.cn</u></a></td>
  </tr>
</table>
</body>
</html>