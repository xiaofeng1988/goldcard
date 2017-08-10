<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<script type="text/javascript">
		$(function(){
			$("#nameId").validatebox({
				required:true,
				missingMessage:'组织类型名称不能为空',
				validType:'remote["${rootPath}/systemController/sysDeptType/findCountTypeNameById?id=${sysDeptType.id }","name"]',
				invalidMessage:'组织类型名称已经存在'
			});
			
		});

	</script>

			
			
		<form action="${rootPath }/systemController/sysDeptType/saveSysDeptType" id="addsysDeptTypeFormId" method="post">
			<table class="dialog-tbl">
                    
                    <tr style="height: 35px">
                        <td class="tit-col" style="width: 70px">
                            <div>类型编码</div>
                        </td>
                        <td>
                        	<input type="hidden" name="id" value="${sysDeptType.id }" />
                            <input type="text" style="width: 250px; height: 20px" class="easyui-validatebox"
                                 name="no" value="${sysDeptType.no }" readonly="readonly" />
                        </td>
                    </tr>
                    <tr style="height: 35px">
                        <td class="tit-col">
                            <div>类型名称</div>
                        </td>
                        <td>
                            <input style="width: 250px; height: 20px" type="text" maxlength="50"
                                class="easyui-validatebox"  name="name" value="${sysDeptType.name }" id="nameId" />
                        </td>
                    </tr>
                </table>
		</form>
