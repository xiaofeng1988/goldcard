/// <reference path="../../Script/easyui/jquery-1.8.0.min.js" />
/// <reference path="../../Script/easyui/jquery.easyui.min.js" />
$(function () {
    //设置DataGrid默认值
    //全屏
    $.fn.datagrid.defaults.fit = true;
    //无边框
    $.fn.datagrid.defaults.border = false;
    //单选
    $.fn.datagrid.defaults.singleSelect = true;
    //带行高
    $.fn.datagrid.defaults.rownumbers = true;
    //是否分页
    $.fn.datagrid.defaults.pagination = true;
    //默认每页显示行数
    $.fn.datagrid.defaults.pageSize = 15;
    //选择每页显示行数
    $.fn.datagrid.defaults.pageList = [15, 20, 30];
    //自动设置高度设置为false,可提高性能
    $.fn.datagrid.defaults.autoRowHeight = false;
    //交替显示行背景
    $.fn.datagrid.defaults.striped = true;

    //设置Dialog默认值
    //在本侧内显示对话框
    $.fn.dialog.defaults.inline = true;
    $.fn.dialog.defaults.resizable = true;
    $.fn.dialog.defaults.modal = true
    $.fn.dialog.defaults.closed = true;
    $.fn.dialog.defaults.width = 260;

    //设置PropertyGrid默认值
    //全屏
    $.fn.propertygrid.defaults.fit = true;
    //无下拉
    $.fn.propertygrid.defaults.scrollbarSize = 0;
    //不显示头
    $.fn.propertygrid.defaults.showHeader = false;

    //设置combobox的默认值
    $.fn.combobox.defaults.width = 155;

    //设置linkbutton的默认值
    $.fn.linkbutton.defaults.plain = true;

    //设置TreeGrid默认值
    //设置节点值为id字段
    $.fn.treegrid.defaults.idField = "id";
    //设置节点值为字段
    $.fn.treegrid.defaults.treeField = "name";
    //设置动画效果为true
    $.fn.treegrid.defaults.animate = true;
    //设置为单选
    $.fn.treegrid.defaults.singleSelect = true;
    //全屏
    $.fn.treegrid.defaults.fit = true;
    //无边框
    $.fn.treegrid.defaults.border = false;

});

