<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../common/global.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title> ${webSiteTitle} 招领贴详情页面 </title>   
	<%@include file="../common/base-meta.jsp"%>
	<meta name="viewport" content="width=device-width, initial-scale=0.5, minimum-scale=0.5, maximum-scale=0.5, user-scalable=no">
	<%@include file="../common/base-css-js.jsp"%>

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
			#details  {
				width:90%;
				margin: 50px auto; 
			}	
			hr { /*container 与 footer 间*/
			    margin-top : 2%;    
			} 
		}
		
		/* min-width兼容移动设备 */
		@media screen and (min-width: 960px) { 		
			#details {
				max-width:75%;
				margin: 20px auto; 
			}		
		}
   </style>
</head>

   <body style="background: rgb(255, 255, 255); overflow-x: hidden;">



   <!--封装容器开始-->
   <div id="pagewrapper" style="margin:0 auto;height:auto;overflow:visible;min-height:600px;height:800px;">
    
    <!--------------页眉开始------------------>	 
    <div class="container-fluser" style="width:100%;margin:0 auto;padding:0;">
	<!-- header start-->
	<div id="find-details-header" style="margin:0 auto;">
	<%@include file="../common/header.jsp"%>
	</div> 
	<!-- header end-->
	
	<!-- 导航条 start -->
	<%@include file="../common/navigator.jsp"%>
    <script>
    	activeNav("find-details");
    </script>
	<!-- 导航条 end -->
	</div>
	<!--------------页眉结束------------------>				  
		
	<!-------------主体部分开始--------------->
     <div id="details" class="container-fluser" style="min-height:420px;">
	     <p style="font-size:14px;color:black;">
	     	现在的位置 
	     	<a href="${path}/index.html" target="_self" style="color:#666;">主页</a>
	     	-&gt;招领贴详情页面 
		 </p>
		 
	<button id="prev" style="width:80px;height:30px;font-size:16px; position:relative; top:200px; left:-10px;" class="btn btn-mini btn-default">上一贴</button>	 
	<button id="next" style="width:80px;height:30px;font-size:16px; float:right;position:relative; top:200px; right:-10px;" class="btn btn-mini btn-default">下一贴</button>

	 <script type="text/javascript">
		 $("#next").click(function (){

			 $("#next").attr("disable", true);
			 var url = "${path}/find/find-details.html/next.do?publishTime=${pickThings.publishTime}";

			 var id="${pickThings.id}";

			 $.post(url, function(data) {
				 console.log(data);
				 var newId = data.id;
				 if(id == newId || newId==null){
					 alert("已经是最后一贴了");
					 $("#next").css("display","none");
					 return false;
				 } else {
					 var locationUrl="${path}/find/find-details.html?id="+newId;
					 location.href = locationUrl;
				 }
			 });
			 $("#next").attr("disable", false);
		 });

		 $("#prev").click(function () {
			 $("#prev").attr("disable", true);

			 var id="${pickThings.id}";
			 var url = "${path}/find/find-details.html/previous.do?publishTime=${pickThings.publishTime}";
			 $.post(url, function(data) {
				 var newId = data.id;
				 if(id == newId || newId==null){
					 alert("已经是第一贴了");
					 $("#prev").css("visibility","hidden");
					 return false;
				 } else {
					 var locationUrl="${path}/find/find-details.html?id="+newId;
					 location.href = locationUrl;
				 }
			 });
			 $("#prev").attr("disable", false);
		 });

		 function parseValue(value){
			 var v;
			 if(value == "card")
				 v = "卡类证件";
			 else if(value == "book")
				 v = "书籍资料";
			 else if(value == "clothing")
				 v = "衣物首饰";
			 else if(value == "electronic")
				 v = "电子数码";
			 else if(value == "other")
				 v = "其他宝贝";
			 else
				 v = "";

			 return v;
		 }
	 </script>
	 <hr>
  <!-- Modal Srtart-->
  <div id="telInfo" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" width="300">
    <div class="modal-header">
       <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
       <h4 id="myModalLabel" style="text-align: center;">
       	校园失物招领平台
       </h4>
       <c:if test="${user.id eq pickThings.user}">
    		<div style="font-size:12px;color: blue;text-align: center;line-height:15px;">此贴为自己发布的招领贴</div>
       </c:if>
    </div>
    <div class="modal-body" id="user-info"></div>
    <div class="modal-footer">
       <button id="close" class="btn" data-dismiss="modal" aria-hidden="true" style="font-size:20px;">关闭</button>
       <c:choose>
       <c:when test="${(user.id ne pickThings.user) and (pickThings.state != 1)}">
       	<button class="btn btn-primary" onclick="confirm('${path}/user/updateFindState.do','${pickThings.id}');">确定认领</button>
       </c:when>
       <c:when test="${(user.id eq pickThings.user) and (pickThings.state != 1)}">
       	<button class="btn btn-primary" onclick="confirm('${path}/user/updateFindState.do','${pickThings.id}');">确定已归还</button>
       </c:when>
       </c:choose>
    </div>
  </div>
  <!-- Modal End-->

 <div>
 <table id="thingsinfo" style="width:85%;margin:0px auto;" class="table table-bordered">
	 <c:choose>
	 <c:when test="${!empty pickThings}">
	  <tbody>
	  <tr>
	  	<td style="width: 100px;">物品名称 :</td><td> ${pickThings.name}</td>
	  </tr>
	  <tr>
	  	<td id="date">捡到时间 :</td><td> ${pickThings.pickDate}</td>
	  </tr>
	  <tr>
	  	<td id="place">捡到地点 :</td><td>${pickThings.pickPlace}</td>
	  </tr>
	  <tr>	 
	   <td>所属类型 : </td>
	   <td>
	   	<script>document.write(parseValue("${pickThings.typeCode}"));</script>
	   </td>
	  <%-- <c:if test="${pickThings.thingsType eq 'card' and !empty pickThings.thingsNo}">
		   <tr>
		   	<td>卡号 :</td><td> ${pickThings.thingsNo}（安全起见，只为您显示后三位!）</td>
		   </tr>
	   </c:if>--%>
	  </tr>
	  <tr>
	  	<td>相关描述 :</td><td>${pickThings.description}</td>
	  </tr>
	  
	  <c:if test="${!empty pickThings.storagePlace}">
		  <tr>
		  	<td>暂存地点 :</td>
		  	<td>${pickThings.storagePlace}</td>
		  </tr>
	  </c:if>
	  <tr>
	  	<td colspan="2">
	  		<input type="button" class="btn btn-default" id="showTel" name="showTel" value="查看发帖人及其联系方式" />
	  	</td>
	  </tr>
	  <c:if test="${!empty pickThings.img}">
		  <tr>  
		  	<td>物品图片:</td>
		  	<td>
		  		<img src="${path}/${pickThings.img}" alt="物品图片" width="150" height="150" oncontextmenu="return false;" ondragstart="return false;" style="width:150px;height:150px;" >
		  	</td>
		  </tr>
	  </c:if>
	  </tbody>
	 </c:when>
	 <c:otherwise>
	 	<tbody>
	   	 <tr>
		   <td colspan="3" style="color: red;text-align: center;" > 
		   	<div style="width:200px;margin:150px auto;">暂无该记录!</div>
		   </td>
	     </tr>
	 	</tbody>	
	 </c:otherwise>
	 </c:choose>
  </table>
  </div>	 
