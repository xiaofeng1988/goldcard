//注册tab右击事件
function tabsInit(tabsId, tab_rightmenuId) {
    //绑定tabs的右键菜单
    $("#" + tabsId).tabs({
        onContextMenu: function (e, title) {//这时去掉 tabsId所在的div的这个属性：class="easyui-tabs"，否则会加载2次
            e.preventDefault();
            $('#' + tab_rightmenuId).menu('show', {
                left: e.pageX,
                top: e.pageY
            }).data("tabTitle", title);
        }
    });

    //实例化menu的onClick事件
    $("#" + tab_rightmenuId).menu({
        onClick: function (item) {
            CloseTab(tabsId, tab_rightmenuId, item.name);
        }
    });
}

/**
tab关闭事件
@param	tabId		tab组件Id
@param	tabMenuId	tab组件右键菜单Id
@param	type		tab组件右键菜单div中的name属性值
*/
function CloseTab(tabId, tabMenuId, type) {
    //tab组件对象
    var tabs = $('#' + tabId);
    //tab组件右键菜单对象
    var tab_menu = $('#' + tabMenuId);

    //获取当前tab的标题
    var curTabTitle = tab_menu.data('tabTitle'); 
    switch (type) {
        case 'tab_menu-tabReload':
            //刷新当前tab
            var tab = tabs.tabs("getTab", curTabTitle);
            var opt = tab.panel('options');
            //var url=opt.content;
            if (opt.closable) {
                tabs.tabs("update", {tab: tab,
					options: {
						title: curTabTitle
						//content:url
					}
				});
            }
            else{
            	tabs.tabs("update",{
            		tab:tab,
            		options:{
            			content:'<div class="easyui-panel" style="overflow: hidden;" data-options="fit:true,border:false" ><iframe src="/zjugis/view/desk/desk.jsp" frameborder="no" scrolling="no" style="height:100%;width:100%;margin:0;"></iframe></div>'
            			//content:url
            		}
            	})
            }
            break;
        case 'tab_menu-tabModuleDefault':
            //设置模块默认页
            break;
        case 'tab_menu-tabHomeDefault':
            //设置默认页
            break;
        case 'tab_menu-tabclose':
            //关闭当前tab
            var tab = tabs.tabs("getTab", curTabTitle);
            var opt = tab.panel('options');
            if (opt.closable) {
                tabs.tabs("close", curTabTitle);
            }
            break;
        case 'tab_menu-tabcloseall':
            //获取所有关闭的tab对象
            var closeTabsTitle = getAllTabObj(tabs);
            //循环删除要关闭的tab
            $.each(closeTabsTitle, function () {
                var title = this;
                tabs.tabs('close', title);
            });
            break;
        case 'tab_menu-tabcloseother':
            //获取所有关闭的tab对象
            var closeTabsTitle = getAllTabObj(tabs);
            //循环删除要关闭的tab
            $.each(closeTabsTitle, function () {
                var title = this;
                if (title != curTabTitle) {
                    tabs.tabs('close', title);
                }
            });
            break;
        case 'tab_menu-tabcloseleft':
            //获取所有关闭的tab对象
            var closeTabsTitle = getLeftToCurrTabObj(tabs, curTabTitle);
            //循环删除要关闭的tab
            $.each(closeTabsTitle, function () {
                var title = this;
                tabs.tabs('close', title);
            });
            break;
        case 'tab_menu-tabcloseright':
            //获取所有关闭的tab对象
            var closeTabsTitle = getRightToCurrTabObj(tabs, curTabTitle);
            //循环删除要关闭的tab
            $.each(closeTabsTitle, function () {
                var title = this;
                tabs.tabs('close', title);
            });
            break;
        default:

    }
}

/**
获取所有关闭的tab对象
@param	tabs	tab组件
*/
function getAllTabObj(tabs) {
    //存放所有tab标题
    var closeTabsTitle = [];
    //所有所有tab对象
    var allTabs = tabs.tabs('tabs');
    $.each(allTabs, function () {
        var tab = this;
        var opt = tab.panel('options');
        //获取标题
        var title = opt.title;
        //是否可关闭 ture:会显示一个关闭按钮，点击该按钮将关闭选项卡
        var closable = opt.closable;
        if (closable) {
            closeTabsTitle.push(title);
        }
    });
    return closeTabsTitle;
}

