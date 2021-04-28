<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path=application.getContextPath()+"/static/admin/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <base href="<%=path%>">
	<meta charset="UTF-8">
	<title>个人信息</title>
	<meta name="renderer" content="webkit">	
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">	
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">	
	<meta name="apple-mobile-web-app-status-bar-style" content="black">	
	<meta name="apple-mobile-web-app-capable" content="yes">	
	<meta name="format-detection" content="telephone=no">	
	<link rel="stylesheet" type="text/css" href="common/layui/css/layui.css" media="all">
	<link rel="stylesheet" type="text/css" href="common/bootstrap/css/bootstrap.css" media="all">
	<link rel="stylesheet" type="text/css" href="common/global.css" media="all">
	<link rel="stylesheet" type="text/css" href="css/personal.css" media="all">

	<script type="text/javascript" src="js/jquery-1.11.1-min.js"></script>

	<link href="common/bs_pagination/jquery.bs_pagination.min.css" type="text/css" rel="stylesheet">
	<script type="text/javascript" src="common/bootstrap/js/bootstrap.js"></script>
	<script type="text/javascript" src="common/bs_pagination/jquery.bs_pagination.min.js"></script>
	<script type="text/javascript" src="common/bs_pagination/en.js"></script>
	<script type="text/javascript">
		$(function () {

			pageList(1,10);

			//为全选的复选框绑定事件，触发全选操作
			$("#selected-all").click(function () {
				$("input[name=dx]").prop("checked",this.checked);

			})

			//以下这种做法是不行的,因为动态生成的元素是不能够以普通绑定事件的形式进行生成的
			/*$("input[name=xz]").click(function () {
                alert(123)
            })*/
			/*
                动态生成的元素，我们需要以on方法的形式来触发事件
                语法：
                    $(需要绑定元素的有效的外层元素).on(绑定事件的方式，需要绑定的元素的jquery对象，回调函数)
             */
			$("#userBody").on("click",$("input[name=dx]"),function () {
				$("#selected-all").prop("checked",$("input[name=dx]").length==$("input[name=dx]:checked").length);
			})

			//打开创建用户模态窗口
			$("#createBtn").click(function () {
				$("#createUser").modal("show")
			})

			//为注册按钮事件
			$("#saveBtn").click(function register() {

				//检查密码和账号输入

				if ($("#create-loginPwd").val()=="" || $("#create-loginPwd").val()==""){
					alert("账号密码不能为空");
					return false;
				}

				if($("#create-loginPwd").val().trim().length<8 || $("#create-loginPwd").val().trim().length>16
						|| $("#create-loginAct").val().trim().length<8 || $("#create-loginAct").val().trim().length>16
				){
					alert("注意：账号密码长度为8-16");
					return false;
				}


				$.post(
					"${path}/admin/addUser.do",
					{
						"loginAct":$("#create-loginAct").val().trim(),
						"loginPwd":$("#create-loginPwd").val().trim(),
						"nickname":$("#create-nickname").val().trim(),
						"phone":$("#create-phone").val().trim(),
						"weChat":$("#create-wechat").val().trim(),
						"roleCode":$("#create-roleCode").val().trim()
					},
					function (data) {
						if (data.success){
							//注册成功，刷新用户列表，关闭模态窗口
							pageList(1,10);
							$("#createUser").modal("hide")
						}else{
							//注册失败，弹出失败信息
							alert(data.msg);
						}
					},
					"json"
				)

			})

			//为删除按钮绑定事件
			$("#deleteBtn").click(function () {

				//找到复选框中所有条√的jquery对象
				var $xz=$("input[name=dx]:checked");

				if ($xz.length==0){
					alert("请选择需要删除的用户");
				}else {

					//url:workbench/activity/delete.do?id=xxx&id=xxx&id=xxx
					//拼接参数
					var param="";

					//将$xz中的每一个dom对象遍历出来，取其value值，就相当于取得了需要删除的记录的id
					for(var i=0;i<$xz.length;i++){
						param+="userIds="+$($xz[i]).val()

						//如果不是最后一个元素，需要在后面追加一个&符号
						if (i<$xz.length-1){
							param+="&";
						}
					}

					if (confirm("确定删除所选择的数据？")){
						$.ajax({
							url:"${path}/admin/deleteUser.do?"+param,
							type:"post",
							dataType:"json",
							success:function (data) {
								/*
                                    data
                                        {"success":true/false}
                                 */
								if(data.success){
									//删除成功后,刷新用户列表
									pageList($("#userPage").bs_pagination('getOption','currentPage'),
											$("#userPage").bs_pagination('getOption','rowsPerPage'));
								}else{
									alert("删除失败");
								}
							}
						})
					}
				}
			})


			//为修改操作绑定事件，打开修改操作的模态窗口
			$("#editBtn").click(function () {
				var $xz=$("input[name=dx]:checked");
				if($xz.length==0){
					alert("请选择需要修改的记录")
				}else if($xz.length>1){
					alert("只能选择一条记录进行修改")
				}else {
					var id=$xz.val();
					$.ajax({
						url:"${path}/admin/queryUserById.do",
						type:"get",
						data:{
							"userId":id
						},
						dataType:"json",
						success:function (data) {

							//处理单条user
							$("#edit-id").val(data.id);
							$("#edit-loginAct").val(data.loginAct);
							$("#edit-nickname").val(data.nickname);
							$("#edit-phone").val(data.phone);
							$("#edit-weChat").val(data.weChat);
							$("#edit-lockState").val(data.lockState);
							$("#edit-roleCode").val(data.roleCode)

							//所有的值都填写好之后，打开修改操作的模态窗口
							$("#editUser").modal("show");
						}
					})
				}
			})

			//为更新按钮绑定事件
			$("#updateBtn").click(function () {

				$.ajax({
					url:"${path}/admin/updateUser.do",
					type:"post",
					data:{
						"id":$("#edit-id").val(),
						"loginAct":$("#edit-loginAct").val(),
						"nickname":$("#edit-nickname").val(),
						"phone":$("#edit-phone").val(),
						"weChat":$("#edit-weChat").val(),
						"lockState":$("#edit-lockState").val(),
					},
					dataType:"json",
					success:function (data) {
						//data:{"success":true/false}
						if (data.success=="1"){
							//修改成功后，局部刷新市场活动信息列表
							pageList($("#activityPage").bs_pagination('getOption','currentPage'),
									$("#activityPage").bs_pagination('getOption','rowsPerPage'));
							//修改成功后，关闭修改模态窗口
							$("#editActivityModal").modal("hide");
						}else if(data.success=="2"){
							alert("当前账号信息已更改，请重新登录");
							window.parent.location.href="${path}/admin/login.html";
						}else{
						    alert("修改失败");
						}
					}
				})
			})

		})



		/*
            对于所有的关系型数据库，做前端的分页相关操作的基础组件就是pageNo和pageSize
            pageNo：页码
            pageSize：每页展现的记录数

            pageList方法：就是发出ajax请求到后台，从后台取得最新的市场活动信息列表数据
                            通过响应回来的数据，局部刷新市场活动信息列表

            在哪些情况下需要调用pageList方法：
                （1）点击左侧菜单中的市场活动“超链接”
                （2）添加、修改、删除后，需要刷新市场活动列表
                （3）点击查询按钮的时候，需要刷新市场活动列表
                （4）点击分页组件的时候

                以上为pageList方法制定了6个入口，在以上6个操作执行完毕后，我们必须调用pageList方法，刷新市场活动信息列表
         */
		function pageList(pageNo,pageSize){

			//将全选的复选框取消全选
			$("#selected-all").prop("checked",false);

			$.ajax({
				url:"${path}/admin/getUserList.do",
				type:"get",
				data:{
					"pageNo":pageNo,
					"pageSize":pageSize,
					"keyword":$("#keyword").val().trim()
				},
				dataType:"json",
				success:function (data) {


					var html="";
					$.each(data.userList,function (i,user) {

						html+='<tr><td><input name="dx" value="'+user.id+'" type="checkbox"></td>';
						html+='<td>'+user.loginAct+'</td>';
						html+='<td>'+user.nickname+'</td>';
						html+='<td>'+user.roleCode+'</td>';
						html+='<td>'+user.phone+'</td>';
						html+='<td>'+user.weChat+'</td>';
						html+='<td>'+(user.lockState==1 ? "正常":"已冻结")+'</td>';
						html+='<td>'+user.createTime+'</td></tr>';

					})

					//计算总页数
					var totalPages=data.total%pageSize==0?data.total/pageSize:parseInt(data.total/pageSize)+1;

					$("#userBody").html(html)
					//数据处理完毕后，结合分页查询对前端展示分页信息
					$("#userPage").bs_pagination({
						currentPage: pageNo, // 页码
						rowsPerPage: pageSize, // 每页显示的记录条数
						maxRowsPerPage: 20, // 每页最多显示的记录条数
						totalPages: totalPages, // 总页数
						totalRows: data.total, // 总记录条数

						visiblePageLinks: 3, // 显示几个卡片

						showGoToPage: true,
						showRowsPerPage: true,
						showRowsInfo: true,
						showRowsDefaultInfo: true,

						//该回调函数在点击分页组件的时候触发
						onChangePage : function(event, data){
							pageList(data.currentPage , data.rowsPerPage);
						}
					});

				}
			});
		}
	</script>
