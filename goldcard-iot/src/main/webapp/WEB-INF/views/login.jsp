<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=11; IE=10; IE=9; IE=8; IE=7; IE=EDGE">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <title>登录页面-JAVA基础开发平台</title>
    <link href="${pageContext.request.contextPath}/static/images/favicon.ico" rel="shortcut icon" type="image/x-icon" />
    <link href="${pageContext.request.contextPath }/static/js/easyui/themes/metro/easyui.css" type="text/css" rel="Stylesheet">
    <link href="${pageContext.request.contextPath }/static/login/css/login.css" type="text/css" rel="Stylesheet" />
    <script type="text/javascript" src="${pageContext.request.contextPath }/static/login/js/jquery-1.8.1.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/static/js/easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/static/js/jquery.cookie.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/static/js/common/validate.js"></script>
    
    		<script type="text/javascript">
			//初始化页面时加载用户名和密码
			$(document).ready(function(){
				  if ($.cookie("rmbUser") == "true") {  
				   $("#rmbUser").attr("checked", true);  
				   $("#txtusername").val($.cookie("userName"));  
				   $("#txtpassword").val($.cookie("passWord"));  
				  } 
			});
			var code;
			function enter(event){
		        if(event.keyCode==13){ 
		        	goSubmit();
		        } 
			}
		  var isLogining=false;
			function goSubmit(){ 
				if(!$("#loginFormId").form('validate')) return;
				if(isLogining)return;
				var username=$('#txtusername').val();
				var password=$('#txtpassword').val();
				usernametrim=username.replace(/^\s+|\s+$/g,"");
				passwordtrim=password.replace(/^\s+|\s+$/g,"");
				if(usernametrim==''){
					//$.messager.alert("提示", "请输入用户名！");
					$('#txtusername').focus();
					$('#checkmsg').text("请输入用户名！")
					return false;
				}
				if(passwordtrim==''){
					//$('#txtpassword').val('');
					//$.messager.alert("提示", "请输入密码！");
					$('#txtpassword').focus();
					$('#checkmsg').text("请输入密码！")
					return false;
				}
				var inputCode = document.getElementById("checkCodeInput").value;
				if(inputCode.length <=0){
					$('#checkmsg').text("请输入验证码！");
			       }else if(inputCode.toUpperCase()!= code.toUpperCase()){
			    	  $('#checkmsg').text("验证码错误！");  
			    	  //毛文龙：将验证码输入框中的错误输入信息清空
			    	  document.getElementById('checkCodeInput').value="";
			          createCode();//刷新验证码  
			       }else{ 
			            isLogining=true;
// 				  		 $.post('${pageContext.request.contextPath }/validateLoginStatus',{'loginname':username,'password':password},function(data){
// 							isLogining=false
// 							 var result=eval('('+data+')');  
// 							 if (result.success){ 
// 								 $('#loginFormId').submit();
// 							 }else{ 
// 								      if(window.confirm('此账号已经有人登录，确认强行登录吗？')){
// 									      $('#loginFormId').submit();
// 							          }
// 							 }
// 						 });
                       $('#loginFormId').submit();
			    	   saveUserInfo();
			       }
			}
			function createCode(){
				code="";
				document.getElementById("checkCodeInput").value="";
				var codeLength=4;
				var checkCode=document.getElementById("checkCode");
				var selectChar = new Array('A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z');
				for(var i=0;i<codeLength;i++){     
			       var charIndex = Math.floor(Math.random()*26);  
			       code +=selectChar[charIndex];  
			    }
				if(checkCode){  
			         checkCode.className="code";  
			         checkCode.value = code;  
			    }
			    //记录验证码
			     $('#checkCodeInput').val(code);     
			}
			//保存用户信息
			function saveUserInfo(){
				if($('#rmbUser').attr("checked") == "checked"){
					var userName = $("#txtusername").val();  
					var passWord = $("#txtpassword").val();
					$.cookie("rmbUser", "true", {  
					    expires : 7  
					}); // 存储一个带7天期限的 cookie   
					$.cookie("userName", userName, {  
					    expires : 7  
					}); // 存储一个带7天期限的 cookie   
					$.cookie("passWord", passWord, {  
					    expires : 7  
					}); // 存储一个带7天期限的 cookie   
					} else {  
					   $.cookie("rmbUser", "false", {  
					    expires : -1  
					});  
					$.cookie("userName", '', {  
					    expires : -1  
					});  
					$.cookie("passWord", '', {  
					    expires : -1  
					});  
				}
			}

			//密码加密
			function synPassword(){ 
				var pwd=$("#txtpassword").val();
				var ppwd=pwd+code;
                $("#ppassword").val(ppwd);
			}
			//执行同步 
			 setInterval(synPassword,500);//同步的时间间隔，每0.5秒同步一次  
		</script>
</head>
<body onload="createCode()">
    <div class="wrap">
    	<div class="top-bg">
    		<div class="btm-bg">
    			<div class="main-container">
			        <div class="head">
			            <h1 class="title"></h1>
			            <div class="clear"></div>
			        </div>
			        <div class="main-wrap">
			           	<form name="form1" method="post" action="${pageContext.request.contextPath }/api/sysUserController/loginSubmit" id="loginFormId"> 
			            <div class="login-box">
			                <dl>
			            	    <dt>账&nbsp;&nbsp;&nbsp;号：</dt>
			                    <dd class="i-bg"><input class="i easyui-validatebox" data-options="validType:['length[0,15]']" type="text" name="loginname"	id="txtusername" value="admin" /></dd>
			                    <dt>密&nbsp;&nbsp;&nbsp;码：</dt>
			                    <dd class="i-bg">
			                        <input class="i easyui-validatebox" data-options="validType:['length[0,20]']" type="password"  id="txtpassword" name="password"  onkeydown="enter(event)"
			                        	onkeyup="synPassword()"
			                        />
			                        <input type="hidden" id="ppassword" name="ppassword" />
			                    </dd>
			                    <dt>验证码：</dt>
			                    <dd class="verify">
			                    	<span class="i-bg-s">
			                        	<input class="i" type="text" value=""  name="checkCodeInput" id="checkCodeInput" onkeydown="enter(event) " value=""/>
			                        </span>
			                        <input   id="checkCode"   readonly="readonly" onclick="createCode()"  onmouseover="this.style.cursor='pointer';" class="code" value="ASDR">
			                        <a class="change" href="javascript:void(0)" onclick="createCode()">换一个</a>
			                    </dd>
			                    <dd class="over">
			                        <span id="checkmsg" class="error">${msg}</span>
			                    </dd>
			                </dl>
			                <div class="log-in">
			                	<label><input type="checkbox" id="rmbUser" value=""  checked="checked"/>记住密码</label>
<%--			                    <label><input type="checkbox" name="skipNav" id="skipNav" value="true" checked="checked"/>跳过导航</label>--%>
			                	<input class="login-btn" type="button" value="" onclick="goSubmit()" />
			                </div>
			            </div>
			            </form>
			            <div class="clear"></div>
			        </div>
			        <ul class="list-pic" id="listPic">
			        	<li class="pic1"></li>
			            <li class="pic2"></li>
			            <li class="pic3"></li>
			            <li class="pic4"></li>
			            <li class="pic5"></li>
			            <li class="pic6"></li>
			        </ul>
			    </div>
			        <!-- <p class="tech-support">技术支持：杭州万维空间信息技术有限公司 010-8888888</p> -->
	        </div>
	    </div>
	 </div>
</body>
</html>
	