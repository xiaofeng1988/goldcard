<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
			
<div class="easyui-layout" data-options="fit:true">
		<table class="defaulttableStyle" cellspacing="1px">
                    <tr style="height: 35px">
                        <td style="width: 120px">
                            <div>组织类型编码</div>
                        </td>
                        <td>
                            <div id="deptnum901">${sysDeptType.id }</div>
                        </td>
                    </tr>
                    <tr style="height: 35px">
                        <td>组织类型名称 </td>
                        <td>
                            <div id="deptname901">${sysDeptType.name } </div>
                        </td>
                    </tr>
                </table>
</div>