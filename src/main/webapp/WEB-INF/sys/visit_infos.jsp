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




	<!-- 主体展示 -->
	<%-- <table class='layui-table'
		lay-data="{url:'sys/visit_infos/${customer_id}',toolbar:'#tollbar', page:true ,id:'table_list',limit:50}"
		lay-filter="test">
		<thead>
			<tr>
				<th lay-data="{field:'visit_time'}" lay-filter="deluserform">回访时间</th>
				<th lay-data="{templet:function(d){
				return d.visit_user_bean.username;
				}}">业务员</th>
				<th lay-data="{templet:function(d){
				return d.visit_partten_bean.partten_name;
				}}">回访方式</th>
				<th lay-data="{field:'visit_info'}">回访内容</th>
				<th lay-data="{field:'visit_pay_text'}">是否付款</th>
				<th lay-data="{field:'visit_money'}">付款金额</th>
				<th
					lay-data="{templet:function(d){
		return $('#rowbar').html();
			}}">操作</th>
			</tr>
		</thead>
	</table> --%>
	<div class="layui-collapse" id="show_div">
		<div class="layui-colla-item">
			<h2 class="layui-colla-title">杜甫</h2>
			<div class="layui-colla-content layui-show">内容区域</div>
		</div>

	</div>

	<script type="text/html" id="rowbar">
  <a class="layui-btn layui-btn-xs" lay-event="annotation" >批注</a>
    </script>


	<script type="text/html" id="tollbar">
<input type="text" name="text"  placeholder="请输入查询内容"  id="checktb" style="height:31px">
<button type="button" class="layui-btn layui-btn-sm" lay-event="check">
  <i class="layui-icon ">&#xe615;</i> 查询</button>
</script>


	<%@ include file="../layui.jsp"%>
	<script>
		var show_data;
		var count;
		var page = {
			page : 1,
			limit : 50
		};
		$
				.post(
						"sys/visit_infos/${customer_id}",
						page,
						function(d) {
							console.log(d);
							show_data = d.data;
							//显示信息
							$("#shiw_div").html('');
							for (var i = 0; i < show_data.length; i++) {
								var show = '<div class="layui-colla-item"><h2 class="layui-colla-title">'
									+'<div style="width:20%;height:10px;float:left;">'
										+ show_data[i].visit_time
										+ '</div><div style="width:20%;height:10px;float:left;">'
										+ show_data[i].visit_user_bean.username
										+ '</div><div style="width:20%;height:10px;float:left;">'
										+ show_data[i].visit_pay_text
										+ '</div><div style="width:20%;height:10px;float:left;">'
										+ show_data[i].visit_money
										+ '</div></h2><div class="layui-colla-content layui-show">'
										+ show_data[i].visit_info
										+ '</div></div>';
								$("#show_div").append(show);
							}
							//显示分页

						});

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
			}
		});
	</script>
</body>
</html>