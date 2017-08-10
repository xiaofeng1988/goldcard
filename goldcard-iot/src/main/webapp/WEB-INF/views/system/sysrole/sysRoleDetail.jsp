<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
		<form action="${rootPath}/systemController/sysRole/updateRolePermission" id="updateRolePermissionFormId" method="post">
    	<input type="hidden" name="id" value="${sysRole.id }" >
		<input type="hidden" name="remark" id="remarkId">
    	<table class="dept-right-tbl">
                    <tr style="height: 35px">
                        <th colspan="2" style="text-align: left" class="dept-title">
                            <div id="currentdept901">当前选择角色：${sysRole.name }</div>
                        </th>
                    </tr>
                    <tr style="height: 35px">
                        <td colspan="2" class="dept-btns">
                        	<a class="green-btn btn" href="javascript:void(0)" onclick="expandAll()">全部展开</a>
							<a class="red-btn btn" href="javascript:void(0)" onclick="collapseAll()">全部关闭</a>
							<a class="orange-btn btn" href="javascript:void(0)" onclick="selectAll()">全部选中</a>
							<a class="purple-btn btn" href="javascript:void(0)" onclick="uncheckAll()">全部不选</a>
							
							<c:if test="${CANMANAGER>0 }">
	                            <a href="#" class="blue-btn btn"  onclick="saveSysRolePermission()" >保存权限</a>
							</c:if>
                    	</td>
                    </tr>
                    <tr style="height: 35px" class="permission">
                        <td class="per-tit">模块权限：</td>
                        <td>
                            <div id="deptname901" class="per-list">
	                            <c:forEach items="${allfuns}" var="allfun">
									<input type="checkbox" name="name" value="${allfun.value }" checked="checked" style="width: 13px;" >${allfun.key }</input>
								</c:forEach>
                            </div>
                        </td>
                    </tr>
                    <tr style="height: 35px">
                        <td colspan="2" style="background:#f3f3f3;">
                        	<ul id="permissionttId" class="easyui-tree" data-options="url:'${rootPath }/sysRightController/${sysRole.id }/findAllSysRightChildRightByRole', 
                        	checkbox:true, onLoadSuccess:function(node, data){
                        			$('#permissionttId').tree('expandAll');
                        		}"></ul>
                        </td>
                    </tr>
                </table>
    
		
		</form>		
			
