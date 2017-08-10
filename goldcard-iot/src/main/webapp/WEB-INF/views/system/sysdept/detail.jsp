<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
		 	// 上移，需要进行封装
			function moveUp(){
			 	var totalChildCount = 0;
				var currNodeIndex = 0;
			 	// 1：获取当前选择
				var selectNode = $('#treemenu901').tree('getSelected');
				var findPreNode ;
				// 2：获取父节点
				var fatherNode = $('#treemenu901').tree('getParent', selectNode.target);
				if(fatherNode != null){ // 存在父节点
					// 3：获取所有的父节点的子节点
					var childNodes = $('#treemenu901').tree('getData', fatherNode.target);
					var brotherNodeids = childNodes.children;
					var totalChildCount = brotherNodeids.length;
					for(var i = 0; i < totalChildCount; i ++ ){
						var chNode =  brotherNodeids[i];
						if(chNode.id == selectNode.id){
							currNodeIndex = i;
						}
					}
					if(currNodeIndex == 0){
						$.messager.alert("提示","当前节点为最高节点，不能再进行上移操作！","warning");
						return false;
					}
					//获取上一个节点
					var preNode = brotherNodeids[currNodeIndex-1];
					findPreNode = preNode;
					var currNodeChilds = $('#treemenu901').tree('getData', selectNode.target);
					// 删除当前节点
					$('#treemenu901').tree('remove', selectNode.target);
					// 添加新节点
					$('#treemenu901').tree('insert', {
						before: preNode.target,
						data: currNodeChilds
					});
					var newChildNodes = $('#treemenu901').tree('getData', fatherNode.target);
	 				// 重新选择该节点
					var newNode = newChildNodes.children[currNodeIndex-1];
					$('#treemenu901').tree('select', newNode.target);
				}else{
					// 3：获取所有的父节点的子节点
					var childNodes = $('#treemenu901').tree('getRoots');
					// 4：获取兄弟节点
					for(var i = 0; i < childNodes.length ; i++){
						var chNode = childNodes[i];
						if(chNode.id == selectNode.id){
							currNodeIndex = i;
						}
					}
					if(currNodeIndex == 0){
						$.messager.alert("提示","当前节点为最高节点，不能再进行上移操作！","warning");
						return false;
					}
					//获取上一个节点
					var preNode = childNodes[currNodeIndex-1];
					findPreNode = preNode;
					var currNodeChilds = $('#treemenu901').tree('getData', selectNode.target);
					// 删除当前节点
					$('#treemenu901').tree('remove', selectNode.target);
					// 添加新节点
					$('#treemenu901').tree('insert', {
						before: preNode.target,
						data: currNodeChilds
					});
	 				// 重新选择该节点
					var newChildNodes = $('#treemenu901').tree('getRoots');
					var newNode = newChildNodes[currNodeIndex-1];
					$('#treemenu901').tree('select', newNode.target);
				}
				// 向后台发送请求，当前节点值（newNode.id），当前角标值（newNode.orderId - 1）
				$.post("${rootPath}/systemController/sysDept/moveSysDept", 
						{"currSysDeptId":selectNode.id, "moveSysDeptId":findPreNode.id},
						function(data){
							if(data<1){
								//$.messager.alert("提示", "上移成功！","info");
							}else{
								$.messager.alert("提示", "上移失败！","error");
							}
						}
				);
			 }

			// 下移，需要进行封装
			function moveDown(){
			 	var totalChildCount = 0;
				var currNodeIndex = 0;
			 	// 1：获取当前选择
				var selectNode = $('#treemenu901').tree('getSelected');
				var findNextNode ;
				// 2：获取父节点
				var fatherNode = $('#treemenu901').tree('getParent', selectNode.target);
				if(fatherNode != null){ // 存在父节点
					// 3：获取所有的父节点的子节点
					var childNodes = $('#treemenu901').tree('getData', fatherNode.target);
					var brotherNodeids = childNodes.children;
					var totalChildCount = brotherNodeids.length;
					for(var i = 0; i < totalChildCount; i ++ ){
						var chNode =  brotherNodeids[i];
						if(chNode.id == selectNode.id){
							currNodeIndex = i;
						}
					}
					if(currNodeIndex == totalChildCount-1){
						$.messager.alert("提示", "当前节点为最低节点，不能再进行下移操作！","warning");
						return false;
					}
					//获取下一个节点
					var preNode = brotherNodeids[currNodeIndex+1];
					findNextNode = preNode;
					var currNodeChilds = $('#treemenu901').tree('getData', selectNode.target);
					// 删除当前节点
					$('#treemenu901').tree('remove', selectNode.target);
					// 添加新节点
					$('#treemenu901').tree('insert', {
						after: preNode.target,
						data: currNodeChilds
					});
					var newChildNodes = $('#treemenu901').tree('getData', fatherNode.target);
	 				// 重新选择该节点
					var newNode = newChildNodes.children[currNodeIndex+1];
					$('#treemenu901').tree('select', newNode.target);
				}else{
					// 3：获取所有的父节点的子节点
					var childNodes = $('#treemenu901').tree('getRoots');
					// 4：获取兄弟节点
					for(var i = 0; i < childNodes.length ; i++){
						var chNode = childNodes[i];
						if(chNode.id == selectNode.id){
							currNodeIndex = i;
						}
					}
					if(currNodeIndex == childNodes.length -1 ){
						$.messager.alert("提示", "当前节点为最低节点，不能再进行下移操作！","warning");
						return false;
					}
					//获取上一个节点
					var preNode = childNodes[currNodeIndex+1];
					findNextNode = preNode;
					var currNodeChilds = $('#treemenu901').tree('getData', selectNode.target);
					// 删除当前节点
					$('#treemenu901').tree('remove', selectNode.target);
					// 添加新节点
					$('#treemenu901').tree('insert', {
						after: preNode.target,
						data: currNodeChilds
					});
	 				// 重新选择该节点
					var newChildNodes = $('#treemenu901').tree('getRoots');
					var newNode = newChildNodes[currNodeIndex+1];
					$('#treemenu901').tree('select', newNode.target);
				}
				// 向后台发送请求，当前节点值（newNode.id），当前角标值（newNode.orderId - 1）
				$.post("${rootPath}/systemController/sysDept/moveSysDept", 
						{"currSysDeptId":selectNode.id, "moveSysDeptId":findNextNode.id},
						function(data){
							if(data<1){
								//$.messager.alert("提示", "下移成功！","info");
							}else{
								$.messager.alert("提示", "下移失败！","error");
							}
						}
				);
			 }
		</script>
		
