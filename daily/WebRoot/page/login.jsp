<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
		<title>万创日报系统</title>
		<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
	overflow: hidden;
}

.STYLE3 {
	color: #528311;
	font-size: 12px;
}

.STYLE4 {
	color: #42870a;
	font-size: 12px;
}
-->
</style>
		<script type="text/javascript">
function check() {
	if (form1.username.value == "") {
		alert("用户名不能为空!");
		return false;
	} else if (form1.password.value == "") {
		alert("密码不能为空!");
		return false;
	}
	return true;
}
</script>
	</head>

	<body>
		<form name="form1" action="login" method="post"
			onSubmit="return check();">
			<table width="100%" height="100%" border="0" cellpadding="0"
				cellspacing="0">
				<tr>
					<td bgcolor="#e5f6cf">&nbsp;
						
					</td>
				</tr>
				<tr>
					<td height="608" background="page/images/login_03.gif">
						<table width="862" border="0" align="center" cellpadding="0"
							cellspacing="0">
							<tr>
								<td height="266" background="page/images/login_04.gif">&nbsp;
									
								</td>
							</tr>
							<tr>
								<td height="95">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="424" height="95"
												background="page/images/login_06.gif">&nbsp;
												
											</td>
											<td width="183" background="page/images/login_07.gif">

												<table width="100%" border="0" cellspacing="0"
													cellpadding="0">
													<tr>
														<td height="21">
															<table width="100%" border="0" cellspacing="0"
																cellpadding="0">
																<tr>
																	<td width="21%" height="32">
																		<div align="center">
																			<span class="STYLE3">用户</span>
																		</div>
																	</td>
																	<td width="79%" height="32">
																		<input type="text" name="username" id="up"
																			style="height: 18px; width: 130px; border: solid 1px #cadcb2; font-size: 12px; color: #81b432;">
																			<input type="hidden" name="role" value="1"><!--隐藏默认登录角色  --> 
																	</td>
																</tr>
																<tr>
																	<td height="22">
																		<div align="center">
																			<span class="STYLE3">密码</span>
																		</div>
																	</td>
																	<td height="22">
																		<input type="password" name="password" id="password"
																			style="height: 18px; width: 130px; border: solid 1px #cadcb2; font-size: 12px; color: #81b432;">
																	</td>
																</tr>
															</table>
														</td>
													</tr>
												</table>
											</td>
											<td width="255" background="page/images/login_08.gif"
												id="pass">&nbsp;
												
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td height="247" valign="top"
									background="page/images/login_09.gif">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="22%" height="30">&nbsp;
												
											</td>
											<td width="56%">
												<div align="center">
													&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
													&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
													<input type="submit" name="Submit" value="登录">
													&nbsp;
													<input type="reset" name="Submit2" value="重设">
												</div>
											</td>
											<td width="22%">&nbsp;
												
											</td>
										</tr>
										<tr>
											<td>&nbsp;
												
											</td>
											<td height="30">
												<table width="100%" border="0" cellspacing="0"
													cellpadding="0">
													<tr>
														<td width="44%" height="20">&nbsp;
															
														</td>
														<td width="56%" class="STYLE4">
														</td>
													</tr>
												</table>
											</td>
											<td>&nbsp;
												
											</td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td bgcolor="#a2d962">&nbsp;
						
					</td>
				</tr>
			</table>

			<map name="Map">
				<area shape="rect" coords="3,3,36,19" href="#">
				<area shape="rect" coords="40,3,78,18" href="#">
			</map>
		</form>
	</body>
</html>
