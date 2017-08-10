<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
		<script type="text/javascript">
			$(function(){
 
				$.extend($.fn.validatebox.defaults.rules, {   
				// 判断是否是一致
				    equals: {   
				        validator: function(value, param){  
							var rfps = $( eval( "('" + param + "')" )   ).val();
							return value == rfps; 
				        },   
				        message: 'Please enter equals {0} value.'  
				    } 
				});
				//////////////////////字段验证//////////////////////
					// 用户名校验
// 					$("#noid").validatebox({
// 						required: true,   
// 						missingMessage:'用户编码不能为空',
// 						validType:"remote['${rootPath}/systemController/sysUser/checkUserNoIsExistInSystem','no']",
// 						invalidMessage:'用户编码已经存在'
// 					});
					// 用户名校验
					$("#nameid").validatebox({
						required: true,   
						missingMessage:'用户名不能为空',
						validType:'length[1,20]'
						// validType:"remote['${pageContext.request.contextPath}/systemController/sysUser/checkUserNoAndUserName?no='+$('#noid').val(),'name']",
						// invalidMessage:'集团系统中不存在该用户编号和用户姓名'
					});
					// 工种职务
					$("#typeofworkId").validatebox({
						validType:'length[1,20]',
						invalidMessage:'工种职务长度为1-20'
					});
					// 登录名校验
					$("#loginnameId").validatebox({
						required: true,   
						missingMessage:'登录名不能为空',
						validType:["length[1,20]","remote['${rootPath}/systemController/sysUser/userNameIsUnique','loginname']"] 
<%--						validType:"remote['${pageContext.request.contextPath}/systemController/sysUser/userNameIsUnique','loginname']",--%>
<%--						invalidMessage:"['工种职务长度为1-10','登录名已经存在']"--%>
					});
					
					// 密码校验
					$("#passwordid").validatebox({
						required: true,   
						missingMessage:'密码不能为空',
						validType:'length[1,20]',
						invalidMessage:'密码长度为1-20'
					});
					
					// 确认密码校验
					$("#confirmpasswordid").validatebox({
						required: true,   
						missingMessage:'确认密码不能为空',
						validType:"equals['#passwordid']",
						invalidMessage:'确认密码和密码要一致'
					});
					// 校验手机
					$('#mobileId').validatebox({   
						validType:'mobile'
					}); 
					// 校验手机
					$('#phoneId').validatebox({   
						validType:'telephone'
					}); 
					// 校验邮箱
					$('#emailId').validatebox({   
					    validType: 'email', 
				    	invalidMessage:'邮箱格式不正确'
					}); 
		
			});


			// 校验用户信息
			function validateUser(){
// 				var userNo = $("#noid").val();
// 				if(userNo==""){
// 					$.messager.alert("提示", "用户编码不能为空！","warning");	
// 					return false;
// 				}

				var userName = $("#nameid").val();
				if(userName==""){
					$.messager.alert("提示", "用户姓名不能为空！","warning");	
					return false;
				}

// 				$.post("${rootPath}/user/validateUser", {
// 						"userNo":userNo,
// 						"userName":userName
// 					}, function(data){
// 						if("SUCCESS"==data){
// 							$.messager.alert("提示", "校验用户信息成功！","info");
// 							$("#hiddenValidataUserId").val(1);	
// 						}else{
// 							$.messager.alert("提示", "校验用户信息失败！","error");
// 							$("#hiddenValidataUserId").val(0);	
// 						}
// 					} 
// 				);
			}
		</script>
			
	<form action="${rootPath }/systemController/sysUser/saveSysUser" id="addSysRightFormId" method="post">
                <table class="dialog-tbl">
                    <tr style="height: 35px">
                        <th colspan="2" style="text-align: left">
                            <div id="addcurrentdept901">当前选择组织：${fatherSysDept.shortname }
                            </div>
                            <input type="hidden" id="hiddenValidataUserId" value="0"/>
                            <input type="hidden" name="deptid" value="${fatherSysDept.id }"/>
                        </th>
                    </tr>
<!--                     <tr style="height: 35px"> -->
<!--                         <td class="tit-col" style="width: 70px"> -->
<!--                             <div>用户编码</div> -->
<!--                         </td> -->
<!--                         <td> -->
<!--                         	<input  name="no" id="noid"  type="text" style="width: 246px; height: 20px; text-align: left;"  -->
<!--                                 class="easyui-validatebox" /> -->
<!--                         </td> -->
<!--                     </tr> -->
                    <tr style="height: 35px">
                        <td class="tit-col">
                            <div>用户姓名</div>
                        </td>
                        <td>
                            <input  name="name" id="nameid"  type="text"style="width: 246px; height: 20px text-align: left;" 
                                class="easyui-validatebox" />
