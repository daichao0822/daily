<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>审阅日报成功</title>
<script language="javascript">
if(confirm("审阅日报成功，返回继续审阅吗？")){
location.replace("DailyCheckServlet?flag=1");
}
else{
location.replace("page/head_of_department/main.jsp");
}

</script>
</head>

<body>
</body>
</html>