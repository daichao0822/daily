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

function DeleteHead(did,uid){
    if(confirm("ȷ��ɾ������ID="+did+" �Ĳ��ų���")){
        var url = "DepartmentManageServlet?flag=6&did=" + did + "&uid=" + uid;
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
		http_request.open("GET", url, true);
		http_request.onreadystatechange = updatepage;
		http_request.send(null);
	}
    }
}

function updatepage() {
	if (http_request.readyState == 4) {
		if (http_request.status == 200) {
			if (http_request.responseText == 1) {
				alert("ɾ�����ų��ɹ���");
				window.location.reload();
			} else if (http_request.responseText == 0) {
				alert("ɾ�����ų�ʧ�ܣ�");
			}else if (http_request.responseText == 2){
			    alert("���������ܼ�������������ԭ��1��session��ʱ  2�������˳�  3�������˺����ڱ𴦵�¼�������µ�¼");
			    window.close();
			    top.location.replace("http://localhost/daily");
			}
		} else {
			alert("���������ҳ�����쳣");
		}
	}
}

function check() {
	var obj = document.getElementsByName("departmentID");
	for (i = 0; i < obj.length; i++) {
		 if (obj[i].checked ) {
			if (confirm("���ż�������Ա��Ϣ����ɾ�������������棬ȷ��ɾ����")) {
				return true;
			} else {
				return false;
			}
		}
	}
	window.alert("����ѡ��һ�����ţ�");
	return false;
}

function AddNewHead(id){
    window.open("DepartmentManageServlet?flag=7&id="+id,"addNewHead","directories=no,left=200,top=250,height=180,width=920,location=no,menubar=no,resizable=yes,scrollbars=yes,status=yes,toolbar=no",false);
}

function ChangeHead(did,uid){
    window.open("DepartmentManageServlet?flag=9&did="+did+"&uid="+uid,"ChangeHead","directories=no,left=200,top=250,height=180,width=920,location=no,menubar=no,resizable=yes,scrollbars=yes,status=yes,toolbar=no",false);
}

function CreateNewDepartment(){
	window.open("DepartmentManageServlet?flag=3","addNewDepartment","directories=no,left=200,top=250,height=180,width=920,location=no,menubar=no,resizable=yes,scrollbars=yes,status=yes,toolbar=no",false);
}
</script>
</head>
<body leftmargin="8" topmargin='8'>
<%
List<Department> list=(List<Department>)request.getAttribute("dep");
Connection con=Connect.getConnection();
ChangeIDForName change=new ChangeIDForName();
 %>
<br >
<form name="form" action="DepartmentManageServlet?flag=2" method="post" onSubmit="return check()">
<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td><div style='float:left'> <img height="14" src="page/head_of_department/skin/images/frame/book1.gif" width="20" />&nbsp;���в�����Ϣ�� </div>
      </td>
  </tr>
  <tr>
    <td height="1" background="page/head_of_department/skin/images/frame/sp_bg.gif" style='padding:0px'></td>
  </tr>
</table>

<table width="98%" align="center" border="0" cellpadding="4" cellspacing="1" bgcolor="#CBD8AC" >
  <tr bgcolor="#EEF4EA">
    <td colspan="2" background="page/head_of_department/skin/images/frame/wbg.gif" class='title'>
    <span>������Ϣ</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <input type="button" name="button" value="�½�����" onClick="CreateNewDepartment()" />
    </td>
  </tr>
  </table>
<table width="98%" align="center" border="0" cellpadding="4" cellspacing="1" bgcolor="#CBD8AC" style="margin-bottom:8px">
  <tr bgcolor="#FFFFFF">
    <td width="7%" align="center">ѡ��</td>
    <td width="9%" align="center">����ID</td>
    <td width="17%" align="center">��������</td>
    <td width="11%" align="center">���ų�</td>
    <td width="36%" align="center">��������</td>
    <td width="20%" align="center">����</td>
  </tr>
  <%
  if(list!=null){
      for(int i=0;i<list.size();i++){
      %>
  <tr bgcolor="#FFFFFF">
    <td align="center"><input type="checkbox" name="departmentID" value="<%=list.get(i).getG_intDepartmentId() %>" /></td>
    <td align="center"><%=list.get(i).getG_intDepartmentId() %></td>
    <td align="center"><%=change.GetDepartmentName(con,list.get(i).getG_intDepartmentId()) %></td>
    <td align="center"><%=change.getUserName(con,list.get(i).getG_intDepartmentHead()) %></td>
    <td align="center"><%=list.get(i).getG_strDepartmentDescription() %></td>
    <td align="center">
    <%
    if(change.getUserName(con,list.get(i).getG_intDepartmentHead()).equals("��")){
    %>
    <input type="button" name="button1" value="ָ�����ų�"  onclick="AddNewHead(<%=list.get(i).getG_intDepartmentId() %>)" >
    <%
    }else{
    %>
    <input type="button" name="button2" value="ɾ�����ų�" onClick="DeleteHead(<%=list.get(i).getG_intDepartmentId() %>,<%=list.get(i).getG_intDepartmentHead() %>)">&nbsp;
    <input type="button" name="button3" value="���Ĳ��ų�" onClick="ChangeHead(<%=list.get(i).getG_intDepartmentId() %>,<%=list.get(i).getG_intDepartmentHead() %>)" />
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
     <td align="center"><font color="#FF0000">û�в���</font></td>
     <td>&nbsp;</td>
  </tr>
  <%
  }
   %>
  
</table>

<table width="98%" align="center" border="0" cellpadding="4" cellspacing="1" bgcolor="#CBD8AC">
  <tr bgcolor="#FFFFFF">
    <td align="center" height="32"><input type="submit" value="ɾ������" />
      &nbsp;
    <input type='button' class="coolbg np" onClick="newLocation('page/administrator/main.jsp')" value='������ҳ' /></td>
  </tr>
</table>
</form>
</body>
</html>
