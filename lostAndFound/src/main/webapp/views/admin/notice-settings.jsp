<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
	String path=application.getContextPath()+"/static/admin/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
	<base href="<%=path%>">
	<meta charset="UTF-8">
	<title>系统公告</title>
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
		$(function () {
			pageList(1,10);

			//全选操作
			$("#allChoose").click(function () {
				$("input[name=dx]").prop("checked",this.checked)
			})

			//为所有单选框绑定事件
			$("#noticeBody").on("click",$("input[name=dx]"),function () {
				$("#allChoose").prop("checked",$("input[name=dx]").length==$("input[name=dx]:checked").length)
			})
		})

		function editNoticeBtn(i){
			var id=$(i).attr("value");
		    //根据id获取notice
			$.get(
			    "${path}/admin/getNoticeById.do",
				{"id":id},
				function (data) {
			    	$("#edit-id").val(data.id);
					$("#edit-title").val(data.title);
					$("#edit-content").val(data.content);
					$("#editNoticeModal").modal("show");
				},
				"json"
			)

		}

		function editNotice(){
			var title=$.trim($("#edit-title").val());
			var content=$.trim($("#edit-content").val());
			if (title=="" || content==""){
				alert("标题和内容不能为空！！！");
				return false;
			}
			$.post(
					"${path}/admin/editNotice.do", {"id":$("#edit-id").val(),"title":title,"content":content},function (data) {
						if (data.success){
							pageList(1,10);
							$("#editNoticeModal").modal("hide");
						}else {
							alert("保存失败！！！")
						}
					},
					"json"
			)
		}

		//修改发布状态
		function updateState(i){
		    var id=$(i).attr("value");
		    $.post(
		    	"${path}/admin/updateNoticeState.do",
					{"id":id},
					function (data) {
						if (data.success){
						    pageList(1,10);
						}else{
						    alert("发布失败");
						}
					}
			)

		}

		function pageList(pageNo,pageSize){

			//将全选的复选框取消全选
			$("#allChoose").prop("checked",false);

			$.ajax({
				url:"${path}/admin/getNoticeList.do",
				type:"get",
				data:{
					"pageNo":pageNo,
					"pageSize":pageSize,
					"keyword":$.trim($("#keyword").val())
				},
				dataType:"json",
				success:function (data) {


					var html="";
					$.each(data.noticeList,function (i,notice) {

						html+='<tr><td><input name="dx" value="'+notice.id+'" lay-skin="primary" lay-filter="choose" type="checkbox"></td>';
						html+='<td>'+notice.title+'</td>';
						html+='<td>'+(notice.state==1?"已发布":"未发布")+'</td>';
						html+='<td>'+notice.createTime+'</td>';
						html+='<td>'+notice.publishTime+'</td>';
						html+='<td><a onclick="editNoticeBtn(this)" value="'+notice.id+'" class="layui-btn layui-btn-mini news_edit"><i class="iconfont icon-edit"></i> 编辑</a>';
						html+='<a onclick="updateState(this)" value="'+notice.id+'" class="layui-btn layui-btn-normal layui-btn-mini news_collect"><i class="layui-icon"></i> 发布</a></td></tr>';

					})

					//计算总页数
					var totalPages=data.total%pageSize==0?data.total/pageSize:parseInt(data.total/pageSize)+1;

					$("#noticeBody").html(html)
					//数据处理完毕后，结合分页查询对前端展示分页信息
					$("#page").bs_pagination({
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

		function addNoticeBtn(){
			$("#createNoticeModal").modal("show")
		}

		function addNotice(){
		    var title=$.trim($("#create-title").val());
		    var content=$.trim($("#create-content").val());
			if (title=="" || content==""){
				alert("标题和内容不能为空！！！");
				return false;
			}
			$.post(
				"${path}/admin/addNotice.do", {"title":title,"content":content},function (data) {
					if (data.success){
						pageList(1,10);
						$("#createNoticeModal").modal("hide");
					}else {
						alert("保存失败！！！")
					}
				},
				"json"
			)
		}

		function deleteNotice(){
			var $notices=$("input[name=dx]:checked");
			if ($notices.length<1){
				alert("请至少选中一条公告进行删除");
				return false;
			}

			/*拼接参数*/
			var param="";
			for(var i=0;i<$notices.length;i++){
			    param+="id="+$($notices[i]).val()
				if (i<$notices.length-1){
					param+="&";
				}
			}

			$.post(
				"${path}/admin/deleteNotice.do?"+param,
				function (data) {
					if (data.success){
					    pageList(1,10);
					}else{
					    alert("删除失败")
					}
				},
				"json"
			)

		}
	</script>
</head>
<body>

<!--新增公告-->
<div class="modal fade" id="createNoticeModal" role="dialog">
	<div class="modal-dialog" role="document" style="width: 85%;">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">
					<span aria-hidden="true">×</span>
				</button>
				<h4 class="modal-title" id="myModalLabel1">添加系统公告</h4>
			</div>
			<div class="modal-body">

				<form id="noticeAddForm" class="form-horizontal" role="form">

					<div class="form-group">
						<label for="create-title" class="col-sm-2 control-label">标题<span style="font-size: 15px; color: red;">*</span></label>
						<div class="col-sm-10" style="width: 300px;">
							<input type="text" class="form-control" id="create-title">
						</div>
					</div>

					<div class="form-group">
						<label for="create-title" class="col-sm-2 control-label">内容<span style="font-size: 15px; color: red;">*</span></label>
						<div class="col-sm-10" style="width: 81%;">
							<textarea class="form-control" rows="3" id="create-content"></textarea>
						</div>
					</div>

				</form>

			</div>
			<div class="modal-footer">
				<!--
                    data-dismiss="modal":表示关闭模态窗口
                -->
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				<button type="button" class="btn btn-primary" onclick="addNotice()" id="saveBtn">保存</button>
			</div>
		</div>
	</div>
</div>

<!--编辑公告-->
<div class="modal fade" id="editNoticeModal" role="dialog">
	<div class="modal-dialog" role="document" style="width: 85%;">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">
					<span aria-hidden="true">×</span>
				</button>
				<h4 class="modal-title" id="myModalLabel2">编辑系统公告</h4>
			</div>
			<div class="modal-body">

				<form id="noticeEditForm" class="form-horizontal" role="form">
					<input type="hidden" id="edit-id"/>
					<div class="form-group">
						<label for="edit-title" class="col-sm-2 control-label">标题<span style="font-size: 15px; color: red;">*</span></label>
						<div class="col-sm-10" style="width: 300px;">
							<input type="text" class="form-control" id="edit-title">
						</div>
					</div>

					<div class="form-group">
						<label for="edit-title" class="col-sm-2 control-label">内容<span style="font-size: 15px; color: red;">*</span></label>
						<div class="col-sm-10" style="width: 81%;">
							<textarea class="form-control" rows="3" id="edit-content"></textarea>
						</div>
					</div>

				</form>

			</div>
			<div class="modal-footer">
				<!--
                    data-dismiss="modal":表示关闭模态窗口
                -->
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				<button type="button" class="btn btn-primary" onclick="editNotice()">保存</button>
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
		</div><div class="layui-inline">
			<a class="layui-btn layui-btn-normal newsAdd_btn" onclick="addNoticeBtn()">添加公告</a>
		</div>
		<div class="layui-inline">
			<a class="layui-btn layui-btn-danger batchDel" onclick="deleteNotice()">删除</a>
		</div>
	</blockquote>
            
		         <!-- 操作日志 -->
                <div class=" news_list">
                    <table class="layui-table">
					<thead>
						<tr>
							<th><input name="qx" lay-skin="primary" lay-filter="allChoose" id="allChoose" type="checkbox">
							</th>
							<th>公告标题</th>
							<th>发布状态</th>
							<th>创建时间</th>
							<th>发布时间</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody id="noticeBody" class="news_content">


					</tbody>
					</table>
                     <div class="larry-table-page clearfix">
				          <div id="page" class="page"></div>
			         </div>
			    </div>

		    </div>
		</div>
	
</section>
</body>
</html>