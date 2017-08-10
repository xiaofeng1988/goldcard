<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>组织机构管理</title>
		<jsp:include page="../../common/common.jsp"></jsp:include>
		<script type="text/javascript" src="${pageContext.request.contextPath }/static/js/common/ueditor/ueditor.config.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath }/static/js/common/ueditor/ueditor.all.js"></script>
		<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
		<script type="text/javascript">
	    	var $deptTree=null;
			$(function(){
				var currentOperationNodeId = 0;
				$deptTree=$('#treemenu901');
				var isFirst=true;  //是否首次
				// 1.加载部门树
				$deptTree.tree({
					url:'${rootPath }/systemController/dept/tree',
					lines:true,
					onLoadSuccess:function(){
						if(isFirst){
							var node=$deptTree.tree("getRoot");
							node.target.click();
							isFirst=false;
						}

					},
					// 2.注册数据加载完成事件
					onClick:function(node){
						var closeSta = node.state;
						if(closeSta=="closed"){ // 打开子节点
							$deptTree.tree("collapse", node.target);
						}else if(closeSta=='open'){ // 关闭子节点
							$deptTree.tree("expand", node.target);
						} 
						
						$.post('${rootPath }/systemController/sysDept/'+node.id+'/detailSysDept', null, function(data){
							$("#detailId").html(data);
						});
					}
				});				
				
				// 周恪竭：注册添加功能
				$("#addId").click(function(){
					var node = $deptTree.tree('getSelected');
					if(node == null){
						$.messager.alert('提示','请选择要操作的组织','warning');   
						return false;
					}
					var nodeid = 0;
					// 判断当前树中是否有选中节点，如果有就是在下面建立子节点，如果没有就是建立一级菜单，默认是添加一级菜单
					$('#addSysDeptFormId').form('clear');
					if(node){
						$.ajax({
							url: '${rootPath }/systemController/sysDept/addSysDeptLoad?random='+Math.random(),
							type: "get",
							data:"deptId="+node.id,
							datatype:"json",
							async:false,
							success: function(data){
								// $('#id').val(data.sysDept.id);
								myValidate(data.sysDept.id);
								$('#fatherId').val(data.sysDept.id);
								$('#nameId').val(" ");
								$('#cSelect').empty();
							    $('#cSelect').append(data.sysDept.shortname );
							 	var editor = UE.getEditor('remark');
							 		editor.setContent("");
								$('#adddeptpanel901').panel({title:'添加组织',iconCls:'add-blue-icon'});
								$('#adddeptpanel901').window('open');
							}
						});
					}
					//$('#adddeptpanel901').dialog('setTitle','添加组织').dialog('refresh', '${pageContext.request.contextPath}/systemControllerController/sysDept/'+nodeid+'/addSysDept').dialog('open');  // 
				});

				// 周恪竭：注册删除功能
				$("#deleteId").click(function(){
					var node = $deptTree.tree('getSelected');
					if(node){
						$.messager.confirm("警告", "你确定要删除当前数据吗?" , function(r){
							if(r){
								window.location.href="${rootPath }/systemController/sysDept/deleteSysDept?deptId="+node.id+"&deptName="+node.text;
							}
						});
					}else{
						$.messager.alert('提示','请选择要操作的组织','warning');   
					}
				});

				// 周恪竭：注册修改功能
				$("#editId").click(function(){ 
					var node = $deptTree.tree('getSelected');  
					$('#addSysDeptFormId').form('clear');
					if(node){  
						$.ajax({
							url: '${rootPath }/systemController/sysDept/editSysDept',
							type: "get",
							data:"deptId="+node.id,
							datatype:"json",
							cache: false,
							async:false,
							success: function(data){
								//$('#oSysDeptName').val(node.text);
								$('#id').val(data.sysDept.id);
								myValidate(data.sysDept.id);
								$('#fatherId').val(data.sysDept.fatherId);
								$('#nameId').val(data.sysDept.name);
								$('#shortNameId').val(data.sysDept.shortname);
								$('#cSelect').empty();
								$('#cSelect').append(data.sysDept.name );
								$('#latitude').val(data.sysDept.latitude);
								$('#longitude').val(data.sysDept.longitude);
								$('#coordinates').val(data.sysDept.coordinates);
								var editor = UE.getEditor('remark');
								var remark = data.sysDept.remark;
								if(remark != null){
						 			editor.setContent(remark);
						 		}else{
						 			editor.setContent("");
						 		}
							 	var sysDeptTypes = data.sysDeptTypes;
							 	if(sysDeptTypes != null){
							 		var stypes = [];
							 		for(var i = 0 ; i < sysDeptTypes.length; i++){
							 			stypes.push(sysDeptTypes[i].id);
							 		}
							 		$('#deptTypeIds').combobox('setValues',stypes);
								}
								$('#adddeptpanel901').panel({title:'修改组织',iconCls:'edit-blue-icon'});
								$('#adddeptpanel901').dialog('open');
							}
						});
						//$('#adddeptpanel901').dialog('setTitle','修改组织').dialog('refresh', '${pageContext.request.contextPath}/systemController/sysDept/'+node.id+'/editSysDept').dialog('open');
					}else{
						$.messager.alert('提示','请选择要操作的组织','warning');   
					}
				});

				/****
				保存菜单：这里使用直接提交因为1）组织树需要重新加载，但是是异步加载的不能定位到当前所加的组织
				2）组织不能获取所加组织，所以对应的组织详细不对应
				*/ 
				$("#adddeptpanelSave901").click(function(){
					var vd = $('#addSysDeptFormId').form("validate");  
					if(vd){
						$('#addSysDeptFormId').submit();  
					}
				});	
				
				$("#deptTypeIds").combobox({   
				    url:"${rootPath }/systemController/getSysDeptType",
				    valueField:'id',   
				    textField:'text',
				    editable:false,
				    multiple:true
				}); 
				
				function myValidate(nodeid){
					// 组织名称
					$("#nameId").validatebox({
						required:true,
						missingMessage:'组织名称不能为空' ,
						// validType:["length[1,50]","remote['${pageContext.request.contextPath}/system/sysDept/findCountDeptNameByDeptId?deptId="+nodeid+"','name']"],
					});
	
					//  组织编码
					$("#deptno").validatebox({
						required:true,
						missingMessage:'煤矿编号不能为空',
						validType:'length[1,30]',
						invalidMessage:'煤矿编号长度为1-30'
					});
					
					$("#shortNameId").validatebox({
						required:true,
						missingMessage:'组织简称不能为空',
						//validType:["length[1,30]","remote['${pageContext.request.contextPath}/systemController/sysDept/findCountDeptShortNameByDeptId?deptId="+nodeid+"','shortName']"],
					});
				}
				
			});

		</script>
	</head>
	<!-- 主面板 -->
	<body>
    <div class="easyui-panel" style="border: 0px; width: 740px; height: 400px;" data-options="border:false,fit:true">
        <div class="easyui-layout" data-options="fit:true,border:false" >
