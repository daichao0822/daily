<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*,java.util.*,com.bean.*,com.dao.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>��̱�</title>
<base target="_self">
<link rel="stylesheet" type="text/css" href="page/manager/skin/css/base.css" />
<link rel="stylesheet" type="text/css" href="page/manager/skin/css/main.css" />
<script type="text/javascript">
function checkConfirm(){
    var opinion=document.getElementById("confirmOpinion").value;
    if(opinion==""){
        if(confirm("ȷ�����Ϊ�գ���Ȼ�ύ��")){
            return true;
        }
        else{
            return false;
        }
    }
    else{
        if(confirm("ȷ���ύ��")){
            return true;
        }
        else{
            return false;
        }
    }
    
}
</script>
</head>

<body>
<%
List<Milestone> list=(List)request.getAttribute("milestone");
int int_PCBID=Integer.parseInt(request.getParameter("pid"));
ChangeIDForName change=new ChangeIDForName();
Connection con=Connect.getConnection();
java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 
java.util.Date currentTime = new java.util.Date();//�õ���ǰϵͳʱ�� 
String strDate = formatter.format(currentTime); //������ʱ���ʽ��
 %>
 <form name="form" action="AddMilestoneConfServlet?flag=2" method="post" onsubmit="return checkConfirm()">
<table width="98%" align="center" border="0" cellpadding="4" cellspacing="1" bgcolor="#CBD8AC"  style="margin-bottom:8px">
<tr bgcolor="#EEF4EA">
<td colspan="2" bgcolor="#CBD8AC"  class='title'><span>PCB��̱�</span></td>
</tr>
<tr>
<td width="12%" align="center" background="page/PMO/skin/images/frame/wbg.gif">��̱�����</td>
<td width="16%" align="center" background="page/PMO/skin/images/frame/wbg.gif">����PCB</td>
<td width="16%" align="center" background="page/PMO/skin/images/frame/wbg.gif">��̱�ȷ����</td>
<td width="27%" align="center" background="page/PMO/skin/images/frame/wbg.gif">��̱�ȷ�����</td>
<td width="18%" align="center" background="page/PMO/skin/images/frame/wbg.gif">��̱�ȷ��ʱ��</td>
</tr>
<%
if(list!=null){
    
 %>
<tr bgcolor="#FFFFFF">
<td align="center">
    <select name="milestoneID" id="milestoneID">
    <%for(int i=0;i<list.size();i++){ %>
    <option value="<%=list.get(i).getG_intMileStoneId() %>"><%=list.get(i).getG_strMileStoneName() %></option>
    <%} %>
    </select></td>
<td align="center"><%=change.GetPCBName(con,int_PCBID) %>
<input type="hidden" value="<%=int_PCBID %>" name="PCBID" id="PCBID" /></td>
<td align="center">
${sessionScope.userInfo.g_strUserName}
<input type="hidden" name="confirmUser" id="confirmUser" value="${sessionScope.userInfo.g_intUserId}" /></td>
<td align="center"><input type="text" name="confirmOpinion" id="confirmOpinion" /></td>
<td align="center"><input type="text" name="confirmTime" id="confirmTime" value="<%=strDate %>" readonly="readonly" /></td>

</tr>
 <%
 }
 else{ %>
<tr bgcolor="#FFFFFF">
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td align="center"><font color="#FF0000">û������̱����������</font></td>
<td>&nbsp;</td>
</tr>
 <%} %>
</table>
<%con.close(); %>
<table width="98%" align="center">
  <tr>
<td align="center">
<%if(list!=null){%><input type="submit" value="�ύ" />&nbsp; <%} %>
<input type="button" value="�ر�" onclick="window.close()" />
</td>
</tr>
</table>
</form>
</body>
</html>