/**
获取左侧第一个到当前的tab
@param	tabs		tab组件
@param	curTabTitle	到当前的tab
*/
function getLeftToCurrTabObj(tabs, curTabTitle) {
    //存放所有tab标题
    var closeTabsTitle = [];
    //所有所有tab对象
    var allTabs = tabs.tabs('tabs');
    for (var i = 0; i < allTabs.length; i++) {
        var tab = allTabs[i];
        var opt = tab.panel('options');
        //获取标题
        var title = opt.title;
        //是否可关闭 ture:会显示一个关闭按钮，点击该按钮将关闭选项卡
        var closable = opt.closable;
        if (closable) {
            //alert('title' + title + '  curTabTitle:' + curTabTitle);
            if (title == curTabTitle) {
                return closeTabsTitle;
            }
            closeTabsTitle.push(title);
        }
    }
    return closeTabsTitle;
}

/**
获取当前到右侧最后一个的tab
@param	tabs		tab组件
@param	curTabTitle	到当前的tab
*/
function getRightToCurrTabObj(tabs, curTabTitle) {
    //存放所有tab标题
    var closeTabsTitle = [];
    //所有所有tab对象
    var allTabs = tabs.tabs('tabs');
    for (var i = (allTabs.length - 1); i >= 0; i--) {
        var tab = allTabs[i];
        var opt = tab.panel('options');
        //获取标题
        var title = opt.title;
        //是否可关闭 ture:会显示一个关闭按钮，点击该按钮将关闭选项卡
        var closable = opt.closable;
        if (closable) {
            //alert('title' + title + '  curTabTitle:' + curTabTitle);
            if (title == curTabTitle) {
                return closeTabsTitle;
            }
            closeTabsTitle.push(title);
        }
    }
    return closeTabsTitle;
}

/**
 * 合并单元格函数（相同内容合并到一起）
 * create date 2012-11-5
 **/
$.extend($.fn.datagrid.methods, {
    autoMergeCells : function (jq, fields) {
        return jq.each(function () {
            var target = $(this);
            if (!fields) {
                fields = target.datagrid("getColumnFields");
            }
            var rows = target.datagrid("getRows");
            var i = 0,
            j = 0,
            temp = {};
            for (i; i < rows.length; i++) {
                var row = rows[i];
                j = 0;
                for (j; j < fields.length; j++) {
                    var field = fields[j];
                    var tf = temp[field];
                    if (!tf) {
                        tf = temp[field] = {};
                        tf[row[field]] = [i];
                    } else {
                        var tfv = tf[row[field]];
                        if (tfv) {
                            tfv.push(i);
                        } else {
                            tfv = tf[row[field]] = [i];
                        }
                    }
                }
            }
            $.each(temp, function (field, colunm) {
                $.each(colunm, function () {
                    var group = this;
                    
                    if (group.length > 1) {
                        var before,
                        after,
                        megerIndex = group[0];
                        for (var i = 0; i < group.length; i++) {
                            before = group[i];
                            after = group[i + 1];
                            if (after && (after - before) == 1) {
                                continue;
                            }
                            var rowspan = before - megerIndex + 1;
                            if (rowspan > 1) {
                                target.datagrid('mergeCells', {
                                    index : megerIndex,
                                    field : field,
                                    rowspan : rowspan
                                });
                            }
                            if (after && (after - before) != 1) {
                                megerIndex = after;
                            }
                        }
                    }
                });
            });
        });
    }
});

/**
 * 扩展两个方法
 */