</head>
<body>

<!-- 新建用户的模态窗口 -->
<div class="modal fade" id="createUser" role="dialog">
	<div class="modal-dialog" role="document" style="width: 85%;">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">
					<span aria-hidden="true">×</span>
				</button>
				<h4 class="modal-title" id="myModalLabel1">注册用户</h4>
			</div>
			<div class="modal-body">

				<form id="userAddForm" class="form-horizontal" role="form">

					<div class="form-group">
						<label for="create-loginAct" class="col-sm-2 control-label">账号<span style="font-size: 15px; color: red;">*</span></label>
						<div class="col-sm-10" style="width: 300px;">
							<input type="text" class="form-control" id="create-loginAct" >
						</div>

						<label for="create-loginPwd" class="col-sm-2 control-label">密码<span style="font-size: 15px; color: red;">*</span></label>
						<div class="col-sm-10" style="width: 300px;">
							<input type="password" class="form-control" id="create-loginPwd">
						</div>

						<label for="create-roleCode" class="col-sm-2 control-label">权限<span style="font-size: 15px; color: red;">*</span></label>
						<div class="col-sm-10" style="width: 300px;">
							<select class="form-control" id="create-roleCode">
								<option value="user">普通用户</option>
								<option value="admin">管理员</option>
							</select>
						</div>

						<label for="create-nickname" class="col-sm-2 control-label">昵称</label>
						<div class="col-sm-10" style="width: 300px;">
							<input type="text" class="form-control time" id="create-nickname">
						</div>

						<label for="create-phone" class="col-sm-2 control-label">电话号码</label>
						<div class="col-sm-10" style="width: 300px;">
							<input type="text" class="form-control" id="create-phone">
						</div>

						<label for="create-weChat" class="col-sm-2 control-label">微信</label>
						<div class="col-sm-10" style="width: 300px;">
							<input type="text" class="form-control" id="create-weChat">
						</div>

					</div>

				</form>

			</div>
			<div class="modal-footer">
				<!--
                    data-dismiss="modal":表示关闭模态窗口
                -->
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				<button type="button" class="btn btn-primary" id="saveBtn">注册</button>
			</div>
		</div>
	</div>
