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
			<span>修改密码</span>
		</header><!-- /header -->
		<div class="larry-personal-body clearfix changepwd">
			<div class="layui-form col-lg-4">
			 	<div class="layui-form-item">
					<label class="layui-form-label">账号</label>
					<div class="layui-input-block">  
					  	<input type="text" name="title" id="loginAct"  autocomplete="off"  class="layui-input layui-disabled" value="${admin.loginAct}" disabled="disabled" >
					</div>
				</div>

				<div class="layui-form-item">
					<label class="layui-form-label">旧密码</label>
					<div class="layui-input-block">
						<input type="password" id="oldPassword" name="title"  autocomplete="off"  class="layui-input" value="" placeholder="请输入新密码">
					</div>
				</div>

				<div class="layui-form-item">
					<label class="layui-form-label">新密码</label>
					<div class="layui-input-block">  
					  	<input type="password" id="newPassword" name="title"  autocomplete="off"  class="layui-input" value="" placeholder="请输入新密码">
					</div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label">确认密码</label>
					<div class="layui-input-block">  
					  	<input type="password" id="confirmPassword" name="title"  autocomplete="off"  class="layui-input" value="" placeholder="请输入确认新密码">
					</div>
				</div>
				<div class="layui-form-item change-submit">
					<div class="layui-input-block">
						<button class="layui-btn" id="modifyPwd"  lay-filter="demo1">提交修改</button>
						<button type="button" id="reset" class="layui-btn layui-btn-primary">重置</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>
<script type="text/javascript" src="js/jquery-1.11.1-min.js"></script>
<script type="text/javascript">
	$(function () {

		//清空输入框
		$("#reset").click(function () {
			$("#oldPassword").val("");
			$("#newPassword").val("");
			$("#confirmPassword").val("");
		})

		/*修改密码，ajax请求*/
		$("#modifyPwd").click(function () {

			if ($("#newPassword").val().trim().length<8 || $("#confirmPassword").val().trim().length<8 ||
					$("#newPassword").val().trim().length>16 || $("#confirmPassword").val().trim().length>16
			){
				alert("密码长度不能小于8大于16!!!");
				return false;
			}

			if ($("#newPassword").val().trim()=="" || $("#confirmPassword").val().trim()=="" || $("#oldPassword").val().trim()==""){
				alert("密码输入不能为空！！！");
				return false;
			}

			if ($("#newPassword").val().trim()!=$("#confirmPassword").val().trim()){
				alert("两次密码输入不一致！！！");
				return false;
			}

			$.post(
				"${path}/admin/updatePwd.do",
				{
					"loginAct":$("#loginAct").val().trim(),
					"loginPwd":$("#newPassword").val().trim(),
					"oldPassword":$("#oldPassword").val().trim()
				},
				function (data) {
					if (data.success){
					    alert("修改成功，请重新登录！！！");
					    window.parent.location.href="${path}"+"/admin/login.html";
					}else{
						alert(data.msg);
					}
				},
				"json"
			)
		})
	})
</script>
</body>
</html>