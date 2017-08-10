<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<script type="text/javascript">
		 	// 上移，需要进行封装
			function moveUp(){
			 	var totalChildCount = 0;
				var currNodeIndex = 0;
			 	// 1：获取当前选择
				var selectNode = $('#alltreeId').tree('getSelected');
				var findPreNode ;
				// 2：获取父节点
				var fatherNode = $('#alltreeId').tree('getParent', selectNode.target);
				if(fatherNode != null){ // 存在父节点
					// 3：获取所有的父节点的子节点
					var childNodes = $('#alltreeId').tree('getData', fatherNode.target);
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
					var currNodeChilds = $('#alltreeId').tree('getData', selectNode.target);
					// 删除当前节点
					$('#alltreeId').tree('remove', selectNode.target);
					// 添加新节点
					$('#alltreeId').tree('insert', {
						before: preNode.target,
						data: currNodeChilds
					});
					var newChildNodes = $('#alltreeId').tree('getData', fatherNode.target);
	 				// 重新选择该节点
					var newNode = newChildNodes.children[currNodeIndex-1];
					$('#alltreeId').tree('select', newNode.target);
				}else{
					// 3：获取所有的父节点的子节点
					var childNodes = $('#alltreeId').tree('getRoots');
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
					var currNodeChilds = $('#alltreeId').tree('getData', selectNode.target);
					// 删除当前节点
					$('#alltreeId').tree('remove', selectNode.target);
					// 添加新节点
					$('#alltreeId').tree('insert', {
						before: preNode.target,
						data: currNodeChilds
					});
	 				// 重新选择该节点
					var newChildNodes = $('#alltreeId').tree('getRoots');
					var newNode = newChildNodes[currNodeIndex-1];
					$('#alltreeId').tree('select', newNode.target);
				}
				// 向后台发送请求，当前节点值（newNode.id），当前角标值（newNode.orderId - 1）
				$.post("${rootPath}/sysRightController/sysright/moveUpSysright", 
						{"nodeId":selectNode.id, "preNodeId":findPreNode.id}
				);
			 }

			// 下移，需要进行封装
			function moveDown(){
			 	var totalChildCount = 0;
				var currNodeIndex = 0;
			 	// 1：获取当前选择
				var selectNode = $('#alltreeId').tree('getSelected');
				var findNextNode ;
				// 2：获取父节点
				var fatherNode = $('#alltreeId').tree('getParent', selectNode.target);
				if(fatherNode != null){ // 存在父节点
					// 3：获取所有的父节点的子节点
					var childNodes = $('#alltreeId').tree('getData', fatherNode.target);
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
					var currNodeChilds = $('#alltreeId').tree('getData', selectNode.target);
					// 删除当前节点
					$('#alltreeId').tree('remove', selectNode.target);
					// 添加新节点
					$('#alltreeId').tree('insert', {
						after: preNode.target,
						data: currNodeChilds
					});
					var newChildNodes = $('#alltreeId').tree('getData', fatherNode.target);
	 				// 重新选择该节点
					var newNode = newChildNodes.children[currNodeIndex+1];
					$('#alltreeId').tree('select', newNode.target);
				}else{
					// 3：获取所有的父节点的子节点
					var childNodes = $('#alltreeId').tree('getRoots');
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
					var currNodeChilds = $('#alltreeId').tree('getData', selectNode.target);
					// 删除当前节点
					$('#alltreeId').tree('remove', selectNode.target);
					// 添加新节点
					$('#alltreeId').tree('insert', {
						after: preNode.target,
						data: currNodeChilds
					});
	 				// 重新选择该节点
					var newChildNodes = $('#alltreeId').tree('getRoots');
					var newNode = newChildNodes[currNodeIndex+1];
					$('#alltreeId').tree('select', newNode.target);
				}
				// 向后台发送请求，当前节点值（newNode.id），当前角标值（newNode.orderId - 1）
				$.post("${pageContext.request.contextPath}/sysRightController/sysright/moveDownSysright", 
						{"nodeId":selectNode.id, "nextNodeId":findNextNode.id}
				);
			 }
		</script>
	</head>
	<body>
    <table class="defaulttableStyle" cellspacing="1px">
             <tr style="height: 35px">
                 <th colspan="2" style="text-align: left">
                     <div id="currentdept901">当前选择功能：${sysRight.name }</div>
                     <input type="hidden" id="hiddenNodeId" value="${sysRight.id }"></input>
                 </th>
             </tr>
<%--             <tr style="height: 35px">--%>
<%--                 <td style="width: 120px">--%>
<%--                     <div>功能编码</div>--%>
<%--                 </td>--%>
<%--                 <td>--%>
<%--                     <div id="deptnum901">${sysRight.nodeid }</div>--%>
<%--                 </td>--%>
<%--             </tr>--%>
             <tr style="height: 35px">
                 <td>功能名称</td>
                 <td>
                     <div id="deptname901">${sysRight.name }</div>
                 </td>
             </tr>
             <tr style="height: 35px">
                 <td>页面路径</td>
                 <td>
                     <div id="depttype901">${sysRight.url }</div>
                 </td>
             </tr>
             <c:if test="${CANADD>0 }">
             <tr style="height: 35px">
                 <td>修改排序</td>
                 <td>
                 	<a id="btnup" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-up'" onclick="moveUp();">上移节点</a>  
                 	<a id="btndown" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-down'" onclick="moveDown();">下移节点</a>  
                 </td>
             </tr>
             </c:if>
             <tr style="height: 35px">
                 <td>子  功  能</td>
                 <td>
                     <div id="depttype901">
                     	<c:forEach items="${allfuns}" var="fun">
							<input type="checkbox" <c:if test="${fun.value > 0}">checked="checked"</c:if> disabled="disabled" style="width: 13px;" >${fun.key }</input>
						</c:forEach>
                     </div>
                 </td>
             </tr>
         </table>
           <div id="adddeptpanel901" title="添加组织机构" class="easyui-dialog" 
				data-options="width:400,height:280,closed:true,buttons:[{text:'确定',iconCls:'icon-ok',handler:function(){var vd=$('#addSysRightFormId').form('validate');if(vd){$('#addSysRightFormId').submit();}}},{text:'取消',iconCls:'icon-cancel',handler:function(){$('#adddeptpanel901').dialog('close');}}]">  
		 </div> 
         
   </body>   
   
   

         
</html>