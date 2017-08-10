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
			// 只要加载之后
			$('#alltreeId').tree({
				onCheck:function(node,checked){
					if(checked){
						flag = false;
						var isLeaf = $('#alltreeId').tree('isLeaf',node.target);
						if(isLeaf==true){
							var snodes = $('#alltreeId').tree("getChecked");
							for(var i = 0; i < snodes.length; i++){
								if(snodes[i].id != node.id){
									$('#alltreeId').tree('uncheck',snodes[i].target);
								}
							}
							var t=new Date().getTime()
							var url = '${pageContext.request.contextPath }/systemController/sysUser/sysDept/getCusDeptIds/'+node.id+'?t='+t;
							$.get(url, function(result){
								setSelect(result);
						  	});
						}
					}
				},
				onClick:function(node){
					// 
					var closeSta = node.state;
					var nodeId = node.id;
					if(closeSta=="closed"){ // 打开子节点
						$('#alltreeId').tree("expand", node.target);
					}else if(closeSta=='open'){ // 关闭子节点
						$('#alltreeId').tree("collapse", node.target);
					}else{ // 叶子节点
						$('#alltreeId').tree("check", node.target);
					}
					
				} 
			}); 
			
			$('#treemenu901').tree({
				onCheck:function(node,checked){
					if(checked){
						var pnode = $('#treemenu901').tree('getParent',node.target);
						if(pnode != null) {
							$('#treemenu901').tree('check', pnode.target);
						}
					} else {
						var childs = $('#treemenu901').tree('getChildren',node.target);
						for(var i = 0; i < childs.length; i++){
							$('#treemenu901').tree('uncheck', childs[i].target);
						}
					}
				}
			});
			
			
		});

		
		// 周恪竭：展开权限树
		function expandAll(treeid){
			 $('#'+treeid).tree("expandAll");
		}
		// 周恪竭：折叠所有节点
		function collapseAll(treeid){
			 $('#'+treeid).tree("collapseAll");
		}
		
		// 周恪竭：选中所有节点
		function selectAll(treeid){
			 var root = $('#'+treeid).tree("getRoot");
			 var childs = $('#'+treeid).tree('getChildren',root.target);
			 for(var i = 0; i < childs.length; i++){
			 	 $('#'+treeid).tree('check', childs[i].target);
			 }
			 return;
			 $('#'+treeid).tree("expandAll");
			 var roots = $('#'+treeid).tree("getRoots");
			 var s = '';
			for(var i=0; i<roots.length; i++){
				if (s != '') s += ',';
				s += roots[i].id;
				// 获取所有的顶级菜单
				var node = $('#'+treeid).tree('find', roots[i].id);
				$('#'+treeid).tree('check', node.target);
			}
			// 为了进行测试
			//alert(s);
		}
		
		// 周恪竭：选中所有节点
		function uncheckAll(treeid){
			 $('#'+treeid).tree("expandAll");
			 var roots = $('#'+treeid).tree("getRoots");
			 var s = '';
			for(var i=0; i<roots.length; i++){
				if (s != '') s += ',';
				s += roots[i].id;
				// 获取所有的顶级菜单
				var node = $('#'+treeid).tree('find', roots[i].id);
				$('#'+treeid).tree('uncheck', node.target);
			}
			for(var i=0; i<roots.length; i++){
				if (s != '') s += ',';
				s += roots[i].id;
				// 获取所有的顶级菜单
				var node = $('#'+treeid).tree('find', roots[i].id);
				$('#'+treeid).tree('uncheck', node.target);
			}
		}
		
		//根据返回结果更新右侧组织机构树
		function setSelect(arr){
			var ctree = $('#treemenu901');
			var root = ctree.tree('getRoot');
			var childs = ctree.tree('getChildren',root.target);
			ctree.tree('uncheck', root.target);
			for(var i = 0; i < childs.length; i++){
				ctree.tree('uncheck', childs[i].target);
			}
			if (arr){
				var node = null;
				for (var j = 0; j < arr.length; j++){
					node = ctree.tree('find', arr[j]);
					ctree.tree('check', node.target);
				}
			}
		}

		// 保存设置
		function  save(){
			var rightIds = "";
			var sysrightroots = $('#alltreeId').tree("getChecked");
			if(sysrightroots.length<1){
				$.messager.alert('提示','请选择要操作的菜单','warning');
				return; 
			} else {
				for(var i = 0; i < sysrightroots.length; i++){
					rightIds += sysrightroots[i].id+",";
				}
			}
			rightIds = rightIds.length > 1 ? rightIds.substring(0,rightIds.length - 1) : rightIds;
			
			var deptIds="";
			var ctree = $('#treemenu901');
			var nodes=ctree.tree("getChecked","indeterminate");
            for(var i=0;i<nodes.length;i++){
            	deptIds += nodes[i].id+",";
            }
			
			nodes=ctree.tree("getChecked");
            for(var i=0;i<nodes.length;i++){
            	deptIds += nodes[i].id+",";
            }
            
            deptIds = deptIds.length > 1 ? deptIds.substring(0,deptIds.length - 1) : deptIds;
            if(deptIds.length < 1){
            	$.messager.alert('提示','请选择要操作的组织机构','warning');
				return; 
            }
            
			$.messager.confirm("警告", "你确定要保存当前数据吗?" , function(r){
				if(r){
					// 向后台发送
					$.post("${pageContext.request.contextPath}/systemController/sysdeptandsysright/saveSysright2SysDept?random="+Math.random(), {
							"rightIds":rightIds,
							"deptIds":deptIds
						}, function(data){
							if(data == "1"){
								$.messager.alert('提示','操作成功！','info');
							}else{
								$.messager.alert('提示','操作失败！','error');
							}
						}
					);
				}
			});
		}
	</script>
