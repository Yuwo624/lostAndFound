	<%--标签 --%>
	<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<!-- css样式 -->
	<link rel="canonical" href="${path}/index.html">
	<%--<link rel="shortcut icon" href="${path}/static/images/favicon.ico" type="image/x-icon">
	<link rel="apple-touch-icon" href="${path}/static/images/applogo.png">--%>
	<link rel="stylesheet" href="${path}/static/css/bootstrap.min.css" >
	<link rel="stylesheet" href="${path}/static/css/index-v1.0.css">
	<link rel="stylesheet" href="${path}/static/css/lostandfound_layoutframe_v0.1.1.css">
	
	<!-- js -->
	<script type="text/javascript" src="${path}/static/js/jquery-1.11.1-min.js"></script>
	<script type="text/javascript" src="${path}/static/easyui/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="${path}/static/easyui/locale/easyui-lang-zh_CN.js"></script>
	<script type="text/javascript" src="${path}/static/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="${path}/static/js/index-v1.0.js"></script>
	<script type="text/javascript" src="${path}/static/js/loginhandler.js"></script>
	
	
	<style>
		/*ie8提示*/
		#ie8-warning{width:100%;position:absolute;top:0;left:0;background:#fae692;padding:5px 0;font-size:12px}
		#ie8-warning p{width:960px;margin:0 auto;}
	</style>
	
	<script type="text/javascript">
	
		// 全局变量
		var sessionStartTime = new Date().getTime(); // 毫秒数
		var sessionExpiresTime = 30 * 60 * 1000; // 30分钟（毫秒数）
		// 全局变量（当前用户）
		var USER = "${user}";
		
		// 已登录
		var isLogin = ${!empty user};
		// alert(isLogin);
		
		jQuery(document).ready(function() {
			// alert(window.location.href.substring(window.location.href.indexOf("${path}")));
			// 初始化url
			$("#srcUrl").val(window.location.href.substring(window.location.href.indexOf("${path}")));
			if(!isLogin) {
				$("#mobilelog").attr("style","display:block;");
			}		
		});	
		
		//判断是否存在指定函数   
		function isExitsFunction(funcName) {  
		    try {  
		        if (typeof (eval(funcName)) == "function") {  
		            return true;  
		        }  
		    } catch (e) { }  
		    
		    return false;  
		}  
		
		// 判断是否存在指定变量   
		function isExitsVariable(variableName) {  
		    try {
		        if (typeof (variableName) == "undefined") {  
		            return false;  
		        } else {  
		            return true;  
		        }  
		    } catch (e) { } 
		    
		    return false;  
		}  
		
		//全局的ajax访问，处理ajax清求时sesion超时  
		$.ajaxSetup({  
		    contentType:"application/x-www-form-urlencoded;charset=utf-8",  
		    complete:function(XMLHttpRequest,textStatus){
		    	// 刷新sessionTime
		    	sessionStartTime = new Date().getTime();
		        //通过XMLHttpRequest取得响应头，sessionstatus，  
		        var sessionstatus = XMLHttpRequest.getResponseHeader("sessionstatus");   
		        if(sessionstatus == "timeout"){  
		        	//如果超时就处理 ，指定要跳转的页面  
		        	alert("页面过期，请重新登录!"); 
		        	parent.window.location.reload(true);  
		        }  
		    }  
		});
		
	</script>
	
	<script>
		// 全局sessionTime监听变量
		var globalSessionTime;
		
		var ii = 0;
		// sessionTime监听函数
		function globalSessionValid() {
			var nowTime = new Date().getTime();
			
			console.log("nowTime---" +ii+ ": " +nowTime +" " +sessionStartTime+ " " +sessionExpiresTime);
			if((nowTime - sessionStartTime) > sessionExpiresTime) {
				USER = null;
				isLogin = false;
				clearInterval(globalSessionTime);
				//alert("globalSession...over");
				//关闭窗口
				if(isExitsFunction("close_window_mini"))
					close_window_mini();
			}
			
			ii ++;
		}
		
		// 判断监听器是否执行
		if(isLogin) {
			// 采用定时器来监听（每5秒监听一次）
			globalSessionTime = setInterval("globalSessionValid()", 5000);
		}
		
		// 判断屏幕
		function isSmallScreen() {
			return $("body").width() <= 960;
		}
	</script>