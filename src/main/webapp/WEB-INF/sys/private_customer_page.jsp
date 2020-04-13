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
<title>跟单客户管理</title>
<link rel="stylesheet" href="layui/css/layui.css">
<style>
.form-visit {
	/* height: 320px;
	width: 480px, */
}
</style>
</head>
<body>

	<!-- 弹出层：回访客户-->
	<div hidden class=" layui-form form-visit" id='visit_customer'>
		<form class=" layui-form  form-visit" lay-filter="visit_customer">
			<!-- <div class="  "> -->
			<div class="layui-inline ">
				<label class="layui-form-label ">回访方式</label>
				<div class="layui-input-inline ">
					<select name='visit_partten' lay-verify="" id="visit_partten">
					</select>
				</div>
			</div>
			<div class="layui-inline ">
				<div class="layui-input-block">
					<input type="checkbox"  lay-skin="switch"
						lay-filter="visit_pay" lay-text="付款|未付款">
						<input type="hidden" name="visit_pay" value="0" id="vist_pay">
				</div>
				<label class="layui-form-label switch-hide" hidden>付款金额</label>
				<div class="layui-input-inline switch-hide" hidden>
					<input type='text' name='visit_money' autocomplete='off'
						class='layui-input '>
				</div>
			</div>
			 <div class="layui-form-item layui-form-text">
				<label class="layui-form-label ">回访内容</label>
				<div class="layui-input-block">
					<textarea name="visit_info" placeholder="请输入内容" style="height:180px;"
						class="layui-textarea"></textarea>
				</div>
			</div>
			<!-- 	</div> -->
		</form>
	</div>

	<!-- 弹出层：发送邮件-->
	<div hidden class=" layui-form form-visit" id='visit_email'>
		<form class=" layui-form  form-visit" lay-filter="visit_email">
			<div class="layui-inline ">
				<label class="layui-form-label ">标题</label>
				<div class="layui-input-inline ">
					<input type='text' name='title' autocomplete='off'
						class='layui-input '>
				</div>
			</div>
			
			 <div class="layui-form-item layui-form-text">
				<label class="layui-form-label ">邮件内容</label>
				<div class="layui-input-block">
					<textarea name="info" placeholder="请输入内容" style="height:180px;"
						class="layui-textarea"></textarea>
				</div>
			</div>
		</form>
	</div>
	<table class='layui-table'
		lay-data="{url:'sys/private_customer_list',toolbar:'#tollbar', page:true ,id:'table_list'}"
		lay-filter="test">
		<thead>
			<tr>
				<th lay-data="{type:'checkbox'}"></th>
				<th lay-data="{field:'customer_name'}">客户名</th>
				<th lay-data="{field:'customer_man'}">跟随用户名</th>
				<th lay-data="{field:'customer_tel'}">手机号</th>
				<th lay-data="{field:'customer_addr'}">客户住址</th>
				<th
					lay-data="{templet:function(d){
		return $('#rowbar').html();
			}}">操作</th>
			</tr>
		</thead>
	</table>


	<script type="text/html" id="rowbar">
  <a class="layui-btn layui-btn-xs layui-icon layui-icon-edit" lay-event="edit" >编辑</a>
<a class="layui-btn layui-btn-xs layui-icon layui-icon-delete"  lay-event="public" >放弃</a>
<a class="layui-btn layui-btn-xs "  lay-event="visit_infos" ><i class="layui-icon">&#xe600;</i>详情</button></a>
    </script>


	<script type="text/html" id="tollbar">
<input type="text" name="text"  placeholder="请输入查询内容"  id="checktb" style="height:31px">
<button type="button" class="layui-btn layui-btn-sm" lay-event="check">
  <i class="layui-icon ">&#xe615;</i> 查询</button>
<button type="button" class="layui-btn layui-btn-sm" lay-event="selected_visit">
  <i class="layui-icon">&#xe600;</i>选中跟单</button>
<button type="button" class="layui-btn layui-btn-sm" lay-event="all_visit">
  <i class="layui-icon">&#xe658;</i>全部跟单</button>
<button type="button" class="layui-btn layui-btn-sm" lay-event="selected_email">
  <i class="layui-icon">&#xe618;</i>选中发送邮件</button>
<button type="button" class="layui-btn layui-btn-sm" lay-event="all_email">
  <i class="layui-icon">&#xe609;</i>全部发送邮件</button>
<button type="button" class="layui-btn layui-btn-sm" lay-event="public">
  <i class="layui-icon">&#xe640;</i>放弃跟单</button>

