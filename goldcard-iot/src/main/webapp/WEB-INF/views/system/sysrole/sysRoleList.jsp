<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Insert title here</title>
		<jsp:include page="../../common/common.jsp"></jsp:include>
		<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
		<script type="text/javascript">
			$(function(){
				// 周恪竭：当前页面一加载
				$("#alltreeId").tree({
					// 注册数据加载完成事件
					onLoadSuccess:function(node, data){
						if(data.length>0){
							var node = $('#alltreeId').tree('getRoot'); // 查询
							$('#alltreeId').tree('select', node.target); // 选择
							// 获取信息
							$.post('${rootPath}/systemController/sysRole/'+node.id+'/updatePermissionByRid', null, function(data){
								$("#detailId").html(data);
								$.parser.parse("#detailId");
							});
						}
					},
					onClick:function(node){
						$.post('${rootPath}/systemController/sysRole/'+node.id+'/updatePermissionByRid', null, function(data){
							$("#detailId").html(data);
							$.parser.parse("#detailId");
						});
					}
				});				

				// 周恪竭：注册添加功能
				$("#addId").click(function(){
					$("#sysDeptTypeDivId").dialog("refresh", "${rootPath}/systemController/sysRole/addSysRole");
					$("#sysDeptTypeDivId").dialog({
						title:'添加角色'
					});
					$.parser.parse("#sysDeptTypeDivId");
					$("#sysDeptTypeDivId").dialog("open");
				});

				// 周恪竭：注册删除功能
				$("#deleteId").click(function(){
					var node = $('#alltreeId').tree('getSelected');
					if(node){
						$.messager.confirm("警告", "你确定要删除当前数据吗?" , function(r){
							if(r){
								window.location.href="${rootPath}/systemController/sysRole/deleteSysRole?sysRoleid="+node.id+"&name="+node.text;
							}
						});
					}else{
						$.messager.alert('提示','请选择要操作的菜单','warning');   
					}
				});

				// 周恪竭：注册修改功能
				$("#editId").click(function(){
					var node = $('#alltreeId').tree('getSelected');
					if(node){
						$("#sysDeptTypeDivId").dialog("refresh", '${rootPath}/systemController/sysRole/'+node.id+'/editSysRole');
						$("#sysDeptTypeDivId").dialog({
							title:'修改角色'
						});
						$.parser.parse("#sysDeptTypeDivId");
						$("#sysDeptTypeDivId").dialog("open");
					}else{
						$.messager.alert('提示','请选择要操作的菜单','warning');   
					}
				});


				// 周恪竭：添加，修改的dialog
				$("#sysDeptTypeDivId").dialog({
					 title:"添加组织机构",
					 width: 400,
			         height: 280,
			         iconCls:'icon-add',
			         resizable:true,
			         modal:true,
			         closed:true,
			         resizable:false,
			         buttons: [{
								text:'确定',
								iconCls:'icon-ok',
								handler:function(){
					        	 	var vd = $('#addSysRoleFormId').form("validate");  
									if(vd){
										$('#addSysRoleFormId').submit();  
									}   
								}
							},{
								text:'取消',
			                    iconCls:'icon-cancel',
								handler:function(){$('#sysDeptTypeDivId').dialog('close');}
							}]
				});
				
				
			});

			/****
			保存菜单：这里使用直接提交因为1）组织机构树需要重新加载，但是是异步加载的不能定位到当前所加的组织机构
			2）组织机构不能获取所加组织机构，所以对应的组织机构详细不对应
			*/ 
			function savaSysRole(){
				var vd = $('#addSysRoleFormId').form("validate");  
				if(vd){
					$('#addSysRoleFormId').submit();  
				}
			}

			//
			function reLoadRight(){
				var node = $('#alltreeId').tree('getSelected');
				$.post('${rootPath}/systemController/sysRole/'+node.id+'/updatePermissionByRid', null, function(data){
					$("#detailId").html(data);
					$.parser.parse("#detailId");
				});
			}

			
			// 返回
			function goBack(){
				window.location.href="${rootPath}/systemController/sysDept/main";
			}
			// 周恪竭：关闭窗口
			function closeWindow(){
				$("#sysDeptTypeDivId").dialog("close");
			}

			// 周恪竭：保存权限
			function saveSysRolePermission(){
				$.messager.confirm("警告", "确定要进行保存?" , function(r){
					if(r){
						//实心圆节点
						var rnodes = $('#permissionttId').tree('getChecked','indeterminate');
						//叶子节点选中
						var nodes = $('#permissionttId').tree('getChecked');
						var s = "";  //总权限字符串(rightIds_roleRights)
						for(var i=0; i<rnodes.length; i++){  
			                if (s != ''){ s += ','};  
			                s += rnodes[i].id;  
			            } 
						if(nodes != null){
							for(var i=0; i<nodes.length; i++){
								if (s != '') s += ',';
								s += nodes[i].id;
							}
						}
						$("#remarkId").val(s);
						$("#updateRolePermissionFormId").submit();
					}
				});
			}


			// 周恪竭：重置权限
			function resetSysRolePermission(){
				$("#remarkId").val("true");
				$("#updateRolePermissionFormId").submit();
			}



			// 周恪竭：展开权限树
			function expandAll(){
				 $('#permissionttId').tree("expandAll");
			}
			// 周恪竭：折叠所有节点
			function collapseAll(){
				 $('#permissionttId').tree("collapseAll");
			}
			
			// 周恪竭：选中所有节点
			function selectAll(){
				 $('#permissionttId').tree("expandAll");
				 var roots = $('#permissionttId').tree("getRoots");
				 var s = '';
				for(var i=0; i<roots.length; i++){
					if (s != '') s += ',';
					s += roots[i].id;
					// 获取所有的顶级菜单
					var node = $('#permissionttId').tree('find', roots[i].id);
					$('#permissionttId').tree('check', node.target);
				}
				// 为了进行测试
				//alert(s);
			}
			
			// 周恪竭：选中所有节点
			function uncheckAll(){
				 $('#permissionttId').tree("expandAll");
				 var roots = $('#permissionttId').tree("getRoots");
				 var s = '';
				for(var i=0; i<roots.length; i++){
					if (s != '') s += ',';
					s += roots[i].id;
					// 获取所有的顶级菜单
					var node = $('#permissionttId').tree('find', roots[i].id);
					$('#permissionttId').tree('uncheck', node.target);
				}
				for(var i=0; i<roots.length; i++){
					if (s != '') s += ',';
					s += roots[i].id;
					// 获取所有的顶级菜单
					var node = $('#permissionttId').tree('find', roots[i].id);
					$('#permissionttId').tree('uncheck', node.target);
				}
				// 为了进行测试
				//alert(s);
			}
			
		</script>
	</head>
	
	<body>
    <div class="easyui-panel" style="border: 0px; width: 700px; height: 400px;" data-options="border:false,fit:true">
        <div class="easyui-layout" data-options="fit:true,border:false" >
        	
<%--         	<c:if test="${ONLYSHOW>0 }"> --%>
	            <div data-options="border:false,region:'north'" class="panelTopbarStyl">
		        	<c:if test="${CANADD>0 }">
		                <a class="easyui-linkbutton" id="addId"  data-options="iconCls:'add-user-icon',plain:true">添加角色</a>  
		        	</c:if>
		        	<c:if test="${CANDELETE>0 }">
		                <a class="easyui-linkbutton" id="deleteId"  data-options="iconCls:'del-user-icon',plain:true">删除角色</a> 
		        	</c:if>
		        	<c:if test="${CANUPDATE>0 }">
		                <a class="easyui-linkbutton" id="editId"  data-options="iconCls:'edit-user-icon',plain:true">修改角色</a>
		        	</c:if>
	            </div>
<%--         	</c:if> --%>
            <div data-options="border:true,region:'west',split:true" style="width: 270px;">
                <ul id="alltreeId" data-options="url:'${rootPath }/systemController/sysRole/findAllSysRoleJson'">
                </ul>
            </div>
            <div data-options="border:false,region:'center'"   id="detailId">
				
            </div>
        </div>
    </div>
            <div id="sysDeptTypeDivId"></div>
            
            
</body>
	
</html>