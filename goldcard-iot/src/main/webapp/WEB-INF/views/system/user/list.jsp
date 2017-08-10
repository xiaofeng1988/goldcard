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
					url:'${rootPath }/systemController/dept/tree',
					// 注册数据加载完成事件
					onLoadSuccess:function(){
						var node = $('#alltreeId').tree('getRoot');
						$('#alltreeId').tree('select', node.target);
						$("#alltreeId").tree('expand', node.target);
					},
					// 根据当前节点获取用户信息
					onClick:function(node){
						$('#test').datagrid('uncheckAll');   
						$('#test').datagrid('load',getSearchParam());	
					}
				});	

				
				// 定义数据表
				var iCount=getAutoRowCount(); 
				$('#test').datagrid({
					toolbar: '#tbId',
					iconCls:'icon-save',
					width:890,
					height:470,
					nowrap: true,
					autoRowHeight: false,
					striped: true,
					remoteSort: false,
					singleSelect:false,
					pagination:true,
					scrollbarSize:0,
				//  showPageList:false,
					pageList:[iCount,2*iCount,3*iCount],
				//	queryParams:getSearchParam(),
					url:'${rootPath}/systemController/sysUser/findSysUserPageByDeptId',
					columns:[[   
							  {field:'ck',checkbox:true},
					          {field:'deptName',title:'组织简称',width:$(this).width() * 0.1,align:'center'},  
// 					          {field:'no',title:'用户编号',width:80,sortable:true},  
					          {field:'name',title:'用户姓名',align:'center',width:$(this).width() * 0.1,sortable:true,
					        	 formatter:function(value,row,index){
					        	  	if(${CANUPDATE>0}){
										return "<a href='#' onclick='editSysUserByUserId("+row.id+")' >"+row.name+"</a>";
									}else{
										return row.name;
									}
								 },
								 styler:function(){
								 	return("background:#edf7ff;color:#0963b1;");
								 }
							  },   
					          {field:'loginname',title:'登录名',width:$(this).width() * 0.1,sortable:true},   
					          {field:'sex',title:'性别',width:$(this).width() * 0.1,
						          formatter: function(value,row,index){
										if ('Y' == value){
											return "男";
										} else {
											return "女";
										}
									}
								},  
							{field:'phone',title:'固话',width:$(this).width() * 0.1}, 
							{field:'mobile',title:'手机',width:$(this).width() * 0.1}, 
							{field:'email',title:'邮箱',width:$(this).width() * 0.1},
					        {field:'opt',title:'设置权限',width:$(this).width() * 0.14,
									formatter:function(value,row,index){
										if(${CANMANAGER>0}){
											return "<a href='#' onclick='updatePermissionByUserId("+row.id+")' >设置权限</a>";
										}else{
											return "<span style='color:#999'>设置权限</span>";
										}
									}
							  }
					      ]],
					onLoadSuccess:function(data){
						$(this).datagrid('doCellTip',{'max-width':'300px','delay':100});
					}
				});


					
				// 周恪竭：添加，修改用户信息的dialog
				$("#sysUserPersionId").dialog({
					width: 450,
		            height: 440,
		 			iconCls:'add-user-icon',
		 			modal:true,
		 			closed:true,
		 			resizable:false,
		 			buttons: [{
							text:'保存',
							iconCls:'icon-ok',
							handler:function(){
				 				$('#addSysRightFormId').form({   
								    url:"${rootPath }/systemController/sysUser/saveSysUser",   
								    onSubmit: function(){ 
// 								    	var hiddenValidataUserId = $("#hiddenValidataUserId").val();
// 								    	if(hiddenValidataUserId < 1){
// 								    		$.messager.alert("提示", "用户信息未通过校验，不能进行保存！","warning");	
// 								    		return false;
// 									    }
										return $("#addSysRightFormId").form("validate");
									},   
								    success:function(data){  
										$('#sysUserPersionId').dialog('close'); 
									    var result=eval('('+data+')');
							   			if(result.success){ 
							   				$.messager.alert("提示", "保存成功！","info");	 
							   			   }else{
							   				$.messager.alert("提示", "保存失败！","error");
							   			}
									    var selectNode = $("#alltreeId").tree("getSelected");
									    if(selectNode == null){
									    	selectNode = $('#alltreeId').tree('getRoot');
										}
										$('#test').datagrid('load',{
											'deptid':selectNode.id
										});	
								    }   
								});   
								$('#addSysRightFormId').submit();
		 					}
						},{
							text:'关闭',
		                    iconCls:'icon-cancel',
							handler:function(){$('#sysUserPersionId').dialog('close');}
						}]
				});	

					
				// 
				$("#test123").dialog({
					width: 450,
		            height: 500,
		 			iconCls:'icon-add',
		 			resizable:true,
		 			modal:true,
		 			closed:true,
		 			resizable:false,
		 			buttons: [{
							text:'保存权限',
							iconCls:'icon-ok',
							handler:function(){
				 				$("#sysUserPersionFormId").form({
									onSubmit:function(){
										//实心圆节点
										var rnodes = $('#permissionttId').tree('getChecked','indeterminate');
										//叶子节点选中
										var nodes = $('#permissionttId').tree('getChecked');
										var s = '';
										for(var i=0; i<rnodes.length; i++){  
							                if (s != ''){ s += ','};  
							                s += rnodes[i].id;  
							            }  
										for(var i=0; i<nodes.length; i++){
											if (s != '') s += ',';
											s += nodes[i].id;
										}
										$("#typeofwork").val(s);
									},
									success:function(data){
										if('Y' == data){
											$.messager.alert("提示", "保存成功！","info");
											$('#test123').dialog('close');
										}else{
											$.messager.alert("提示", "保存失败！","error");
										}
									}
								});
								$("#sysUserPersionFormId").submit();
		 				
		 					}
						},{
							text:'关闭',
		                    iconCls:'icon-cancel',
							handler:function(){$('#test123').dialog('close');}
						}]
				});		



				$("#adddeptpanelSave901").click(function(){
					var vd = $('#addSysDeptFormId').form("validate");  
					if(vd){
						$('#addSysDeptFormId').submit();  
					}
				});	


				// 周恪竭：注册查询功能
				/*$("#searchId").click(function(){
					var node = $("#alltreeId").tree("getSelected");
					$("#searchdivid").window('open');
				});*/

			});


			
			// 返回
			function goBack(){
				// 比较好的方法是重新请求数据，树不动；最好的是记录上次数据，这里不想麻烦
				window.location.href="${rootPath}/systemController/user/list";
			}

			// 周恪竭：选择用户角色
			function searchRole(){
				$('#roleid').window('open');  // 打开角色窗口
			}
			
			
			// 周恪竭：保存用户信息
			function savaSysRight(){
				var vd = $("#addSysRightFormId").form("validate"); // 校验
				if(vd){
					$("#addSysRightFormId").submit();   // 表单提交
				}
			}


			// 周恪竭：根据用户id修改用户信息
			function editSysUserByUserId(userId){
				$("#sysUserPersionId").dialog("refresh", '${rootPath}/systemController/sysUser/'+userId+'/editSysUserByUserId');
				$("#sysUserPersionId").dialog({
					title:'修改用户',
					iconCls:'edit-user-icon'
				});
				$.parser.parse("#sysUserPersionId");
				$("#sysUserPersionId").dialog("open");
			}

			// 周恪竭：为用户设置权限
			function updatePermissionByUserId(userId){
				// 一般用户不能为管理员进行分配权限，只能是管理员自己进行更新
				var node = $("#alltreeId").tree("getSelected");
				$('#test123').dialog('refresh', '${rootPath}/systemController/sysUser/'+userId+'/updatePermissionByUserId');  
				//$('#test123').dialog({
					//title:'当前选择部门：'+node.text
				//});
				$('#test123').dialog('open');
			}

			// 周恪竭：关闭查询窗口
			function closeSearch(){
				$("#snameId").val("");
				$("#sloginNameId").val("");
				$("#searchdivid").window("close");
			}
			
			
			// 周恪竭:关闭设置用户权限窗口
			function closePermission(){
				$('#sysUserPersionId').dialog('close');
			}

			// 周恪竭：保存用户权限
			function savePermission(){
				$("#sysUserPersionFormId").form({
					onSubmit:function(){
						var nodes = $('#permissionttId').tree('getChecked');
						var s = '';
						for(var i=0; i<nodes.length; i++){
							if (s != '') s += ',';
							s += nodes[i].id;
						}
						$("#typeofwork").val(s);
					},
					success:function(data){
						if('ok' == data){
							$.messager.alert("提示", "权限设置成功！","info");
							
						}else{
							$.messager.alert("提示", "权限设置失败！","error");
						}
						$('#sysUserPersionId').dialog('close');
					}
				});
				$("#sysUserPersionFormId").submit();
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


			// 周恪竭：查询用户信息
			function searchSysUser(){
				$("#searchdivid").window("close");
				$('#test').datagrid('loading');
				$('#test').datagrid('load',getSearchParam()); 
				$("#snameId").val("");
				$("#sloginNameId").val("");
			}
			
			function addClick(){
				var node = $('#alltreeId').tree('getSelected');
				var nodeid = 0;
				// 判断当前树中是否有选中节点，如果有就是在下面建立子节点，如果没有就是建立一级菜单，默认是添加一级菜单
				if(node){
					nodeid = node.id; // 如果当前节点为真就在当前节点下添加节点
				}
				$("#sysUserPersionId").dialog("refresh", '${rootPath}/systemController/sysUser/'+nodeid+'/addSysUser');
				$("#sysUserPersionId").dialog({
					title:'添加用户',
					iconCls:'add-user-icon'
				});
				$.parser.parse("#sysUserPersionId");
				$("#sysUserPersionId").dialog("open");
			}
			
			function editClick(){
			     var rows = $("#test").datagrid('getChecked');  
	       		 if(rows.length==1){
	       		      var row=rows[0];  
	       			  editSysUserByUserId(row.id);
	       		   }else{
	       			$.messager.alert('提示','请选择一条修改信息!','info');  
	       		   }
			}
			
			function deleteClick(){
				var nodes = $('#test').datagrid('getChecked');
				var ids = [];
				var names = [];
				for(var i = 0; i < nodes.length; i ++){
					ids.push(nodes[i].id);
					names.push(nodes[i].name);
				}
				ids.join(",");
				//alert(ids);
				names.join(",");
				//alert(names);
				if(nodes.length > 0){
					$.messager.confirm("警告", "你确定要删除当前数据吗?" , function(r){
						if(r){
							// 如果确定要删除当前记录
							$.post('${rootPath}/systemController/sysUser/deleteSysUser?ids='+ids+'&userNames='+names, null, function(data){
								// 如果返回状态为ok，就重新加载当前数据
								var result=eval('('+data+')');
					   			if(result.success){ 
					   				$.messager.alert("提示", "删除成功！","info");	 
					   			   }else{
					   				$.messager.alert("提示", "删除失败！","error");
					   			}
								
								var selectNode = $("#alltreeId").tree("getSelected");
							    if(selectNode == null){
							    	selectNode = $('#alltreeId').tree('getRoot');
								}
								$('#test').datagrid('load',{
									'deptid':selectNode.id
								});
							});
						}
					});
				}else{
					$.messager.alert('提示','请选择要操作的数据','warning');   
				}
			}
			
			function schClick(){
				var node = $("#alltreeId").tree("getSelected");
				$("#searchdivid").window('open');
			}


	    	//获取查询参数
	    	function getSearchParam(){
				$("#nameId").val(  $("#snameId").val()  );
				$("#loginNameId").val(  $("#sloginNameId").val() );
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
			background:#daedf5 url(${pageContext.request.contextPath }/static/images/hoverheader.gif) repeat-x 0 bottom;}
		</style>
	</head>
	<!-- 主面板 -->
	<body class="easyui-layout">
		<input type="hidden" id="CANMANAGERID" value="${CANMANAGER }">
		<input type="hidden" id="nameId" value="">
		<input type="hidden" id="loginNameId" value="">
		
		<input type="hidden" id="currentUserId" value="${sysuser.id }">
		<div data-options="region:'west',split:true" style="width:200px">
			<ul id="alltreeId"></ul>
		</div>
		<!-- 页面的内容显示部分 -->
		<div data-options="region:'center'" id="detailId" >
			<div style="width:98%;" id="tbId">
				<c:if test="${CANADD>0 }">
					<a href="javascript:void(0);" onclick="addClick();" id="addId" class="easyui-linkbutton" data-options="plain:true,iconCls:'add-user-icon'">添加用户</a>
				</c:if>
				<c:if test="${CANUPDATE>0 }">
					<a href="javascript:void(0);" onclick="editClick();" id="editId" class="easyui-linkbutton" data-options="plain:true,iconCls:'edit-user-icon'">修改用户</a>
				</c:if>
				<c:if test="${CANDELETE>0 }">
					<a href="javascript:void(0);" onclick="deleteClick();" id="deleteId" class="easyui-linkbutton" data-options="plain:true,iconCls:'del-user-icon'">删除用户</a>
				</c:if>
				<a href="javascript:void(0);" id="searchId" onclick="schClick();" class="easyui-linkbutton" data-options="plain:true,iconCls:'sch-icon'">查询用户</a>
			</div>
			<!-- 显示用户列表 -->
			<table id="test">  </table>  
			
			</div>
		
			<div id="test123" title="设置权限"> </div>
		
		<div id="sysUserPersionId" title="添加用户"></div>
		
		
		<div id="searchdivid" class="easyui-window" data-options="title:'查询用户',closed:true,maximizable:false,minimizable:false, collapsible:false, iconCls:'sch-icon'" 
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
	</body>
</html>