<script>  
   $("#showTel").click(function(event){
		 // 未登录控制
		 if(!isLogin){
			// 小屏幕未登录
			if(isSmallScreen()) {
				mobileLoginFocus(event);
			} else {
				loginFocus(event);
			}
		 } else {
			 event.preventDefault();// 如果<a>定义了 target="_blank" 需要这句来阻止打开新页面   
			 var url = "${path}/user/queryById.do";
			 var userId = "${pickThings.user}";
			 showInfo(url, userId);
		 }
	});
	
    // 显示发帖人信息
	function showInfo(url, userId){
		 var table = '<table style="width: 80%;margin: 0px auto;">'
			  + '<tbody><tr><td>账号 : <span id="info_loginAct"></span></td><td>姓名 : <span id="info_username"></span></td></tr>'
			  + '<tr><td>联系电话 : <span id="info_phone"></span></td><td>微信 : <span id="info_weChat"></span></td></tr>'
		  	  + '</tbody></table>';
	 	 $("#user-info").html(table);
	 	 
		 $('#telInfo').modal({
	            backdrop: 'static', keyboard: false
	     });
		 
		 userInfo(url, userId);
	}
	
	// 发帖人信息
	function userInfo(url, userId) {
		$.post(url, {userId: userId}, function(data,status){
			 //alert(data.userName +" "+status);
			 if(status == "success") {
				 $("#info_loginAct").html(data.loginAct);
				 $("#info_username").html(data.username);
				 $("#info_phone").html(data.phone);
				 $("#info_weChat").html(data.weChat);
			 } else {
				 $("#user-info").html('<span style="color:red;">获取发帖人信息失败，请刷新重新获取...</span>');
			 }
		 }, "json");
	}
	 
	function confirm(url, id) {
		 $.post(url, {id: id}, function(data){
			if (data.success){
				$("#close").click();
				window.location.reload(true);
			}else{
			    alert("系统发生错误，请稍后重试！！！")
			}
		 }, "json");
	 }
	
	function showMsg(){
		 $("#user-info").html('<span style="color: red;">您确定失主已领回失物？感谢您所做的一切!</sapn>');
         $('#telInfo').modal({
       	  backdrop: 'static', keyboard: false
         });
	}
	</script>
	
	<c:if test="${!empty user}">
	<div style="margin-right:100px;">
	    <c:choose>
		<c:when test="${(pickThings.user == user.id) and (pickThings.state != 1)}">
			<a href="javascript:void(0);" class="btn btn-default pull-right" onclick="showMsg();"  >失主已找到</a>
		</c:when>
		<c:when test="${pickThings.state == 1}">
			<a href="javascript:void(0);" class="btn btn-success pull-right" style="cursor:default;">此贴已成功</a>
		</c:when>
		<c:when test="${(pickThings.user != user.id) and (pickThings.state != 1)}">
			<a href="javascript:void(0);" class="btn btn-default pull-right" onclick="showMsg();" >失物已找到</a>
		</c:when>
		</c:choose>
	</div>
	</c:if>
	</div> 
	<!-------------主体部分结束--------------->

    <hr>

    <!----------------页脚开始---------------->	
    <div class="container-fluid footer" style="max-width:100%;height:100px;">
	   <div style="width:100%;margin:10px auto;text-align: center;"> 
	     <!--页脚相关信息-->
			<%@include file="../common/footer.jsp" %>
	     <!--网站相关说明及信息-->
		</div>
   	</div>
    <!----------------页脚结束---------------->
    </div>
    <!--封装容器结束-->
   <script type="text/javascript">
	$(function () {
		// 登录框改变
		$("#myModalLogin .modal-header p").html('登录后，可查看<font color="red">联系方式</font>等信息');

	});


</script>
</body>

</html>