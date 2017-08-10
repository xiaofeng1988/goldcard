<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Insert title here</title>
		<jsp:include page="../../common/common.jsp"></jsp:include>
		
		<script type="text/javascript">
			$(function(){
				// 周恪竭：根据nodeid获取子节点信息
				$("#alltreeId").tree({
					url:'${rootPath }/sysRightController/list/findAllSysRight',
					// 当中当前节点的 时候显示当前节点的详细信息
					onClick:function(node){
						$.post('${rootPath}/sysRightController/'+node.id+'/detailSysRight', null, function(data){
							$("#detailId").html(data);
							$.parser.parse("#detailId");
						});
					},
					onLoadSuccess:function(node, data){
						if(node==null){
							$.post('${rootPath}/sysRightController/addDialog', null, function(data){
// 								console.log(data);
								$("#detailId").html(data);
								$.parser.parse("#detailId");
							});
						}
					}
				});

				// 周恪竭：注册添加功能
				$("#addId").click(function(){
					var node = $('#alltreeId').tree('getSelected');
					var nodeid = 0;
					// 判断当前树中是否有选中节点，如果有就是在下面建立子节点，如果没有就是建立一级菜单，默认是添加一级菜单
					if(node){
						nodeid = node.id; // 如果当前节点为真就在当前节点下添加节点
					}
					$("#adddeptpanel901").dialog("refresh", '${rootPath}/sysRightController/'+nodeid+'/addSysRight');
					$("#adddeptpanel901").dialog({
						title:'添加功能信息',
						iconCls:'add-blue-icon',
						modal:true
					});
					$.parser.parse("#adddeptpanel901");
					$("#adddeptpanel901").dialog("open");
					
				});

				// 周恪竭：注册删除功能
				$("#deleteId").click(function(){
					var node = $('#alltreeId').tree('getSelected');
					if(node){
						$.messager.confirm("警告", "你确定要删除当前数据吗?" , function(r){
							if(r){
								$.post("${rootPath}/sysRightController/sysright/deleteSysRight/"+node.id, null, function(data){
									
									if(data > 0){
										$.messager.alert('提示','操作失败','error');   
									}else{
										$.messager.alert('提示','操作成功','info');   
									}
									$('#alltreeId').tree("reload");
								});
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
						
						$("#adddeptpanel901").dialog("refresh", '${rootPath}/sysRightController/'+node.id+'/editSysRight');
						$("#adddeptpanel901").dialog({
							title:'修改功能信息',
							iconCls:'edit-blue-icon',
							modal:true
						});
						$.parser.parse("#adddeptpanel901");
						$("#adddeptpanel901").dialog("open");
					}else{
						$.messager.alert('提示','请选择要操作的菜单','info');   
					}
				});
			});
		</script>
	</head>
	<body>
        <div class="easyui-layout" data-options="fit:true,border:false" >
            <div data-options="border:false,region:'north'" class="panelTopbarStyl">
            <c:if test="${CANADD>0 }">
                <a class="easyui-linkbutton" id="addId" data-options="iconCls:'add-blue-icon',plain:true" >添加功能</a>  
             </c:if>
             <c:if test="${CANDELETE>0 }">
                <a class="easyui-linkbutton" id="deleteId" data-options="iconCls:'delete-icon',plain:true">删除功能</a> 
             </c:if>
             <c:if test="${CANUPDATE>0 }">
                <a class="easyui-linkbutton" id="editId" data-options="iconCls:'edit-blue-icon',plain:true">修改功能</a>
              </c:if>
            </div>
            <div data-options="border:true,region:'west',split:true" style="width: 250px;">
                <ul id="alltreeId"></ul>
            </div>
            <div data-options="border:false,region:'center'"   id="detailId" >
            </div>
        </div>
</body>
</html>