<%--         	<c:if test="${ONLYSHOW>0 }"> --%>
	            <div data-options="region:'north',border:false" style="padding:3px 0;height:30px;">
	            	<c:if test="${CANADD>0 }">
		                <a class="easyui-linkbutton" data-options="iconCls:'add-blue-icon',plain:true" id="addId" > 添加组织</a>  
	            	</c:if>
	            	<c:if test="${CANDELETE>0 }">
		                <a class="easyui-linkbutton" data-options="iconCls:'delete-icon',plain:true" id="deleteId">删除组织</a> 
	            	</c:if>
	            	<c:if test="${CANUPDATE>0 }">
		                <a class="easyui-linkbutton" data-options="iconCls:'edit-blue-icon',plain:true" id="editId">修改组织</a>
	            	</c:if>
	            </div>
<%--         	</c:if> --%>
	            
            <div data-options="border:true,region:'west',split:true" class="dept-w">
                <ul id="treemenu901" style="padding:5px 0;" >
                </ul>
            </div>
            <div data-options="border:false,region:'center'"   id="detailId" class="dept-wrap">
            </div>
            <div id="adddeptpanel901" class="easyui-dialog" title="添加组织" style="width: 750px;
                height: 430px;" data-options="iconCls:'add-blue-icon',resizable:true,modal:true,closed:true,resizable:false,buttons: [{
					text:'确定',
					plain:true,
					iconCls:'icon-ok',
					id:'adddeptpanelSave901'
				},{
					text:'取消',
					plain:true,
                    iconCls:'icon-cancel',
					handler:function(){$('#adddeptpanel901').dialog('close');}
					}]">
                <form action="${rootPath }/systemController/sysDept/saveSysDept" id="addSysDeptFormId" method="post" enctype="multipart/form-data">
					<table align="center" border="0" class="dialog-tbl" style="width:95%;">
						<tr style="height: 25px">
							<td colspan="4" class="dept-manage-tit">
								当前选择组织：<label id="cSelect"></label>
							</td> 
						</tr>
						<tr style="height: 25px">
							<td class="tit-col" style="width:85px;">组织名称</td>
							<td style="width:250px;">
								<input type="hidden" id="id" name="id" value="${sysDept.id }" />
								<input type="hidden" id="fatherId" name="fatherId" value="${sysDept.fatherId }" />
								<input type="hidden" id="oSysDeptName" name="oSysDeptName" />
								<input style="width: 220px; height: 20px" type="text"
									class="easyui-validatebox" name="name" value="${sysDept.name }"
									id="nameId" />
							</td>
							<td class="tit-col">组织类型</td>
							<td>
								<input style="width: 226px;" id="deptTypeIds" name="deptTypeIds"/>  
							</td>
							
						</tr>
						<tr style="height: 25px">
							<td class="tit-col">组织简称</td>
							<td>
								<input type="text" class="easyui-validatebox" style="width: 220px; height: 20px"  name="shortname" id="shortNameId" />
							</td>
							<td class="tit-col" style="vertical-align:top;">组织经度</td>
							<td>
								<input type="text" class="easyui-validatebox" style="width: 220px;" name="longitude" id="longitude" data-options="validType:['checkFloat']" /><span class="jwd-tip">(如：112.366989)</span>  
							</td>
						</tr>
						<tr style="height: 25px">
							
							<td class="tit-col" style="vertical-align:top;">组织纬度</td>
							<td>
								<input type="text" class="easyui-validatebox" style="width: 220px;" name="latitude" id="latitude"  data-options="validType:['checkFloat']" /><span class="jwd-tip">(如：100.455438)</span> 
							</td>
						</tr>
						
						<tr style="height: 25px">
							<td class="tit-col" style="vertical-align:top;">组织边界</td>
							<td colspan="3">
								<input class="dept-border-wid" type="text" id="coordinates" name="coordinates"/>
								<span class="jwd-tip">(如：[39.46989,112.33641])</span>
							</td>
						</tr>
	
						<tr style="height: 120px;width: 635px;width:600px\9;" align="left">
							<td style="width:635px;width:600px\9;" colspan='4' style="padding-left:38px;">
								<textarea name="remark" id="remark"></textarea>
								
							</td>
						</tr>
					</table>
				</form>
            </div>
            
        </div>
    </div>
    <script type="text/javascript">
      	$(document).ready(function(){
      		 var editor = UE.getEditor('remark',{toolbars: [["fullscreen","undo","redo","insertunorderedlist","insertorderedlist","link","selectall","cleardoc","preview","simpleupload","insertimage","spechars","template","background","bold","italic","underline","forecolor","backcolor","justifyleft","justifycenter","justifyright","justifyjustify","paragraph","rowspacingbottom","rowspacingtop","lineheight","fontfamily","fontsize","imagenone","imageleft","imageright","imagecenter"]]   
      		      								    	,wordCount:true
      		      								    	,autoFloatEnabled:false //工具栏浮动   
      		      								    	,elementPathEnabled:false //左下角显示元素路径   
      		      								    	,maximumWords:30000       //允许的最大字符数
      		      						    		});
      		      						    		editor.ready(function(){
      		      									    editor.setContent('${sysDept.remark}');
      		      									});
          	});					   
	</script>
</body>
</html>