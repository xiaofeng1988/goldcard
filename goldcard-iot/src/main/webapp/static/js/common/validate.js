/**
 * easyui校验扩展
 */
$(function() {
    $.extend($.fn.validatebox.defaults.rules, {
        notnull: { //验证必输项
            /*validator:function(value){   
        	var len=$.trim(value).length;   
        	return len>0;*/
            validator: function(value) {
                var reg = /^[\s]*|[\s]*$/g;
                var v = value.replace(reg, "");
                return v.length > 0;
            },
            message: "该输入项为必输项."
        },
        //验证字符长度在某个区间
        length: {
            validator: function(value, param) {
                this.message = '字符的长度在[ {0}-{1} ] ';
                var len = $.trim(value).length;
                if (param) {
                    for (var i = 0; i < param.length; i++) {
                        this.message = this.message.replace(new RegExp("\\{" + i + "\\}", "g"), param[i]);
                    }
                }
                return len >= param[0] && len <= param[1];
            },
            message: '请输入一个值在 {0} 和 {1} 之间.'
        },
        //验证字符长度的最大值
        maxLength: {
            validator: function(value, param) {
                return value.length < param[0];
            },
            message: '字符长度必须小于 {0}个字符！'
        },
        //验证字符长度的最小值
        minLength: {
            validator: function(value, param) {
                return value.length >= param[0];
            },
            message: '请输入至少（2）个字符.'
        },
        //验证汉子
        CHS: {
            validator: function(value) {
                return /^[\u0391-\uFFE5]+$/.test(value);
            },
            message: '只能输入汉字'
        },
        phone: { // 验证电话号码   
            validator: function(value) {
               // return /^((\(\d{2,3}\))|(\d{3}\-))?(\(0\d{2,3}\)|0\d{2,3}-)?[1-9]\d{6,7}(\-\d{1,4})?$/i.test(value);
                var reg= /^0\d{2,3}-?\d{7,8}$/;
            	return reg.test(value);
            },
            message: '格式不正确,请使用下面格式:010-88888888'
        },
        // 验证电话号码   
        telephone: { 
            validator: function(value) {
                var reg= /^[\d\s\-]+$/;
            	return reg.test(value);
            },
            message: "格式不正确,只能输入数字或'-'"
        },
        
        //移动手机号码验证
        mobile: { //value值为文本框中的值
            validator: function(value) {
                var reg = /^1[0-9]\d{9}$/;
                return reg.test(value);
            },
            message: '输入正确手机号码[1开头，11位有效数字]'
        },
        //用户账号验证(只能包括 _ 数字 字母) 
        account: { //param的值为[]中值
            validator: function(value, param) {
                if (value.length < param[0] || value.length > param[1]) {
                    $.fn.validatebox.defaults.rules.account.message = '用户名长度必须在' + param[0] + '至' + param[1] + '范围';
                    return false;
                } else {
                    if (!/^[\w]+$/.test(value)) {
                        $.fn.validatebox.defaults.rules.account.message = '用户名只能数字、字母、下划线组成.';
                        return false;
                    } else {
                        return true;
                    }
                }
            },
            message: ''
        },
        idcard: { // 验证身份证   
            validator: function(value) {
                return /^\d{15}(\d{2}[A-Za-z0-9])?$/i.test(value);
            },
            message: '身份证号码格式不正确'
        },
        checkNum: { //验证整数
            validator: function(value, param) {
                return /^([0-9]+)$/.test(value);
            },
            message: '请输入数字'
        },
        checkFloat: { //验证合法数字
            validator: function(value, param) {
                return /^[+|-]?([0-9]+\.[0-9]+)|[0-9]+$/.test(value);
            },
            message: '请输入合法数字'
        },
        intOrFloat: { // 验证整数或小数   
            validator: function(value) {
                return /^\d+(\.\d+)?$/i.test(value);
            },
            message: '请输入数字，并确保格式正确'
        },
        currency: { // 验证货币   
            validator: function(value) {
                return /^\d+(\.\d+)?$/i.test(value);
            },
            message: '货币格式不正确'
        },
        qq: { // 验证QQ,从10000开始   
            validator: function(value) {
                return /^[1-9]\d{4,9}$/i.test(value);
            },
            message: 'QQ号码格式不正确'
        },
        integer: { // 验证整数   
            validator: function(value) {
                return /^[+]?[1-9]+\d*$/i.test(value);
            },
            message: '请输入整数'
        },
        age: { // 验证年龄  
            validator: function(value) {
                return /^(?:[1-9][0-9]?|1[01][0-9]|120)$/i.test(value);
            },
            message: '年龄必须是1到120之间的整数'
        },
        number: {
            validator: function(value, param) {
                return /^\d+$/.test(value);
            },
            message: '请输入数字'
        },
        float: {
            validator: function (value, param) {
                return /(^\d+(\.)(\d+))|(^\d+)$/.test(value);
            },
            message: '请输入小数'
        },
        chinese: { // 验证中文   
            validator: function(value) {
                return /^[\Α-\￥]+$/i.test(value);
            },
            message: '请输入中文'
        },
        english: { // 验证英语   
            validator: function(value) {
                return /^[A-Za-z]+$/i.test(value);
            },
            message: '请输入英文'
        },
        unnormal: { // 验证是否包含空格和非法字符   
            validator: function(value) {
                return /.+/i.test(value);
            },
            message: '输入值不能为空和包含其他非法字符'
        },
        username: { // 验证用户名   
            validator: function(value) {
                return /^[a-zA-Z][a-zA-Z0-9_]{5,15}$/i.test(value);
            },
            message: '用户名不合法（字母开头，允许6-16字节，允许字母数字下划线）'
        },
        faxno: { // 验证传真   
            validator: function(value) {
                //                return /^[+]{0,1}(\d){1,3}[ ]?([-]?((\d)|[ ]){1,12})+$/i.test(value);   
                return /^((\(\d{2,3}\))|(\d{3}\-))?(\(0\d{2,3}\)|0\d{2,3}-)?[1-9]\d{6,7}(\-\d{1,4})?$/i.test(value);
            },
            message: '传真号码不正确'
        },
        zip: { // 验证邮政编码   
            validator: function(value) {
                return /^[1-9]\d{5}$/i.test(value);
            },
            message: '邮政编码格式不正确'
        },
        ip: { // 验证IP地址   
            validator: function(value) {
	        	 var reg = /^((1?\d?\d|(2([0-4]\d|5[0-5])))\.){3}(1?\d?\d|(2([0-4]\d|5[0-5])))$/ ;  
	             return reg.test(value);  
            },
            message: 'IP地址格式不正确'
        },
        name: { // 验证姓名，可以是中文或英文   
            validator: function(value) {
                return /^[\Α-\￥]+$/i.test(value) | /^\w+[\w\s]+\w+$/i.test(value);
            },
            message: '请输入姓名'
        },
        date: { // 验证日期   
            validator: function(value) {
                //格式yyyy-MM-dd或yyyy-M-d  
                return /^(?:(?!0000)[0-9]{4}([-]?)(?:(?:0?[1-9]|1[0-2])\1(?:0?[1-9]|1[0-9]|2[0-8])|(?:0?[13-9]|1[0-2])\1(?:29|30)|(?:0?[13578]|1[02])\1(?:31))|(?:[0-9]{2}(?:0[48]|[2468][048]|[13579][26])|(?:0[48]|[2468][048]|[13579][26])00)([-]?)0?2\2(?:29))$/i.test(value);
            },
            message: '清输入合适的日期格式'
        },
        msn: {
            validator: function(value) {
                return /^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/.test(value);
            },
            message: '请输入有效的msn账号(例：abc@hotnail(msn/live).com)'
        },
        same: {
            validator: function(value, param) {
                if ($("#" + param[0]).val() != "" && value != "") {
                    return $("#" + param[0]).val() == value;
                } else {
                    return true;
                }
            },
            message: '两次输入的密码不一致！'
        },
        
	    lessThanDate: {   
	        validator: function(value, param){
				target = $(param[0]).datetimebox('getValue'); 
	        	if(target != '' && value != ''){
	        		return target >= value;  
	        	}else{
	        		return true;
	        	}
	        },   
	        message: '开始时间 必须小于等于 结束时间！'  
	    }, 
		greaterThanDate:{
	        validator: function(value, param){   
				target = $(param[0]).datetimebox('getValue'); 
	        	if(target != '' && value != ''){
	        		return target <= value;  
	        	}else{
	        		return true;
	        	}
	        },   
	        message: ' 结束时间  必须大于等于 开始时间！'  		
		},
	    lessThanToday: {   
	        validator: function(value){	       
			    var today = getCurrentDate(0,0);
	        	if(today != '' && value != ''){ 
	        		return value <= today;  
	        	}else{
	        		return true;
	        	}
	        },   
	        message: '结束时间 必须小于等于 今天！'  
	    },
        coordinates: { // 验证经纬度  
            validator: function(value) {
                return /^\d+(\.\d+)?,\d+(\.\d+)?$/i.test(value);
            },
            message: '请输入正确格式'
        },
        phoneOrMobile: { // 验证手机或者电话号码
            validator: function(value) {
                //return /^(([0\+]\d{2,3}-)?(0\d{2,3})-)(\d{7,8})(-(\d{3,}))?$/.test(value);
                return /(^((0[1,2]{1}\d{1}-?\d{8})|(0[3-9]{1}\d{2}-?\d{7,8}))$)|(^0?(13[0-9]|15[0-35-9]|18[0236789]|14[57])[0-9]{8}$)/.test(value);
            },
            message: '手机或固话号码格式不正确'
        },
        /*必须和某个字段相等*/
        equalTo: { 
        	validator: function (value, param) { 
        	   return $(param[0]).val() == value; 
        	}, 
        	message: '两次输入的内容不一致' 
        },
        //经度
        longitude: {
            validator: function (value, param) {
//                return /^-?(?:(?:180(?:\.0{1,5})?)|(?:(?:(?:1[0-7]\d)|(?:[1-9]?\d))(?:\.\d{1,5})?))$/.test(value);
                return  /^((\d|[1-9]\d|1[0-7]\d)(\.\d{1,6})?$)|(180$)/.test(value);
            },
            message: '经度不合法'
        },
        //纬度
        latitude: {
            validator: function (value, param) {
//            return /^-?(?:90(?:\.0{1,5})?|(?:[1-8]?\d(?:\.\d{1,5})?))$/.test(value);
              return  /^((\d|[1-8]\d)(\.\d{1,6})?$)|(90$)/.test(value);
	        },
	        message: '纬度不合法'
	    },
	    //行政区划  六位数字 简单验证  第一位1-8
	    region:{
	    	validator: function(value) {
                return /^[1-8]\d{5}$/i.test(value);
            },
            message: '行政区划格式不正确'
	    }

    });
});