</head>
	<body class="easyui-layout">
		<div data-options="region:'south',border:false" id="detailId"  style="width:100%" >
			<a class="easyui-linkbutton save-set-btn" data-options="iconCls:'save-icon'" href="javascript:void(0)" onclick="save()">保存设置</a>
		</div> 
		<div data-options="region:'west',split:true" class="w-width" style="width:400px; ">
			<div class="easyui-layout" fit="true">
				<div data-options="region:'north',border:false" class="option-btns-area" style="margin:0;">
					<a class="easyui-linkbutton" data-options="iconCls:'open-icon'" href="javascript:void(0)" onclick="expandAll('alltreeId')">全部展开</a>
					<a class="easyui-linkbutton" data-options="iconCls:'close-icon'" href="javascript:void(0)" onclick="collapseAll('alltreeId')">全部关闭</a>
					<!-- 
					<a class="easyui-linkbutton" data-options="iconCls:'checked-icon'" href="javascript:void(0)" onclick="selectAll('alltreeId')">全部选中</a>
					<a class="easyui-linkbutton" data-options="iconCls:'check-icon'" href="javascript:void(0)" onclick="uncheckAll('alltreeId')">全部不选</a>
					 -->
				</div>
				<div data-options="region:'center',border:false ">
					<ul style="padding:5px 0;" id="alltreeId" class="easyui-tree tree-ul" data-options="url:'${pageContext.request.contextPath }/sysRight/list/findAllSysRight',checkbox:true,onlyLeafCheck:true"></ul>
				</div>
			</div>
        </div>

		<div data-options="region:'center'">
			<div class="easyui-layout" fit="true">
				<div data-options="region:'north',border:false" class="option-btns-area" style="margin:0;">
					<a class="easyui-linkbutton" data-options="iconCls:'open-icon'" href="javascript:void(0)" onclick="expandAll('treemenu901')">全部展开</a>
					<a class="easyui-linkbutton" data-options="iconCls:'close-icon'" href="javascript:void(0)" onclick="collapseAll('treemenu901')">全部关闭</a>
					<a class="easyui-linkbutton" data-options="iconCls:'checked-icon'" href="javascript:void(0)" onclick="selectAll('treemenu901')">全部选中</a>
					<a class="easyui-linkbutton" data-options="iconCls:'check-icon'" href="javascript:void(0)" onclick="uncheckAll('treemenu901')">全部不选</a>
				</div>
				<div data-options="region:'center',border:false">
	            	<ul style="padding:5px 0;" id="treemenu901" class="easyui-tree tree-ul" data-options="url:'${pageContext.request.contextPath }/systemController/sysUser/sysDept/listDept',checkbox:true,cascadeCheck:false"></ul>
	            <div data-options="region:'center',border:false">
	        </div>
		</div>
		
		<!-- 页面的内容显示部分 -->
	</body>
</html>