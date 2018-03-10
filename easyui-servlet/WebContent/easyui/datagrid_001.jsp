<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="themes/icon.css"/>
<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/jquery.easyui.min.js"></script>
<style type="text/css">
  <style type="text/css"> 
        #fm 
        { 
            margin: 0; 
            padding: 10px 30px; 
        } 
        .ftitle 
        { 
            font-size: 14px; 
            font-weight: bold; 
            padding: 5px 0; 
            margin-bottom: 10px; 
            border-bottom: 1px solid #ccc; 
        } 
        .fitem 
        { 
            margin-bottom: 5px; 
        } 
        .fitem label 
        { 
            display: inline-block; 
            width: 80px; 
        } 
    </style> 
</head>
<body>
   <table id="dg"></table>
		<div id="dlg" class="easyui-dialog" style="width: 500px; height: 300px; padding: 10px 20px;" closed="true" buttons="#dlg-buttons"> 
		       <form id="fm" method="post">
		       <div class="fitem"> 
		                            首次登陆名<input id="firstname" name="firstname" class="easyui-validatebox"/> 
		       </div> 
		       <div class="fitem"> 
		           最后登录名<input id="lastname" name="lastname" class="easyui-validatebox"/> 
		       </div> 
		       <div class="fitem"> 
		           手机&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input id="phone" name="phone" value="${users.phone}" class="easyui-validatebox"/> 
		       </div> 
		       <div class="fitem"> 
		           邮箱&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input id="email" name="email"  value="${users.email}" class="easyui-vlidatebox"/> 
		       </div> 
		       </form> 
		</div>
	<div id="dlg-buttons"> 
	        <a href="javascript:void(0)" class="easyui-linkbutton" onclick="save()" iconcls="icon-save">保存</a> 
	        <a href="javascript:void(0)" class="easyui-linkbutton" onclick="javascript:$('#dlg').dialog('close')"
	            iconcls="icon-cancel">取消</a> 
	</div>
	
	<div id="dllg" class="easyui-dialog" style="width: 500px; height: 300px; padding: 10px 20px;" closed="true" buttons="#dlg-buttons"> 
		       <form id="fmm" method="post">
		       <div class="fitem"> 
		                            首次登陆名<input id="firstname" name="firstname" class="easyui-validatebox"/> 
		       </div> 
		       <div class="fitem"> 
		           最后登录名<input id="lastname" name="lastname" class="easyui-validatebox"/> 
		       </div> 
		       <div class="fitem"> 
		           手机&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input id="phone" name="phone" value="${users.phone}" class="easyui-validatebox"/> 
		       </div> 
		       <div class="fitem"> 
		           邮箱&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input id="email" name="email" value="${users.email}" class="easyui-vlidatebox"/> 
		       </div> 
		       <input type="hidden" name="id" id="id" /> 
		       </form> 
		</div>
	<div id="dlg-buttons"> 
	        <a href="javascript:void(0)" class="easyui-linkbutton" onclick="saveuser()" iconcls="icon-save">保存</a> 
	        <a href="javascript:void(0)" class="easyui-linkbutton" onclick="javascript:$('#dllg').dialog('close')"
	            iconcls="icon-cancel">取消</a> 
	</div>
</body>
<script type="text/javascript">
    $(function(){
    	$('#dg').datagrid({
    	    url:"${pageContext.request.contextPath}/userServlet.do",
    	    nowrap: true,
			fit : true,
			fitColumns : false,
			border : false,
			rownumbers : true,
			idField : 'id',
			remoteSort: false,
			singleSelect : true,
			checkOnSelect : true,
			selectOnCheck : true,
			showPageList:false,
    	    columns:[[
    	        {field:'id',title:'编号',width:100},
    	        {field:'firstname',title:'首次名',width:100},
    	        {field:'lastname',title:'最后名',width:100},
    	        {field:'phone',title:'手机',width:100},
    	        {field:'email',title:'邮箱',width:150}
    	    ]],
    	     toolbar:[{
    	    	    text:'新增',
    	    	    iconCls: 'icon-add',
    	    	    handler: function(){
    	    	    	add();
    	    	    }
    	    	    },'-',{
    	    	    	text:'修改',
        	    	    iconCls: 'icon-edit',
        	    	    handler: function(){
        	    	    	update();
        	    	    }
    	    	    },'-',{
    	    	    	text:'删除',
    	    	    	iconCls: 'icon-remove',
        	    	    handler: function(){
        	    	    	destroyUser();
        	    	    }
    	    	    }]
    	});
    });
    function add(){
    	$("#dlg").dialog("open").dialog('setTitle', '新增用户');
    	 $("#fm").form("clear");
    }
    function save() {
        $("#fm").form("submit", {
            url: "${pageContext.request.contextPath}/userServlet.do?flag=add",
            onsubmit: function () {
                return $(this).form("validate");
            },
            success: function (result) {
                if (result) {
                    $.messager.alert("提示信息", "操作成功");
                    $("#dlg").dialog("close");
                    $("#dg").datagrid("load");
                }else {
                    $.messager.alert("提示信息", "操作失败");
                }
            }
        });
    }
    function saveuser() {
    	 $("#fmm").form("submit", {
             url: "${pageContext.request.contextPath}/userServlet.do?flag=update",
             onsubmit: function () {
                 return $(this).form("validate");
             },
             success: function (result) {
                 if (result) {
                     $.messager.alert("提示信息", "修改成功");
                     $("#dllg").dialog("close");
                     $("#dg").datagrid("load");
                 }else {
                     $.messager.alert("提示信息", "操作失败");
                 }
             }
         });
    }
    function update(){
    	var row = $('#dg').datagrid('getSelected');
    	if(row){
    		$("#dllg").dialog("open").dialog('setTitle', '更新用户');
    		$("#fmm").form("clear");
    		$("#fmm").form("load", row);
             url = "${pageContext.request.contextPath}/userServlet.do?id=" + row.id+"&flag=updateUI";
    	}
    }
    function destroyUser() {
        var row = $('#dg').datagrid('getSelected');
        if (row) {
            $.messager.confirm('Confirm', '您确认删除吗?', function (r) {
                if (r) {
                    $.post('${pageContext.request.contextPath}/userServlet.do?flag=delete'+"&id="+row.id, function (json) {
                    		 $.messager.alert("提示信息", "删除成功");
                    		 $("#dlg").dialog("close");
                    		 $("#dg").datagrid("load");
                    });
                }
            });
        }else{
       	 $.messager.alert("提示信息", "请选择要删除的数据");
        }
    }  
    		
</script>
</html>