<!--                             <a href="#" onclick="validateUser()"  class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-edit'" >校验用户</a> -->
                        </td>
                    </tr>
                     <tr style="height: 35px">
                        <td class="tit-col">
                            <div>登  陆  名</div>
                        </td>
                        <td>
                           <input class="easyui-validatebox" type="text" name="loginname"
                           style="width: 246px; height: 20px; text-align: left;"  id="loginnameId"    />
                        </td>
                    </tr>
                    <tr style="height: 35px">
                        <td class="tit-col">
                            <div>密        码</div>
                        </td>
                        <td>
                           <input class="easyui-validatebox" type="password" name="password"
                           style="width: 246px; height: 20px; text-align: left;"  id="passwordid" />
                        </td>
                    </tr>
                    <tr style="height: 35px">
                        <td class="tit-col">
                            <div>确认密码</div>
                        </td>
                        <td>
                           <input class="easyui-validatebox" type="password"
                           style="width: 246px; height: 20px; text-align: left;"  id="confirmpasswordid" />
                        </td>
                    </tr>
                    <tr style="height: 35px">
                        <td class="tit-col">
                            <div>角色类型</div>
                        </td>
                        <td>
                       	<input class="easyui-combobox" 
							name="roleids"
							data-options="
									url:'${rootPath }/systemController/sysRole/findSysRoleComboxJson',
									width: 253,
									valueField:'id',
									textField:'text',
									multiple:true,
									panelHeight:200,
									editable:false
							">
<%--                            <select  style="width: 253px; height: 20px; text-align: left;"  name="roleids" class="easyui-combobox" --%>
<%--								data-options="multiple:true">--%>
<%--									<c:forEach items="${sysUserTypes}" var="sysUserType">--%>
<%--										<option value="${sysUserType.id }">--%>
<%--											${sysUserType.name }--%>
<%--										</option>--%>
<%--									</c:forEach>--%>
<%--								</select>--%>
                        </td>
                    </tr>
                    <tr style="height: 35px">
                        <td class="tit-col">
                            <div>性别</div>
                        </td>
                        <td>
                        	 <select  style="width: 253px; height: 20px; text-align: left;"  name="sex" class="easyui-combobox"  data-options="editable:false" >
									<option value="Y" selected="selected">男</option>
									<option value="N">女</option>
							</select>
                        </td>
                    </tr>
                    <tr style="height: 35px">
                        <td class="tit-col">
                            <div>工种职务</div>
                        </td>
                        <td>
                            <input class="easyui-validatebox" type="text" name="typeofwork" 
                            style="width: 246px; height: 20px; text-align: left;"  id="typeofworkId" />
                        </td>
                    </tr>
                    <tr style="height: 35px">
                        <td class="tit-col">
                            <div>人员类型</div>
                        </td>
                        <td>
                            <select name="typeofperson" style="width: 253px; height: 20px; text-align: left;" class="easyui-combobox" data-options="editable:false">
								<c:forEach items="${sysUserTypes}" var="sysUserType">
									<option value="${sysUserType.id }">${sysUserType.name }</option>
								</c:forEach>
							</select>
                        </td>
                    </tr>
                    <tr style="height: 35px">
                        <td class="tit-col">
                            <div>固		话</div>
                        </td>
                        <td>
                            <input class="easyui-validatebox" type="text" 
                            style="width: 246px; height: 20px; text-align: left;"  name="phone" id="phoneId" />
                        </td>
                    </tr>
                    <tr style="height: 35px">
                        <td class="tit-col">
                            <div>手        机</div>
                        </td>
                        <td>
                            <input class="easyui-validatebox" type="text" id="mobileId"
                            style="width: 246px; height: 20px; text-align: left;"  name="mobile"  />
                        </td>
                    </tr>
                    <tr style="height: 35px">
                        <td class="tit-col">
                            <div>邮		箱</div>
                        </td>
                        <td>
                            <input class="easyui-validatebox" type="text" id="emailId"
                            style="width: 246px; height: 20px; text-align: left;"  name="email"  />
                        </td>
                    </tr>
                   
                </table>
                </form>
