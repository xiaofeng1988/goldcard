/**    
 * 对Date的扩展，将 Date 转化为指定格式的String    
 * 月(M)、日(d)、12小时(h)、24小时(H)、分(m)、秒(s)、周(E)、季度(q) 可以用 1-2 个占位符    
 * 年(y)可以用 1-4 个占位符，毫秒(S)只能用 1 个占位符(是 1-3 位的数字)    
 * eg:    
 * (new Date()).pattern("yyyy-MM-dd hh:mm:ss.S") ==> 2006-07-02 08:09:04.423    
 * (new Date()).pattern("yyyy-MM-dd E HH:mm:ss") ==> 2009-03-10 二 20:09:04    
 * (new Date()).pattern("yyyy-MM-dd EE hh:mm:ss") ==> 2009-03-10 周二 08:09:04    
 * (new Date()).pattern("yyyy-MM-dd EEE hh:mm:ss") ==> 2009-03-10 星期二 08:09:04    
 * (new Date()).pattern("yyyy-M-d h:m:s.S") ==> 2006-7-2 8:9:4.18    
 */     

//毛文龙注释 此方法有bug 在小时大于12小时时会减去12小时 例如 2013-04-05 13:23:44 会被解析成 2013-04-05 01:23:44 建议使用下面的format方法
Date.prototype.pattern=function(fmt) {      
    var o = {      
    "M+" : this.getMonth()+1, //月份      
    "d+" : this.getDate(), //日      
    "h+" : this.getHours()%12 == 0 ? 12 : this.getHours()%12, //小时      
    "H+" : this.getHours()-8, //小时      
    "m+" : this.getMinutes(), //分      
    "s+" : this.getSeconds(), //秒      
    "q+" : Math.floor((this.getMonth()+3)/3), //季度      
    "S" : this.getMilliseconds() //毫秒      
    };      
    var week = {      
    "0" : "\u65e5",      
    "1" : "\u4e00",      
    "2" : "\u4e8c",      
    "3" : "\u4e09",      
    "4" : "\u56db",      
    "5" : "\u4e94",      
    "6" : "\u516d"     
    };      
    if(/(y+)/.test(fmt)){      
        fmt=fmt.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length));      
    }      
    if(/(E+)/.test(fmt)){      
        fmt=fmt.replace(RegExp.$1, ((RegExp.$1.length>1) ? (RegExp.$1.length>2 ? "\u661f\u671f" : "\u5468") : "")+week[this.getDay()+""]);      
    }      
    for(var k in o){      
        if(new RegExp("("+ k +")").test(fmt)){      
            fmt = fmt.replace(RegExp.$1, (RegExp.$1.length==1) ? (o[k]) : (("00"+ o[k]).substr((""+ o[k]).length)));      
        }      
    }      
    return fmt;      
}    
 
function dateFormatTime(value){
	var out = "";
	var h = 0,m = 0,s = 0;
	var h,m,s;
	h = parseInt(value/3600);
	m = parseInt(value%3600/60);
	s = parseInt(value%3600%60);
	if(h<10){
		out += "0"+h+":";
	}else{
		out += h+":";
	}
	if(m<10){
		out += "0"+m+":";
	}else{
		out += m+":";
	}
	if(s<10){
		out += "0"+s;
	}else{
		out += s;
	}
	return out;
}

Date.prototype.format = function(format) {
		  var o = {
		    "M+" : this.getMonth()+1, //month
		    "d+" : this.getDate(),    //day
		    "h+" : this.getHours(),   //hour
		    "m+" : this.getMinutes(), //minute
		    "s+" : this.getSeconds(), //second
		    "q+" : Math.floor((this.getMonth()+3)/3),  //quarter
		    "S" : this.getMilliseconds() //millisecond
		  } ;
		  if(/(y+)/.test(format)) format=format.replace(RegExp.$1,
		    (this.getFullYear()+"").substr(4 - RegExp.$1.length));
		  for(var k in o)if(new RegExp("("+ k +")").test(format))
		    format = format.replace(RegExp.$1,
		      RegExp.$1.length==1 ? o[k] :
		        ("00"+ o[k]).substr((""+ o[k]).length));
		  return format;
} ;		

//返回当前日期时间 格式为 yyyy-MM-dd 
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
		//var sth = date.getHours() < 10 ? "0"+date.getHours() : date.getHours();
		//var stmi = date.getMinutes() < 10 ? "0"+date.getMinutes() : date.getMinutes();
		//var sts = date.getSeconds() < 10 ? "0"+date.getSeconds() : date.getSeconds();
			sty = sty+"-"+stm+"-"+std;
		return sty;
}

/**
 * 返回当前日期时间 格式为 yyyy-MM-dd HH:mm:ss
 * 样例:getCurrentDateTime("1432523376000",0)
 */
function getCurrentDateTime(date,hourBefore){ 
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

//校验开始时间小于结束时间 
function dateCompare(startDate,endDate){	
	startDate = startDate.replace(/\-/gi,"/");	
	endDate = endDate.replace(/\-/gi,"/");	
	var time1 = new Date(startDate).getTime();	
	var time2 = new Date(endDate).getTime();	
	if(time1 > time2){		
    	    return false;	
    }
    return true;
}

//时间差
function dateDiff(interval, dt1, dt2)
{
   var objInterval = {'D':1000 * 60 * 60 * 24,'H':1000 * 60 * 60,'M':1000 * 60,'S':1000,'T':1};
   interval = interval.toUpperCase();
//   var dt1 = new Date(Date.parse(date1.replace(/-/g, '/')));
//   var dt2 = new Date(Date.parse(date2.replace(/-/g, '/')));
   try
   {
      //alert(dt2.getTime() - dt1.getTime());
      //alert(eval('objInterval.'+interval));
      //alert((dt2.getTime() - dt1.getTime()) / eval_r('objInterval.'+interval));
      return Math.abs(Math.round((dt2 - dt1) / eval('objInterval.'+interval)));
    }
    catch (e)
    {
      return e.message;
    }
}

/**
*简单的date转string，算法挺好
*/
function dateFormat(formatStr, fdate){  
     var fTime, fStr = 'ymdhis';  
     if (!formatStr)  
        formatStr= "y-m-d h:i:s";  
     if (fdate)  
        fTime = new Date(fdate);  
     else  
        fTime = new Date();  
     var formatArr = [  
         fTime.getFullYear().toString(),  
         (fTime.getMonth()+1).toString(),  
         fTime.getDate().toString(),  
         fTime.getHours().toString(),  
         fTime.getMinutes().toString(),  
         fTime.getSeconds().toString()   
     ];  
     for (var i=0; i<formatArr.length; i++){  
        formatStr = formatStr.replace(fStr.charAt(i), formatArr[i]);  
     }  
     return formatStr;  
} 
