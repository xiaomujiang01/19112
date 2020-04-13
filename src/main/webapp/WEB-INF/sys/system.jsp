<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<base href="<%=basePath%>">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
<title>客户管理系统</title>
<link rel="stylesheet" href="./layui/css/layui.css">
</head>
<body class="layui-layout-body">
	<div class="layui-layout layui-layout-admin">
		<div class="layui-header">
			<div class="layui-logo">
				<i class="layui-icon layui-icon-tree" style="font-size: 20px;">
					&nbsp;李国泽CRM</i>
			</div>


			<!-- 头部区域（可配合layui已有的水平导航） -->
			<!-- 	<ul class="layui-nav layui-layout-left">
				<li class="layui-nav-item"><a href="">控制台</a></li>
				<li class="layui-nav-item"><a href="">商品管理</a></li>
				<li class="layui-nav-item"><a href="">用户</a></li>
				<li class="layui-nav-item"><a href="javascript:;">其它系统</a>
					<dl class="layui-nav-child">
						<dd>
							<a href="">邮件管理</a>
						</dd>
						<dd>
							<a href="">消息管理</a>
						</dd>
						<dd>
							<a href="">授权管理</a>
						</dd>
					</dl></li>
			</ul> -->


			<ul class="layui-nav layui-layout-right">
				<li class="layui-nav-item"><a href="javascript:;"> <img
						src="./img/liguoze_touxiang.jpeg" class="layui-nav-img">
						<c:if test="${TIP_COUNT!=0 }">
						<span><span class="layui-badge">${TIP_COUNT}</span>&nbsp;&nbsp;&nbsp;&nbsp;</span></c:if>
						李国泽
				</a>
					<dl class="layui-nav-child">
						<dd>
							<a>基本资料</a>
						</dd>
						<dd>
							<a href="">安全设置</a>
						</dd>
					</dl></li>
				<li class="layui-nav-item"><a href="">退出</a></li>
			</ul>
		</div>

		<div class="layui-side layui-bg-black">
			<div class="layui-side-scroll">
				<!-- 左侧导航区域（可配合layui已有的垂直导航） -->
				<ul class="layui-nav layui-nav-tree" lay-filter="test">
					<li class="layui-nav-item"><a href="javascript:;"
						url="sys/user_page">用户管理</a></li>
					<li class="layui-nav-item"><a href="javascript:;"
						url="sys/bumen_page">部门管理</a></li>
					<li class="layui-nav-item"><a href="javascript:;"
						url="sys/role_page">角色管理</a></li>
				<!-- 	<li class="layui-nav-item"><a href="javascript:;"
						url="sys/permission_page">权限管理</a></li> -->
					<li class="layui-nav-item"><a href="javascript:;">客户管理</a>
						<dl class="layui-nav-child">
							<dd>
								<a href="javascript:;" url='sys/customer_page'> <i
									class="layui-icon layui-icon-friends">&nbsp;客户管理</i></a>
							</dd>
							<dd>
								<a href="javascript:;" url='sys/public_customer_page'>公海客户</a>
							</dd>
							<dd>
								<a href="javascript:;" url='sys/private_customer_page'>跟单客户</a>
							</dd>
						</dl></li>
					<li class="layui-nav-item"><a href="javascript:;"
						url="sys/permission_page">回访记录</a></li>
				</ul>
			</div>
		</div>


		<div class="layui-body">
			<!-- 内容主体区域 -->
			<iframe style="height: 98.5%; width: 100%;" src=""></iframe>
		</div>


		<div class="layui-footer">底部固定区域 © layui.com - 底部固定区域</div>
	</div>


	<%@ include file="../layui.jsp"%>
	<script>
		var $ = layui.jquery;
		$("[url]").click(function() {
			$("iframe").attr("src", $(this).attr("url"));
		});
	</script>
</body>
</html>