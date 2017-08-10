<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="X-UA-Compatible" content="IE=11; IE=10; IE=9; IE=8; IE=7; IE=EDGE" />
    <meta http-equiv="cache-control" content="no-cache" />
<%--     <link href="${pageContext.request.contextPath}/static/images/favicon.ico" rel="shortcut icon" type="image/x-icon" /> --%>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/logo/logo.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/index.css">
    <%@ include file="common/common.jsp"%>
    <title>JAVA基础开发平台</title>
</head>
<body class="easyui-layout" id="body1" onload="closeTopLoading()"> 
    <div data-options="region:'north',border:false,onCollapse:function(){northmax=false;$('#northExpand').val(false);},onExpand:function(){northmax=true;$('#northExpand').val(true);if(westmax){setmaxbutton('全屏','icon-maxfull');ismax=false;}}"
        style="height: 98px;padding:0 0 3px;">
        <div class="easyui-layout header-bg" data-options="fit:true,border:false" style="height: 65px">
            <div data-options="region:'north',border:false,bodyCls:'logo-wrap'" style="height: 65px; text-align: right;
                background: none">
                <input type="hidden" name="northExpand" id="northExpand" value="true" readOnly/>
                <div class="logo-title">
                    <div class="logo">
                        <span>
                            <!-- <object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=7,0,19,0"
                                width="762" height="60px">
                                <param name="movie" value="${pageContext.request.contextPath}/static/logo/f17.swf" />
                                <param name="quality" value="high" />
                                <param name="wmode" value="transparent" />
                                <embed src="${pageContext.request.contextPath}/static/logo/f17.swf" width="320" height="60px" quality="high" pluginspage="http://www.macromedia.com/go/getflashplayer"
                                    type="application/x-shockwave-flash" wmode="transparent"></embed>
                            </object> -->
                        </span>
                        <span class="logo-bg">
                        </span>
                    </div>
                    <div class="nav-optioins">
                    	<div class="userinfostyle" style="margin-right: 5px;">
                    		<span id="nowDateDiv" style="margin-left: 10px;"></span> 
                            <span id="nowTimeDiv" style="margin-left: 10px"></span>
                            <span style="margin-left: 10px">当前用户：<span id="username">${sysuser["name"]}</span></span>
                            <a href="javascript:void(0)" onClick="javascript:exit()" class="easyui-linkbutton" data-options="iconCls:'icon-logout-w',plain:true">注销</a>
                        </div>
                        
                        <div class="tooldiv">
                            <a href="javascript:void(0)" onclick="showOnLine()" class="easyui-linkbutton" data-options="iconCls:'users-icon',plain:true">在线人员</a>
                            <a href="javascript:void(0)" class="easyui-menubutton" data-options="menu:'#settings',iconCls:'icon-set-w'">设置 </a>
                            <a href="javascript:void(0)" onclick="javascript: $('#helppanel').dialog('open');" class="easyui-linkbutton" data-options="iconCls:'icon-help-w',plain:true">帮助</a>
                            <!--<a href="javascript:void(0)" onClick="javascript:exit()" class="easyui-linkbutton" data-options="iconCls:'icon-exit',plain:true">注销</a>-->
                        </div>
                    </div>
                    <!--显示浏览的组织机构名称-->
                    <div class="currentDeptStyle">
                        <span></span>
                        <div id="currentDept" style="float: right">
                        </div>
                    </div>
                </div>
            </div>
            <div id="firstmenu" data-options="region:'center',border:false,cls:'main-nav',bodyCls:'main-nav-wrap'"
                class="divbackground">
            </div>
        </div>
    </div>
    
    <div id="treepanel" data-options="region:'west',split:true,onCollapse:function(){westmax=false;$('#westExpand').val(false);},onExpand:function(){westmax=true;$('#westExpand').val(true);if(northmax){setmaxbutton('全屏','icon-maxfull');ismax=false;}}"
        style="width: 200px;background: #f7f7f7;background-attachment:fixed;">
        <input type="hidden" name="westExpand" id="westExpand" value="" readOnly/>
        <ul id="treemenu" style="padding:0 0 15px 0;"/>
    </div>
    <div data-options="region:'center',border:false">
        <div id="maintabs" class="easyui-tabs main-tabs"  data-options="tools:'#tab-tools',fit:true,border:false">
            <div title="桌面"  data-options="iconCls:'icon-house',border:false">
                <div class="easyui-panel"  data-options="fit:true,border:false" >
                  <iframe src="${rootPath }/deskController/main/load"  frameborder="no" scrolling="no" style="height:100%;width:100%;margin:0;"></iframe>
                </div>
            </div>
        </div>
    </div>
    <div id="tab_rightmenu" class="easyui-menu" style="width: 150px;display:none">
    <!-- lijunjie :解决ActiveX弹出层遮挡问题 -->
    <iframe frameborder= "0" scrolling="no" style="background-color:transparent; position: absolute; z-index: -1; width: 100%; height: 100%; top: 0; left:0;"></iframe>
        <div name="tab_menu-tabReload" data-options="iconCls:'icon-reload'">
            刷新</div>
        <div name="tab_menu-tabcloseall" data-options="iconCls:'close-all-tabs-icon'">
            关闭全部标签</div>
        <div name="tab_menu-tabcloseother" data-options="iconCls:'close-other-tabs-icon'">
            关闭其他标签</div>
        <div name="tab_menu-tabcloseright" data-options="iconCls:'close-right-tabs-icon'">
            关闭右侧标签</div>
        <div name="tab_menu-tabcloseleft" data-options="iconCls:'close-left-tabs-icon'">
            关闭左侧标签</div>
    </div>
    <!--组织机构列表树-->