$.extend($.fn.datagrid.methods, {
    /**
     * 开打提示功能
     * @param {} jq
     * @param {} params 提示消息框的样式
     * @return {}
     */
    doCellTip: function(jq, params){
        function showTip(data, td, e){
            if ($(td).text() == "") 
                return;
            var xValue=$("body").width()-e.pageX;
            if(xValue < data.tooltip.text($(td).text()).width()){
            	data.tooltip.text($(td).text()).css({
            		top: (e.pageY + 10) + 'px',
            		right:0,
            		left:'auto',
            		'z-index': $.fn.window.defaults.zIndex,
	                display: 'block'
            	});
            }
            else{
	            data.tooltip.text($(td).text()).css({
	                top: (e.pageY + 10) + 'px',
	                left: (e.pageX + 10) + 'px',
	                right:'auto',
	                'z-index': $.fn.window.defaults.zIndex,
	                display: 'block'
	            });
            }
        };
        return jq.each(function(){
            var grid = $(this);
            var options = $(this).data('datagrid');
            if (!options.tooltip) {
                var panel = grid.datagrid('getPanel').panel('panel');
                var defaultCls = {
                    'border': '1px solid #333',
                    'padding': '2px',
                    'color': '#333',
                    'background': '#f7f5d1',
                    'position': 'absolute',
                    'max-width': '300px',
					'border-radius' : '4px',
					'-moz-border-radius' : '4px',
					'-webkit-border-radius' : '4px',
                    'display': 'none',
                    'word-break': 'break-all'
                 //   'white-space':'nowrap'
                }
                var tooltip = $("<div id='celltip'></div>").appendTo('body');
                tooltip.css($.extend({}, defaultCls, params.cls));
                options.tooltip = tooltip;
                panel.find('.datagrid-body').each(function(){
                    var delegateEle = $(this).find('> div.datagrid-body-inner').length ? $(this).find('> div.datagrid-body-inner')[0] : this;
                    $(delegateEle).undelegate('td', 'mouseover').undelegate('td', 'mouseout').undelegate('td', 'mousemove').delegate('td', {
                        'mouseover': function(e){
                            if (params.delay) {
                                if (options.tipDelayTime) 
                                    clearTimeout(options.tipDelayTime);
                                var that = this;
                                options.tipDelayTime = setTimeout(function(){
                                    showTip(options, that, e);
                                }, params.delay);
                            }
                            else {
                                showTip(options, this, e);
                            }
                            
                        },
                        'mouseout': function(e){
                            if (options.tipDelayTime) 
                                clearTimeout(options.tipDelayTime);
                            options.tooltip.css({
                                'display': 'none'
                            });
                        },
                        'mousemove': function(e){
							var that = this;
                            if (options.tipDelayTime) 
                                clearTimeout(options.tipDelayTime);
                            //showTip(options, this, e);
							options.tipDelayTime = setTimeout(function(){
                                    showTip(options, that, e);
                                }, params.delay);
                        }
                    });
                });
                
            }
            
        });
    },
    /**
     * 关闭消息提示功能
     *
     * @param {}
     *            jq
     * @return {}
     */
    cancelCellTip: function(jq){
        return jq.each(function(){
            var data = $(this).data('datagrid');
            if (data.tooltip) {
                data.tooltip.remove();
                data.tooltip = null;
                var panel = $(this).datagrid('getPanel').panel('panel');
                panel.find('.datagrid-body').undelegate('td', 'mouseover').undelegate('td', 'mouseout').undelegate('td', 'mousemove')
            }
            if (data.tipDelayTime) {
                clearTimeout(data.tipDelayTime);
                data.tipDelayTime = null;
            }
        });
    }
});

//
//$.ajaxSetup({   
//    contentType:"application/x-www-form-urlencoded;charset=utf-8",   
//    complete:function(XMLHttpRequest,textStatus){  
//      var sessionstatus=XMLHttpRequest.getResponseHeader("sessionstatus"); //通过XMLHttpRequest取得响应头，sessionstatus，  
//      if(sessionstatus=="timeout"){ 
//              alert("登录超时,请重新登录！");
//              if (window != top) {
//            	  top.location.href="/api/sysUserController/loginOut";
//              }else{
//            	  window.location.replace("/api/sysUserController/loginOut"); 
//              }  
//          } 
//          if(sessionstatus=="otherlogin"){ 
//              alert("此账号已经有人登陆,请重新登录！");
//              if (window != top) {
//            	  top.location.href="/api/sysUserController/loginOut";
//              }else{
//            	  window.location.replace("/api/sysUserController/loginOut"); 
//              }  
//          } 
//       }   
//  });