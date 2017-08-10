<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<script type="text/javascript">

	</script>

			
			
		<form id="addFormId" method="post">
		    <input type="hidden" id="sid" name="sid" value="${student.sid }" />
			<table class="dialog-tbl"> 
                    <tr style="height: 35px">
                        <td class="tit-col">
                            <div>姓名：</div>
                        </td>
                        <td>
                            <input style="width: 250px; height: 20px" type="text" maxlength="50"
                                class="easyui-validatebox"  name="name" value="${student.name }" id="nameId" />
                        </td>
                    </tr>
                    <tr style="height: 35px">
                        <td class="tit-col">
                            <div>性别：</div>
                        </td>
                        <td>
                            <select  style="width: 255px; height: 20px; text-align: left;"  name="sex" class="easyui-combobox" data-options="editable:false">
									<option value="0"  <c:if test="${student.sex == '0' }">selected="selected"</c:if> >男</option>
									<option value="1"  <c:if test="${student.sex == '1' }">selected="selected"</c:if> >女</option>
							</select>
                        </td>
                    </tr>
                    <tr style="height: 35px">
                        <td class="tit-col">
                            <div>地址：</div>
                        </td>
                        <td>
                            <input style="width: 250px; height: 20px" type="text" maxlength="100"
                                class="easyui-validatebox"  name="address" value="${student.address }" id="addressId" />
                        </td>
                    </tr>
                    <tr style="height: 35px">
                        <td class="tit-col">
                            <div>备注：</div>
                        </td>
                        <td>
                            <input style="width: 250px; height: 20px" type="text" maxlength="100"
                                class="easyui-validatebox"  name="remark" value="${student.remark }" id="remarkId" />
                        </td>
                    </tr>
                </table>
		</form>
