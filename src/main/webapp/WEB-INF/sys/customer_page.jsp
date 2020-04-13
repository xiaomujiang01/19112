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
<title>客户管理</title>
<link rel="stylesheet" href="layui/css/layui.css">
</head>
<body>

	<!-- 弹出层：增加客户 -->
	<div hidden class=" layui-form" id='addCustomer'>
		<form class=" layui-form" lay-filter="addform">
			<div class="layui-form-item  ">
				<div class="layui-inline ">
					<label class="layui-form-label ">客户名</label>
					<div class="layui-input-inline ">
						<input type='text' name='customer_name' autocomplete='off'
							class='layui-input'>
					</div>
				</div>
				<div class="layui-inline ">
					<label class="layui-form-label ">联系人</label>
					<div class="layui-input-inline ">
						<input type='text' name='customer_man' autocomplete='off'
							class='layui-input'>
					</div>
				</div>
				<div class="layui-inline ">
					<label class="layui-form-label ">电话</label>
					<div class="layui-input-inline ">
						<input type='text' name='customer_tel' autocomplete='off'
							class='layui-input'>
					</div>
				</div>
				<div class="layui-inline ">
					<label class="layui-form-label ">地址</label>
					<div class="layui-input-inline ">
						<input type='text' name='customer_addr' autocomplete='off'
							class='layui-input'>
					</div>
				</div>
			</div>
		</form>
	</div>


<!-- 弹出层：修改客户 -->
	<div hidden class=" layui-form" id='updCustomer'>
		<form class=" layui-form" lay-filter="updform">
		<input type="hidden" name="customer_id">
			<div class="layui-form-item  ">
				<div class="layui-inline ">
					<label class="layui-form-label ">客户名</label>
					<div class="layui-input-inline ">
						<input type='text' name='customer_name' autocomplete='off'
							class='layui-input'>
					</div>
				</div>
				<div class="layui-inline ">
					<label class="layui-form-label ">联系人</label>
					<div class="layui-input-inline ">
						<input type='text' name='customer_man' autocomplete='off'
							class='layui-input'>
					</div>
				</div>
				<div class="layui-inline ">
					<label class="layui-form-label ">电话</label>
					<div class="layui-input-inline ">
						<input type='text' name='customer_tel' autocomplete='off'
							class='layui-input'>
					</div>
				</div>
				<div class="layui-inline ">
					<label class="layui-form-label ">地址</label>
					<div class="layui-input-inline ">
						<input type='text' name='customer_addr' autocomplete='off'
							class='layui-input'>
					</div>
				</div>
			</div>
		</form>
	</div>

	<table class='layui-table'
		lay-data="{url:'sys/customer_list',toolbar:'#tollbar', page:true ,id:'table_list'}"
		lay-filter="test">
		<thead>
			<tr>
				<th lay-data="{type:'checkbox'}"></th>
				<th lay-data="{field:'customer_name'}">客户名</th>
				<th lay-data="{field:'customer_man'}">联系人</th>
				<th lay-data="{field:'customer_tel'}">电话</th>
				<th lay-data="{field:'customer_addr'}">客户住址</th>
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
		/* 根据客户名、联系人查找（state=1）的客户    *  增加客户   *  删除客户 */
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
					title : '新增客户',
					content : $("#addCustomer"),
					type : 1,
					btn : [ "保存", "取消" ],
					btn1 : function() {
						var formdata = form.val("addform");
						$.post("sys/customer_add", formdata, function(d) {
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
						id_arry += data[i].customer_id + ",";
					}
					$.post("sys/customer_del", {
						"customer_ids" : id_arry
					}, function(d) {
						table.reload('table_list');
						layer.closeAll();
					});
				});
				break;
			}
		});

		/* 修改客户信息 *  删除单个客户  */
		table.on('tool(test)', function(obj) {
			var data = obj.data;
			switch (obj.event) {
			case 'edit':
				form.val("updform", {
					"customer_id" : data.customer_id,
					"customer_name" : data.customer_name,
					"customer_man" : data.customer_man,
					"customer_tel" : data.customer_tel,
					"customer_addr": data.customer_addr
				});
				layer.open({
					title : '修改客户信息',
					content : $("#updCustomer"),
					type : 1,
					btn : [ "保存", "取消" ],
					btn1 : function() {
						var formdata = form.val("updform");
						console.log(formdata);
						$.post("sys/customer_upd", formdata, function(d) {
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
				layer.confirm("确认要删除" + data.customer_name + "客户吗？",
						function(index) {
							$.post("sys/customer_del_row", data, function(d) {
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