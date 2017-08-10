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
				// 展开所有的节点
				onLoadSuccess:function(node, data){ 
					//expandAll('alltreeId');
				} ,
				onSelect:function(node){
					// 这里需要在看看easyui的tree中是否可以进行传值，这里只能这么做
					var selectNode = $('#alltreeId').tree("getSelected");
					$('#treemenu901').tree({
						url:'${pageContext.request.contextPath }/systemController/sysdepAndSysright/findAllDeptByRightIdJson?rightId='+selectNode.id
					});
					$('#treemenu901').tree("reload");
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

			// 保存设置
			function  save(){
				// 检查菜单
				var sysrightroots = $('#alltreeId').tree("getChecked");
				if(sysrightroots.length<1){
					$.messager.alert('提示','请选择要操作的菜单','warning');
					return false; 
				}
				// 检查组织机构
				var sysdeptroots = $('#treemenu901').tree("getChecked");
				
				// 遍历菜单
				var sysrights = '';
				for(var i=0; i<sysrightroots.length; i++){
					if (sysrights != '') sysrights += ',';
					sysrights += sysrightroots[i].id;
				}
				
				// 遍历指标
				var sysdepts = '';
				for(var i=0; i<sysdeptroots.length; i++){
					if (sysdepts != '') sysdepts += ',';
					sysdepts += sysdeptroots[i].id;
				}

				$.messager.confirm("警告", "你确定要保存当前数据吗?" , function(r){
					if(r){
						// 向后台发送
						$.post("${pageContext.request.contextPath}/systemController/sysdeptandsysright/saveSysdeptAndSysrights?random="+Math.random(), {
								"sysrights":sysrights,
								"sysdepts":sysdepts
							}, function(data){
								if(data < 1 ){
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
	<!-- 主面板 -->
	<body class="easyui-layout">
		<div data-options="region:'west',split:true" class="w-width" style="width:400px\9;">
			<div class="option-btns-area">
				<a class="easyui-linkbutton" data-options="iconCls:'open-icon'" href="javascript:void(0)" onclick="expandAll('alltreeId')">全部展开</a>
				<a class="easyui-linkbutton" data-options="iconCls:'close-icon'" href="javascript:void(0)" onclick="collapseAll('alltreeId')">全部关闭</a>
				<a class="easyui-linkbutton" data-options="iconCls:'checked-icon'" href="javascript:void(0)" onclick="selectAll('alltreeId')">全部选中</a>
				<a class="easyui-linkbutton" data-options="iconCls:'check-icon'" href="javascript:void(0)" onclick="uncheckAll('alltreeId')">全部不选</a>
			</div>
			<ul id="alltreeId" class="easyui-tree tree-ul" data-options="url:'${pageContext.request.contextPath }/sysRight/list/findAllSysRight',checkbox:true"></ul>
        </div>

		<div data-options="region:'center'">
			<div class="option-btns-area">
				<a class="easyui-linkbutton" data-options="iconCls:'open-icon'" href="javascript:void(0)" onclick="expandAll('treemenu901')">全部展开</a>
				<a class="easyui-linkbutton" data-options="iconCls:'close-icon'" href="javascript:void(0)" onclick="collapseAll('treemenu901')">全部关闭</a>
				<a class="easyui-linkbutton" data-options="iconCls:'checked-icon'" href="javascript:void(0)" onclick="selectAll('treemenu901')">全部选中</a>
				<a class="easyui-linkbutton" data-options="iconCls:'check-icon'" href="javascript:void(0)" onclick="uncheckAll('treemenu901')">全部不选</a>
			</div>
            <ul id="treemenu901" class="easyui-tree tree-ul" data-options="url:'${pageContext.request.contextPath }/systemController/sysUser/sysDept/list?isConfig=1',checkbox:true"></ul>
		</div>
		
				<!-- 页面的内容显示部分 -->
		<div data-options="region:'south',border:false" id="detailId"  style="width:100%" >
			<a class="easyui-linkbutton save-set-btn" data-options="iconCls:'save-icon'" href="javascript:void(0)" onclick="save()">保存设置</a>
		</div> 
	</body>
</html>