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
<title>部门管理</title>
<link rel="stylesheet" href="layui/css/layui.css">
</head>
<body>

	<!-- 弹出层：增加部门 -->
	<div hidden class=" layui-form" id='addBumen'>
		<form class=" layui-form" lay-filter="addform">
			<div class="layui-form-item  ">
				<div class="layui-inline ">
					<label class="layui-form-label ">部门名</label>
					<div class="layui-input-inline ">
						<input type='text' name='bumen_name' autocomplete='off'
							class='layui-input'>
					</div>
				</div>
				<div class="layui-inline ">
					<label class="layui-form-label ">经理</label>
					<div class="layui-input-inline ">
						<input type='text' name='manager' autocomplete='off'
							class='layui-input'>
					</div>
				</div>
			</div>
		</form>
	</div>


<!-- 弹出层：修改部门 -->
	<div hidden class=" layui-form" id='updBumen'>
		<form class=" layui-form" lay-filter="updform">
		<input type="hidden" name="bumen_id">
			<div class="layui-form-item  ">
				<div class="layui-inline ">
					<label class="layui-form-label ">部门名</label>
					<div class="layui-input-inline ">
						<input type='text' name='bumen_name' autocomplete='off'
							class='layui-input'>
					</div>
				</div>
				<div class="layui-inline ">
					<label class="layui-form-label ">经理</label>
					<div class="layui-input-inline ">
						<input type='text' name='manager' autocomplete='off'
							class='layui-input'>
					</div>
				</div>
			</div>
		</form>
	</div>

	<table class='layui-table'
		lay-data="{url:'sys/bumen_list',toolbar:'#tollbar', page:true ,id:'table_list'}"
		lay-filter="test">
		<thead>
			<tr>
				<th lay-data="{type:'checkbox'}"></th>
				<th lay-data="{field:'bumen_id'}">部门ID</th>
				<th lay-data="{field:'bumen_name'}">部门名</th>
				<th lay-data="{field:'manager'}">经理</th>
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


</script>
	<%@ include file="../layui.jsp"%>
	<script>
		/* 根据部门名、部门ID、经理查找部门    *  增加部门   *  删除部门 */
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
					title : '新增部门',
					content : $("#addBumen"),
					type : 1,
					btn : [ "保存", "取消" ],
					btn1 : function() {
						var formdata = form.val("addform");
						$.post("sys/bumen_add", formdata, function(d) {
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
						id_arry += data[i].bumen_id + ",";
					}
					$.post("sys/bumen_del", {
						"bumen_ids" : id_arry
					}, function(d) {
						table.reload('table_list');
						layer.closeAll();
					});
				});
				break;
			}
		});

		/* 修改部门信息 *  删除单个部门  */
		table.on('tool(test)', function(obj) {
			var data = obj.data;
			switch (obj.event) {
			case 'edit':
				form.val("updform", {
					"bumen_id" : data.bumen_id,
					"bumen_name" : data.bumen_name,
					"manager" : data.manager
				});
				layer.open({
					title : '修改部门信息',
					content : $("#updBumen"),
					type : 1,
					btn : [ "保存", "取消" ],
					btn1 : function() {
						var formdata = form.val("updform");
						console.log(formdata);
						$.post("sys/bumen_upd", formdata, function(d) {
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
				layer.confirm("确认要删除" + data.bumen_name + "吗？",
						function(index) {
							$.post("sys/bumen_del_row", data, function(d) {
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