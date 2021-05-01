<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
</head>
<body>
<section class="layui-larry-box">
	<div class="larry-personal">
		<header class="larry-personal-tit">
			<span>个人信息</span>
		</header><!-- /header -->
		<div class="larry-personal-body clearfix">
			<form class="layui-form col-lg-5">
				<input type="hidden" id="lockState" value="${admin.lockState}">
				<div class="layui-form-item">
					<label class="layui-form-label">账号</label>
					<div class="layui-input-block">  
						<input type="text" name="loginAct" id="loginAct"  autocomplete="off"  class="layui-input layui-disabled" value="${admin.loginAct}" disabled="disabled" >
					</div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label">所属角色</label>
					<div class="layui-input-block">
						<input type="text" name="roleCode"  autocomplete="off" class="layui-input layui-disabled" value="${admin.roleCode}" disabled="disabled">
					</div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label">昵称</label>
					<div class="layui-input-block">
						<input type="text" name="nickname" id="nickname"  autocomplete="off" class="layui-input" value="${admin.nickname}">
					</div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label">手机号码</label>
					<div class="layui-input-block">
						<input type="text" id="phone" name="phone" value="${admin.phone}"  autocomplete="off" class="layui-input" placeholder="输入手机号码">
					</div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label">微信</label>
					<div class="layui-input-block">
						<input type="text" id="weChat" name="weChat" value="${admin.weChat}"  autocomplete="off" class="layui-input">
					</div>
				</div>
				<!--<div class="layui-form-item">
					<label class="layui-form-label">性别</label>
					<div class="layui-input-block">
						<input type="radio" name="sex" value="男" title="男" checked=""><div class="layui-unselect layui-form-radio layui-form-radioed"><i class="layui-anim layui-icon"></i><span>男</span></div>
						<input type="radio" name="sex" value="女" title="女"><div class="layui-unselect layui-form-radio"><i class="layui-anim layui-icon"></i><span>女</span></div>
					</div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label">修改头像</label>
					<div class="layui-input-block">
						<input type="file" name="file" class="layui-upload-file">
					</div>
				</div>-->
				<!--<div class="layui-form-item">
					<label class="layui-form-label">界面语言</label>
					<div class="layui-input-block">
						<select name="interest" lay-filter="aihao">
							<option value=""></option>
							<option value="0" selected="selected">中文</option>
							<option value="1">英文</option>
						</select>
					</div>
				</div>-->

				<!--<div class="layui-form-item layui-form-text">
					<label class="layui-form-label">座右铭</label>
					<div class="layui-input-block">
						<textarea placeholder="既然选择了远方，便只顾风雨兼程；路漫漫其修远兮，吾将上下而求索" value="" class="layui-textarea"></textarea>
					</div>
				</div>-->
				
				<div class="layui-form-item">
					<div class="layui-input-block">
						<button class="layui-btn" type="button" id="update" lay-filter="demo1">提交修改</button>
						<button type="button" id="reset"  class="layui-btn layui-btn-primary">重置</button>
					</div>
				</div>
			</form>
		</div>
	</div>
</section>
<script type="text/javascript" src="js/jquery-1.11.1-min.js"></script>
<script type="text/javascript">

	$(function () {
		//清空输入框
		$("#reset").click(function () {
			$("#nickname").val("");
			$("#phone").val("");
			$("#weChat").val("");
		})

		//更新个人信息
		$("#update").click(function (){
		    $.ajax({
				url:"${path}/admin/updateAdmin.do",
				type:"post",
				data:{
					"loginAct":$("#loginAct").val().trim(),
					"nickname":$("#nickname").val().trim(),
					"phone":$("#phone").val().trim(),
					"weChat":$("#weChat").val().trim(),
					"lockState":$("#lockState").val()
				},
				dataType:"json",
				success:function (data) {
					if (data.msg=="success"){
						window.parent.location.reload();
					}else{
					    alert("更新失败");
					}
				}
			})
		})
	})

</script>
</body>
</html>