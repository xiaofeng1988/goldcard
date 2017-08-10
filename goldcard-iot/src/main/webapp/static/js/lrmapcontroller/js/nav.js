var navB_mouseDown = false;
var timer = null;//定时器对象

var maxZoom = 18;
var minZoom = 1;

function zoomIn(){
	var navB = document.getElementById("navB");
	var top = navB.style.top.replace("px","");
		top = parseInt(top)-6;
	var level = (110-top)/6; 
	if(level < 1){
		level = 1;
	}else if(level > maxZoom){
		level = maxZoom;
	}
	setControllerZoom(level);
}

function zoomOut(){
	var navB = document.getElementById("navB");
	var top = navB.style.top.replace("px","");
		top = parseInt(top)+6;
	var level = (110-top)/6; 
	if(level < minZoom){
		level = minZoom;
	}else if(level > maxZoom){
		level = maxZoom;
	}
	setControllerZoom(level);
}

function setNavBarSectionStyle(level){
	var navB = document.getElementById("navB");
	var section = document.getElementById("navBarSection");
	var top = (110 - level*6) > 0 ? (110 - level*6) : 2;
	navB.style.top = top+"px";
	section.style.height = top+4+"px";
}

function setZoomButtonStyle(level){
	var zoomIn = document.getElementById("zoomIn");
	var zoomOut = document.getElementById("zoomOut");
	if(level > minZoom && level < maxZoom){//当前级别在1-18级之间不包括1和18级
		zoomIn.style.cursor = "pointer";
		zoomOut.style.cursor = "pointer";
	}else if(level <= minZoom){
		zoomOut.style.cursor = "not-allowed";
	}else if(level >= maxZoom){
		zoomIn.style.cursor = "not-allowed";
	}
}

function setControllerZoom(level){
	setNavBarSectionStyle(level);
	setZoomButtonStyle(level);
	map.setZoom(level);
}

function translation(flag){
	var range = map.getBounds();
	var mlat = (parseInt(range._southWest.lat) + parseInt(range._northEast.lat))/2;
	var mlng = (parseInt(range._southWest.lng) + parseInt(range._northEast.lng))/2;
	if(flag == 'up'){
		var dif = mlat-parseInt(range._southWest.lat);
		map.setView([mlat+dif,mlng],map.getZoom());
	}else if(flag == 'right'){
		var dif = mlng-parseInt(range._southWest.lng);
		map.setView([mlat,mlng+dif],map.getZoom());
	}else if(flag == 'down'){
		var dif = mlat-parseInt(range._southWest.lat);
		map.setView([mlat-dif,mlng],map.getZoom());
	}else if(flag == 'left'){
		var dif = mlng-parseInt(range._southWest.lng);
		map.setView([mlat,mlng-dif],map.getZoom());
	}
}

function translationMouseOver(flag){
	var translation = document.getElementById("translation");	
	if(flag == 'up'){
		translation.style.backgroundPosition = '0px -44px';
	}else if(flag == 'right'){
		translation.style.backgroundPosition = '0px -88px';
	}else if(flag == 'down'){
		translation.style.backgroundPosition = '0px -132px';
	}else if(flag == 'left'){
		translation.style.backgroundPosition = '0px -176px';
	}
}

function translationMouseOut(){
	var translation = document.getElementById("translation");	
	translation.style.backgroundPosition = '0px 0px';
}

function onnavbMouseDown(){
	//将鼠标在导航按钮按下鼠标时标记设置为true
	navB_mouseDown = true;
}

function onnavbMouseUp(){
	//将鼠标在导航放开鼠标按钮时标记设置为false
	navB_mouseDown = false;
}

function onnavbMouseMove(evt){
	var et = evt || window.event;
	//将鼠标在导航移动鼠标时
	if(navB_mouseDown == true && et.button == 1){
		var top = et.clientY;
		var navB = document.getElementById("navB");
		//因为在navB上面移动的时候经常会移出按钮所以就获取不到真正的Y值 但是可以获取navB外层元素的Y值 这个值比navB的Y值始终大73
		//所以要将获取的值-73就是navB当前的Y值了
		var level = maxZoom - parseInt((top-73)/6);
		if(level < minZoom){
			level = minZoom;
		}
		setControllerZoom(level);
	}
	//onnavbMouseDownx='+window.event.offsetX+' oy='+window.event.offsetY+' button='+level;
}
function getMovedToLevel(){
	
}

/**
 *得到鼠标在导航栏中间级别刻度条上面点击时 所对应的刻度级别，并将地图定位到该级别
 */
// function getClickSliderBarLevel(evt){
	// var et = evt || window.event;
	// //注意这里要用window.event.y获取导航刻度条的外层元素的Y值再 -73 计算出 navB的Y值，要不然在刻度上面拖动的时候放开鼠标会有问题
	// var top = et.clientY;
	// //总共是17个级别
	// var level = 17 - parseInt((top-73)/6);
	// setControllerZoom(level);
// }
/**
 *当鼠标移到导航栏时显示级别按钮（国，省，市，街），并清除timer定时器
 */
function levelShow(){
	var ele = document.getElementById("level");	
	ele.style.display = "block";
	//清除定时器
	window.clearTimeout(timer);
}

/**
 *当鼠标移出导航栏两秒后隐藏级别按钮（国，省，市，街） 
 */
function levelHidden(){
	var ele = document.getElementById("level");	
	timer = window.setTimeout(function(){
		ele.style.display = 'none';
	},2000);
}

$(function(){
	$("#navBarSection,#navBarAll").click(function(evt){
	    var et = evt || window.event;
		//注意这里要用window.event.y获取导航刻度条的外层元素的Y值再 -73 计算出 navB的Y值，要不然在刻度上面拖动的时候放开鼠标会有问题
		var top = et.clientY;
		//总共是19个级别
		var level = maxZoom - parseInt((top-73)/6);
		setControllerZoom(level);
	});
	
	$("#navBarSection,#navBarAll,#navB,#mapNavBar").mousemove(function(evt){
	    var et = evt || window.event;
		//将鼠标在导航移动鼠标时
		if(navB_mouseDown == true && (et.buttons == 1 || et.button == 0)){
			var top = et.clientY;
			var navB = document.getElementById("navB");
			//因为在navB上面移动的时候经常会移出按钮所以就获取不到真正的Y值 但是可以获取navB外层元素的Y值 这个值比navB的Y值始终大73
			//所以要将获取的值-73就是navB当前的Y值了
			var level = maxZoom - parseInt((top-73)/6);
			if(level < minZoom){
				level = minZoom;
			}
			setControllerZoom(level);
			window.status = 'mousemove X=' + et.x + ' Y=' + et.y+' ox='+et.offsetX+' oy='+et.offsetY+' cx='+et.clientX+' cy='+et.clientY+' button='+level;
		}
	});
});	