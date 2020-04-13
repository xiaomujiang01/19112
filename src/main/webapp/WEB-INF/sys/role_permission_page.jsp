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
<title>角色分配权限</title>
<link rel="stylesheet" href="layui/css/layui.css">
</head>
<body>
	<fieldset class="layui-elem-field layui-field-title" style="margin-top: 30px;">
  <legend>开启复选框</legend>
</fieldset>
 
<div id="test7" class="demo-tree"></div>

<button type="button" class="layui-btn layui-btn-sm" id="save_role_permission">
  <i class="layui-icon ">&#xe615;</i> 保存</button>
  <button type="button" class="layui-btn layui-btn-sm" id="cancel">
  <i class="layui-icon ">&#xe615;</i> 取消</button>
	<%@ include file="../layui.jsp"%>
	
	<script type="text/javascript">
	$("#save_role_permission").click(function(){
		
		//点击保存按钮获取已经选中的数据
		var checkData = tree.getChecked('role_permission');//id,title
		//将数据发送到后台--保存到指定的角色信息中
		var perm_id_arr="";
		getid({children:checkData});
		for(var i=0;i<perm_arr.length;i++){
			perm_id_arr+=perm_arr[i]+",";
		}
		console.log(perm_id_arr);
		$.post("sys/save_role_perm",{"perm_arr":perm_id_arr,"role_id":'${role_id}'},function(d){
			location.href="sys/role_page";
		});
		
	});

	var perm_arr=new Array();
	function getid( data){
		
		if(data.id!=undefined){
		perm_arr.push(data.id);
		}
		if(data.children!=undefined){
			for(var i=0;i<data.children.length;i++){
				getid(data.children[i]);
			}
		}
	}
	
	//模拟数据2
	  var data2 = {};
	  $.post("sys/role_permission_list/${role_id}",function(d){
		data2=d;
		console.log(d);
		});
	 
	  //开启复选框
	  tree.render({
	    elem: '#test7'
	    ,data: data2
	    ,showCheckbox: true
	    ,id:"role_permission"
	  });
	</script>
</body>
</html>