<!--    <div id="depttree" class="easyui-panel" data-options="closed:true" style="width: 200px;-->
<!--        height: 250px; z-index: 900; position: absolute;">-->
<!--        <ul id="depttreelist" class="easyui-tree" data-options="lines:true,editable:false,url:'${pageContext.request.contextPath }/systemController/sysUser/sysDept/shortNameNoNodeList?isSyn=false',onSelect:function(){treedeptselect();},onLoadSuccess:function(node,data){deptTreeLoadSuccess(node,data);}"></ul>-->
<!--    </div>-->
    <div id="tab-tools" style="display:none;border-bottom:1px solid #BDD1EA;background:#E2EBF4;">
    	<input type="hidden" name="qpOrTc" id="qpOrTc" value="tuichu" readOnly/>
    	 <a href="javascript:void(0)" id="linkbuttonref" class="easyui-linkbutton" data-options="plain:true,iconCls:'index-fresh-icon'" style="margin-top:2px;"
            onclick="autoRefush()">刷新</a>
        <a href="javascript:void(0)" id="linkbuttonmax" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-maxfull'" style="margin-top:2px;"
            onclick="maxClick()">全屏</a>
    </div>
    <!--设置菜单-->
    <div id="settings" style="width: 150px;display:none">
        <div data-options="iconCls:'icon-edit'" onclick="passwordChangClick();">密码设置</div>
        
    </div>

	<div id="online" class="easyui-dialog" title="在线人员" data-options="iconCls:'users-icon',closed:'true',modal:true" style="padding:2px;height:450px;width:700px"></div>  
	 <div id="mm" style="width:120px;display:none">  
				    <div data-options="name:'analysis',iconCls:'icon-ok'">数据统计分析</div>  
				    <div data-options="name:'sequerity'">安全监测</div>  
				    <div data-options="name:'position'">人员定位</div>  
				    <div data-options="name:'msg'">短彩信</div>  
				    <div data-options="name:'operate'">安全运营管理</div>  
				    <div data-options="name:'yingjiwuzi'">应急物资</div>  
				    <div data-options="name:'msgPublish'">信息发布</div>  
				    <div data-options="name:'videoMsg'">视频信息</div>  
				</div> 
	<script type="text/javascript">
		function doSearch(value,name){ 
			var n = ["analysis","sequerity","position","msg","operate","yingjiwuzi","msgPublish","videoMsg"];
			var v = ["数据统计分析","安全监测","人员定位","短彩信","安全运营管理","应急物资","信息发布","视频信息"];
			for(var i=0;i<n.length;i++){
				if(name==n[i]){
					 alert('您要查找的是: ' + v[i] +' 子系统下  -->'+value); 
				}
			}
         } 
				
	</script> 
	
	<!-- 修改密码窗口 -->
	<div id="updatePasswordWin" class="easyui-dialog" data-options="closed:'true',title:'密码设置',inline:false,draggable:true,height:220,collapsible:false,maximizable:false,minimizable:false,modal:true" style="padding:10px;width:400px">
		<input type="hidden" id="hiddenpassword" >
		<form id="updatePasswordForm" method="post" onsubmit="return false;">
			<table id="updatePasswordTable" border="0" class="dialog-tbl">
				<tr>
					<td class="tit-col"><label for="oldPassword">原始密码:</label></td>
					<td><input style="width:180px;height:20px;" name="oldPassword" id="oldPassword" type="password" class="easyui-validatebox" data-options="required:true" validType="equals['#hiddenpassword']"/></td>
				</tr>
				<tr>
					<td class="tit-col"><label for="newPassword">新密码:</label></td>
					<td><input style="width:180px;height:20px;" name="password" id="newPassword" type="password" class="easyui-validatebox" data-options="required:true"></td>
				</tr>
				<tr>
					<td class="tit-col"><label for="affirmPassword">确认密码:</label></td>
					<td><input style="width:180px;height:20px;" name="affirmPassword" type="password" id="affirmPassword" class="easyui-validatebox" data-options="required:true" validType="equals['#newPassword']" ></td>
				</tr>
			</table>
		</form>
	</div>
    
    <!--帮助-->
    <div id="helppanel" class="easyui-dialog" title="帮助" style="width: 450px; height: 285px;"
        data-options="iconCls:'icon-help',resizable:true,modal:true,closed:true,resizable:false">
        <div class="easyui-layout,border:false" data-options="fit:true" style="padding:10px 20px">
            <table class="tablebaseStyle" cellspacing="1">
                <tr>
                    <th colspan="2">
                        <div style="text-align: center;">
                            控件下载</div>
                    </th>
                </tr>
                <tr>
                    <td>
                        ChinaExcel控件下载
                    </td>
                    <td style="width: 50px">
                        <a href="/uploadfile/help/tool/Install_Webocx_4.0.0.3.exe">下载</a>
                    </td>
                </tr>
                <tr>
                    <td>
                        图形辅助控件
                    </td>
                    <td>
                        <a href="/uploadfile/help/tool/LrWebGIS_3.2_setup.exe">下载</a>
                    </td>
                </tr>
                <tr>
                    <td>
                        在线word展示控件
                    </td>
                    <td>
                        <a href="/uploadfile/help/tool/Dsoframerocx_32.rar">下载</a>
                    </td>
                </tr>
                <tr>
                    <td>
                       视频插件
                    </td>
                    <td>
                        <a href="/uploadfile/help/tool/cmsocx.exe">下载</a>
                    </td>
                </tr>
                <tr>
                    <td>
                        系统使用说明书下载
                    </td>
                    <td>
                        <a href="/uploadfile/help/noitcesatt/11d3a22e-c690-4737-b672-f4f45929aa85.doc">下载</a>
                    </td>
                </tr>
            </table>
        </div>
    </div>
    
    <div id='dateComplateProcessDivOut' style="position: relative;display:'none';">
    </div>
    
    <script language="JavaScript">
        var nowDay = new Date();
        function dateview() {
            var WEEK = new Array(7);
            WEEK[0] = "日"; WEEK[1] = "一"; WEEK[2] = "二"; WEEK[3] = "三"; WEEK[4] = "四"; WEEK[5] = "五"; WEEK[6] = "六";

            var temp = "";

            // temp += "今日";
            // temp += ""+ nowDay.getYear() +"年"+ (nowDay.getMonth()+1) +"月"+ nowDay.getDate() +"日";
            temp += (nowDay.getMonth() + 1) + "月" + nowDay.getDate() + "日";
            temp += "  星期" + WEEK[nowDay.getDay()];

            nowDateDiv.innerHTML = temp;
        }
        dateview();
        function timeview() {
            var timestr = nowDay.toLocaleString();
            timestr = timestr.substring(timestr.indexOf(" "));
            nowTimeDiv.innerHTML = timestr;
            nowDay.setSeconds(nowDay.getSeconds() + 1);
        }
        timeview();
        selectObj = document.getElementById("td1");
        
         //初始化时关闭dialog窗口,防止加载时一闪而过的现象
        $("#passwordChange").dialog({});
        $("#helppanel").dialog({});
        $("#updatePasswordWin").dialog({});
        
        function openDetailAlarmPage(url){
	        if(url==''){
	        	window.parent.addTabFromSubPage("5","报警信息","${rootPath }/gasController/AlarmData");
        	}else{
        		window.parent.addTabFromSubPage("5","报警信息",url);
        	}
        }
    </script> 
    <script type="text/javascript">
        var hasdefaultmenu = false;
        var curtuch = 0;
        var myurl = "";
		
		//顶层遮罩
		var $topLoading = null;
		//子页面iframe onload 事件 去除遮罩
		function closeTopLoading() {
			if ($topLoading != null) {
				$topLoading.dialog('close');
				$topLoading.dialog('destroy');
				$topLoading = null;
			}
		};

		//创建顶层遮罩
		function showTopLoading() {
			if (null != $topLoading) { return; }
			$topLoading = $('<div>').appendTo($('body'));
			var loadHtml = '<p class="loading">';
			loadHtml += '<img id="forLoading" />&nbsp;&nbsp;加载页面,请稍候...</p>';
			//loadHtml += '&nbsp;&nbsp;正在加载页面,请稍候...</p>';
			$topLoading.html(loadHtml);
			$topLoading.find('#forLoading').attr('src', '${pageContext.request.contextPath}/static/images/loading.gif');
		     setTimeout(function(){ //遮罩超时关闭
				if($topLoading){ closeTopLoading(); }
			     },10*1000);
			$topLoading.dialog({
				width: 280,
				height: 100,
				modal: true,
				border: false,
				noheader: true,
				closable: false,
				closed: false
			});
		};
         /*****************************初始化加载*****************************/
        $(function(){
            //打开遮罩层
        	//showTopLoading();
            //注册tab右击事件
            tabsInit('maintabs', 'tab_rightmenu');
            setInterval("timeview()", 1000);
            $("#treepanel").panel("resize",{
            	height:$("#maintabs").height()-35
            });

			//加载一级菜单
          	$.getJSON("${rootPath }/sysRightController/findSysRightOneLevel?random="+Math.random(), function (result) {
                var htmlmenu = "";
                if(result!=null){
                	$.each(result, function (i, field) {
    	                htmlmenu = htmlmenu + "<a id='btn' href='#' style='font-size: 13px;' class='easyui-linkbutton firstmenuStyle' onclick='loadtreemenu(\"" + field.id + "\",\"" + field.text + "\",\"" + field.attributes.url + "\")' data-options='plain:true,iconCls:\"" + field.iconCls + "\"'>" + field.text + "</a>";
                     	if(i == 0){
                     		loadtreemenu(field.id,field.text, field.attributes.url);
                         }
                    });
                }
                $("#firstmenu").html(htmlmenu);
                $.parser.parse($('#firstmenu'));
                $("#firstmenu a").eq(0).addClass("hover");
                $('#firstmenu a').each(function(){
                	$(this).bind('click', function () {
                        $('#firstmenu a').removeClass('hover');
                        $(this).addClass('hover');
                    });
                });
		   
      		});
      });
        

      /** 
	    *判断页面是否已经打开window框 
	    */  
    function hastalarmMessager(){  
        var len = $(".messager-body #talarm").length;  
        if(len==0){  
            return false ;  
        }else{  
            return true;  
        }  
    }  

    	/** 
	    *判断页面是否已经打开window框 
	    */  
	 function hasDateComplateProcessMessager(){  
	     var len = $(".messager-body #tDateComplateProcess").length;  
	     if(len==0){  
	         return false ;  
	     }else{  
	         return true;  
	     }  
	 }  
    
        var openedTreedept = false;
        //弹出组织机构
        function ondeptclick1() {
            openedTreedept = true;
            var a = $('#deptlink').position();
            $("#depttree").css({ width: "200px", height: "300px", top: a.top + 15, left: a.left, position: "absolute" });
            $('#depttree').panel('open');
            return false;
        }
        //浏览组织机构选择事件
        function treedeptselect() {
            var t = $('#depttreelist').tree('getSelected'); // 得到树对象
            $('#currentDept').html('——'+t.text); 	// 得到选择的节点  n.text组织机构名称     n.id 组织机构id
           // $('#depttree').panel('close');
            openedTreedept = false;
        }

		function deptTreeLoadSuccess(node,data){
			var userdeptid = "${sysuser['deptid']}";
			if(userdeptid == data[0].id){
				var node = $("#depttreelist").tree('find', userdeptid);
				$("#depttreelist").tree('select', node.target);
			}else{
				var children = data[0].children;//二级公司
				if(children.length > 0){
					//如果是二级公司用户登录则选择。
					for(var i = 0 ; i < children.length; i++){
						if(userdeptid == children[i].id){
							var node = $("#depttreelist").tree('find', userdeptid);
							$("#depttreelist").tree('select', node.target);
						}
					}
					//如果不是二级公司用户和公司总部人员登录，则寻找三级公司
					for(var i = 0 ; i < children.length; i++){
						var company = children[i].children;
						if(company.length > 0){
							for(var j = 0 ; j < company.length ; j++){
								if(userdeptid == company[i].id){
									var node = $("#depttreelist").tree('find', userdeptid);
									$("#depttreelist").tree('select', node.target);
								}
							}
						}
					}
				}
			}
		}

        //加载二级菜单
        function loadtreemenu(fatherId,name, url) { 
        	if(curtuch == 1 ){
				$('#body1').layout('expand','west');
				curtuch = 0;
			}
            $("#treepanel").panel({ title: name,headerCls:'side-treepanel' });
            $('#treemenu').tree({
            	lines:true, 
                url: "${rootPath }/"+url+"?fatherId="+fatherId,
          		onClick:function(node){
          			//var isleaf = $('#treemenu').tree('isLeaf',node.target); 
          			//if(isleaf){
	          			$('#treemenu').tree('expand',node.target); 
          			//}else{
	          		//	$('#treemenu').tree('toggle',node.target); 
          			//}
          		},
                onSelect:function(node){
                    if(node.state == "closed"){ // "open"
                    	 $(this).tree('expand', node.target);
                     }else{ // 打开
                    	var selectNode = $('#treemenu').tree('getSelected');
                     	var childrenNodes = $('#treemenu').tree('getChildren', selectNode.target);
                     	if(childrenNodes.length == 0){
 		                    treemenuselect();
                         }
                     }
                },
                onExpand:function(node){
					//$(this).tree("load");					
                },
                onLoadSuccess:function(node,data){ 
                	//初始化页面
                    var rootNode = $('#treemenu').tree('getRoot');
                  //  alert(rootNode.id);
                  if(rootNode!=null){
                	  $('#treemenu').tree('select', rootNode.target);
                  }
                   
                }
            });
        }
        
         //二级子菜单菜单选择事件
        function treemenuselect() {
            var node = $('#treemenu').tree('getSelected');     	// 得到选择的节点  n.text名称     n.id id
            // 周恪竭：在这里进行判断选择的当前节点是否有子节点，如果有子节点获取第一个子节点，如果没有子节点就是当前内容
            if(node.attributes != null && node.attributes.url != null && node.attributes.url != ""){
				//addtab(node.id, node.text, node.attributes, node.text);  //加载Tab页面
				var name = getHierarchies(node.id);
	            addtab(node.id, node.text, node.attributes,name);   //加载Tab页面
			}else{ 
				$.messager.alert('提示','该节点没有对应的处理路径！ ');  
			}
			//关闭进度条。。。
          //$.messager.progress('close');
        } 