</script>
	<%@ include file="../layui.jsp"%>
	<script>
		$(".switch-hide").hide();
		form.on('switch(visit_pay)', function(data) {
			//开关是否开启，true或者false
			if (data.elem.checked) {
				$(".switch-hide").show();
				$("#visit_pay").val(1);
			} else {
				$(".switch-hide").hide();
				$("#visit_pay").val(0);
			}

		});
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
			case 'public':
				layer.confirm("确认要放弃跟单吗？", function(index) {
					var id_arry = "";
					for (var i = 0; i < data.length; i++) {
						id_arry += data[i].customer_id + ",";
					}
					$.post("sys/public_customer", {
						"customer_ids" : id_arry
					}, function(d) {
						layer.msg('已放弃跟单', {
							icon : 6
						});
						table.reload('table_list');
						layer.closeAll();
					});
				});
				break;
			case 'selected_visit':
				if(data.length>0){
					layer.open({
						title : '回访记录',
						content : $("#visit_customer"),
						type : 1,
						area : [ '500px', '400px' ],
						btn : [ "保存", "取消" ],
						btn1 : function() {
							var formdata = form.val("visit_customer");
							//获取表格中选中数据的id
							var customer_id_arr="";
							for(var i=0;i<data.length;i++){
								customer_id_arr+=data[i].customer_id+","
							}
							formdata.customer_arr=customer_id_arr;
							$.post("sys/visit_customer", formdata, function(d) {
								table.reload('table_list');
								layer.closeAll();
							})
						},
						btn2 : function() {
							layer.closeAll();
						}
					});
					$("#visit_partten").html("");
					$.post("sys/visit_partten_list", function(d) {
						for (var i = 0; i < d.length; i++) {
							var option = "<option value='"+d[i].partten_id+"'>"
									+ d[i].partten_name + "</option>";
							$("#visit_partten").append(option);
						}
						form.render('select');
					});
				}else{
					layer.msg("请先选中数据后操作", {
						icon : 6
					});
					}
					break;
				case 'all_visit':
						layer.open({
							title : '添加回访',
							content : $("#visit_customer"),
							type : 1,
							area : [ '500px', '400px' ],
							btn : [ "保存", "取消" ],
							btn1 : function() {
								var formdata = form.val("visit_customer");
								$.post("sys/visit_all_customer", formdata, function(d) {
									table.reload('table_list');
									layer.closeAll();
								})
							},
							btn2 : function() {
								layer.closeAll();
							}
						});
						$("#visit_partten").html("");
						$.post("sys/visit_partten_list", function(d) {
							for (var i = 0; i < d.length; i++) {
								var option = "<option value='"+d[i].partten_id+"'>"
										+ d[i].partten_name + "</option>";
								console.log(option);
								$("#visit_partten").append(option);
							}
							form.render('select');
						});
				
				break;
				case 'selected_email':
					layer.open({
						title : '发送邮件',
						content : $("#visit_email"),
						type : 1,
						area : [ '500px', '400px' ],
						btn : [ "发送", "取消" ],
						btn1 : function() {
							var formdata = form.val("visit_email");
							var customer_email_arr="";
							for(var i=0;i<data.length;i++){
								customer_email_arr+=data[i].customer_email+","
							}
							formdata.email_arr=customer_email_arr;
							console.log(formdata);
							$.post("sys/visit_selected_email", formdata, function(d) {
								layer.msg("邮件发送成功", {
									icon : 6
								});
								table.reload('table_list');
								layer.closeAll();
							})
						},
						btn2 : function() {
							layer.closeAll();
						}
					});
					
			
			break;
				case 'all_email':
					layer.open({
						title : '发送邮件',
						content : $("#visit_email"),
						type : 1,
						area : [ '500px', '400px' ],
						btn : [ "发送", "取消" ],
						btn1 : function() {
							var formdata = form.val("visit_email");
							$.post("sys/visit_all_email", formdata, function(d) {
								layer.msg("邮件发送成功", {
									icon : 6
								});
								table.reload('table_list');
								layer.closeAll();
							})
						},
						btn2 : function() {
							layer.closeAll();
						}
					});
					
			
			break;
			}
		});

		table.on('tool(test)', function(obj) {
			var data = obj.data;//得到当前行数据 
			 if (obj.event == 'visit_infos') {
				 //点击回访详情按钮
				//打开新的页面-展示该客户的所有回访信息
				location.href="sys/visit_infos_page/"+data.customer_id;
				 
			 }else if (obj.event == 'edit') {
				layer.confirm("确认要删除" + data.username + "用户吗？",
						function(index) {

						})
			} else if (obj.event == 'public') {
				layer.confirm("确认要放弃" + data.customer_name + "客户吗？", function(
						index) {
					//发送请求，将该客户变为登录用户的跟单客户 
					$.post("sys/public_customer", {
						"customer_ids" : data.customer_id
					}, function() {
						layer.msg("要放弃" + data.customer_name + "客户", {
							icon : 6
						});
						table.reload("table_list");
					})
				})
			}
		});
	</script>
</body>
</html>