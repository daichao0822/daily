
<html>
<head>
<title>menu</title>
<link rel="stylesheet" href="skin/css/base.css" type="text/css" />
<link rel="stylesheet" href="skin/css/menu.css" type="text/css" />
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<script language='javascript'>var curopenItem = '1';</script>
<script language="javascript" type="text/javascript" src="skin/js/frame/menu.js"></script>
<base target="main" />
</head>
<body target="main">
<table width='99%' height="100%" border='0' cellspacing='0' cellpadding='0'>
  <tr>
    <td style='padding-left:3px;padding-top:8px' valign="top">
	<!-- Item 1 Strat -->
      <dl class='bitem'>
        <dt onClick='showHide("items1_1")'><b>常用操作</b></dt>
        <dd style='display:block' class='sitem' id='items1_1'>
          <ul class='sitemu'>
            <li><a href='home_page.jsp' target='main'>个人信息</a></li>
            <li><a href='../../DepartmentalInfoServlet' target='main'>部门信息</a></li>
            <li><a href='../../StatisticsForDepServlet' target='main'>部门统计</a></li>
            <li><a href='../../DailyCheckServlet?flag=1' target='main'>日报审阅</a></li>
            <li><a href='../../DailyQueryForDepServlet?flag=1' target='main'>日报查询</a></li>
            <li><a href='../../UserMngForDepServlet?flag=1' target='main'>人员管理</a></li>
          </ul>
        </dd>
      </dl>
      <!-- Item 1 End -->
	  </td>
  </tr>
</table>
</body>
</html>