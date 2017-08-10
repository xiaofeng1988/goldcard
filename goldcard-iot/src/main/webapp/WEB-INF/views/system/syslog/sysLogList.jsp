<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>操作日志主页面</title>
<jsp:include page="../../common/common.jsp"></jsp:include>

	<script type="text/javascript">
		$(function(){
			//为传感器类型设置
			$.ajax({
				  url: "${pageContext.request.contextPath}/systemController/getOperationType",
				  dataType:'json',
				  success: function(data){
						data.unshift({ "text": "全部", "id": '全部' });		
						$('#operationType').combobox({
						data : data,
						valueField:'id',
						textField:'text',
						value:"全部"  //默认选中value指定的选项
						});
					  }	 
				});
			//初始化 开始时间
			$("#stime").datetimebox().datetimebox('setValue',getCurrentDate(0,-24));
			//初始化 结束时间
			$("#etime").datetimebox().datetimebox('setValue',getCurrentDate(0,0));
			//设置datebox为只读
			$(".datebox :text").attr("readonly","readonly");
			// 定义数据表
			var iCount=getAutoRowCount(); 
			$('#sysLogGrid').datagrid({
				iconCls:'icon-save',
				height:480,
				nowrap: true,
				autoRowHeight: false,
				fitColumns:true,
				striped: true,
				sortName: 'id',
				sortOrder: 'desc',
				remoteSort: false,
				//idField:'id',
				pagination:true,
				singleSelect:false,
				pageList:[iCount,2*iCount,3*iCount],
				queryParams:{righttype:"",stime:getCurrentDate(0,-24),etime:getCurrentDate(0,0)},
				url:"${pageContext.request.contextPath}/systemController/findAllSysLog",
				onLoadSuccess:function(data){
					   $(this).datagrid('doCellTip',{'max-width':'300px','delay':100});
				},
				columns:[[   
                	{field:'ck',checkbox:true,width:$(this).width() * 0.05}, 
			        {field:'operator',title:'操作用户',align:'center',sortable:true,width:$(this).width()*0.15,
			        	formatter: function(value,row,index){
			        		return row.sysUser.name
			        	},
			        	styler:function(value,row,index){
			        		return("background:#EDF7FF;color:#367fc9;")
			        	}
			        },    
			        {field:'sRightType',title:'操作类型',sortable:true,width:$(this).width()*0.10},  
			        {field:'nodeid',title:'操作模块',sortable:true,width:$(this).width()*0.2,
			        	styler:function(){
			        		return("background:#f0f0f0;text-align:center;")
			        	}
			        }, 
			        {field:'description',title:'日志内容',sortable:true,width:$(this).width()*0.45},   
			        {field:'operationtime',title:'操作时间',sortable:true,width:$(this).width()*0.15,
			        	formatter: function(value,row,index){
				        	var date = new Date(value);   
							if (value != "" && value != undefined){
								return date.format("yyyy-MM-dd hh:mm:ss");
							}
							return "";
						}
					}
			    ]],
			    boolbar:'#toolBar'
			});
			
			
			//返回当前日期时间 格式为 yyyy-MM-dd HH:mm:ss
			function getCurrentDate(date,hourBefore){ 
				var d1; 
				if(date != null && date != "" && date != 0){
					d1 = new Date(date);
				}else{
					d1 = new Date();
				}
				var l = hourBefore * 60 * 60 *1000;
			 	var date = new Date(d1.getTime()+l);   
			 	var sty = date.getFullYear();
				var stm = date.getMonth()+1 < 10 ? "0"+(date.getMonth()+1): date.getMonth()+1;
				var std = date.getDate() < 10 ? "0"+date.getDate() : date.getDate();
				var sth = date.getHours() < 10 ? "0"+date.getHours() : date.getHours();
				var stmi = date.getMinutes() < 10 ? "0"+date.getMinutes() : date.getMinutes();
				var sts = date.getSeconds() < 10 ? "0"+date.getSeconds() : date.getSeconds();
					sty = sty+"-"+stm+"-"+std+" "+sth+":"+stmi+":"+sts;
				return sty;
			}
			

	
		});
		function searchItem(){
						$("#sysLogGrid").datagrid("load",getSearchParam());
					}
			function removeItem(){
						var p = $('#sysLogGrid').datagrid('getPager');
						var ids = [];
						var rows = $('#sysLogGrid').datagrid('getChecked');
						for(var i = 0 ; i < rows.length ; i++){
							ids.push(rows[i].id);
						}
						ids.join(",");
						if(ids.length > 0 ){
							$.messager.confirm("警告", "确定要删除这些数据吗?", function(r){
								if(r){
									$.post("${pageContext.request.contextPath}/systemController/delChosedLogs?ids="+ids);
									var value = $("#operationType").combobox("getValue");
									if(value=="全部"){
										value="";
									}
									var oname = $("#name").val();
									var stime = $("#stime").datetimebox("getValue");
									var etime = $("#etime").datetimebox("getValue");
									var currentPage = p.pagination('options').pageNumber
									var pageSize =   p.pagination('options').pageSize
									$("#sysLogGrid").datagrid("reload",{currentPage:currentPage,pageSize:pageSize,righttype:value,stime:stime,etime:etime,name:oname});
								}
							});
						}else {
							$.messager.alert("提示", "请选择要删除的数据!","warning");
						}
					}

	    	//获取查询参数
	    	function getSearchParam(){
				var p = $('#sysLogGrid').datagrid('getPager');
				var value = $("#operationType").combobox("getValue");
				if(value=="全部"){
					value="";
				}
				var oname = $("#name").val(); 
				var stime = $("#stime").datetimebox("getValue");
				var etime = $("#etime").datetimebox("getValue");
				return {
					"righttype":value,
					"stime":stime,
					"etime":etime,
					"name":oname
					}
	        	}
	</script>
	<style type="text/css">
			.datagrid-header td[field="operator"]{
			background:#daedf5 url(${pageContext.request.contextPath}/resource/img/hoverheader.gif) repeat-x 0 bottom;text-align:center;}
			.datagrid-header td[field="nodeid"]{text-align:center;}
		</style>
</head>
<body class="easyui-layout" data-options="fit:true">
	<div data-options="region:'north',border:false" style="height:30px;">
		<table id="toolBar" class="toolbar-tbl" style="margin-top:4px;">
			<tr>
				<td style="width:6%;text-align:right;">操作类型:</td>
				<td class="ipt-wrap">  <select id="operationType" name="operationType" /> </td>
				<td style="width:6%;text-align:right;">操作用户:</td>
				<td class="ipt-wrap"><input id="name" type="text" /></td>
				<td style="width:6%;text-align:right;">开始时间:</td>
				<td class="ipt-wrap"><input id="stime" type="text" /></td>
				<td style="width:6%;text-align:right;">结束时间:</td>
				<td class="ipt-wrap"><input id="etime" type="text" /></td>
				<td style="width:7%;"><a id="btnadd" class="sch-btn mlbtn" onclick="searchItem()">查询</a></td>
				<td style="width:9%;"><a id="btnremove" class="easyui-linkbutton" data-options="plain:true,iconCls:'delete-icon'" onclick="removeItem()">删除日志</a></td>
			</tr>
		</table>
	</div>
	<div data-options="region:'center'">
		<table fit="true" id="sysLogGrid"></table>
	</div>	  
</body>
</html>