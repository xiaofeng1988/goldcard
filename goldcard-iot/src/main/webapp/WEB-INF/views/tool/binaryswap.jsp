<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>列表信息</title>
<%@ include file="../common/common.jsp"%>
<script type="text/javascript">

//十进制转换为二进制 
	function decimalToBinary(){
		var decimalVal = $("#decimalId").val();
		console.log(decimalVal);
		$.post('${rootPath}/tool/decimalToBinary',{decimal:decimalVal},function(data){
// 			 var data=eval('('+data+')');
			 if (data.status){
					$("#binaryId").val(data.result)
			 }else{
				 $.messager.alert('提示', 'error','error');
			 }
		 });
	}
	//二进制转换为十进制
	function binaryToDecimal(){
		var binaryId2 = $("#binaryId2").val(); 
		console.log(binaryId2);
		$.post('${rootPath}/tool/binaryToDecimal',{binary:binaryId2},function(data){
// 			var result=eval('('+data+')');
			if (data.status){
				$("#decimalId2").val(data.result);
		 }else{
			 $.messager.alert('提示', 'error','error');
		 }
		 });
	}
	
</script>

</head>

<body>
	十进制转换二进制：
	<input style="width: 250px; height: 20px" type="text" maxlength="50"
		class="easyui-validatebox" name="decimalId" id="decimalId"
		onchange="decimalToBinary()" /> -->
	<input style="width: 250px; height: 20px" type="text" maxlength="50"
		class="easyui-validatebox" name="binaryId" id="binaryId" />
	</br><h1></h1>
	二进制转换十进制：
	<input style="width: 250px; height: 20px" type="text" maxlength="50"
		class="easyui-validatebox" name="binaryId2" id="binaryId2" onchange="binaryToDecimal()"  />-->
	<input style="width: 250px; height: 20px" type="text" maxlength="50"
		class="easyui-validatebox" name="decimalId2" id="decimalId2" /> 
	
		
		
</body>
</html>