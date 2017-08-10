
//基于easyui的双表格控件
(function ($) {
    $.fn.extend({ doublegrid: DoubleGrid });
    $.fn.doublegrid.defaults =
        {
            grid: { //datagrid 属性
                fitColumns: true,
                width: 'auto',
                rownumbers: false,
                pagination: false,
                scrollbarSize: 0,
                method: 'POST'
            },
            pagetion:  //Pagination 属性
                {
                    pageSize: 20,
                    pageNumber: 1,
                    showPageList:false
                }
            ,onLoadSuccess:$.noop
        }
    function DoubleGrid(options) {
        var gridOpts = $.extend({}, $.fn.doublegrid.defaults.grid,
            options.grid || {}
            );
        var pageOpts = $.extend({}, $.fn.doublegrid.defaults.pagetion,
            options.pagetion || {},
            {
                onSelectPage: function (n, s) {
                    loadData(n, s);
                }
            }
            );
        var $wrap1 = $('<div></div>').css({ width: "50%", float: 'left',height:'93%' });
        var $wrap2 = $('<div></div>').css({ width: "50%", float: 'right',height:'93%' });
        this.append($wrap1);
        this.append($wrap2);
        this.append('<br style="clear:both;"/>');
        var $grid1 = $('<div>').appendTo($wrap1);
        var $grid2 = $('<div>').appendTo($wrap2);
        var $pagetion = $('<div>').appendTo(this);

        var url = gridOpts.url; delete gridOpts.url;
        $pagetion.pagination(pageOpts);
        $grid1.datagrid(gridOpts);
        $grid2.datagrid(gridOpts);
        $(window).bind('resize',resizeGrid);
        resizeGrid();
        //alert('opts:'+ pageOpts.pageSize);
        loadData(pageOpts.pageNumber, pageOpts.pageSize);

        //宽高度自适应
        function resizeGrid(){
            $grid1.datagrid('resize',{width:'50%'});
            $grid2.datagrid('resize',{width:'50%'});
        }
        //加载数据
        function loadData(pageNumber, pageSize) {
            var method = gridOpts.method;
            var queryParams = gridOpts.queryParams || {};
            if (typeof queryParams == 'function') {
                queryParams = queryParams();
            }
            var sendData = $.extend({}, { currentPage: pageNumber, pageSize: pageSize }, queryParams);
            $.ajax({
                url: url,
                data: sendData,
                type: method,
                dataType: 'JSON',
                success: function (d) {
            		if(typeof options.onLoadSuccess =='function'){ options.onLoadSuccess(d); }
                    $pagetion.pagination('refresh', { total: d.total, pageNumber: pageNumber });
                    var ps=d.rows.length;
                    var left=Math.ceil(ps/2);
                    $grid1.datagrid('loadData', d.rows.slice(0, left));
                    $grid2.datagrid('loadData', d.rows.slice(left));
                    $grid1.datagrid('doCellTip',{'max-width':'300px','delay':500});
                    $grid2.datagrid('doCellTip',{'max-width':'300px','delay':500});
                }
            });
        };

        //外部属性
        this.pagination = $pagetion;
        this.datagrid = [$grid1, $grid2];
        return this;
    };
})(jQuery);