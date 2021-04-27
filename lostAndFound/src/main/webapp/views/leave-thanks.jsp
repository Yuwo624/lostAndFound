<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="common/global.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>校园失物招领平台 留言感谢墙</title>
	<%@include file="common/base-meta.jsp"%>
	<meta name="viewport" content="width=device-width, initial-scale=0.5, maximum-scale=1.0, user-scalable=no"/>
	<%@include file="common/base-css-js.jsp"%>
	<link rel="stylesheet" href="${path}/static/css/leave-thanks.css">
	<link rel="stylesheet" href="${path}/static/css/chat/chat.css">
	<script type="text/javascript" src="${path}/static/js/leave-thanks.js"></script>
  <style>
     /* Let's get this party started */
	::-webkit-scrollbar {
	    width: 12px;
	}
	/* Track */
	::-webkit-scrollbar-track {
	    -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,0.3); 
	    -webkit-border-radius: 10px;
	    border-radius: 10px;
	}
	/* Handle */
	::-webkit-scrollbar-thumb {
	    -webkit-border-radius: 10px;
	    border-radius: 10px;
	    background: #99CCFF; 
	    -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,0.5); 
	}
	::-webkit-scrollbar-thumb:window-inactive {
		background: rgba(255,0,0,0.4); 
	}
	.clear {
		clear:both; height: 0; line-height: 0; font-size: 0
	}
	/* min-width & max-width 兼容移动设备 */
	@media screen and (min-width: 220px) and (max-width: 960px) { 
		#navbardiv {
	 		position: fixed;
			right: 0;
			left: 0;
			z-index: 1030;
			margin-bottom: 0;
			top: 0px;
		} 
		#container{
			position:relative;
			top:50px;
		}
		#leave-thanks-list{
			width:95%;
		}
		.p_info {
			width:98%;
		}
		.thanks{
			width:41%;
		}
	}	
	/* min-width兼容移动设备 */
	@media screen and (min-width: 960px) { 		
		#leave-thanks-list {
			max-width:75%;
		}
		.p_info {
			width:80%;
		}		
	}	
  </style>    
  </head>
  <body style="background: rgb(255, 255, 255); overflow-x: hidden; -webkit-user-select: none; min-height: 1150px;"> 
   <div id="pagewrapper" style="margin:0 auto;height:auto;overflow:visible;min-height:800px;*height:1000px;border: 1px solid white;">
    
    <!--------------页眉开始------------------>	 
    <div class="container-fluid" style="width:100%;margin:0 auto;padding:0;">
    
	<!-- header start-->
	<div id="leave-thanks-header" style="width:100%;margin:0 auto;">
		<%@include file="common/header.jsp"%>
	</div>
	<!-- header end-->	
		
	<!-- 导航条 start -->
	<%@include file="common/navigator.jsp"%>
    <script>
    	activeNav("leave-thanks");
    </script>
	<!-- 导航条 end -->
	
	</div>
	<!--------------页眉结束------------------>
					  
	<!-------------主体部分开始--------------->
	<div id="container" style="max-width:100%;min-height:800px;">
		<p class="p_info" style="margin:0 auto;height:15px;font-size:14px;color:black;">
	     	<span style="float:left;">现在的位置 <a href="${path}/index.html" target="_self" style="color:#666;">主页</a>-&gt;留言感谢墙</span>
		</p>
		
	 <div id="leave-thanks-list" style="margin:0 auto;height:auto;min-height:800px;border-bottom:1px solid #aaa;">

		
		<!-- 留言感谢部分 -->
		<div style="width:100%;min-height:800px;margin-top:5px;" >
			<div id="leave-thanks">
				<div class="clear"></div>
		 		<div id="main" style="width: 100%;text-align:center;">
		 		<a href="javascript:void(0);" 
		 		   id="want-to-thanks"
		 		   class="btn btn-info" title="我要感谢"
				   style="width:130px;margin: 20px auto;">
						<b style="font-size:20px;height:30px;line-height:30px;">我要留言感谢</b>
				</a>
				
		 		<div id="thanks" style="margin:0px;width:100%;min-height:800px;float: left;">
		 		</div>
		 		
		 		<div class="clear"></div>
		 		
		 		<div id="thanks-more" style="margin:15px auto;"></div>
		 		
		 		</div>
		 		
		 		<div id="send-form">
					<p class="title">
						<span>写下你的感谢语</span>
						<a href="javascript:void(0);" id="close" onclick="closeThanksView();"></a>
					</p>
					<form id="thanks-info" name='thanks-info'>
						<p>
							<label for="title">标题：</label>
							<input type="hidden" name="user" value="${user.loginAct}"/>
							<input type="text" name="title" id="title" maxlength="15" style="width:220px;"/>
							<span style="color: red;">*必填</span>
						</p>
						<p>
							<label for="content">想说的话：<span id='font-num' style="color: blue;"></span></label>
							<textarea name="content" id='content' onfocus="valueListenerLimiter(this, 50);" onblur="labelHidden(this);"></textarea>
							<span style="color: red;">*必填</span>
						</p>

						<p style="text-align:center;">
							<input type="submit" name="saveThanks" id="saveThanks" value="提交"
								   class="btn btn-info"
								   style="height: 30px;line-height:20px;font-size:15px;" />
						</p>
					</form>
				</div>
		 		<div class="clear"></div>
			</div>
	 	</div>
	 </div>
    </div>
	<!-------------主体部分结束--------------->
	
	<!-- go to top start-->
	<div id="go-top" class="sr_hidden pull-right" style="display:none;position:fixed;bottom:150px;right:5px;z-index:99;">
		<a id="goTop" href="${path}/leave-thanks.html#logo">
			<img src="${path}/static/images/goTop.gif" oncontextmenu="return false;" ondargstart="return false;" height="42" width="46" alt="回顶部" >
		</a>
	</div> 
	<!-- /.go to top end --> 
	                        
    <!----------------页脚开始---------------->	
	<div class="container-fluid footer" style="max-width:100%;height:120px;">
	   <div style="width:100%;margin:10px auto;text-align: center;"> 
	     <!--页脚相关信息-->
		 <%@include file="common/footer.jsp" %>
	     <!--网站相关说明及信息-->
		</div>
   	</div>
	<!----------------页脚结束---------------->
   </div>
   <!--封装容器结束-->
   
      <script> 
	    var thanksListUrl = "${path}/thanks.do";
	    var saveThanksUrl = "${path}/user/saveThanks.do";
	    
	    var $obj = function(id) {return document.getElementById(id) ? document.getElementById(id) : null};
	    var onlineClick = true;
	    var Left = 0;
	    var Top = 0;
	    
		var max_to_normal = $obj("max_to_normal");
		var min_to_normal = $obj("min_to_normal");

		 		
 		thanksList(thanksListUrl, globalpageIndex, globalpageSize);
 		
 		$("#want-to-thanks").click(function (event) {
 			thanksView(event);
 		});
 		
 		$("#thanks-info").submit(function(e) {
 			e.preventDefault();
 			
 			var data = $("#thanks-info").serialize();
 			
 			if(checkThanks($("#title"), $("#content"))){
 				saveThanks(saveThanksUrl, data);
 			}
 		});
	
		//当滚动条的位置处于距顶部100像素以下时，跳转链接出现，否则消失
		$(function () {
			$(window).scroll(function () {
				if ($(window).scrollTop() > 100) {
					$("#go-top").fadeIn(100);
				} else {
					$("#go-top").fadeOut(100);
				}
			});
		});
		  
</script>  

</body>
</html>