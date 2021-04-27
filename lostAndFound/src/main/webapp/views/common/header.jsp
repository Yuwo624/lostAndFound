<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>

	<header class="container100 child_join">
	
	<!-- 大标题开始  start -->
	<div style="max-width: 1200px; margin: 0px auto;  ">
		<!-- 用于存储跳转的url地址 -->
		<input type="hidden" id="srcUrl" name="srcUrl" value="">

		
		<!-- 搜索框 -->
		<aside class="rightbox area area_block" 
		       style="position:relative;top:0px;height:230px;font-size:14px;letter-spacing:0;">

			<div class="sr_hidden" style="width: 100%; height: 150px; position: relative;top: 11%">

				<!-- mobile login 手机端登陆框-->
				<div id="mobilelog" style="overflow: visible;display: none;">
					<form class="form-horizontal" id="MloginForm" name="loginForm" method="post" >

						<div style="width:220px;margin:0 auto;">
							<input type="text" name="loginAct" id="Mcard_num"
								   style="width: 180px; height: 30%;float:left;" placeholder="账号" required="required">
							<span id="Mcn" style="width: 10px;"></span>
						</div>
						<div class="gap5"></div>
						<div style="width:220px;margin:0 auto;">
							<input type="password" name="loginPwd" id="Mcard_pass"
								   style="width: 180px; height: 30%;float:left;" placeholder="密码 " required="required">
							<span id="Mcp" style="width: 10px;"></span>
						</div>
						<div class="gap5"></div>
						<div style="width:220px;margin:0 auto;">
							<input type="text" name="code" id="Mcard_code"
								   style="width: 80px; height: 30%;float:left;" placeholder="验证码 " required="required">
							<img id="Mimgcode" src="${path}/imgCode/code.do" onclick="changeCode(this);" alt="看不清，单击更换" style="width:100px;height:30px;float:left;cursor:pointer;">
							<span id="Mcd" style="width: 10px;"></span>
						</div>
						<div class="gap5"></div>
						<input type="button" name="sub" id="MloginSub" value="登录"
							   class="btn btn-danger btn-block" style="width: 60px; *background: #f2000d;">
					</form>
				</div>
			</div>
			<!-- 判断用户是否登陆，手机端 -->
			<c:if test="${!empty user}">
				<div class="moblie_show" style="width:100%; height: 60px;margin:0 auto;padding:0px;">
					<div class="gap20"></div>
					<ul class="inline">
						<!-- http://LostAndFound/index.html#myModal -->
						<li style="margin-right:5px;padding:0px;">
							<a href="${path}/user/user-center.html" role="button"
							   class="btn btn-mini btn-success" data-toggle="modal" title="${user.loginAct}"
							   style="_float: right; _margin-top: 20px;" oncontextmenu="return false;" ondragstart="return false;">
								${(empty user.nickname) ? user.loginAct : user.nickname}
							</a>
						</li>
						<li style="margin-right:5px;padding:0px;">
							<a href="${path}/find/find-publish.html" style="_float: right; _margin-top: 20px;"
							   class="btn btn-mini btn-danger" title="捡到东西猛戳我" oncontextmenu="return false;" ondragstart="return false;">
								捡东西了
							</a>
						</li>
						<li style="margin-right:5px;padding:0px;">
							<a href="${path}/lost/lost-publish.html" style="_float: right; _margin-top: 20px;"
							   class="btn btn-mini btn-danger" title="丢失东西猛戳我" oncontextmenu="return false;" ondragstart="return false;">
								丢东西了
							</a>
						</li>
						<li style="padding:0px;">
							<a class="btn btn-mini btn-success" onclick="return logout();" href="${path}/user/logout.do" style="_float: right;" oncontextmenu="return false;" ondragstart="return false;">
								注销
							</a>
						</li>
					</ul>
				</div>
			</c:if>

			<!-- 判断用户是否登录-->
		<div class="sr_only" style="width:100%;height:80%;">
			<h3>
				校园失物招领平台
			</h3>
			<br>
			<ul class="inline">
				<c:choose>
				<c:when test="${empty user}">
					<li>
						<a href="javascript:void(0)" id="loginClick" role="button"
						   class="btn btn-info" data-toggle="modal" title="立即登录"
						   oncontextmenu="return false;" ondragstart="return false;">
							立即登录
						</a>
					</li>
					<li>
						<a href="javascript:void(0)" id="registerClick" role="button"
						   class="btn btn-info" data-toggle="modal" title="立即注册"
						   oncontextmenu="return false;" ondragstart="return false;">
							立即注册
						</a>
					</li>
				</c:when>			
				<c:otherwise>
				<li>
					<a href="${path}/find/find-publish.html" style="_float: right; _margin-top: 20px;" 
						class="btn btn-info" title="捡到东西点击此处" oncontextmenu="return false;" ondragstart="return false;">
						发布招领信息
					</a>
				</li>
				<li>
					<a href="${path}/lost/lost-publish.html" style="_float: right; _margin-top: 20px;"
						class="btn btn-info" title="丢失东西点击此处" oncontextmenu="return false;" ondragstart="return false;">
						发布寻物信息
					</a>
				</li>
				<li>
					<a href="${path}/user/user-center.html" role="button"
						class="btn btn-info" data-toggle="modal" title="${user.loginAct}">
						个人中心
					</a>
				</li>
				<li>
					<a class="btn btn-info" onclick="return logout();"
						href="${path}/user/logout.do" style="_float: right;" oncontextmenu="return false;" ondragstart="return false;">
						注销
					</a>
				</li>
				</c:otherwise>
				</c:choose>
			</ul>
		</div>

		<!-- Modal start-->
		<div id="myModalLogin" class="modal hide fade"
			style="background: WhiteSmoke; text-align: left; padding: 10px; font-size: 16px;"
			tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">

			<div class="modal-header" align="center">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
				<h4 id="myModalLabel"></h4>
				<h5>登录</h5>

			</div>

			<div class="modal-body">
				<form class="form-horizontal" id="loginForm" name="loginForm">

					<div class="control-group">
						<label class="control-label" for="loginAct">账号</label>
						<div class="controls">
							<input type="text"  id="loginAct"
								style="height: 5%; margin-top: 3px; margin-right: 3px;"
								required="required"><span id="Lcn"></span>
							<!-- chrom ie11 input bug 5% height fixed it -->
						</div>
					</div>

					<div class="control-group">
						<label class="control-label" for="loginPwd">密码</label>
						<div class="controls">
							<input type="password"  id="loginPwd"
								style="height: 5%; margin-top: 3px; margin-right: 3px;"
								required="required"><span id="Lcp"></span>
						</div>
					</div>

					<div class="control-group">
						<label class="control-label" for="code">验证码</label>
						<div class="controls">
							<input type="text" name="code" id="code"
								style="height: 5%; margin-top: 3px; margin-right: 3px;width:100px;"
								required="required">
								<img id="imgCode" src="${path}/imgCode/code.do" onclick="changeCode(this);" title="看不清，单击更换" alt="看不清，单击更换" style="width:80px;height:30px;cursor:pointer;">
								<span id="Lcd"></span>
						</div>
					</div>

					<div class="control-group">
						<div class="controls">
							<input type="button" name="sub" id="loginSub" onclick="login()" value="登录"
								class="btn btn-primary btn-block" style="margin-left: -90px; height: 30px; *background: #f2000d;">
						</div>
					</div>

				</form>
			</div>

			<div class="modal-footer">
				<p class="pull-right">校园失物招领平台</p>
				<div class="accordion" id="accordion2">
					<div class="accordion-group" style="border: none;">
						<div class="accordion-heading">
							<a class="accordion-toggle" data-toggle="collapse"
								data-parent="#accordion2" href="${path}/index.html#collapseOne">
								<p style="font-size: 12px; margin-top: -3px; *margin-top: -1px; float: left; color: green;">
								登录帮助
								</p>
							</a>
						</div>
						<div id="collapseOne" class="accordion-body collapse" style="border:none;font-size:12px;width:100%;max-height:80px;">
               				<div class="accordion-inner alert alert-error" style="float:left;text-align:left;height:60px;">
								* 忘记密码请即时联系平台管理员。
							</div>
						</div>
					</div>
				</div>
			</div>

		</div>
		<!-- Modal end-->
		
		<!-- Modal start-->
		<div id="myModalRegister" class="modal hide fade"
			style="background: WhiteSmoke; text-align: left; padding: 10px; font-size: 16px;"
			tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">

			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
				<h4 id="myModalLabel1"></h4>
				<center><h5>注册</h5></center>
				
			</div>

			<div class="modal-body">
				<form class="form-horizontal" id="registerForm" name="loginForm">

					<div class="control-group">
						<label class="control-label" for="registerAct">账号</label>
						<div class="controls">
							<input type="text"  id="registerAct"
								style="height: 5%; margin-top: 3px; margin-right: 3px;"
								required="required"><span style="color: red" id="Lcn1"></span>
							<!-- chrom ie11 input bug 5% height fixed it -->
						</div>
					</div>

					<div class="control-group">
						<label class="control-label" for="registerPwd">密码</label>
						<div class="controls">
							<input type="password"  id="registerPwd"
								style="height: 5%; margin-top: 3px; margin-right: 3px;"
								required="required"><span  style="color: red" id="Lcp1"></span>
						</div>
					</div>
					
					<div class="control-group">
						<label class="control-label" for="registerNickname">昵称</label>
						<div class="controls">
							<input type="text"  id="registerNickname"
								style="height: 5%; margin-top: 3px; margin-right: 3px;"
								required="required"><span id="Lcu"></span>
							<!-- chrom ie11 input bug 5% height fixed it -->
						</div>
					</div>

					<div class="control-group">
						<label class="control-label" for="registerWeChat">微信</label>
						<div class="controls">
							<input type="text" id="registerWeChat"
								   style="height: 5%; margin-top: 3px; margin-right: 3px;"
								   required="required"><span id="Lcpw"></span>
						</div>
					</div>

					<div class="control-group">
						<label class="control-label" for="registerPhone">联系电话</label>
						<div class="controls">
							<input type="text"  id="registerPhone"
								style="height: 5%; margin-top: 3px; margin-right: 3px;"
								required="required"><span style="color: red" id="Lcph"></span>
						</div>
					</div>

					<div class="control-group">
						<label class="control-label" for="registerCode">验证码</label>
						<div class="controls">
							<input type="text" name="registerCode" id="registerCode"
								style="height: 5%; margin-top: 3px; margin-right: 3px;width:100px;"
								required="required">
								<img id="registerImgCode" src="${path}/imgCode/code.do" onclick="changeCode(this);" title="看不清，单击更换" alt="看不清，单击更换" style="width:80px;height:30px;cursor:pointer;">
								<span id="codeSpan"></span>
						</div>
					</div>

					<div class="control-group">
						<div class="controls">
							<input type="button" name="sub" id="registerBtn" onclick="register()" value="注册"
								class="btn btn-primary btn-block" style="margin-left: -90px; height: 30px; *background: #f2000d;">
						</div>
					</div>

				</form>
			</div>

			<div class="modal-footer">
				<p class="pull-right">校园失物招领平台</p>
				<div class="accordion" id="accordion3">
					<div class="accordion-group" style="border: none;">
						<div class="accordion-heading">
							<a class="accordion-toggle" data-toggle="collapse"
								data-parent="#accordion2" href="${path}/index.html#collapseTwo">
								<p style="font-size: 12px; margin-top: -3px; *margin-top: -1px; float: left; color: green;">
								注册提醒
								</p>
							</a>
						</div>
						<div id="collapseTwo" class="accordion-body collapse" style="border:none;font-size:12px;width:100%;max-height:80px;">
               				<div class="accordion-inner alert alert-error" style="float:left;text-align:left;height:60px;">
								*账号密码联系方式不能为空。<br>
								* 账号长度为8-16位。<br>
								* 密码长度8-16位。<br>
								* 联系方式请填手机号码。
							</div>
						</div>
					</div>
				</div>
			</div>

		</div>
		<!-- Modal end-->

		<div id="searchdiv" style="width: 100%; height: 30px;">
			<!-- 站内搜索 start -->
			<form name="searchForm" action="${path}/search-list.html" method="get"
				class="form-search" >
				<input type="text" id="search" name="keyword" value="${keyword}" list="words" class="input-medium search-query"
					style="width: 200px; font-size: 12px; overflow: hidden; height: 25%;"
					placeholder="搜搜看~双击查看小伙伴们的搜索热词" x-webkit-speech="" x-webkit-grammar="bUIltin:search">
				<datalist id="words">
					<option value="校园卡"></option>
					<option value="饭卡"></option>
					<option value="钥匙"></option>
					<option value="手机"></option>
					<option value="钱包"></option>
					<option value="..."></option>
				</datalist>
				<button type="submit" class="btn btn-info" title="不搜你不知道，一搜说不定就有">搜索</button>
			</form>
			<!-- 站内搜索 end -->
		</div>
		</aside>
		<!-- header rightbox end -->

	</div>
	<!-- big box end --> 
	</header>
	
	<script type="text/javascript">


		$(function (){
			//打开登录模态窗口前请求输入框中的内容
		    $("#loginClick").click(function () {
				$("#loginAct").val("");
				$("#loginPwd").val("");
				$("#code").val("");
				$("#myModalLogin").modal("show");
			})

			$("#registerClick").click(function () {
				$("#registerPwd").val("");
				$("#registerAct").val("");
				$("#registerCode").val("");
				$("#registerNickname").val("");
				$("#registerPhone").val("");
				$("#registerWeChat").val("");
				$("#myModalRegister").modal("show");
			})

			//手机端登录
			$("#MloginSub").click(function () {
				$.ajax({
					url:"/lostAndFound/login.do",
					type:"post",
					data:{
						"loginAct":$("#Mcard_num").val(),
						"loginPwd":$("#Mcard_pass").val(),
						"code":$("#Mcard_code").val()
					},
					dataType: "json",
					success:function (data) {
						if (data.success){
							alert(data.user.nickname+"，欢迎你进入校园失物招领平台！");
							$("#myModalLogin").modal("hide");
							/*window.location.href="/lostAndFound/index.html";*/
							location.reload(true);
						}else{
							alert(data.msg);
						}
					}
				})
			})
		})

		// 移动终端登录获得焦点
		function mobileLoginFocus(event){
			alert("请您先登录啊!");
			scroll(0,0);
			$('#Mcard_num').focus();
            event.preventDefault();// 如果<a>定义了 target="_blank" 需要这句来阻止打开新页面 
		}
		
		// PC端网页登录获得焦点显示
		function loginFocus(event){
			event.preventDefault();// 如果<a>定义了 target="_blank" 需要这句来阻止打开新页面      
            $('#myModalLogin').modal({
              keyboard: true
            });
		}
	
		// 搜索防空
		function checkpost(){
		     if(searchForm.search.value==""){
		      alert("请输入搜索内容！");
		      searchForm.search.focus();
		      return false;
		    }
		}
		 
		//更换验证码
		function changeCode(img) {
			img.src = "${path}/imgCode/code.do?time=" + new Date().getTime();
		}
		
		//注销
		function logout(){
		    return confirm("您确定要注销登录吗?");
		}

		/*注册*/
		function register() {

			var registerPwd=$("#registerPwd").val();
			var registerAct=$("#registerAct").val();
			var registerCode=$("#registerCode").val();
			var registerNickname=$("#registerNickname").val();
			var registerPhone=$("#registerPhone").val();
			var registerWeChat=$("#registerWeChat").val();

			if (registerAct.trim()=="" || registerAct.trim().length<8 || registerAct.trim().length>16){
				$("#Lcn1").html("账号长度8-16位");
				return false;
			}

			if (registerPwd.trim()=="" || registerPwd.trim().length<8 || registerPwd.trim().length>16){
				$("#Lcp1").html("密码长度8-16位");
				return false;
			}


			if (registerPhone.trim()=="" || registerPhone.trim().length!=11){
				$("#Lcph").html("电话号码长度11位");
				return false;
			}

			$.ajax({
				url:"/lostAndFound/register.do",
				type:"post",
				data:{
					"loginAct":registerAct,
					"loginPwd":registerPwd,
					"nickname":registerNickname,
					"phone":registerPhone,
					"weChat":registerWeChat,
					"code":registerCode
				},
				dataType:"json",
				success:function (data) {
					if (data.success){
						window.location.href="/lostAndFound/index.html";
					}else{
						alert(data.msg);
					}
				}
			})
		}

		/*登录验证*/
		function login(){
			$.ajax({
				url:"/lostAndFound/login.do",
				type:"post",
				data:{
					"loginAct":$("#loginAct").val(),
					"loginPwd":$("#loginPwd").val(),
					"code":$("#code").val()
				},
				dataType: "json",
				success:function (data) {
					if (data.success){
						alert(data.user.nickname+"，欢迎你进入校园失物招领平台！");
						$("#myModalLogin").modal("hide");
						/*window.location.href="/lostAndFound/index.html";*/
						location.reload(true);
					}else{
						alert(data.msg);
					}
				}
			})

		}
	</script>
