<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>列表信息</title>
<%@ include file="../common/common.jsp"%>
<script type="text/javascript">
		$(function(){
			// 定义数据表
			 var iCount=getAutoRowCount();  
		 	 $("#tabId").datagrid({ 
					fitColumns:true, 
				    fit:true,//自适应宽度和高度   
					nowrap: true,
					autoRowHeight: false,
					striped: true,
					collapsible:true,
					rownumbers:true,
					remoteSort: false,
					pagination:true,
					singleSelect:false,
					pageList:[iCount,2*iCount,3*iCount],
					//queryParams:{'group_ids':2},
				    url:'${rootPath}/admin/student/findStudentPageByConditions',  
				    columns:[[   
				        {field:'ck',checkbox:true},  
				        {field:'sid',hidden:true},     
				        {field:'name',title:'姓名',width:$(this).width() * 0.1}, 
				        {field:'sex',title:'性别',width:$(this).width() * 0.1,
				        	formatter: function(value,row,index){
								if ('0' == value){
									return "男";
								} else {
									return "女";
								}
							}
				        },
				        {field:'address',title:'地址',width:$(this).width() * 0.1},
				        {field:'inserttime',title:'插入时间',width:$(this).width() * 0.1,
				        	formatter:function(value,row,index){ 
							       if (row.inserttime != null){ 
								        return getCurrentDateTime(value,0);
							      }
				             }
				        },
				        {field:'remark',title:'备注',width:$(this).width() * 0.1}  
				    ]],
				    onLoadSuccess:function(data){   
						  $(this).datagrid('doCellTip',{'max-width':'300px','delay':100});
					}
		 	 });

		 	 //初始化弹出dialog窗口 
				$("#crudDivId").dialog({
					width:450,
					height:380,
					iconCls:'icon-save', 
					modal:true,
					resizable:false,
					closed:true,
					buttons: [{
						text:'保存',
						iconCls:'icon-ok',
						handler:function(){ 
						   saveDialog();
	 					}
					},{
						text:'关闭',
	                    iconCls:'icon-cancel',
						handler:function(){$('#crudDivId').dialog('close');}
					}]
				});
				
				//保存
			    function saveDialog(){ 
				 //非空校验 
				   	$("#addFormId").form('submit',{
				   		url:'${rootPath }/admin/student/saveStudent',
				   		onSubmit:function (){
				   		 return $(this).form('validate');
				   		},
				   		success:function(data){  
				   			   var result=eval('('+data+')');
				   			   if(result.success){ 
				   				   $.messager.alert('提示','保存成功!','info'); 
				   				   $('#crudDivId').dialog('close');  
				   				   $("#tabId").datagrid('uncheckAll');    
				   				   $("#tabId").datagrid('reload');    
				   			   }else{
				   				   $.messager.alert('提示',result.msg,'error');
				   			   }
				   		   }
				   	   });      	
		            }


				// 注册添加
				$("#addId").click(function(){
					// 加载数据
					$('#crudDivId').dialog('refresh', '${rootPath}/admin/student/add/load');  
					// 设置title
					$("#crudDivId").dialog({
						title:'添加数据',
						iconCls:'add-blue-icon'
					});
					// 打开窗口
					$("#crudDivId").dialog("open");
				});	
				//注册修改
				$("#editId").click(function(){
				     var rows = $("#tabId").datagrid('getChecked');  
		       		 if(rows.length==1){	
						    var row = $('#tabId').datagrid('getSelected');  
							// 加载数据
							$('#crudDivId').dialog('refresh', '${rootPath}/admin/student/edit/load?id='+row.sid);  
							// 设置title
							$("#crudDivId").dialog({
								title:'修改数据',
								iconCls:'edit-blue-icon'
							});
							// 打开窗口
							$("#crudDivId").dialog("open");
		       		   }else{
		       			     $.messager.alert('提示','请选择一条信息!','info');  
		       		   }
				});
				//注册删除
				$("#deleteId").click(function(){
		    		var rows = $("#tabId").datagrid('getChecked');
					var ids=[]; //通讯录ID数组
		        	 if(rows.length>0){
		        		$.messager.confirm('提示', '确定要删除数据?',function(r){
		        			if(r){
			        		     for(var i = 0; i < rows.length; i ++){
									ids.push(rows[i].sid);
							     }
			        		      var idss=ids.join(","); //数组转换为字符串 
		        				 $.post('${rootPath}/admin/student/deleteStudent',{ids:idss},function(data){
		        					 var result=eval('('+data+')');
		        					 if (result.success){
		        						 $("#tabId").datagrid('reload');
		        					 }else{
		        						 $.messager.alert('提示',result.msg,'error');
		        					 }
		        				 });
		        				
		        			}
		        		});
		
		        	 }else{
		        		 $.messager.alert('提示','请你选择要删除的数据!','info'); 
		        	 }
				});
				
		});

        //根据窗口大小自动计算行数
        $(window).bind('resize',function(){ 
            var $dg=$('#tabId');       
	   		 var pageSize= getAutoRowCount();
	   		 $dg.datagrid("options").pageSize = pageSize;
	   		 var p = $dg.datagrid('getPager');  
	   		 $(p).pagination({
	   		 		pageList:[pageSize,2*pageSize,3*pageSize]
	   		 }); 
	   		$dg.datagrid("reload");
        });
	</script>
</head>

<body>
	<div class="easyui-layout" data-options="fit:true,border:false">
		<div data-options="border:false,region:'north'"
			class="panelTopbarStyl">
			<!-- 功能区 -->
			<a href="#" id="addId" class="easyui-linkbutton"
				data-options="plain:true,iconCls:'add-blue-icon'">添加数据</a> <a
				href="#" id="editId" class="easyui-linkbutton"
				data-options="plain:true,iconCls:'edit-blue-icon'">修改数据</a> <a
				href="#" id="deleteId" class="easyui-linkbutton"
				data-options="plain:true,iconCls:'delete-icon'">删除数据</a>
		</div>
		<div data-options="border:false,region:'center'">
			<table id="tabId"></table>
		</div>
	</div>

	<!-- 添加编辑信息窗口 -->
	<div id="crudDivId"></div>
</body>
</html>