<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

	<script type="text/javascript">
		$(function(){
			$("#nameId").validatebox({
				required:true,
				missingMessage:'功能名称不能为空'
<%--				validType:'remote["${pageContext.request.contextPath }/systemController/sysright/findCountSysrightNameByRoleId?id=${sysRight.id }", "name"]',--%>
<%--				invalidMessage:'功能名称已经存在'--%>
			}); 
			
// 			$("#urlId").validatebox({
// 				validType:'remote["${pageContext.request.contextPath }/systemController/sysright/findCountSysrightURLByRoleId?id=${sysRight.id }", "url"]',
// 				invalidMessage:'页面路径已经存在'
// 			});
			
		});
	</script>

		<form action="${rootPath }/sysRightController/sysRight/save" id="addSysRightFormId" method="post">
			
			<table class="dialog-tbl">
                    <tr style="height: 35px">
                        <th colspan="2" style="text-align: left">
                            <div id="addcurrentdept901">当前选择功能：${FatherSysRight.name }</div>
                            <input type="hidden" name="id" value="${sysRight.id }" />
							<input type="hidden" name="fatherId" value="${FatherSysRight.id }" />
							<input type="hidden" name="level" value="${FatherSysRight.level }" />
<%-- 							<input type="text" style="display:none;" name="nodeid" value="${sysRight.nodeid }" /> --%>
                        </th>
                    </tr>
                    <tr style="height: 35px">
                        <td class="tit-col">
                            <div>功能名称</div>
                        </td>
                        <td>
                            <input  name="name" value="${sysRight.name }"  style="width: 250px; height: 20px" type="text"
                                class="easyui-validatebox" id="nameId" data-options="validType:['length[0,50]']" />
                        </td>
                    </tr>
                    <tr style="height: 35px">
                        <td class="tit-col">
                            <div>页面路径</div>
                        </td>
                        <td>
                            <input  name="url" value="${sysRight.url }"  style="width: 250px; height: 20px" type="text"
                                class="easyui-validatebox" id="urlId"/>
                        </td>
                    </tr>
                    
                    <c:if test="${isNew==0}">
	                    <tr style="height: 35px">
	                        <td class="tit-col">
	                            <div>子  功  能</div>
	                        </td>
	                        <td>
	                        	<select editable="false" style="width: 257px; height: 20px; text-align: left;"  name="fun" class="easyui-combobox" 
		                        		<c:choose>
			                            	<c:when test="${isNew==0}">data-options="multiple:true,required:true"</c:when>
			                            	<c:otherwise>data-options="multiple:true"</c:otherwise>
			                            </c:choose>
									 >
										<c:forEach items="${allfuns}" var="fun">
											<option value="${fun.value }">${fun.key }</option>
										</c:forEach>
									</select>
	                        </td>
	                    </tr>
                    </c:if>
                    
                </table>
		</form>
