<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*" import="com.bean.Daily" import="com.dao.ChangeIDForName" import="com.dao.Connect" import="com.bean.DailyReply" import="java.util.List" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
		<title>日报详细</title>
<base target="_self">
<link rel="stylesheet" type="text/css" href="page/member/skin/css/base.css" />
<link rel="stylesheet" type="text/css" href="page/member/skin/css/main.css" />
<style type="text/css">
<!--
body {
	background-image: url(page/images/login_07.gif);
}
-->
</style>
<script type="text/javascript">
function dailyReply(id){
	window.open("/daily/page/daily_reply.jsp?id="+id,"DailyReply","directories=no,left=200,top=150,height=400,width=710,location=no,menubar=no,resizable=yes,scrollbars=yes,status=no,toolbar=no",false);
}

function goBack(){
	window.history.back();
}
</script>
</head>

<body>
<%
Daily DailyDetail=(Daily)request.getAttribute("dailyDetail");
if(DailyDetail!=null){
List<DailyReply> _DailyReply=(List)request.getAttribute("dailyReply");
ChangeIDForName Change=new ChangeIDForName();
Connection con=Connect.getConnection();

//将日报用户ID转换成用户名
int g_intUserID=DailyDetail.getG_intDailyUser();
String g_strUserName=Change.getUserName(con,g_intUserID);

//将审阅人ID转换成审阅人用户名
int g_intDailyCheckUser=DailyDetail.getG_intDailyCheckUser();
String g_strDailyCheckUser=null;
if(g_intDailyCheckUser!=-1){//如果日报为审阅，则审阅人ID=-1，为防止数据库查询错误，做此判断
g_strDailyCheckUser=Change.getUserName(con,g_intDailyCheckUser);
}

//将项目ID转换成项目名
int g_intProjectID=DailyDetail.getG_intDailyProject();
String g_strProjectName=null;
if(g_intProjectID!=-1){//如果该日报为非项目日报，则日报ID=-1，为防止数据库查询错误，做此判断
g_strProjectName=Change.getProjectName(con,g_intProjectID);
}

//将任务ID转换成任务名
int g_intTaskID=DailyDetail.getG_intDailyTask();
String g_strTaskName=Change.getTaskName(con,g_intTaskID);

//将工时提取出来，方便后面转换为日、时、分
int workCount=DailyDetail.getG_intDailyCount();
 %>
<table width="100%" border="0" cellspacing="1" cellpadding="1">
  <tr>
    <td><div align="center"><strong><font size="+2">日报详细信息</font></strong></div></td>
  </tr>
</table>
<table width="100%" height="34" border="1" cellpadding="1" cellspacing="1">
  <tr>
    <td width="10%"><div align="center">日报ID</div></td>
    <td width="17%"><%=DailyDetail.getG_intDailyId() %></td>
    <td width="10%"><div align="center">作者</div></td>
    <td width="22%"><%=g_strUserName %></td>
    <td width="10%"><div align="center">提交日期</div></td>
    <td width="28%"><%=DailyDetail.getG_timDailySubmitTime() %></td>
  </tr>
</table>
<table width="100%" height="34" border="1" cellspacing="1" cellpadding="1">
  <tr>
    <td width="15%" height="28"><div align="center">日报类型</div></td>
    <td width="35%"><%if(DailyDetail.getG_intDailyType()==0){%>非项目日报<%}else{%>项目日报<%} %></td>
    <td width="15%"><div align="center">所属项目</div></td>
    <td width="35%"><%if(g_strProjectName==null){%>&nbsp;<%}else{%><%=g_strProjectName%><%} %></td>
  </tr>
</table>
<table width="100%" height="34" border="1" cellspacing="1" cellpadding="1">
  <tr>
    <td width="15%" height="28"><div align="center">任务名称</div></td>
    <td width="35%"><%=g_strTaskName %></td>
    <td width="15%"><div align="center">工时</div></td>
    <td width="35%">
    <%=workCount/86400 %>&nbsp;日
    <%=(workCount%86400)/3600 %>&nbsp;时
    <%=(workCount%3600)/60 %>&nbsp;分
    <%=(workCount%60) %>&nbsp;秒
    </td>
  </tr>
</table>
<table width="100%" height="34" border="1" cellspacing="1" cellpadding="1">
  <tr>
    <td width="15%" height="28"><div align="center">任务描述</div></td>
    <td width="85%"><label>
      <textarea name="taskDescription" cols="150" rows="5" readonly="readonly" id="taskDescription"><%=DailyDetail.getG_strDailyTaskDescription() %></textarea>
    </label></td>
  </tr>
</table>
<table width="100%" height="34" border="1" cellspacing="1" cellpadding="1">
  <tr>
    <td width="15%" height="28"><div align="center">开始时间</div></td>
    <td width="35%"><%=DailyDetail.getG_timDailyBeginTime() %></td>
    <td width="15%"><div align="center">截止时间</div></td>
    <td width="35%"><%=DailyDetail.getG_timDailyEndTime() %></td>
  </tr>
</table>
<table width="100%" height="34" border="1" cellspacing="1" cellpadding="1">
  <tr>
    <td width="15%" height="28"><div align="center">完成情况</div></td>
    <td width="85%"><label>
      <textarea name="taskDescription" cols="150" rows="5" readonly="readonly" id="taskDescription"><%=DailyDetail.getG_strDailyTaskStatus() %></textarea>
    </label></td>
  </tr>
</table>
<table width="100%" height="34" border="1" cellspacing="1" cellpadding="1">
  <tr>
    <td width="15%" height="28"><div align="center">存在问题</div></td>
    <td width="85%"><label>
      <textarea name="taskDescription" cols="150" rows="5" readonly="readonly" id="taskDescription"><%=DailyDetail.getG_strDailyProblem() %></textarea>
    </label></td>
  </tr>
</table>
<table width="100%" height="34" border="1" cellspacing="1" cellpadding="1">
  <tr>
    <td width="15%" height="28"><div align="center">是否审阅</div></td>
    <td width="35%">
    <%if(DailyDetail.getG_intDailyCheckup()==0){%><font color="#FF0000">未审阅</font>
    <%}else{%>已审阅<%} %></td>
    <td width="15%"><div align="center">审阅人</div></td>
    <td width="35%"><%=g_strDailyCheckUser %></td>
  </tr>
</table>
<table width="100%" height="34" border="1" cellspacing="1" cellpadding="1">
  <tr>
    <td width="15%" height="28"><div align="center">审阅意见</div></td>
    <td width="85%"><label>
      <textarea name="taskDescription" cols="150" rows="5" readonly="readonly" id="taskDescription">
      <%if(DailyDetail.getG_strDailyRemark()==null){%>&nbsp;
      <%}else{%><%=DailyDetail.getG_strDailyRemark() %><%} %></textarea>
    </label></td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="1">
  <tr>
    <td><div align="center"><input type="button" name="button" id="button" value="发表回复" onclick="dailyReply(<%=DailyDetail.getG_intDailyId() %>)" />
    <input type="button" value="返回" onclick="goBack()" />
    </div></td>
    </tr>
</table>
<%if(DailyDetail.getG_strDailyImage()!=null){ %>
<table>
<tr>
<td align="left">附件(点击查看原图)：</td>
</tr>
<tr>
<td><a href="http://localhost/daily/upload/<%=DailyDetail.getG_strDailyImage() %>" target="_blank"><img width="40%" height="40%" alt="点击查看原图" src="upload/<%=DailyDetail.getG_strDailyImage() %>"/></a></td>
</tr>
</table>
<%} %>
<br />
<table width="100%" border="0" cellspacing="0" cellpadding="1">
  <tr>
    <td><div align="left"><font size="+2">回复信息:</font></div></td>
  </tr>
</table>
<br />
<!--下面利用for循环打印回复表格-->
<%if(_DailyReply!=null){
for(int i=0;i<_DailyReply.size();i++){
 %>
<table width="100%" height="34" border="1" cellpadding="1" cellspacing="1">
  <tr>
    <td width="15%"><div align="center">第<font color="#FF0000"><%=i %></font>楼</div></td>
    <td width="15%"><div align="center">作者</div></td>
    <td width="20%"><%
    int g_intUserID_1=_DailyReply.get(i).getG_intDailyReplyUser();
    String g_strUserName_1=Change.getUserName(con,g_intUserID_1);//将作者ID转换成作者姓名
     %><%=g_strUserName_1 %></td>
    <td width="15%"><div align="center">回复时间</div></td>
    <td width="20%"><%=_DailyReply.get(i).getG_timDailyReplyTime() %></td>
    <td width="15%"><div align="center"><input type="button" name="button" id="button" value="回复" onclick="dailyReply(<%=DailyDetail.getG_intDailyId() %>)" /></div></td>
  </tr>
</table>
<table width="100%" height="34" border="1" cellspacing="1" cellpadding="1">
  <tr>
    <td width="15%" height="28"><div align="center">回复内容</div></td>
    <td width="85%">
        <table>
            <tr>
                <td><textarea name="taskDescription" cols="150" rows="5" readonly="readonly" id="taskDescription"><%=_DailyReply.get(i).getG_strDailyReplyContent() %></textarea></td>
            </tr>
            <%if(_DailyReply.get(i).getG_strDailyReplyImage()!=null){ %>
            <tr>
                <td>附件(点击查看原图)：</td>
            </tr>
            <tr>
                <td><a href="http://localhost/daily/upload/<%=_DailyReply.get(i).getG_strDailyReplyImage() %>" target="_blank"><img width="40%" height="40%" alt="点击查看原图" src="upload/<%=_DailyReply.get(i).getG_strDailyReplyImage() %>" /></a></td>
            </tr>
            <%} %>
        </table>
    </td>
  </tr>
</table>
<br />
<%} }%>
<!--循环到此结束-->
<%con.close(); //关闭数据库连接 
}else{%><!-- 查询结果为空 -->
<br />
<br />
<br />
<br />
<table width="100%">
<tr>
<td align="center"><font size="+2" color="#FF0000">无查询结果，或者该日报不属于您，无权查看</font></td>
</tr>
<tr><td>&nbsp;</td></tr>
<tr>
<td align="center"><input type="button" value="返回" onClick="window.history.back();"/></td>
</tr>
</table>
<%}%>
</body>
</html>