/*         //二级子菜单菜单选择事件
        function treemenuselect() {
            var node = $('#treemenu').tree('getSelected');     	// 得到选择的节点  n.text名称     n.id id
            // 周恪竭：在这里进行判断选择的当前节点是否有子节点，如果有子节点获取第一个子节点，如果没有子节点就是当前内容
            var children ;
			if (node){
				children = $('#treemenu').tree('getChildren', node.target);
			} else {
				children = $('#treemenu').tree('getChildren');
			}
			if(children.length > 0){ // 如果有子节点就是第一个子节点的内容
				var chnode ;
				for(var i = 0; i < children.length; i ++){
					if(children[i].attributes != null && children[i].attributes.url != null && children[i].attributes.url != ""){
						chnode = children[i];
						break ;
					}
				}
				var name = getHierarchies(chnode.id);
				addtab(chnode.id, chnode.text, chnode.attributes,name);  //加载Tab页面
			
			}else{ // 没有子节点就是当前节点
				if(node.id!=1202){
					 var name = getHierarchies(node.id);
	                 addtab(node.id, node.text, node.attributes,name);   //加载Tab页面
	            }else{
	            	 biggisnavigato(); //加载大屏幕展示
	            }
			}
			//关闭进度条。。。
          $.messager.progress('close');
        } */
		
		function getHierarchies(id){
			var dif = id.length/2;
			var modeName="";
			for(var i = 0; i < dif ; i++){
				var sid = id.substring(0,2*(i+1));
				var node = $('#treemenu').tree('find', sid);
				if(node){
					modeName = modeName + node.text + " > ";
				}
			}
			return modeName.substring(0,modeName.length-3);
		}
		
		function closeMessager(){$.messager.progress('close'); }
        //添加tab页面
        function addtab(id, name, att,modeName) {
        	$.ajax({
        		data:{
        			id:id,
        			name:modeName
        		},
        		type:"post",
        		dataType:"json",
        		url:"${rootPath}/systemController/addSysLog",
        		success:function(data,status){ 
        			if (att != null && att.url != null && att.url != "") {
		                if (!selectTabById("indextab" + id)) {
		           /*      	if(att.type==255){  //判断框架加载类型，255为IFrame加载类型,0为Div加载类型 */
			                	showTopLoading();
			                	//判断跨域链接
			                	if( (att.url.indexOf("http://") != -1) || (att.url.indexOf("www.") != -1)){
				                	$('#maintabs').tabs('add', {
					                    title: name,
					                    content: '<iframe src="'+ att.url +'" frameborder="no" onload="closeTopLoading()" scrolling="no" style="height:100%;width:100%;"></iframe>',    //将子页面使用ifram内嵌到主框架
					                    closable: true,
					                    id: "indextab" + id.toString()
					             });
				                }else{
				                	$('#maintabs').tabs('add', {
					                    title: name,
					                    content: '<iframe src="${rootPath }/' + att.url + '" onload="closeTopLoading()" frameborder="no" scrolling="no" style="height:100%;width:100%;"></iframe>',    //将子页面使用ifram内嵌到主框架
					                    closable: true,
					                    id: "indextab" + id.toString()
					                });  
					            }
			                	
/* 		                	}else{  alert('22');
		                		$('#maintabs').tabs('add', {
			                    title: name,
			                    href: att.url,   //方案一将子页面集成到主框架中       
			                    closable: true,
			                    id: "indextab" + id.toString(),
								onLoad:closeTopLoading
			                });
		                	} */
		
		                }else{
		                	//判断跨域链接
							$('#maintabs').tabs('select', "indextab" + id.toString());
		                	var tab = $('#maintabs').tabs('getSelected');  // get selected panel
                            if( (att.url.indexOf("http://") != -1) || (att.url.indexOf("www.") != -1)){
                            	$('#maintabs').tabs('update', {
    		                		tab: tab,
    		                		options: {
    		                			content: '<div class="easyui-panel" style="overflow: hidden;" data-options="fit:true,border:false" > <iframe src="' + att.url + '"  frameborder="no" scrolling="no" style="height:100%;width:100%;"></iframe></div>'
    		                		}
    		                	});
		                	}else{
		                		$('#maintabs').tabs('update', {
			                		tab: tab,
			                		options: {
			                			content: '<div class="easyui-panel" style="overflow: hidden;" data-options="fit:true,border:false" > <iframe src="${rootPath }/' + att.url + '"  frameborder="no" scrolling="no" style="height:100%;width:100%;"></iframe></div>'
			                		}
			                	});
		                	}
		                	
		                	
		                }
		            }
        		}
        	});
        }
		
        // 密码设置
        function passwordChangClick() {
            //$('#passwordChange').dialog('open');
            //设置隐藏域
            $("#hiddenpassword").val("${sysuser['password']}");
            $("#updatePasswordWin").dialog({
            	buttons:[{
            		iconCls:'icon-ok',
					text:'修改',
					handler:update
				},{
					iconCls:'icon-cancel',
					text:'关闭',
					handler:function(){$('#updatePasswordWin').dialog('close');}
				}]
            }).dialog("open");
            //打开添加窗口前先清空
			$('#updatePasswordForm').form('clear');
        }
		
		function update(){
			$('#updatePasswordForm').form('submit',{   
				url:"${rootPath }/updataPassword",
				onSubmit:function(){
					return isValid = $(this).form('validate');
				},
			    success: function(data){   
			        var data = eval('(' + data + ')');  // change the JSON string to javascript object
			        if (data.success){ 
			            $("#updatePasswordWin").dialog("close");
			        	//$.messager.alert("操作提示", "修改成功"); 
			        	$(this).form("clear");//清除表单
			        	location.reload();
			        }   
			    }   
			}); 
		}
		
        // 验证密码   
        $.extend($.fn.validatebox.defaults.rules, {
            equals: {
                validator: function (value, param,pp) {
                    return value == $(param[0]).val();
                },
                message: '密码不一致'
            }
        });
		
        function selectTabById(id) {
            var tablist = $('#maintabs').tabs("tabs");
            //判断指定的tab页面是否存在，如果存在就选中，使用索引选中，避免title重复。性能有轻微的影响可以忽略
            if (tablist != null) {
                for (var i = 0; i < tablist.length; i++) {
                    if (tablist[i][0].id == id) {
                        $('#maintabs').tabs('select', i);
                        return true;
                    }
                }
            }
            return false;
        }

        //控制页面最大化
        var westmax = true;
        var northmax = true;
        var ismax = false;
        function maxClick() {
            if (!ismax) {

                if (northmax) {
                    $('#body1').layout('collapse', 'north');
                }
                if (westmax) {
                    $('#body1').layout('collapse', 'west');
                }
                ismax = true;

                setmaxbutton("退出", "icon-exitmaxfull");
                $("#qpOrTc").val("quanping");//quanping全屏状态
            }
            else {
                if (!northmax) {
                    $('#body1').layout('expand', 'north');
                }
                if (!westmax) {
                    $('#body1').layout('expand', 'west');
                }
                ismax = false;
                setmaxbutton("全屏", "icon-maxfull");
                $("#qpOrTc").val("tuichu");//tuichu非全屏状态
            }
        };

        function setmaxbutton(text, icon) {
            $('#linkbuttonmax').linkbutton({ text: text,
                iconCls: icon
            });
        }
        
              //注销       
    function exit() { 
		$.messager.confirm('注销系统', '确定要注销吗?', function(r) {
			if (r) {
					window.location.replace("${rootPath}/sysUserController/loginOut?t=" + Math.random());   
			}
		});
	}
			
	function addTabFromSubPage(id,name,url){
		 showTopLoading();
		 if (!selectTabById("gis" + id)) {
			$('#maintabs').tabs('add', {
	            title: name,
	            content: '<div class="easyui-panel" style="overflow: hidden;" data-options="fit:true,border:false" > <iframe onload="closeTopLoading()" src="' + url + '"  frameborder="no" scrolling="no" style="height:100%;width:100%;"></iframe></div>',
	            closable: true,
	            id: "gis" + id.toString()
	        });
        }else{
        	$('#maintabs').tabs('select', "gis" + id.toString());
           	var tab = $('#maintabs').tabs('getSelected');
           	$('#maintabs').tabs('update', {
           		tab: tab,
           		options: {
           			content: '<div class="easyui-panel" style="overflow: hidden;" data-options="fit:true,border:false" > <iframe onload="closeTopLoading()" src="' + url + '"  frameborder="no" scrolling="no" style="height:100%;width:100%;"></iframe></div>'
           		}
           	});
        }
	}
	function addTabFromSubPageWithScroll(id,name,url){
		 showTopLoading();
		 if (!selectTabById("gis" + id)) {
			$('#maintabs').tabs('add', {
	            title: name,
	            content: '<div class="easyui-panel" style="overflow: hidden;" data-options="fit:true,border:false" > <iframe onload="closeTopLoading()" src="' + url + '"  frameborder="no" scrolling="yes" style="height:100%;width:100%;"></iframe></div>',
	            closable: true,
	            id: "gis" + id.toString()
	        });
        }else{
        	$('#maintabs').tabs('select', "gis" + id.toString());
           	var tab = $('#maintabs').tabs('getSelected');
           	$('#maintabs').tabs('update', {
           		tab: tab,
           		options: {
           			content: '<div class="easyui-panel" style="overflow: hidden;" data-options="fit:true,border:false" > <iframe onload="closeTopLoading()" src="' + url + '"  frameborder="no" scrolling="yes" style="height:100%;width:100%;"></iframe></div>'
           		}
           	});
        }
	}
		
   /*监听浏览器关闭事件   */
    window.onbeforeunload = function(event) {
        if(window.event.clientX>(document.body.clientWidth-40)&&window.event.clientY<0||window.event.clientY<0){
        	window.location.href ="${rootPath }/loginOut";
        }
    };
  
		 //在线人员	
		 function showOnLine(){
			    var url= "${rootPath }/sysUserController/online/load";    
				$("#online").dialog("refresh", url);
				//$.parser.parse("#online");
				$("#online").dialog("open");
		 }
		 //获取Tab标签页的ID
		 function getSysRightNodeId(gisId){ 
			 if(gisId=='8'){
				 return "1216";
			 }else if(gisId=='10'){ 
				 return "170001"; 
			 }else if(gisId=='11'){
		         return "170001";
			 }else{ 
			  	 var selectMenu = $('#treemenu').tree("getSelected"); 
				 return selectMenu.id;
			 }
		}

		  //自刷新 
			function autoRefush(){
	           	var tab = $('#maintabs').tabs('getSelected');
	          //  var opt = tab.panel('options'); 
	          //  var curTabTitle=opt.title;
	            var src=tab.find("iframe").attr("src");
	           	$('#maintabs').tabs('update', {
	           		tab: tab,
	           		options: {
	           		  //  title: curTabTitle,
	           		    content:'<div class="easyui-panel" style="overflow: hidden;" data-options="fit:true,border:false" ><iframe src="' + src + '" frameborder="no" scrolling="no" style="height:100%;width:100%;margin:0;"></iframe></div>'
	           		}
	           	});
             }

            //主动校验Session的有效性
             setInterval("validateSession()",30*60*1000);  //30分钟
		     function validateSession(){ 			     
		    	 $.post('${rootPath }/sessionTimeOut',function(data){ 
		    		 var result=eval('('+data+')');
					 if (!result.success){
						 alert("您的会话已经失效，请重新登陆！");
						 window.location.replace("/goldcardiot/loginOut"); 
					 }
				 });
			  }
            
    </script>
</body>
</html>
