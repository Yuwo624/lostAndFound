<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
	String path=application.getContextPath()+"/static/admin/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
	<base href="<%=path%>">
	<meta charset="UTF-8">
	<title>用户权限</title>
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
	<script type="text/javascript" src="common/layui/layui.js"></script>
	<script type="text/javascript">
		layui.config({
			base : "js/"
		}).use(['form','layer','jquery','laypage'],function(){
			var form = layui.form(),
					layer = parent.layer === undefined ? layui.layer : parent.layer,
					laypage = layui.laypage,
					$ = layui.jquery;

			pageList(1,10);


		})

		function edit(i){
			var userId=$(i).attr("value");
			$.get(
				"${path}/admin/queryUserById.do",
				{"userId":userId},
				function (data) {
					//处理单条user
					$("#edit-id").val(data.id);
					$("#edit-loginAct").val(data.loginAct);
					$("#edit-lockState").val(data.lockState);
					$("#edit-power").val(data.roleCode)
					$("#editModal").modal("show")
				},
				"json"
			)

		}

		function updatePower(){
			$.post(
				"${path}/admin/updateUserPower.do",
				{"id":$("#edit-id").val(),"lockState":$("#edit-lockState").val(),"roleCode":$("#edit-power").val()},
				function (data) {
					if (data.success=="1"){
						pageList(1,10);
						$("#editModal").modal("hide");
					}else if(data.success=="2"){
					    alert("当前登录账号权限已被修改，请重新登录！！！");
					    window.parent.location.href="${path}/admin/login.html";
					}else{
					    alert("更新失败")
					}
				}
			)
		}

		function pageList(pageNo,pageSize){

			//将全选的复选框取消全选
			$("#selected-all").prop("checked",false);

			$.ajax({
				url:"${path}/admin/getUserList.do",
				type:"get",
				data:{
					"pageNo":pageNo,
					"pageSize":pageSize,
					"keyword":$.trim($("#keyword").val())
				},
				dataType:"json",
				success:function (data) {


					var html="";
					$.each(data.userList,function (i,user) {
						html+='<tr><td>'+user.loginAct+'</td>';
						html+='<td>'+user.nickname+'</td>';
						html+='<td>'+(user.lockState==1 ? "正常":"已冻结")+'</td>';
						html+='<td>'+user.createTime+'</td>';
						html+='<td>'+(user.roleCode=="管理员"?"已开启":"未开启")+'</td>';
						html+='<td><a id="editBtn" onclick="edit(this)" class="layui-btn layui-btn-mini news_edit" value="'+user.id+'"><i class="iconfont icon-edit"></i> 编辑</a></td></tr>';

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

<!-- 编辑权限模态窗口 -->
<div class="modal fade" id="editModal" role="dialog">
	<div class="modal-dialog" role="document" style="width: 400px;">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">
					<span aria-hidden="true">×</span>
				</button>
				<h4 class="modal-title" id="myModalLabel2">修改用户权限</h4>
			</div>
			<div class="modal-body">

				<form class="form-horizontal" role="form">

					<input type="hidden" id="edit-id"/>

					<div class="form-group">
						<label for="edit-loginAct" class="col-sm-2 control-label">账号</label>
						<div class="col-sm-10" style="width: 300px;">
							<input type="text" class="form-control" id="edit-loginAct" readonly>
						</div>
					</div>

					<div class="form-group">
						<label for="edit-power" class="col-sm-2 control-label">权限<span style="font-size: 15px; color: red;">*</span></label>
						<div class="col-sm-10" style="width: 300px;">
							<select class="form-control" id="edit-power">
								<option value="user">普通用户</option>
								<option value="admin">管理员</option>
							</select>
						</div>
					</div>
					<div class="form-group">
						<label for="edit-lockState" class="col-sm-2 control-label">状态<span style="font-size: 15px; color: red;">*</span></label>
						<div class="col-sm-10" style="width: 300px;">
							<select class="form-control" id="edit-lockState">
								<option value="1">正常</option>
								<option value="0">已冻结</option>
							</select>
						</div>
					</div>

				</form>

			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				<button type="button" class="btn btn-primary" onclick="updatePower()" id="updateBtn">更新</button>
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
		    <a class="layui-btn search_btn" onclick="pageList(1,10)">查询</a>
		</div>
	</blockquote>
            

                <div class="layui-form news_list">
                    <table class="layui-table">
					<thead>
						<tr>
							<th>账号</th>
							<th>昵称</th>
							<th>状态</th>
							<th>创建时间</th>
							<th>后台权限</th>
							<th>权限修改</th>
						</tr>
					</thead>
					<tbody id="userBody" class="user_content">
					<tr>

					</tr>
					</tbody>
					</table>
					<div class="larry-table-page clearfix">

						<div id="userPage" class="page" style="height: 50px;"></div>
					</div>
			    </div>
		    </div>
		</div>
	
</section>
</body>
</html>