<table class="dept-tbl" cellspacing="0">
	<tr>
		<th colspan="2" style="text-align: left">
			<div id="currentdept901">当前选择组织：${sysDept.name }
			</div>
		</th>
	</tr>
<%--	<tr>--%>
<%--		<td class="tit">--%>
<%--			<div>--%>
<%--				组织编码：--%>
<%--			</div>--%>
<%--		</td>--%>
<%--		<td>--%>
<%--			<div id="deptnum901">--%>
<%--				${sysDept.no }--%>
<%--			</div>--%>
<%--		</td>--%>
<%--	</tr>--%>

	<tr>
		<td class="tit">
			组织名称：
		</td>
		<td>
			<div id="deptname901">
				${sysDept.name }
			</div>
		</td>
	</tr>
	<tr>
		<td class="tit">
			组织简称：
		</td>
		<td>
			<div id="deptname901">
				${sysDept.shortname }
			</div>
		</td>
	</tr>
	<tr>
		<td class="tit">
			组织类型：
		</td>
		<td>
			<div id="depttype901">
						${sysDept.typeName }
			</div>
		</td>
	</tr>
	<tr>
		<td class="tit">
			组织经度：
		</td>
		<td>
			<div id="depttype901">
				${sysDept.longitude }
			</div>
		</td>
	</tr>
	<tr>
		<td class="tit">
			组织纬度：
		</td>
		<td>
			<div id="depttype901">
				${sysDept.latitude }
			</div>
		</td>
	</tr>
<!-- 	<tr> -->
<!-- 		<td class="tit"> -->
<!-- 			组织边界： -->
<!-- 		</td> -->
<!-- 		<td> -->
<!-- 			<div id="depttype901"> -->
<%-- 				${sysDept.coordinates } --%>
<!-- 			</div> -->
<!-- 		</td> -->
<!-- 	</tr> -->
		<tr>
			<td class="tit">
				修改排序：
			</td>
			<td>
				<div id="deptname901">
					<a id="btnup"   href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-up',plain:true" onclick="moveUp();">上移节点</a>  
	                <a id="btndown" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-down',plain:true" onclick="moveDown();">下移节点</a>  
				</div>
			</td>
		</tr>
</table>
