<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<base href="<%=basePath%>">
<title>权限管理</title>
<link rel="stylesheet" href="layui/css/layui.css">
</head>
<body>
	<span><h1>角色权限表</h1></span>
	<table class='layui-table'
		lay-data="{url:'sys/customer_list',toolbar:'#tollbar', page:true ,id:'table_list'}"
		lay-filter="test">
		<thead>
			<tr>
				<th lay-data="{field:'role_id'}">角色ID</th>
				<th lay-data="{field:'role_name'}">角色名</th>
				<th lay-data="{field:'perm_id'}">权限ID</th>
				<th lay-data="{field:'perm_name'}">权限名</th>
			</tr>
		</thead>
	</table>
	<span><h1>用户角色表</h1></span>
	<table class='layui-table'
		lay-data="{url:'sys/customer_list',toolbar:'#tollbar', page:true ,id:'table_list'}"
		lay-filter="test">
		<thead>
			<tr>
				<th lay-data="{field:'userid'}">用户ID</th>
				<th lay-data="{field:'username'}">用户名</th>
				<th lay-data="{field:'role_id'}">角色ID</th>
				<th lay-data="{field:'role_name'}">角色名</th>
			</tr>
		</thead>
	</table>
</body>
</html>