</div>

<!-- 编辑用户的模态窗口 -->
<div class="modal fade" id="editUser" role="dialog">
	<div class="modal-dialog" role="document" style="width: 85%;">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">
					<span aria-hidden="true">×</span>
				</button>
				<h4 class="modal-title" id="myModalLabel2">编辑用户</h4>
			</div>
			<div class="modal-body">

				<form id="userEditForm" class="form-horizontal" role="form">

					<input type="hidden" id="edit-id"/>

					<div class="form-group">
						<label for="edit-loginAct" class="col-sm-2 control-label">账号<span style="font-size: 15px; color: red;">*</span></label>
						<div class="col-sm-10" style="width: 300px;">
							<input type="text" class="form-control" id="edit-loginAct" readonly>
						</div>


						<label for="edit-lockState" class="col-sm-2 control-label">状态<span style="font-size: 15px; color: red;">*</span></label>
						<div class="col-sm-10" style="width: 300px;">
							<select class="form-control" id="edit-lockState">
								<option value="1">正常</option>
								<option value="0">已冻结</option>
							</select>
						</div>

						<label for="edit-nickname" class="col-sm-2 control-label">昵称</label>
						<div class="col-sm-10" style="width: 300px;">
							<input type="text" class="form-control time" id="edit-nickname">
						</div>

						<label for="edit-phone" class="col-sm-2 control-label">电话号码</label>
						<div class="col-sm-10" style="width: 300px;">
							<input type="text" class="form-control" id="edit-phone">
						</div>

						<label for="edit-weChat" class="col-sm-2 control-label">微信</label>
						<div class="col-sm-10" style="width: 300px;">
							<input type="text" class="form-control" id="edit-weChat">
						</div>

					</div>

				</form>

			</div>
			<div class="modal-footer">
				<!--
                    data-dismiss="modal":表示关闭模态窗口
                -->
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				<button type="button" class="btn btn-primary" id="updateBtn">修改</button>
			</div>
		</div>
	</div>
</div>

<section class="layui-larry-box">
	<div class="larry-personal">
	    <div class="layui-tab">
		<blockquote class="layui-elem-quote news_search">
		
		<div class="layui-inline">
		    <div class="layui-input-inline">
		    	<input value="" placeholder="请输入关键字" id="keyword" class="layui-input search_input" type="text">
		    </div>
		    <a class="layui-btn search_btn" id="searchBtn" onclick="pageList(1,10)">查询</a>
		</div>

		<div class="layui-inline">
			<a class="layui-btn layui-btn-normal newsAdd_btn" id="createBtn">注册用户</a>
		</div>
		<div class="layui-inline">
			<a class="layui-btn audit_btn" id="editBtn">编辑用户</a>
		</div>
		<div class="layui-inline">
			<a class="layui-btn layui-btn-danger batchDel" id="deleteBtn">删除</a>
		</div>

	</blockquote>
            
		    <div class="layui-tab-content larry-personal-body clearfix mylog-info-box">

                <div class="layui-tab-item layui-field-box layui-show" >
                     <table class="layui-table table-hover" lay-even="" lay-skin="nob">
                          <thead>
                              <tr>
                                  <th><input type="checkbox" id="selected-all"></th>
                                  <th>账号</th>
                                  <th>昵称</th>
                                  <th>权限</th>
                                  <th>电话号码</th>
                                  <th>微信</th>
                                  <th>状态</th>
                                  <th>创建时间</th>
                              </tr>
                          </thead>
                          <tbody id="userBody">

                          </tbody>
                     </table>
                     <div class="larry-table-page clearfix">

				          <div id="userPage" class="page" style="height: 50px;"></div>
			         </div>
			    </div>
		    </div>
		</div>
	</div>
</section>
</body>
</html>