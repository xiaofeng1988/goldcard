<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<script type="text/javascript">
		$(function(){
			$("#nameId").validatebox({
				required:true,
				missingMessage:'角色名称不能为空',
				validType:['length[1,20]','remote["${rootPath }/systemController/sysRole/findCountRoleNameByRoleId?id=${sysRole.id }", "name"]']
			});
			
			// 校验邮箱
			$('#remarkId').validatebox({   
				validType:'length[0,50]',
				invalidMessage:'角色描述长度为0-50'
			}); 
		});
	
	</script>
		<form action="${rootPath }/systemController/sysRole/saveSysRole" id="addSysRoleFormId" method="post">
			<table class="dialog-tbl">
<%--                    <tr style="height: 35px">--%>
<%--                        <td class="tit-col" style="width: 70px">--%>
<%--                            <div>角色编码</div>--%>
<%--                        </td>--%>
<%--                        <td>--%>
<%--                        	--%>
<%--                          --%>
<%--                        </td>--%>
<%--                    </tr>--%>
                    <tr style="height: 35px">
                        <td class="tit-col">
                            <div>角色名称</div>
                        </td>
                        <td>
                        	<input type="hidden" name="creator" value="${sysRole.creator }" />
							<input type="hidden" name="id" value="${sysRole.id }" />
							<input id="adddeptid901" type="hidden"  name="no" value="${sysRole.no }" /> 
                            <input style="width: 250px; height: 20px" type="text"
                                class="easyui-validatebox" name="name" value="${sysRole.name }" id="nameId" />
                        </td>
                    </tr>
                    <tr style="height: 35px">
                        <td class="tit-col">
                            <div>角色描述</div>
                        </td>
                        <td>
                            <textarea style="width: 250px;" name="remark" id="remarkId">${sysRole.remark }</textarea>
                        </td>
                    </tr>
                </table>
			
		</form>
