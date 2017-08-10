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
				singleSelect:false,
				pageList:[iCount,2*iCount,3*iCount],
				pagination:true,
				scrollbarSize:0,
// 				queryParams:{},
				url:"${rootPath}/systemController/sysUserType/findSysUserTypePageByConditions",
				columns:[[   
		                	{field:'ck',checkbox:true,width:$(this).width() * 0.03}, 
					        {field:'id',title:'用户类型编号',sortable:true,width:$(this).width()*0.35}, 
					        {field:'name',title:'用户类型名称',sortable:true,width:$(this).width()*0.32},
					        {field:'edit',title:'修改',sortable:true,width:$(this).width()*0.3,align:'center',
					        	formatter: function(value,row,index){
					        		if(${CANUPDATE>0}){
					        			return "<a href='#' onclick='editSysUserType("+row.id+")'>修改</a>";
					        		}else{
					        			return "<span style='color:#999'>修改</span>";
					        		}
						        	
								}
							}
					    ]]
					    
			});
			
			//初始化dialog窗口
			$("#sysUserTypeDivId").dialog({
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
						var vd = $("#addsysUserTypeFormId").form("validate");
						if(vd){
							$("#addsysUserTypeFormId").submit();
						}
 					}
				},{
					text:'关闭',
                    iconCls:'icon-cancel',
					handler:function(){$('#sysUserTypeDivId').dialog('close');}
				}]
			});
	
			// 
			$("#sysUserDetailId").dialog({
				width:500,
				height:150,
				title:'My Window',
				iconCls:'icon-save', 
				closed:true,
				buttons: [{
					text:'关闭',
                    iconCls:'icon-cancel',
					handler:function(){$('#sysUserDetailId').dialog('close');}
				}] 
			});
	

			// 添加用户类型
			$("#addId").click(function(){
				// 加载数据
				$('#sysUserTypeDivId').dialog('refresh', 
						'${rootPath}/systemController/sysUserType/addSysUserType');  
				// 设置title
				$("#sysUserTypeDivId").dialog({
					title:'添加用户类型',
					iconCls:'add-blue-icon'
				});
				// 打开窗口addsysUserTypeFormId
				$("#sysUserTypeDivId").dialog("open");
			});	
			
			// 修改用户类型
			$("#editId").click(function(){
				 var rows = $("#test").datagrid('getChecked');  
	      		 if(rows.length==1){
	      		      var row=rows[0];  
	      		      editSysUserType(row.id);
	      		   }else{
	      			$.messager.alert('提示','请选择一条修改信息!','info');  
	      		   }
			});

			// 删除用户类型
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
							window.location.href="${rootPath }/systemController/sysUserType/deleteSysUserTypeByIds?ids="+ids+"&sysUserNames="+names;
						}
					});
				}else {
					$.messager.alert("提示", "请选择要删除的数据!","warning");
				}
			});	
			

		});


		// 周恪竭：关闭窗口
		function closeWindow(){
			$("#sysUserTypeDivId").dialog("close");
		}


		// 周恪竭：保存用户类型
		function savaSysUserType(){
			var vd = $("#addsysUserTypeFormId").form("validate");
			if(vd){
				$("#addsysUserTypeFormId").submit();
			}
		}

		// 周恪竭：修改用户类型信息
		function editSysUserType(sysUserTypeId){
			// 加载数据
			$('#sysUserTypeDivId').dialog('refresh', 
					'${rootPath}/systemController/sysUserType/'+sysUserTypeId+'/editSysUserTypeId');  
			// 设置title
			$("#sysUserTypeDivId").dialog({
				title:'修改用户类型',
				iconCls:'edit-blue-icon'
			});
			// 打开窗口
			$("#sysUserTypeDivId").dialog("open");
		}
		
	</script>
</head>

<body>
        <div class="easyui-layout" data-options="fit:true,border:false" >
            <div data-options="border:false,region:'north'" class="panelTopbarStyl">
				<!-- 功能区 -->
				<c:if test="${CANADD>0 }">
					<a href="#" id="addId" class="easyui-linkbutton" data-options="plain:true,iconCls:'add-blue-icon'">添加用户类型</a>
				</c:if>
				<c:if test="${CANUPDATE>0 }">
					<a href="#" id="editId" class="easyui-linkbutton" data-options="plain:true,iconCls:'edit-blue-icon'">修改用户类型</a>
				</c:if>
				<c:if test="${CANDELETE>0 }">
					<a href="#" id="deleteId" class="easyui-linkbutton" data-options="plain:true,iconCls:'delete-icon'">删除用户类型</a>
				</c:if>
            </div>
            <div data-options="border:false,region:'center'"   id="detailId">
					<table fit="true" id="test">  
					   
					</table> 
	        </div>
        </div>
    
    	<div id="sysUserTypeDivId">	</div>
		<div id="sysUserDetailId">	</div>
</body>
</html>