<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>校园失物招领平台</title>
<script type="text/javascript" src="${path}/static/js/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="${path}/static/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${path}/static/easyui/locale/easyui-lang-zh_CN.js"></script>
<link rel="stylesheet" type="text/css" href="${path}/static/easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="${path}/static/easyui/themes/icon.css">
<link rel="stylesheet" type="text/css" href="${path}/static/easyui/demo.css">
</head>
<body>
	<table id="dg" title="寻物贴列表" class="easyui-datagrid" width="100%"  height="100%"
             data-options="url:'${path}/user/getLostInfo.do',method:'post',toolbar: '#toolbar',border:false,fit:true,fitColumns:true,pagination:true,pagePosition:'bottom'">
         <thead>
             <tr>
             	 <th data-options="field:'id',align:'center',checkbox:true" width="50"></th>
                 <th data-options="field:'typeCode',align:'center',formatter:onThingsTypeRenderer" width="50" >物品类型</th>
                 <th data-options="field:'name',align:'center'" width="60">物品名称</th>
                 <th data-options="field:'lostPlace',align:'center'" width="60">丢失地点</th>
                 <th data-options="field:'lostDate',align:'center'" width="60">丢失时间</th>
                 <th data-options="field:'publishTime',align:'center',
                 	formatter : function(value){
                 		if(value) {
                 			value = value.replace('T',' ');
	                        return value;
                        }
                    }" width="80">发布时间</th>
                 <th data-options="field:'state',align:'center',formatter:onStatusRenderer" width="50" >状态</th>
             </tr>
        </thead>
    </table>
    <div id="toolbar">
		<a href="javascript:void(0);" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="deleteRecord();">删除</a>
	</div>
    
    <script type="text/javascript">
   function onThingsTypeRenderer(value){
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
    
    function onStatusRenderer(value) {
        if (value == 0) 
        	return "未找回";
        else if(value == 1)
        	return "已找回";
    }
    
 // 删除记录
    function deleteRecord(){
    	var rows = $('#dg').datagrid('getSelections');
    	if (rows.length > 0){
    		$.messager.confirm('消息','您确定要删除选中的'+rows.length+'记录?',function(r){
    			if (r){
    				var ids = [];
    				var flag = true;
                    for (var i = 0, l = rows.length; i < l; i++) {
                        var rw = rows[i];
                        if(rw.state == 1){
                        	if(flag)
                        		$.messager.alert("消息","已找回贴不能删除!");
                        	flag = false;
                        	continue;
                        }
                        ids.push(rw.id);
                    }
                    var id = ids.join(',');
	                if(id) {
                	  $.post("deleteLostInfo.do",{ids: id},function(result){
      					if (result.success){
      						$('#dg').datagrid('reload');	// reload the data
      					} else {
      						$.messager.show({	// show error message
      							title: '消息',
      							msg: "删除失败!"
      						});
      					}
      				},'json');
	               }
    			}
    		});
    	} else{
    		$.messager.alert("消息","请至少选中一条记录!");
    	}
    }
    
    </script>
</body>
</html>