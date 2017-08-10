<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
		$(function(){

			// 组织名称
			$("#nameId").validatebox({
				required:true,
				missingMessage:'组织名称不能为空'
// 				validType:'remote["${pageContext.request.contextPath}/systemController/sysDept/findCountDeptNameByDeptId?deptId=${sysDept.id }","name"]',
// 				invalidMessage:'组织名称已经存在'
			});

			//  
// 			$("#nameId").validatebox({
// 				validType:'length[0,30]',
// 				invalidMessage:'煤矿编号长度为0-30'
// 			});

			//  
			$("#remark").validatebox({
				validType:'length[1,2000]',
				invalidMessage:'煤矿编号长度为0-2000'
			});
			
			$("#shortNameId").validatebox({
				required:true,
				missingMessage:'组织简称不能为空'
// 				,
// 				validType:'remote["${pageContext.request.contextPath}/api/systemController/sysDept/findCountDeptShortNameByDeptId?deptId=${sysDept.id }","shortName"]',
// 				invalidMessage:'组织简称已经存在'
			});
		});
	
	</script>

<form action="${rootPath }/systemController/sysDept/saveSysDept" id="addSysDeptFormId" method="post">

	<table style="width: 100%; height: 100px; padding: 2px; text-align: right; font-size: 12px" >
		<tr style="height: 25px">
			<th colspan="2" style="text-align: left">
				<div id="addcurrentdept901">
					当前选择组织：${fatherSysDept.name } 
				</div>
			</th>
		</tr>
		<tr style="height: 25px">
<!-- 			<td style="width: 70px"> -->
<!-- 				<div> -->
<!-- 					组织编号 -->
<!-- 				</div> -->
<!-- 			</td> -->
			<td>
				<input type="hidden" name="id" value="${sysDept.id }" />
				<input id="adddeptid901" type="text"
					style="width: 200px; height: 20px; text-align: left;" class="easyui-validatebox"
					name="no" value="${sysDept.no }" readonly="readonly" />
			</td>
			<td style="width: 70px">
				<div>
					组织类型
				</div>
			</td>
			<td>
				<select style="width: 204px;" name="deptTypeIds" class="easyui-combobox" multiple="multiple">
					<c:forEach items="${sysDeptTypes}" var="sysDeptType">
						<option value="${sysDeptType.id }">${sysDeptType.name }</option>
					</c:forEach>
				</select>
			</td>
			
		</tr>
		<tr style="height: 25px">
			<td>
				<div>
					组织名称
				</div>
			</td>
			<td>
				<input style="width: 200px; height: 20px" type="text"
					class="easyui-validatebox" name="name" value="${sysDept.name }"
					id="nameId" />
			</td>
			
			<td>
				<div>
					组织简称
				</div>
			</td>
			<td>
				<input style="width: 200px; height: 20px" type="text"
					class="easyui-validatebox" name="shortName" value="${sysDept.shortName }"
					id="shortNameId" />
			</td>
		</tr>

		<tr style="height: 125px;width: 690px" align="left">
			<td width="695px" colspan='5'>
				<textarea name="remark" id="remark"></textarea>
			
			</td>
		</tr>
	</table>
</form>
	<script type="text/javascript">
	    $(document).ready(function(){
	    	 UE.getEditor('remark',{toolbars: [["fullscreen","undo","redo","insertunorderedlist","insertorderedlist","link","selectall","cleardoc","preview","simpleupload","insertimage","spechars","template","background","bold","italic","underline","forecolor","backcolor","justifyleft","justifycenter","justifyright","justifyjustify","paragraph","rowspacingbottom","rowspacingtop","lineheight","fontfamily","fontsize","imagenone","imageleft","imageright","imagecenter"]]   
	    	           				    	,wordCount:true
	    	           				    	,autoFloatEnabled:false //工具栏浮动   
	    	           				    	,elementPathEnabled:false //左下角显示元素路径   
	    	           				    	,maximumWords:30000       //允许的最大字符数
	    	           		    		});
		    });
	 </script>
