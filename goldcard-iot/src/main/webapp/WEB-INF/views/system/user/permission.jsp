<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<form id="sysUserPersionFormId" method="post" action="${rootPath }/systemController/sysUser/saveSysUserPermission">
		<input type="hidden"  name="id" value="${sysUser.id }" > <!-- 当前用户id -->
		<input type="hidden"  name="typeofwork" id="typeofwork" value="" > <!-- 授予当前用户权限的字符串集合，用逗号分隔-->
		<input type="hidden"  name="name" id="name" value="${sysUser.name }"> 
		<table class="defaulttableStyle" cellspacing="1px">
                    <tr style="height: 35px">
                        <th colspan="2" style="text-align: left">
                            <div id="currentdept901">选择用户：${sysUser.name }</div>
                        </th>
                    </tr>
                    <tr style="height: 35px">
                        <td style="width: 100px;">模块权限</td>
                        <td>
							<input class="easyui-combobox" 
								name="email"
								data-options="
										url:'${rootPath }/systemController/sysFunction/findSysFunctionComboxJson',
										width: 253,
										valueField:'id',
										textField:'text',
										multiple:true,
										panelHeight:'auto'
								">
							
                        </td>
                    </tr>
                    <tr style="height: 35px">
                    	<td style="width: 100px;">
                    		设置角色
                    	</td>
                        <td>
                            <input class="easyui-combobox" 
								name="language"
								data-options="
										url:'${rootPath }/systemController/sysRole/${sysUser.id }/findSysRoleComboxJson',
										panelHeight:250,
										width: 253,
										valueField:'id',
										textField:'text',
										multiple:true,
								">
                        </td>
                    </tr>
                     <tr style="height: 35px">
                    	<td colspan="2">
                    		<a class="easyui-linkbutton" data-options="iconCls:'icon-expandAll',plain:true" href="javascript:void(0)" onclick="expandAll()">全部展开</a>
							<a class="easyui-linkbutton" data-options="iconCls:'icon-collapseAll',plain:true" href="javascript:void(0)" onclick="collapseAll()">全部关闭</a>
							<a class="easyui-linkbutton" data-options="iconCls:'icon-selectAll',plain:true" href="javascript:void(0)" onclick="selectAll()">全部选中</a>
							<a class="easyui-linkbutton" data-options="iconCls:'icon-uncheckAll',plain:true" href="javascript:void(0)" onclick="uncheckAll()">全部不选</a>
                    	</td>
                    </tr>
                    <tr style="height: 200px">
                        <td colspan="2">
                        	<ul id="permissionttId" class="easyui-tree" data-options="url:'${rootPath }/sysRightController/list/${sysUser.id }/findAllSysRightChildRight', 
                        		checkbox:true, onLoadSuccess:function(node, data){
                        			$('#permissionttId').tree('expandAll');
                        		}"></ul>
                        </td>
                    </tr>
<%--                    <tr style="height: 35px">--%>
<%--                    	<td colspan="2">--%>
<%--							<span style="color: red; line-height: 20px;">注意：当前用户不能给自己进行设置权限，为了确保系统权限的稳定性系统中有两个超级管理员sys和admin，超级管理员的权限为全部功能，且不能进行设置！--%>
<%--							</span>--%>
<%--                    	</td>--%>
<%--                    </tr>--%>
                </table>
	</form>
