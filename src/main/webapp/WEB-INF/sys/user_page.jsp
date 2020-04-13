<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro"%>
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
<title>用户管理</title>
<link rel="stylesheet" href="layui/css/layui.css">
</head>
<body>


	<!-- 弹出层：增加用户 -->
	<div hidden class=" layui-form" id='addUser'>
		<form class=" layui-form" lay-filter="adduserform">
			<div class="layui-form-item  ">
				<div class="layui-inline ">
					<label class="layui-form-label ">用户名</label>
					<div class="layui-input-inline ">
						<input type='text' name='username' autocomplete='off'
							class='layui-input'>
					</div>
				</div>
				<div class="layui-inline ">
					<label class="layui-form-label ">性别</label>
					<div class="layui-input-inline ">
						<input type='text' name='sex' autocomplete='off'
							class='layui-input'>
					</div>
				</div>
				<div class="layui-inline ">
					<label class="layui-form-label ">电话</label>
					<div class="layui-input-inline ">
						<input type='text' name='tel' autocomplete='off'
							class='layui-input'>
					</div>
				</div>
			</div>
		</form>
	</div>


	<!-- 弹出层：修改用户信息 -->
	<div hidden class=" layui-form" id='updUser'>
		<form class=" layui-form" lay-filter="upduserform">
			<input type="hidden" name="userid">
			<div class="layui-form-item  ">
				<div class="layui-inline ">
					<label class="layui-form-label ">用户名</label>
					<div class="layui-input-inline ">
						<input type='text' name='username' autocomplete='off'
							class='layui-input'>
					</div>
				</div>
				<div class="layui-inline ">
					<label class="layui-form-label ">性别</label>
					<div class="layui-input-inline ">
						<input type='text' name='sex' autocomplete='off'
							class='layui-input'>
					</div>
				</div>
				<div class="layui-inline ">
					<label class="layui-form-label ">电话</label>
					<div class="layui-input-inline ">
						<input type='text' name='tel' autocomplete='off'
							class='layui-input'>
					</div>
				</div>
			</div>
		</form>
	</div>


	<!-- 主体展示 -->
	<table class='layui-table'
		lay-data="{url:'sys/user_list',toolbar:'#tollbar', page:true ,id:'table_list'}"
		lay-filter="test">
		<thead>
			<tr>
				<th lay-data="{type:'checkbox'}"></th>
				<th lay-data="{field:'userid'}" lay-filter="deluserform">用户ID</th>
				<th lay-data="{field:'username'}">用户名</th>
				<th lay-data="{field:'sex'}">性别</th>
				<th lay-data="{field:'tel'}">手机号</th>
				<th lay-data="{field:'birthday'}">生日</th>
				<th
					lay-data="{templet:function(d){
		return $('#rowbar').html();
			}}">操作</th>
			</tr>
		</thead>
	</table>


	<script type="text/html" id="rowbar">
<shiro:hasPermission name="user_upd">
  <a class="layui-btn layui-btn-xs" lay-event="edit" >编辑</a>
</shiro:hasPermission>
<shiro:hasPermission name="user_del">
  <a class="layui-btn layui-btn-xs" lay-event="del_row" style="background-color:red">删除</a>
</shiro:hasPermission>
    </script>


	<script type="text/html" id="tollbar">
<shiro:hasPermission name="user_sel">
<input type="text" name="text"  placeholder="请输入查询内容"  id="checktb" style="height:31px">

<button type="button" class="layui-btn layui-btn-sm" lay-event="check">
  <i class="layui-icon ">&#xe615;</i> 查询</button>
</shiro:hasPermission>
<shiro:hasPermission name="user_add">
<button type="button" class="layui-btn layui-btn-sm" lay-event="add">
  <i class="layui-icon">&#xe654;</i> 新增</button>
</shiro:hasPermission>
<shiro:hasPermission name="user_del">
<button type="button" class="layui-btn layui-btn-sm" lay-event="del" style="background-color:red">
  <i class="layui-icon">&#xe67e;</i> 删除</button>
</shiro:hasPermission>
</script>


	<%@ include file="../layui.jsp"%>
	<script>
		/* 根据用户名、用户id、性别查找（state=1）的用户    *  增加用户   *  删除用户 */
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
					title : '新增用户',
					content : $("#addUser"),
					type : 1,
					btn : [ "保存", "取消" ],
					btn1 : function() {
						var formdata = form.val("adduserform");
						$.post("sys/user_add", formdata, function(d) {
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
					var userid_arry = "";
					for (var i = 0; i < data.length; i++) {
						userid_arry += data[i].userid + ",";
					}
					$.post("sys/user_del", {
						"userids" : userid_arry
					}, function(d) {
						table.reload('table_list');
						layer.closeAll();
					});
				});
				break;
			}
		});

		/* 修改用户信息 *  删除单个用户  */
		table.on('tool(test)', function(obj) {
			var data = obj.data;
			switch (obj.event) {
			case 'edit':
				form.val("upduserform", {
					"userid" : data.userid,
					"username" : data.username,
					"sex" : data.sex,
					"tel" : data.tel
				});
				layer.open({
					title : '修改用户信息',
					content : $("#updUser"),
					type : 1,
					btn : [ "保存", "取消" ],
					btn1 : function() {
						var formdata = form.val("upduserform");
						$.post("sys/user_upd", formdata, function(d) {
							table.reload('table_list');
							layer.closeAll();
						})
					},
					btn2 : function() {
						layer.closeAll();
					}
				})
				break;
			case "del_row":
				layer.confirm("确认要删除" + data.username + "用户吗？",
						function(index) {
							$.post("sys/user_del_row", data, function(d) {
								table.reload('table_list');
								layer.closeAll();
							});
						});
				break;
			}
		});

		/* 删除单个用户 */
		/* table.on('tool(test)', function(obj) {
		var data = obj.data;//得到当前行数据 
		if (obj.event == 'del2') {
			layer.confirm("确认要删除" + data.username + "用户吗？",
					function(index) {
				btn: ['确认', '取消']
			  ,btn1: function(){
				  var formdata = form.val("deluserform");
				  $.post("sys/user_del",formdata,function(d){
					  table.reload('user_list');
						layer.closeAll();
					  })
			  },
		       btn2: function(index, layero){
			  layer.closeAll();
			});
		}
		}); */
	</script>


</body>
</html>