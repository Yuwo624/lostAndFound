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
	<link href="common/bootstrap-datetimepicker-master/css/bootstrap-datetimepicker.min.css" type="text/css" rel="stylesheet" />
	<script type="text/javascript" src="common/bootstrap/js/bootstrap.js"></script>
	<script type="text/javascript" src="common/bootstrap-datetimepicker-master/js/bootstrap-datetimepicker.js"></script>
	<script type="text/javascript" src="common/bootstrap-datetimepicker-master/locale/bootstrap-datetimepicker.zh-CN.js"></script>
	<script type="text/javascript" src="common/bs_pagination/jquery.bs_pagination.min.js"></script>
	<script type="text/javascript" src="common/bs_pagination/en.js"></script>
	<script type="text/javascript">
		$(function () {

			pageList(1,10);

			//为日期输入框绑定日历插件
			$("#edit-pickDate").datetimepicker({
				minView:"month",
				language:"zh-CN",
				format:"yyyy-mm-dd",
				autoclose:true,
				todayBtn:true,
				pickerPosition:"bottom-left"
			});

			//为全选的复选框绑定事件，触发全选操作
			$("#selected-all").click(function () {
				$("input[name=dx]").prop("checked",this.checked);

			})


			$("#lostBody").on("click",$("input[name=dx]"),function () {
				$("#selected-all").prop("checked",$("input[name=dx]").length==$("input[name=dx]:checked").length);
			})

			//打开创建模态窗口
			$("#createBtn").click(function () {
				$("#createLost").modal("show")
			})


			//为删除按钮绑定事件
			$("#deleteBtn").click(function () {

				//找到复选框中所有条√的jquery对象
				var $xz=$("input[name=dx]:checked");

				if ($xz.length==0){
					alert("请选择需要删除的帖子");
				}else {

					//url:workbench/activity/delete.do?id=xxx&id=xxx&id=xxx
					//拼接参数
					var param="";

					//将$xz中的每一个dom对象遍历出来，取其value值，就相当于取得了需要删除的记录的id
					for(var i=0;i<$xz.length;i++){
						param+="lostIds="+$($xz[i]).val()

						//如果不是最后一个元素，需要在后面追加一个&符号
						if (i<$xz.length-1){
							param+="&";
						}
					}

					if (confirm("确定删除所选择的数据？")){
						$.ajax({
							url:"${path}/admin/deleteLost.do?"+param,
							type:"post",
							dataType:"json",
							success:function (data) {
								/*
                                    data
                                        {"success":true/false}
                                 */
								if(data.success){
									//删除成功后,刷新用户列表
									pageList($("#lostPage").bs_pagination('getOption','currentPage'),
											$("#lostPage").bs_pagination('getOption','rowsPerPage'));
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
						url:"${path}/admin/queryLostById.do",
						type:"get",
						data:{
							"id":id
						},
						dataType:"json",
						success:function (data) {

							//处理单条lost
							$("#edit-id").val(data.id);
							$("#edit-name").val(data.name);
							$("#edit-lostDate").val(data.lostDate);
							$("#edit-lostPlace").val(data.lostPlace);
							$("#edit-state").val(data.state);

							//所有的值都填写好之后，打开修改操作的模态窗口
							$("#editLost").modal("show");
						}
					})
				}
			})

			//为更新按钮绑定事件
			$("#updateBtn").click(function () {

				$.ajax({
					url:"${path}/admin/updateLost.do",
					type:"post",
					data:{
						"id":$("#edit-id").val(),
						"state":$("#edit-state").val(),
						"name":$("#edit-name").val(),
						"lostPlace":$("#edit-lostPlace").val(),
						"lostDate":$("#edit-lostDate").val(),
					},
					dataType:"json",
					success:function (data) {
						//data:{"success":true/false}
						if (data.success){
							//修改成功后，局部刷新市场活动信息列表
							pageList($("#lostPage").bs_pagination('getOption','currentPage'),
									$("#lostPage").bs_pagination('getOption','rowsPerPage'));
							//修改成功后，关闭修改模态窗口
							$("#editLost").modal("hide");
						}else{
						    alert("修改失败");
						}
					}
				})
			})

		})




		function pageList(pageNo,pageSize){

			//将全选的复选框取消全选
			$("#selected-all").prop("checked",false);


			$.ajax({
				url:"${path}/admin/getLostList.do",
				type:"get",
				data:{
					"pageNo":pageNo,
					"pageSize":pageSize,
					"keyword":$("#keyword").val().trim()
				},
				dataType:"json",
				success:function (data) {
					var html="";
					$.each(data.lostList,function (i,lost) {
						html+='<tr><td><input name="dx" value="'+lost.id+'" type="checkbox"></td>';
						html+='<td>'+lost.user+'</td>';
						html+='<td>'+lost.name+'</td>';
						html+='<td>'+lost.typeCode+'</td>';
						html+='<td>'+lost.lostPlace+'</td>';
						html+='<td>'+lost.lostDate+'</td>';
						html+='<td>'+lost.publishTime+'</td>';
						html+='<td>'+(lost.state==1 ? "已找回":"未找回")+'</td></tr>';
					})

					//计算总页数
					var totalPages=data.total%pageSize==0?data.total/pageSize:parseInt(data.total/pageSize)+1;

					$("#lostBody").html(html)
					//数据处理完毕后，结合分页查询对前端展示分页信息
					$("#lostPage").bs_pagination({
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

<!-- 编辑帖子的模态窗口 -->
<div class="modal fade" id="editLost" role="dialog">
	<div class="modal-dialog" role="document" style="width: 85%;">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">
					<span aria-hidden="true">×</span>
				</button>
				<h4 class="modal-title" id="myModalLabel2">编辑帖子</h4>
			</div>
			<div class="modal-body">

				<form id="lostEditForm" class="form-horizontal" role="form">

					<input type="hidden" id="edit-id"/>

					<div class="form-group">

						<label for="edit-state" class="col-sm-2 control-label">状态<span style="font-size: 15px; color: red;">*</span></label>
						<div class="col-sm-10" style="width: 300px;">
							<select class="form-control" id="edit-state">
								<option value="1">已找回</option>
								<option value="0">未找回</option>
							</select>
						</div>

						<label for="edit-name" class="col-sm-2 control-label">物品名称</label>
						<div class="col-sm-10" style="width: 300px;">
							<input type="text" class="form-control time" id="edit-name">
						</div>

						<label for="edit-lostPlace" class="col-sm-2 control-label">丢失地点</label>
						<div class="col-sm-10" style="width: 300px;">
							<input type="text" class="form-control" id="edit-lostPlace">
						</div>

						<label for="edit-lostDate" class="col-sm-2 control-label">丢失日期</label>
						<div class="col-sm-10" style="width: 300px;">
							<input type="text" class="form-control" id="edit-lostDate" readonly>
						</div>

					</div>

				</form>

			</div>
			<div class="modal-footer">
				<!--
                    data-dismiss="modal":表示关闭模态窗口
                -->
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				<button type="button" class="btn btn-primary" id="updateBtn">保存</button>
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
					<input value="" placeholder="请输入物品名称" id="keyword" class="layui-input search_input" type="text">
				</div>
				<a class="layui-btn search_btn" id="searchBtn" onclick="pageList(1,10)">查询</a>
			<div class="layui-inline">
				<a class="layui-btn audit_btn" id="editBtn">修改帖子</a>
			</div>
			<div class="layui-inline">
				<a class="layui-btn layui-btn-danger batchDel" id="deleteBtn">删除</a>
			</div>
			</div>
		</blockquote>
            
		    <div class="layui-tab-content larry-personal-body clearfix mylog-info-box">
		         <!-- 操作日志 -->
                <div class="layui-tab-item layui-field-box layui-show" >
                     <table class="layui-table table-hover" lay-even="" lay-skin="nob">
                          <thead>
                              <tr>
                                  <th><input type="checkbox" id="selected-all"></th>
                                  <th>用户</th>
                                  <th>物品名称</th>
								  <th>物品类型</th>
                                  <th>丢失地点</th>
                                  <th>丢失时间</th>
                                  <th>发布时间</th>
                                  <th>状态</th>
                              </tr>
                          </thead>
                          <tbody id="lostBody">

                          </tbody>
                     </table>
                     <div class="larry-table-page clearfix">

				          <div id="lostPage" class="page" style="height: 50px;"></div>
			         </div>
			    </div>
		    </div>
		</div>
	</div>
</section>
</body>
</html>