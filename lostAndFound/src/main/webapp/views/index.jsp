<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="common/global.jsp"%>
<%--<%
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
%>--%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<%--<base href="<%=basePath%>" />--%>
<title>校园失物招领平台</title>
<%@include file="common/base-meta.jsp"%>
<meta name="viewport" content="width=device-width, initial-scale=0.8, minimum-scale=0.8, maximum-scale=1.0, user-scalable=no">
<%@include file="common/base-css-js.jsp"%>
</head>
<!-- rgb(238, 238, 238) -->
<body style="background: rgb(255, 255, 255); overflow-x: hidden; -webkit-user-select: none;">
	
	<!-- header start -->
	<div id="index-header" style="width: 100%; margin: 0 auto;">
		<%@include file="common/header.jsp"%>
	</div>
	<!-- header end -->

	<!-- nav start -->
	<nav>
	<div id="navbardiv" class="navbar" style="box-shadow: 1px 1px 7px #999; width: 100%; overflow: hidden; z-index: 99;">
		<div class="navbar-inner" style="width: 100%; max-width: 1680px; margin: 0px auto; padding: 0;">
			<ul class="nav" style="height: 25px; width: 78%; float: none; margin: 0 auto;">
				<li id="index" class="active">
					<a href="index.html">
						<i class="icon-home"></i> 首页
					</a>
				</li>
				<li><a href="${path}/find/find-list.html" title="招领信息汇总">
					<i class="icon-picture"></i> 招领信息 </a></li>
				<li><a href="${path}/lost/lost-list.html" title="寻物信息汇总">
					<i class="icon-zoom-in"></i> 寻物信息 </a></li>
				<li><a href="${path}/leave-thanks.html" title="留言感谢墙">
					<i class="icon-star-empty"></i> 留言感谢墙 </a></li>
			</ul>

		</div>
	</div>
	</nav>
	<!-- /.nav end -->

	<div class="gap50"></div>

	<!-- main start -->
	<div id="main" class="container960 child_join" style="_width: 960px;">
		<!-- main left start -->
		<section class="left area area_block border1">
		
		<!-- 帖子 start -->
		<div class="news area area_area_inline">
			<div class="tabbable">
				<ul class="nav nav-tabs" style="font-weight: bold; font-family: 微软雅黑; font-size: 16px; background: white;">
					<li class="active">
						<a id="shia"
							onclick="this.style.backgroundColor='whiteSmoke';xuna.style.backgroundColor='white';"
							onmouseover="this.style.backgroundColor='whiteSmoke';xuna.style.backgroundColor='white';"
							style="background: whiteSmoke;" href="${path}/index.html#find"
							data-toggle="tab">
							<i class="icon-picture"></i>
							<h2 style="font-size: 16px; display: inline; line-height: 16px;">最新招领信息</h2>
						</a>
					</li>
					<li>
						<a id="xuna"
							onclick="this.style.backgroundColor='whiteSmoke';shia.style.backgroundColor='white';"
							onmouseover="this.style.backgroundColor='whiteSmoke';shia.style.backgroundColor='white';"
							href="${path}/index.html#lost" data-toggle="tab">
							<i class="icon-zoom-in"></i>
							<h2 style="font-size: 16px; display: inline; line-height: 16px;">最新寻物信息</h2>
						</a>
					</li>
				</ul>

				<div class="tab-content" style="font-size: 14px; text-align: left; overflow: hidden;">
					<div class="tab-pane active" id="find">
						<ul id="shiinfo" style="list-style: none; height: auto; text-align: left;">
							<c:forEach items="${pickThingsList}" var="pickThing">
								<li class="clearfix">
									<a href="${path}/find/find-details.html?id=${pickThing.id}">
									<i class="icon-volume-up"></i>
									<font color="#ee5f5b">${pickThing.name}</font> 被捡到了，快来领取吧
										<c:if test="${pickThing.state == 1}">
											<p style="display: inline; color: red; font-weight: bold; font-size: 14px; font-style: italic; border-radius: 5px;">
												已认领
											</p>
										</c:if>
									</a>
									<p class="area area_inline time" style="text-align: right; float: right; *margin-top: -33px;">${pickThing.publishTime}</p>
								</li>
							</c:forEach>

							<li style="border: none;">
								<a href="${path}/find/find-list.html"
									style="float: right; min-width: 40px; color: blue; margin: 5px;"
									title="更多招领信息"> 更多... </a>
							</li>

						</ul>
					</div>

					<div class="tab-pane" id="lost">
						<ul id="xuninfo" style="list-style: none;">
							<c:forEach items="${lostThingsList}" var="lostThing">
								<li class="clearfix">
								<a href="${path}/lost/lost-details.html?id=${lostThing.id}">
								<i class="icon-volume-up"></i>
								<font color="#ee5f5b">${lostThing.name}</font> 丢失了，捡到的同学速看本贴
									<c:if test="${lostThing.state == 1}">
										<p style="display: inline; color: red; font-weight: bold; font-size: 14px; font-style: italic; border-radius: 5px;">
											已找回
										</p>
									</c:if>
								</a>
								<p class="area area_inline" style="text-align: right; float: right; *margin-top: -35px;">${lostThing.publishTime}</p>
								</li>
							</c:forEach>
							<li style="border: none;">
							<a href="${path}/lost/lost-list.html"
							   style="float: right; min-width: 40px; color:blue; margin: 5px;"
							   title="更多寻物信息"> 更多... 
							</a>
							</li>
						</ul>
					</div>
				</div>
			</div>
		</div>
		<!-- /.帖子 end --> 
		</section>

		<aside class="right area area_block">

		<div class="up area area_block border1">
			<h2 class="text-center"
				style="font-size: 16px; font-weight: bold; line-height: 19px;">
				公告栏
			</h2>

			<pre title="${notice.title}" style="margin-top: -5px; height: 150px; padding: -15px; text-align: left;">${notice.content}</pre>

			<div class="shi area area_block" style="*width: 45%; float: left;">
				<div class="gap10"></div>
				<a href="javascript:void(0);" id="findLogin" target="_self"
					style="width: 45%; cursor: default;" class="btn btn-primary center"
					title="捡到东西点击这里">发帖招领</a>
				<div class="gap10"></div>
			</div>

			<div class="xun area area_block">
				<div class="gap10"></div>
				<a href="javascript:void(0);" id="lostLogin" target="_self"
					style="width: 45%; cursor: default;" class="btn btn-primary center"
					title="丢了东西了点击这里">发帖寻物</a>
				<div class="gap10"></div>
			</div>

		</div>
		<!-- /.发帖 end -->

		<div class="bottom area area_block" style="margin-top: 10px">
			<h2 class="text-center" style="margin: 0 0 20px 0;">
				<p class="btn btn-primary btn-block" style="margin: 0 auto;">校园新闻</p>
			</h2>
			<table class="table table-hover table-condensed" style="font-size: 12px;">
				<tbody>
				<tr>
					<td style="background: #eed; font-family: 微软雅黑;">
						<a href="https://www.gdou.edu.cn/info/1091/35101.htm" title="学校党委党史学习教育领导小组召开会议   推进党史学习教育走深走实">学校党委党史学习教育领导小组召开会议</a>&nbsp;&nbsp;<i>2021-04-12</i>
					</td>
				</tr>
				<tr>
					<td style="background: #eed; font-family: 微软雅黑;">
						<a href="https://www.gdou.edu.cn/info/1091/34195.htm" title="省委第十二巡视组巡视广东海洋大学党委工作动员会召开">省委第十二巡视组巡视广东海洋大学党委工作动员会召开</a>&nbsp;&nbsp;<i>2021-03-12</i>
					</td>
				</tr>
				<tr>
					<td style="background: #eed; font-family: 微软雅黑;">
						<a href="https://www.gdou.edu.cn/info/1091/35556.htm" title="学校召开党史学习教育专题宣讲动员会暨集体备课会">学校召开党史学习教育专题宣讲动员会暨集体备课会</a>&nbsp;&nbsp;<i>2021-04-26</i>
					</td>
				</tr>
				<tr>
					<td style="background: #eed; font-family: 微软雅黑;">
						<a href="https://www.gdou.edu.cn/info/1091/35451.htm" title="学校党委党史学习教育领导小组召开会议 推进党史学习教育相关工作">学校党委党史学习教育领导小组召开会议 推进党史学习教育...</a>&nbsp;&nbsp;<i>2021-04-23</i>
					</td>
				</tr>
				<tr>
					<td style="background: #eed; font-family: 微软雅黑;">
						<a href="https://www.gdou.edu.cn/info/1091/35415.htm" title="省教育厅二级巡视员蔡文雅一行到阳江校区调研">省教育厅二级巡视员蔡文雅一行到阳江校区调研</a>&nbsp;&nbsp;<i>2021-04-22</i>
					</td>
				</tr>

				</tbody>
			</table>
			<p class="text-center">
				<a href="${path}/leave-thanks.html" target="_blank"> 
					平台<font style="color: red; font-weight: bold;">留言感谢墙</font>已启动，欢迎使用
				</a>
			</p>
		</div>
		</aside>
	</div>

	<hr class="hr">
	
	<!-- 去顶部 -->
	<div id="go-top" class="sr_hidden pull-right" style="display: none; position: fixed; bottom: 150px; right: 5px; z-index: 99;">
		<img src="${path}/static/images/goTop.gif" oncontextmenu="return false;"
			ondargstart="return false;" height="42" width="40" alt="回顶部">
		</a>
	</div>

	<footer class="container100" style="padding:0px;">
	<div style="width: 98%; margin: 10px auto; text-align: center;"> 
		<%@include file="common/footer.jsp"%>
	</div>
	</footer>
	
	<script> 
		$('.nav-tabs a').mouseover(function(e) { 
			  e.preventDefault();
			  $(this).tab('show');
		});
		//控制 点哪登陆 登录后就去哪
		 $("document").ready(function(){
			 $("#findLogin").click(function(event){
			    	$("#srcUrl").val("${path}/find/find-publish.html");	
			    	if(isLogin){
			    		window.location.href = $("#srcUrl").val();
			    		return;
			    	}
			    	//小屏幕未登录不可发帖
					if(isSmallScreen())
			    		mobileLoginFocus(event);
					else 
		                loginFocus(event);
			  });
			  
			  $("#lostLogin").click(function(event){
			    	$("#srcUrl").val("${path}/lost/lost-publish.html");	
			    	if(isLogin){
			    		window.location.href = $("#srcUrl").val();
			    		return;
			    	}
			    	
			    	//小屏幕未登录不可发帖
					if(isSmallScreen())
			    		mobileLoginFocus(event);
					else 
		                loginFocus(event);
				});
		 });
		//当滚动条的位置处于距顶部100像素以下时，跳转链接出现，否则消失
		$(function () {
			$(window).scroll(function () {
				if ($(window).scrollTop() > 100) {
					$("#go-top").fadeIn(1500);
				} else {
					$("#go-top").fadeOut(1500);
				}
			});

			//当点击跳转链接后，回到页面顶部位置
			$("#go-top").click(function(){
				if ($('html').scrollTop()) {
					$('html').animate({ scrollTop: 0 }, 100);//动画效果
					return false;
				}
				$('body').animate({ scrollTop: 0 }, 100);
				return false;
			});

		}); 
	</script>
</body>
</html>