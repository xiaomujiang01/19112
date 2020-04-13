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
<title>角色管理</title>
<link rel="stylesheet" href="layui/css/layui.css">
<link rel="sytlesheet" href="css/add_permission.css">
</head>
<body>

	<!-- 弹出层：增加角色 -->
	<div hidden class=" layui-form" id='addRole'>
		<form class=" layui-form" lay-filter="addform">
			<div class="layui-form-item  ">
				<div class="layui-inline ">
					<label class="layui-form-label ">角色名</label>
					<div class="layui-input-inline ">
						<input type='text' name='role_name' autocomplete='off'
							class='layui-input'>
					</div>
				</div>
				<div class="layui-inline ">
					<label class="layui-form-label ">code</label>
					<div class="layui-input-inline ">
						<input type='text' name='role_code' autocomplete='off'
							class='layui-input'>
					</div>
				</div>
			</div>
		</form>
	</div>


	<!-- 弹出层：修改角色 -->
	<div hidden class=" layui-table" id='updRole'>
		<form class=" layui-form" lay-filter="updform">
			<input type="hidden" name="role_id">
			<div class="layui-form-item  ">
				<div class="layui-inline ">
					<label class="layui-form-label ">角色名</label>
					<div class="layui-input-inline ">
						<input type='text' name='role_name' autocomplete='off'
							class='layui-input'>
					</div>
				</div>
				<div class="layui-inline ">
					<label class="layui-form-label ">code</label>
					<div class="layui-input-inline ">
						<input type='text' name='role_code' autocomplete='off'
							class='layui-input'>
					</div>
				</div>
			</div>
		</form>
	</div>

	<!-- 添加权限弹出层 -->
	<div hidden id="test1" class="content"></div>

	<table class='layui-table'
		lay-data="{url:'sys/role_list',toolbar:'#tollbar', page:true ,id:'table_list'}"
		lay-filter="test">
		<thead>
			<tr>
				<th lay-data="{type:'checkbox'}"></th>
				<th lay-data="{field:'role_id'}">角色ID</th>
				<th lay-data="{field:'role_name'}">角色名</th>
				<th lay-data="{field:'role_code'}">code</th>
				<th
					lay-data="{templet:function(d){
		return $('#rowbar').html();
			}}">操作</th>
			</tr>
		</thead>
	</table>


	<script type="text/html" id="rowbar">
  <a class="layui-btn layui-btn-xs" lay-event="edit" >编辑</a>
  <a class="layui-btn layui-btn-xs" lay-event="del_row" style="background-color:red">删除</a>
    </script>


	<script type="text/html" id="tollbar">
<input type="text" name="text"  placeholder="请输入查询内容"  id="checktb" style="height:31px">

<button type="button" class="layui-btn layui-btn-sm" lay-event="check">
  <i class="layui-icon ">&#xe615;</i> 查询</button>

<button type="button" class="layui-btn layui-btn-sm" lay-event="add">
  <i class="layui-icon">&#xe654;</i> 新增</button>

<button type="button" class="layui-btn layui-btn-sm" lay-event="del" style="background-color:red">
  <i class="layui-icon">&#xe67e;</i> 删除</button>

<button type="button" class="layui-btn layui-btn-sm" lay-event="add_permission">
  <i class="layui-icon">&#xe654;</i> 添加权限</button>

</script>
	<%@ include file="../layui.jsp"%>
	<script>
		/* 根据角色名、code查找部门    *  增加角色   *  删除角色 */
		table.on('toolbar(test)', function(obj) {
			var checkStatus = table.checkStatus(obj.config.id);
			var data = checkStatus.data;
			switch (obj.event) {
			case 'check':
				table.reload('table_list', {
					where : {
						text : $("[name='text']").val()
					}
				})
				break;
			case 'add':
				layer.open({
					title : '新增角色',
					content : $("#addRole"),
					type : 1,
					btn : [ "保存", "取消" ],
					btn1 : function() {
						var formdata = form.val("addform");
						$.post("sys/role_add", formdata, function(d) {
							table.reload('table_list');
							layer.closeAll();
						})
					},
					btn2 : function() {
						layer.closeAll();
					}
				});
				break;
			case 'del':
				console.log(data);
				layer.confirm("确认要删除吗？", function(index) {
					var id_arry = "";
					for (var i = 0; i < data.length; i++) {
						id_arry += data[i].role_id + ",";
					}
					$.post("sys/role_del", {
						"role_ids" : id_arry
					}, function(d) {
						table.reload('table_list');
						layer.closeAll();
					});
				});
				break;
				/* 分配权限 */
			case 'add_permission':
				location.href="sys/role_permission_page/"+data[0].role_id;
				break;
			}
		});

		/* 修改角色信息 *  删除单个角色  */
		table.on('tool(test)', function(obj) {
			var data = obj.data;
			switch (obj.event) {
			case 'edit':
				form.val("updform", {
					"role_id" : data.role_id,
					"role_name" : data.role_name,
					"role_code" : data.role_code
				});
				layer.open({
					title : '修改角色信息',
					content : $("#updRole"),
					type : 1,
					btn : [ "保存", "取消" ],
					btn1 : function() {
						var formdata = form.val("updform");
						console.log(formdata);
						$.post("sys/role_upd", formdata, function(d) {
							table.reload('table_list');
							layer.closeAll();
						})
					},
					btn2 : function() {
						layer.closeAll();
					}
				})
				break;
			case 'del_row':
				layer.confirm("确认要删除" + data.role_name + "吗？", function(index) {
					$.post("sys/role_del_row", data, function(d) {
						table.reload('table_list');
						layer.closeAll();
					});
				});
				break;
			}
		});
	</script>
</body>
</html>