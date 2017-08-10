<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<jsp:include page="../../common/common.jsp"></jsp:include>
	<script>
		$(function(){
			// 定义数据表
			var iCount=getAutoRowCount(); 
			$('#test').datagrid({
				height:480,
				nowrap: true,
				autoRowHeight: false,
				fitColumns:true,
				striped: true,
				remoteSort: false,
				pagination:false,
				singleSelect:false,
				pageList:[iCount,2*iCount,3*iCount],
// 				queryParams:{},
				url:"${rootPath}/systemController/sysDeptType/findSysDeptTypeList",
				columns:[[   
		                	{field:'ck',checkbox:true,width:$(this).width() * 0.03}, 
					        {field:'no',title:'组织类型编号',sortable:true,width:$(this).width()*0.35}, 
					        {field:'name',title:'组织类型名称',sortable:true,width:$(this).width()*0.32,
					        	formatter: function(value,row,index){
						        	return "<a href='#' onclick='showSysDeptType("+row.id+")'>"+row.name+"</a>";
								}
					        },
					        {field:'edit',title:'修改',sortable:true,width:$(this).width()*0.3,align:'center',
					        	formatter: function(value,row,index){
					        		if(${CANUPDATE>0}){
					        			return "<a href='#' onclick='editSysDeptType("+row.id+")'>修改</a>";
					        		}else{
					        			return "<span style='color:#999'>修改</span>";
					        		}
						        	
								}
							}
					    ]]
					    
			});
			
			//初始化dialog窗口
			$("#sysDeptTypeDivId").dialog({
				width:450,
				height:180,
				title:'My Window',
				iconCls:'icon-save', 
				modal:true,
				resizable:false,
				closed:true,
				buttons: [{
					text:'保存',
					iconCls:'icon-ok',
					handler:function(){
						var vd = $("#addsysDeptTypeFormId").form("validate");
						if(vd){
							$("#addsysDeptTypeFormId").submit();
						}
 					}
				},{
					text:'关闭',
                    iconCls:'icon-cancel',
					handler:function(){$('#sysDeptTypeDivId').dialog('close');}
				}]
			});
	
			// 
			$("#sysDeptDetailId").dialog({
				width:500,
				height:150,
				title:'My Window',
				iconCls:'icon-save', 
				closed:true,
				buttons: [{
					text:'关闭',
                    iconCls:'icon-cancel',
					handler:function(){$('#sysDeptDetailId').dialog('close');}
				}] 
			});
	

			// 添加组织类型
			$("#addId").click(function(){
				// 加载数据
				$('#sysDeptTypeDivId').dialog('refresh', 
						'${rootPath}/systemController/sysDeptType/addSysDeptType');  
				// 设置title
				$("#sysDeptTypeDivId").dialog({
					title:'添加组织类型',
					iconCls:'add-blue-icon'
				});
				// 打开窗口
				$("#sysDeptTypeDivId").dialog("open");
			});	
			
			// 修改组织类型
			$("#editId").click(function(){
				 var rows = $("#test").datagrid('getChecked');  
	      		 if(rows.length==1){
	      		      var row=rows[0];  
	      		      editSysDeptType(row.id);
	      		   }else{
	      			$.messager.alert('提示','请选择一条修改信息!','info');  
	      		   }
			});

			// 删除组织类型
			$("#deleteId").click(function(){
				var ids = [];
				var names = [];
				var rows = $('#test').datagrid('getSelections');
				for(var i=0;i<rows.length;i++){
					ids.push(rows[i].id);
					names.push(rows[i].hname);
				}
				ids.join(',');
				names.join(',');
				if(ids.length > 0 ){
					$.messager.confirm("警告", "确定要删除这些数据吗?", function(r){
						if(r){
							window.location.href="${rootPath }/systemController/sysDeptType/deleteSysDeptTypeByIds?ids="+ids+"&sysDeptNames="+names;
						}
					});
				}else {
					$.messager.alert("提示", "请选择要删除的数据!","warning");
				}
			});	
			

		});

		// 周恪竭：根据主键id查询组织类型详细信息
		function showSysDeptType(sysDeptTypeId){
			// 加载数据
			$('#sysDeptDetailId').dialog('refresh', 
					'${rootPath}/systemController/sysDeptType/'+sysDeptTypeId+'/showSysDeptTypeId');  
			// 设置title
			$("#sysDeptDetailId").dialog({
				title:'查看组织类型'
			});
			// 打开窗口
			$("#sysDeptDetailId").dialog("open");
		}

		// 周恪竭：关闭窗口
		function closeWindow(){
			$("#sysDeptTypeDivId").dialog("close");
		}


		// 周恪竭：保存组织类型
		function savaSysDeptType(){
			var vd = $("#addsysDeptTypeFormId").form("validate");
			if(vd){
				$("#addsysDeptTypeFormId").submit();
			}
		}

		// 周恪竭：修改组织类型信息
		function editSysDeptType(sysDeptTypeId){
			// 加载数据
			$('#sysDeptTypeDivId').dialog('refresh', 
					'${rootPath}/systemController/sysDeptType/'+sysDeptTypeId+'/editSysDeptTypeId');  
			// 设置title
			$("#sysDeptTypeDivId").dialog({
				title:'修改组织类型',
				iconCls:'edit-blue-icon'
			});
			// 打开窗口
			$("#sysDeptTypeDivId").dialog("open");
		}
		
	</script>
</head>

<body>
        <div class="easyui-layout" data-options="fit:true,border:false" >
            <div data-options="border:false,region:'north'" class="panelTopbarStyl">
				<!-- 功能区 -->
				<c:if test="${CANADD>0 }">
					<a href="#" id="addId" class="easyui-linkbutton" data-options="plain:true,iconCls:'add-blue-icon'">添加组织类型</a>
				</c:if>
				<c:if test="${CANUPDATE>0 }">
					<a href="#" id="editId" class="easyui-linkbutton" data-options="plain:true,iconCls:'edit-blue-icon'">修改组织类型</a>
				</c:if>
				<c:if test="${CANDELETE>0 }">
					<a href="#" id="deleteId" class="easyui-linkbutton" data-options="plain:true,iconCls:'delete-icon'">删除组织类型</a>
				</c:if>
            </div>
            <div data-options="border:false,region:'center'"   id="detailId">
					<table fit="true" id="test">  
					   
					</table> 
	        </div>
        </div>
    
    	<div id="sysDeptTypeDivId">	</div>
		<div id="sysDeptDetailId">	</div>
</body>
</html>