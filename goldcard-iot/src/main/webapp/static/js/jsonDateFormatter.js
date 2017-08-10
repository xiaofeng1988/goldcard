/**
 * 李云龙：处理列表后台传回来到前端页面json格式数据日期显示问题
 *        将列表日期显示long格式转换为熟悉的日期格式的处理
 */
	//将列表日期显示long格式转换为熟悉的日期格式的处理
    function formatDatebox(value) {
        if (value == null || value == '') {
            return '';
        }
	    var dt;
	    if (value instanceof Date) {
	        dt = value;
	    }
	    else {
	        dt = new Date(value);
	        if (isNaN(dt)) {
	            value = value.replace(/\/Date\((-?\d+)\)\//, '$1'); //将那个长字符串的日期值转换成正常的JS日期格式
	            dt = new Date();
	            dt.setTime(value);
	        }
	    }
	
	    return dt.format("yyyy-MM-dd");   //这里用到一个javascript的Date类型的拓展方法，这个是自己添加的拓展方法，在后面的步骤3定义
	}
    //前面那个方法只是让控件在普通状态下的显示得到纠正，但dataGrid控件还有行编辑状态，行编辑状态下还是会出现日期不能正常显示的状况，
	//此时需要拓展datagrid方法(这里说成重写比较贴切)，使datagrid行编辑时，日期控件内的时间格式正确显示：
	$.extend( $.fn.datagrid.defaults.editors, {
        datebox: {
            init: function (container, options) {
                var input = $('').appendTo(container);
                input.datebox(options);
                return input;
            },
            destroy: function (target) {
                $(target).datebox('destroy');
            },
            getValue: function (target) {
                return $(target).datebox('getValue');
            },
            setValue: function (target, value) {
                $(target).datebox('setValue', formatDatebox(value));
            },
            resize: function (target, width) {
                $(target).datebox('resize', width);
            }
        }
    });
	//将列表日期显示long格式转换为熟悉的日期格式的处理
	Date.prototype.format = function (format) {
	    var o = {
	        "M+": this.getMonth() + 1, //month 
	        "d+": this.getDate(),    //day 
	        "h+": this.getHours(),   //hour 
	        "m+": this.getMinutes(), //minute 
	        "s+": this.getSeconds(), //second 
	        "q+": Math.floor((this.getMonth() + 3) / 3),  //quarter 
	        "S": this.getMilliseconds() //millisecond 
	    }
	    if (/(y+)/.test(format)) format = format.replace(RegExp.$1,
	    (this.getFullYear() + "").substr(4 - RegExp.$1.length));
	    for (var k in o) if (new RegExp("(" + k + ")").test(format))
	        format = format.replace(RegExp.$1,
	      RegExp.$1.length == 1 ? o[k] :
	        ("00" + o[k]).substr(("" + o[k]).length));
	    return format;
	}