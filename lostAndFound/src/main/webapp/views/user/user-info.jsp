<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=0.5">
<title>${webSiteTitle}</title>
<script type="text/javascript" src="${path}/static/js/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="${path}/static/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${path}/static/easyui/locale/easyui-lang-zh_CN.js"></script>
<link rel="stylesheet" type="text/css" href="${path}/static/easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="${path}/static/easyui/themes/icon.css">
<link rel="stylesheet" type="text/css" href="${path}/static/easyui/demo.css">
<style>
	.text-align-right{text-align:right;}
	/* min-width & max-width 兼容移动设备 */
	@media screen and (min-width: 220px) and (max-width: 960px) { 
	 	.easyui-panel {
	 		width:98.5%;
		}
	}
	
	/* min-width兼容移动设备 */
	@media screen and (min-width: 960px) { 		
		.easyui-panel {
			width:500px;		
		}
	}
</style>
</head>
<body>
	<div style="width:100%;margin:30px auto;">
	<div class="easyui-panel" title="完善修改个人资料" data-options="iconCls:'icon-save',fit:true">
		<div style="padding:10px 20px 20px 20px;margin:10px auto;">
	    <form id="user-info" method="post">
	    	<table cellpadding="2" style="margin:0 auto;">
	    		<tr>
	    			<td class="text-align-right">账号:</td>
	    			<td>
	    			<input type="hidden" name="id" value="${user.id}">
	    			<input type="hidden" name="loginAct" value="${user.loginAct}">
	    			<input type="hidden" name="loginPwd" value="${user.loginPwd}">
	    			<input type="hidden" name="roleCode" value="${user.roleCode}">
					<input type="hidden" name="createTime" value="${user.createTime}">
	    			${user.loginAct}
	    			</td>
	    			<!--<td class="text-align-right">年级:</td>
	    			<td>
		    			<select class="easyui-combobox" name="grade" id="grade" style="width:60px;">
		    			</select>
	    			</td>-->
	    		</tr>
	    		<tr>
	    			<td class="text-align-right">昵称:</td>
	    			<td><input class="easyui-textbox" name="nickname" id="nickname" value="${user.nickname}" width="100" style="width:100px;"/></td>
	    		</tr>
	    		<tr>
	    			<td class="text-align-right">电话:</td>
	    			<td><input class="easyui-numberbox" name="phone" id="phone" value="${user.phone}" data-options="required:true,validType: 'length[11,11]' " width="120" style="width:120px;"/></td>
	    		</tr>
	    		<tr>
	    			<td class="text-align-right">微信:</td>
	    			<td><input class="easyui-textbox" type="text" name="weChat" id="weChat" value="${user.weChat}"  width="130" style="width:130px;"/></td>
	    			<!--<td class="text-align-right">QQ:</td>
	    			<td>
	    			<input class="easyui-textbox" type="text" name="qq" id="qq" width="100" data-options="validType:'length[9,11]'" style="width:100px;"/>-->
	    			<input type="hidden" name="roleCode"/>
	    			<input type="hidden" name="createTime"/>
	    			</td>
	    		</tr>
	    	</table>
	    </form>
	    <div style="text-align:center;padding:10px">
	    	<a href="javascript:void(0)" class="easyui-linkbutton" onclick="submitForm()" style="margin-right:15px;">修改</a>
	    	<a href="javascript:void(0)" class="easyui-linkbutton" onclick="clearForm()" style="margin-left:15px;">清除</a>
	    </div>
	    </div>
	</div>
	</div>
	<script>

		function submitForm(){
			$('#user-info').form('submit',{  
                url:'${path}/user/updateUser.do',
                onSubmit: function(){  
                        if($("#user-info").form("validate"))  
                            return true;
                        else  
                            return false;  
                    },  
				//注意ajax的url的后台action方法必须有返回值return "json"，而不是return null,否则下面的回调函数不起作用，sucess方法失效  
                success:function(data){
                	// 注意这个坑！！！（移动设备返回的内容在{}两边含有div标签）
                	data = data.substring(data.indexOf("{"), data.indexOf("}") + 1);
                    //此处data={"msg":success}实际为字符串，而不是json对象，需要用如下代码处理  
                    data = jQuery.parseJSON(data);
                    if(data.msg == "success") {
                    	$.messager.alert('消息',"修改成功!");
                    	/*修改成功，刷新父页面*/
						parent.location.reload();
                    } else if(data.msg == "error")
                    	$.messager.alert('消息',"修改失败!");
                },
                dataType: "json"
              });
		}
		
		function clearForm(){
			$("#nickname").textbox('setValue',"");
			$("#phone").textbox('setValue',"");
			$("#weChat").textbox('setValue',"");
		}
	</script>
</body>
</html>