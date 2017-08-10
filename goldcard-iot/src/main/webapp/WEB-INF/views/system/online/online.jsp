<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
  <script type="text/javascript">
  	$(function(){
    		// 定义数据表
			$('#onLineTable').datagrid({
				border:'2px',
				fit:true,//自适应宽度和高度
				autoRowHeight: false, //定义设置行的高度，根据该行的内容。设置为false可以提高负载性能。
				striped: true, //设置为true将交替显示行背景。
				remoteSort: false,
				pagination:false,
				singleSelect:true, //设置为true将只允许选择一行。默认为false 但是添加了EasyUI的扩张库之后这个默认值该变了。所以这里强制设置为false
				loadMsg:"正在加载数据,请稍后...",
				rownumbers:false,//设置为true将显示行数。
				fitColumns:true,//置为true将自动使列适应表格宽度以防止出现水平滚动。
				url:'${rootPath }/sysUserController/online/findUserOnlines', 
			    columns:[[ 
				    {field:'userName',title:'姓名',sortable:true,width:$(this).width()*0.15},   
			        {field:'stime',title:'登录时间',sortable:true,width:$(this).width()*0.2},
					{field:'ip',title:'来源IP地址',sortable:true,width:$(this).width()*0.3},
<%--				{field:'fromLogin',title:'来源终端',sortable:true,width:$(this).width()*0.1},--%>
					{field:'deptName',title:'所属组织机构',sortable:true,width:$(this).width()*0.2
					}
			    ]],
		        onLoadSuccess: function(data){
<%--	             $(this).datagrid("autoMergeCells",['SHORTNAME']);--%>
                     $(this).datagrid('doCellTip',{'max-width':'300px','delay':100});
	            } 
			});
    	});
     </script>
    <table id="onLineTable"></table>

