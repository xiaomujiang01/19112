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
<title>公海客户管理</title>
<link rel="stylesheet" href="layui/css/layui.css">
</head>
<body>

	<!-- 增加公海客户的弹出层 -->
	<div hidden class=" layui-form" id='addPublic'>
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
					<label class="layui-form-label ">联系人电话</label>
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

	<!-- 修改公海客户的弹出层 -->
	<div hidden class=" layui-form" id='updPublic'>
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
					<label class="layui-form-label ">联系人电话</label>
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
		lay-data="{url:'sys/public_customer_list',toolbar:'#tollbar', page:true ,id:'table_list'}"
		lay-filter="test">
		<thead>
			<tr>
				<th lay-data="{type:'checkbox'}"></th>
				<th lay-data="{field:'customer_name'}">客户名</th>
				<th lay-data="{field:'customer_man'}">联系人</th>
				<th lay-data="{field:'customer_tel'}">联系人电话</th>
				<th lay-data="{field:'customer_addr'}">地址</th>
				<th
					lay-data="{templet:function(d){
		return $('#rowbar').html();
			}}">操作</th>
			</tr>
		</thead>
	</table>


	<script type="text/html" id="rowbar">
  <a class="layui-btn layui-btn-xs" lay-event="edit" >编辑</a>
<a class="layui-btn layui-btn-xs" lay-event="private_row" style="background-color:red" >跟单</a>
    </script>


	<script type="text/html" id="tollbar">
<input type="text" name="text"  placeholder="请输入查询内容"  id="checktb" style="height:31px">
<button type="button" class="layui-btn layui-btn-sm" lay-event="check">
  <i class="layui-icon ">&#xe615;</i> 查询</button>
<button type="button" class="layui-btn layui-btn-sm" lay-event="add">
  <i class="layui-icon">&#xe654;</i> 新增</button>
<button type="button" class="layui-btn layui-btn-sm" lay-event="private" style="background-color:red">
  <i class="layui-icon">&#xe654;</i> 跟单</button>

</script>
	<%@ include file="../layui.jsp"%>
	<script>
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
					title : '新增公海客户',
					content : $("#addPublic"),
					type : 1,
					btn : [ "保存", "取消" ],
					btn1 : function() {
						var formdata = form.val("addform");
						$.post("sys/public_customer_add", formdata, function(d) {
							table.reload('table_list');
							layer.closeAll();
						})
					},
					btn2 : function() {
						layer.closeAll();
					}
				})
				break;
			case 'private':
				layer.confirm("确认要跟单吗？", function(index) {
					var id_arry = "";
					for (var i = 0; i < data.length; i++) {
						id_arry += data[i].customer_id + ",";
					}
					$.post("sys/public_customer_private", {
						"customer_ids" : id_arry
					}, function(d) {
						layer.msg('跟单成功', {icon: 6});
						table.reload('table_list');
						layer.closeAll();
					});
				});
				break;
			}
		});

		table.on('tool(test)', function(obj) {
			var data = obj.data;//得到当前行数据 
			if (obj.event == 'edit') {
				form.val("updform", {
					"customer_id" : data.customer_id,
					"customer_name" : data.customer_name,
					"customer_man" : data.customer_man,
					"customer_tel" : data.customer_tel,
					"customer_addr": data.customer_addr
				});
				layer.open({
					title : '修改公海客户信息',
					content : $("#updPublic"),
					type : 1,
					btn : [ "保存", "取消" ],
					btn1 : function() {
						var formdata = form.val("updform");
						console.log(formdata);
						$.post("sys/public_customer_upd", formdata, function(d) {
							table.reload('table_list');
							layer.closeAll();
						})
					},
					btn2 : function() {
						layer.closeAll();
					}
				})
			}
			else if (obj.event == 'private_row') {
				layer.confirm("确认要跟单" + data.customer_name + "客户吗？",
						function(index) {
					/* 发送请求，将该客户变为登录用户的跟单客户 */
					$.post("sys/public_customer_private_row",data,function(){
						layer.msg('跟单成功', {icon: 6});
						table.reload("table_list");
						})
						    })
			}
		});
	</script>
</body>
</html>