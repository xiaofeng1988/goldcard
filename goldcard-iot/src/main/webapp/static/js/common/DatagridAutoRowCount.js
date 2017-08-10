/**
 * 杨琪：获取datagrid自适应每页记录条数，调用getRowCount获取记录数
 * getRowCount(grid,toolbar) - grid:要获取记录数的datagrid对象. 
 */


// 获取每页记录数
function getRowCount(grid) {
	var rowHeight = 39;// 每行高度固定26px
	var lrownumber=getGridBodyHeight(grid) / rowHeight-1
	return parseInt(lrownumber);
}

// 获取grid body部分的高度
function getGridBodyHeight(grid) {
	var view = grid.data().datagrid.dc.view2;
	var headerCell = view.find("div.datagrid-header td[field]");
	var headerHeight = headerCell.height();// 表头固定高度
	var toolbar = grid.datagrid('options').toolbar;
	var toolbarHeight = 0;
	if (toolbar) {
		toolbarHeight = $(toolbar).height();// 获取toolbar高度
	}
	var pager = grid.datagrid('getPager');
	var pageHeight = pager.height();
	var gridBodyHeight = $(window).height() - headerHeight - toolbarHeight
			- pageHeight;
	return gridBodyHeight;
}
//获取每页记录数
function getRowCountNoPage(grid) {
	var rowHeight = 39;// 每行高度固定39px
	var rrownumber=getGridBodyHeightNoPage(grid) / rowHeight-1;
	return parseInt(rrownumber);
}


// 获取grid body部分的高度
function getGridBodyHeightNoPage(grid) {
	var view = grid.data().datagrid.dc.view2;
	var headerCell = view.find("div.datagrid-header td[field]");
	var headerHeight = headerCell.height()+1;// 表头固定高度
	var toolbar = grid.datagrid('options').toolbar;
	//var toolbarHeight = 0;
	var toolbarHeight = $(".panelTopbarStyl").height();
	if (toolbar) {
		toolbarHeight = $(toolbar).height();
		alert(toolbarHeight);// 获取toolbar高度
	}
	
	var gridBodyHeight = $(window).height() - headerHeight - toolbarHeight;
	return gridBodyHeight;
}

// 获取自适应每页条数:pageSize
function getAutoRowCount() {
	var tableHeight=$(window).height()-70;    
	var rowHeight = 39;// 每行高度固定39px
	var lrownumber=parseInt(tableHeight / rowHeight)-1;  
	return lrownumber;
}
