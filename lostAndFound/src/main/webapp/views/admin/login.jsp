<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
	String path=application.getContextPath()+"/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
	<base href="<%=path%>">
	<meta charset="UTF-8">
	<title>后台登录</title>
	<meta name="renderer" content="webkit">	
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">	
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<meta name="apple-mobile-web-app-status-bar-style" content="black">	
	<meta name="apple-mobile-web-app-capable" content="yes">	
	<meta name="format-detection" content="telephone=no">	
	<!-- load css -->
	<link rel="stylesheet" type="text/css" href="static/admin/common/layui/css/layui.css" media="all">
	<link rel="stylesheet" type="text/css" href="static/admin/css/login.css" media="all">
</head>
<body>
<div class="layui-canvs"></div>
<div class="layui-layout layui-layout-login">
	<h1>
		 <strong>校园失物招领后台管理系统</strong>
		 <em>Management System</em>
	</h1>
	<div class="layui-user-icon larry-login">
		 <input type="text" id="loginAct" placeholder="账号" class="login_txtbx"/>
	</div>
	<div class="layui-pwd-icon larry-login">
		 <input type="password" id="loginPwd" placeholder="密码" class="login_txtbx"/>
	</div>
    <div class="layui-val-icon larry-login">
    	<div class="layui-code-box">
    		<input type="text" id="code" name="code" placeholder="验证码" maxlength="4" class="login_txtbx">
            <img src="imgCode/code.do" alt="" class="verifyImg" id="verifyImg" onclick="changeCode(this)">
    	</div>
		<!--更换验证码-->
		<script type="text/javascript">
			function changeCode(img) {
				img.src = "${path}/imgCode/code.do?time=" + new Date().getTime();
			}
		</script>
    </div>
    <div class="layui-submit larry-login">
    	<input type="button" value="立即登陆" class="submit_btn"/>
    </div>
    <div class="layui-login-text">
    	<!--<p>© 2016-2017 Larry 版权所有</p>
        <p>鄂xxxxxx</p>-->
    </div>
</div>
<script type="text/javascript" src="static/admin/common/layui/lay/dest/layui.all.js"></script>
<script type="text/javascript" src="static/admin/js/login.js"></script>
<script type="text/javascript" src="static/admin/jsplug/jparticle.jquery.js"></script>
<script type="text/javascript">
$(function(){

	$(".layui-canvs").jParticle({
		background: "#141414",
		color: "#E6E6E6"
	});
	//登录链接测试，使用时可删除
	$(".submit_btn").click(function(){

		$.ajax({
			url:"admin/login.do",
			data:{
				"loginAct":$("#loginAct").val().trim(),
				"loginPwd":$("#loginPwd").val().trim(),
				"code":$("#code").val().trim()
			},
			dataType:"json",
			type:"post",
			success:function (data) {
				if (data.success){
					location.href="admin/index.html";
				}else{
					alert(data.msg)
				}
			}
		})

	});

});
</script>
</body>
</html>