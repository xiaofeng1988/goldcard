<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Insert title here</title>
		<jsp:include page="../../common/common.jsp"></jsp:include>
		<script type="text/javascript">
			$(function(){
				// 周恪竭：当前页面一加载
				$("#alltreeId").tree({
					// 注册数据加载完成事件
					onLoadSuccess:function(){
						var node = $('#alltreeId').tree('getRoot');
						$('#alltreeId').tree('select', node.target);
						$("#alltreeId").tree('expand', node.target);
					},
					// 根据当前节点获取用户信息
					onClick:function(node){
						$('#test').datagrid('uncheckAll');  
						$('#test').datagrid('load',{
							'deptid':node.id
						});	
					}
				});	

				
				// 定义数据表
				var iCount=getAutoRowCount(); 
				$('#test').datagrid({
					iconCls:'icon-save',
					width:890,
					height:470,
					showPageList:false,
					pageList:[iCount,2*iCount,3*iCount],
					url:'${pageContext.request.contextPath}/systemController/user/findUsersByPageAndDeptId',
					columns:[[   
							  {field:'ck',checkbox:true},
					          {field:'no',title:'用户编号',width:200},  
					          {field:'name',title:'用户姓名',width:250,
					          	styler: function(value,row,index){
											return 'background:#ecfef7;color:#197651;';
										}
					           },   
					          {field:'loginname',title:'登录名',width:250},   
					          {field:'sex',title:'性别',width:100,
						          formatter: function(value,row,index){
										if ('Y' == value){
											return "男";
										} else {
											return "女";
										}
									}
								} 
					      ]], 
					nowrap: true,
					autoRowHeight: false,
					striped: true,
					remoteSort: false,
					idField:'id',
					singleSelect:false,
					toolbar: '#tbId',
					pagination:true
				});


					
				// 周恪竭：添加，修改用户信息的dialog
				$("#sysUserPersionId").dialog({
					width:350,
		            height: 350,
		            iconCls:'select-icon',
		 			resizable:true,
		 			modal:true,
		 			closed:true,
		 			resizable:false,
		 			buttons: [{
							text:'确定',
							iconCls:'icon-ok',
							handler:function(){
		 							$('#sysUserPersionId').dialog('close');
		 					}
						},{
							text:'关闭',
		                    iconCls:'icon-cancel',
							handler:function(){$('#sysUserPersionId').dialog('close');}
						}]
				});	

					

				// 周恪竭：注册添加功能
				$("#addId").click(function(){
					$("#sysUserPersionId").dialog("open");
				});

				// 周恪竭：注册删除功能
				$("#deleteId").click(function(){
					// 获取datagrid中的选中的记录
					var nodes = $('#test').datagrid('getChecked');
					var ids = [],names = [];
					for(var i = 0; i < nodes.length; i ++){
						ids.push(nodes[i].id);
						names.push(nodes[i].name);
					}
					ids.join(",");
					//names.join(",");
					if(nodes.length > 0){
						$.messager.confirm("提示", "你确定要更改当前数据吗?" , function(r){
							if(r){
								 $("#userAndRoleId").val(ids);
								 $("#userAndRoleNames").val(names.toString());
								 var nns = $("#updateUserAndRoleId input:checked")
								 $('#updateUserAndRoleId').submit();  
								 $.messager.alert('提示','更改成功！','info');   
							}
						});
					}else{
						$.messager.alert('提示','请选择要操作的用户','info');   
					}
				});

				// 周恪竭：注册查询功能
				$("#searchId").click(function(){
					var node = $("#alltreeId").tree("getSelected");
					$("#searchdivid").window('open');
				});
			});
			// 周恪竭：关闭查询窗口
			function closeSearch(){
				$("#snameId").val("");
				$("#sloginNameId").val("");
				$("#searchdivid").window("close");
			}
			
			// 周恪竭：查询用户信息
			function searchSysUser(){
				$("#nameId").val( $("#snameId").val()   );
				$("#loginNameId").val( $("#sloginNameId").val()   );
				$("#searchdivid").window("close");
				$('#test').datagrid('loading');
				var node = $("#alltreeId").tree("getSelected"); 
				$('#test').datagrid('load',{
					'deptid':node.id,
					'name':$("#nameId").val(), 
					'loginname':$("#loginNameId").val() 
				}); 
				$("#snameId").val("");
				$("#sloginNameId").val("");
			}

	    	//获取查询参数
	    	function getSearchParam(){
				$("#nameId").val( $("#snameId").val()   );
				$("#loginNameId").val( $("#sloginNameId").val()   );
				$("#searchdivid").window("close");
				$('#test').datagrid('loading');
				var node = $("#alltreeId").tree("getSelected"); 
				return {
					'deptid':node.id,
					'name':$("#nameId").val(), 
					'loginname':$("#loginNameId").val()
					}
	        }
	    	
	        //根据窗口大小自动计算行数
	        $(window).bind('resize',function(){        
		   		 var pageSize= getAutoRowCount();
		   		 $('#test').datagrid("options").pageSize = pageSize;
		   		 var p = $('#test').datagrid('getPager');  
		   		 $(p).pagination({
		   		 		pageList:[pageSize,2*pageSize,3*pageSize]
		   		 }); 
		   		$('#test').datagrid("reload",getSearchParam());
	        });

		</script>
		<style type="text/css">
			.datagrid-header td[field="name"]{
			background: -webkit-gradient(linear, 0% 0%, 0% 100%, from(#e0fef2), to(#c0f3df)); 
			background: -webkit-linear-gradient(top, #e0fef2, #c0f3df); 
			background: -moz-linear-gradient(top, #e0fef2, #c0f3df); 
			background: -o-linear-gradient(top, #e0fef2, #c0f3df); 
			background: -ms-linear-gradient(top, #e0fef2, #c0f3df); 
			FILTER: progid:DXImageTransform.Microsoft.Gradient(startColorStr=#e0fef2, endColorStr=#c0f3df);text-align:center;}
		</style>
	</head>
	<!-- 主面板 -->
	<body class="easyui-layout">
		<input type="hidden" id="nameId" value="">
		<input type="hidden" id="loginNameId" value="">
		
		<div data-options="region:'west',split:true" style="width:250px">
				<ul id="alltreeId" class="easyui-tree" data-options="url:'${pageContext.request.contextPath }/systemController/sysUser/sysDept/shortNameNodeList'"></ul>
		</div>
		<!-- 页面的内容显示部分 -->
		<div data-options="region:'center'" id="detailId" >
			<div style="width:98%;" id="tbId">
				<a href="#" id="searchId" class="easyui-linkbutton" data-options="plain:true,iconCls:'sch-icon'">查询用户</a>
				<a href="#" id="addId" class="easyui-linkbutton" data-options="plain:true,iconCls:'select-icon'">选择角色</a>
				<c:if test="${CANUPDATE>0 }">
					<a href="#" id="deleteId" class="easyui-linkbutton" data-options="plain:true,iconCls:'save-icon'">保存设置</a>
				</c:if>
			</div>
			<!-- 显示用户列表 -->
			<table id="test">  </table>  
		
			<form action="">
				<!-- 选择角色窗口 -->
				<div id="searchdivid" class="easyui-window" data-options="title:'查询用户',closed:true,maximizable:false,minimizable:false, collapsible:false,iconCls:'sch-icon',resizable:false" 
								style="width:450px;height:180px; ">
					<div class="easyui-layout" data-options="fit:true">
						<div data-options="region:'center',border:false" style="padding:10px;background:#fff;border:1px solid #ccc;" id="roledivId">
							
							<table class="dialog-tbl" cellspacing="0">
								<tr style="height: 35px">
									<td class="tit-col">
										用户姓名：
									</td>
									<td>
										<div id="deptname901">
											<input type="text" id="snameId">
										</div>
									</td>
								</tr>
								<tr style="height: 35px">
									<td class="tit-col">
										登录名：
									</td>
									<td>
										<div id="deptname901">
											<input type="text" id="sloginNameId">
										</div>
									</td>
								</tr>
							</table>
						</div>
						<div data-options="region:'south',border:false" style="text-align:right;padding:5px 0;">
							<a class="easyui-linkbutton" data-options="iconCls:'icon-ok',plain:true" href="javascript:void(0)" onclick="searchSysUser()">确定</a>
							<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel', plain:true" href="javascript:void(0)" onclick="closeSearch()">关闭</a>
						</div>
					</div>
				</div>
			</form>
		
		</div>
		
		
			<div id="sysUserPersionId" title="选择角色">
				<form action="${pageContext.request.contextPath}/systemController/batchuserandrole/updateUserAndRole" id="updateUserAndRoleId" method="post" >
				<input type="hidden"  name="userids" id="userAndRoleId" >
				<input type="hidden"  name="names" id="userAndRoleNames" >
				<c:forEach items="${sysRoles}" var="sysRole">
					<input type="checkbox" name="roleids" style="width: 20px;" value="${sysRole.id }~${sysRole.name }" roleNames="${sysRole.name }">${sysRole.name }<br/>
				</c:forEach>
				</form>
			</div>
		
                
		
		
		
	</body>
	
			
</html>