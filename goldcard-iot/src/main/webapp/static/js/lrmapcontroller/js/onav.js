/**
 *lrmap_leafletjs_nav.js 
 * 龙软地图leafletjs导航插件
 * 毛文龙：2014-01-23
 */
L.Navigation = L.Control.extend({
	includes:L.Mixin.Events,
	options:{
		position:'topleft',
		panOffset:50,
		maxZoom:18,
		minZoom:1,
		hideLevelInterval:2000,
		className:'lrmap-navigation-control'
	},
	initialize:function(options){
		L.setOptions(this, options);
	},
	onAdd:function(map){
		this._map = map;
		//创建相关DOM元素
		this._className = this.options.className;
		this._container = L.DomUtil.create('div', this._className);
		//创建平移DOM相关DIV
		this._pan = L.DomUtil.create('div',this._className+'-pan',this._container);
		this._up = L.DomUtil.create('div',this._className+'-pan-up',this._pan);
		this._right = L.DomUtil.create('div',this._className+'-pan-right',this._pan);
		this._down = L.DomUtil.create('div',this._className+'-pan-down',this._pan);
		this._left = L.DomUtil.create('div',this._className+'-pan-left',this._pan);
		//创建缩放相关DIV
		this._bzoomIn = L.DomUtil.create('div',this._className+'-zoomin',this._container);
		this._bzoomout = L.DomUtil.create('div',this._className+'-zoomout',this._container);
		//创建滚动条相关DIV
		this._barselect = L.DomUtil.create('div',this._className+'-barselect',this._container);
		this._sbar = L.DomUtil.create('div',this._className+'-bar',this._barselect);
		this._barall = L.DomUtil.create('div',this._className+'-barall',this._container);
		//创建国省市街级别按钮DIV
		this._level = L.DomUtil.create('div',this._className+'-level',this._container);
		this._street = L.DomUtil.create('div',this._className+'-level-street',this._level);
		this._city = L.DomUtil.create('div',this._className+'-level-city',this._level);
		this._province = L.DomUtil.create('div',this._className+'-level-province',this._level);
		this._country = L.DomUtil.create('div',this._className+'-level-country',this._level);
		
		L.DomEvent.on(this._container, 'mouseover',this.showLevel,this);
		L.DomEvent.on(this._container, 'mouseout',this.hideLevel,this);
		
		var events = ['mouseover','mouseout','click'];
		for(var i = 0 ; i < events.length; i++){
			L.DomEvent.on(this._pan,events[i],this.fireEvent,this);
		}
		
		//zoomIn zoomOut event
		L.DomEvent.on(this._bzoomIn,'click',this.zoomIn,this);
		L.DomEvent.on(this._bzoomout,'click',this.zoomOut,this);
		
		//level event
		L.DomEvent.on(this._street,'click',function(){this.setControllerZoom(15);},this);
		L.DomEvent.on(this._city,'click',function(){this.setControllerZoom(9);},this);
		L.DomEvent.on(this._province,'click',function(){this.setControllerZoom(5);},this);
		L.DomEvent.on(this._country,'click',function(){this.setControllerZoom(1);},this);
		
		//seekbar click event
		L.DomEvent.on(this._barselect,'click',this.seekbarClick,this);
		L.DomEvent.on(this._barall,'click',this.seekbarClick,this);
		
		//seekbar mousedown event
		//var seekbarevents = ['mousedown','mouseup','mousemove'];
		//for(var i = 0 ; i < seekbarevents.length ; i++){
			
		//}
		L.DomEvent.on(this._barselect,'mousedown',this.seekbarDrag,this);
		L.DomEvent.on(this._barselect,'mousemove',this.seekbarDrag,this);
		L.DomEvent.on(this._barall,'mousedown',this.seekbarDrag,this);
		L.DomEvent.on(this._barall,'mousemove',this.seekbarDrag,this);
		
		this.mousedownFlag = false;
		L.DomEvent.on(this._sbar,'mousedown',function(){this.mousedownFlag = true;},this);
		L.DomEvent.on(this._sbar,'mouseup',function(){this.mousedownFlag = false;},this);
		L.DomEvent.on(this._sbar,'mousemove',this.seekbarDrag,this);
		
		//L.DomEvent.on(this._sbar,'ondrag',function(){alert('eee');},this);
		
		return this._container;
	},
	showLevel:function(){
		var level = this._level;
		level.style.display = "block";
		//清除定时器
		if(this._timer){
			window.clearTimeout(this._timer);
		}
	},
	hideLevel:function(){
		var level = this._level;
		this._timer = window.setTimeout(function(){
			level.style.display = 'none';
		},this.options.hideLevelInterval);
	},
	fireEvent:function(e,flag){
		this.fire(e.type,{originalEvent:e});
		var translation = this._pan;
		var flag = e.target.className;
		if (e.type == 'mouseover'){
			if(flag.match('up') == 'up'){
				translation.style.backgroundPosition = '0px -44px';
			}else if(flag.match('right') == 'right'){
				translation.style.backgroundPosition = '0px -88px';
			}else if(flag.match('down') == 'down'){
				translation.style.backgroundPosition = '0px -132px';
			}else if(flag.match('left') == 'left'){
				translation.style.backgroundPosition = '0px -176px';
			}
		}
		if (e.type == 'mouseout') {
			translation.style.backgroundPosition = '0px 0px';
		}else if(e.type == 'click'){
			var off = this.options.panOffset;
			if(flag.match('up') == 'up'){
				L.DomEvent.on(this._up,'click',function(){ map.panBy(new L.Point(0,-off));}, map)
			}else if(flag.match('right') == 'right'){
				L.DomEvent.on(this._right,'click',function(){ map.panBy(new L.Point(off,0));}, map)
			}else if(flag.match('down') == 'down'){
				L.DomEvent.on(this._down,'click',function(){ map.panBy(new L.Point(0,off));}, map)
			}else if(flag.match('left') == 'left'){
				L.DomEvent.on(this._left,'click',function(){ map.panBy(new L.Point(-off,0));}, map)
			}
		}
	},
	zoomIn:function(){
		var seekbar = this._sbar;
		var top = seekbar.style.top.replace("px","");
			top = parseInt(top)-6;
		var level = (110-top)/6; 
		if(level < this.options.minZoom){
			level = this.options.minZoom;
		}else if(level > this.options.maxZoom){
			level = this.options.maxZoom;
		}
		this.setControllerZoom(level);
	},
	zoomOut:function(){
		var seekbar = this._sbar;
		var top = seekbar.style.top.replace("px","");
			top = parseInt(top)+6;
		var level = (110-top)/6; 
		if(level < this.options.minZoom){
			level = this.options.minZoom;
		}else if(level > this.options.maxZoom){
			level = this.options.maxZoom;
		}
		this.setControllerZoom(level);
	},
	setControllerZoom:function(level){
		this.setNavBarSectionStyle(level);
		this.setZoomButtonStyle(level);
		this._map.setZoom(level);
	},
	setNavBarSectionStyle:function(level){
		var bar = this._sbar;
		var section = this._barselect;
		var top = (110 - level*6) > 0 ? (110 - level*6) : 2;
		bar.style.top = top+"px";
		section.style.height = top+4+"px";
	},
	setZoomButtonStyle:function(level){
		if(level > this.options.minZoom && level < this.options.maxZoom){//当前级别在1-18级之间不包括1和18级
			this._bzoomIn.style.cursor = 'pointer';
			this._bzoomout.style.cursor = 'pointer';
		}else if(level <= this.options.minZoom){
			this._bzoomout.style.cursor = 'not-allowed';
		}else if(level >= this.options.maxZoom){
			this._bzoomIn.style.cursor = 'not-allowed';
		}
	},
	seekbarClick:function(evt){
		var et = evt || window.event;
		//注意这里要用window.event.y获取导航刻度条的外层元素的Y值再 -73 计算出 navB的Y值，要不然在刻度上面拖动的时候放开鼠标会有问题
		var top = et.clientY;
		//总共是19个级别
		var level = this.options.maxZoom - parseInt((top-85)/6);
		this.setControllerZoom(level);
	},
	seekbarDrag:function(evt){
		
		var et = evt || window.event;
		//将鼠标在导航移动鼠标时
		if(this.mousedownFlag == true && et.buttons == 1){
			var top = et.clientY;
			var navB = this._sbar;
			//因为在navB上面移动的时候经常会移出按钮所以就获取不到真正的Y值 但是可以获取navB外层元素的Y值 这个值比navB的Y值始终大73
			//所以要将获取的值-73就是navB当前的Y值了
			var level = this.options.maxZoom - parseInt((top-85)/6);
			if(level < this.options.minZoom){
				level = this.options.minZoom;
			}
			this.setControllerZoom(level);
			//window.status = 'mousemove X=' + et.x + ' Y=' + et.y+' ox='+et.offsetX+' oy='+et.offsetY+' cx='+et.clientX+' cy='+et.clientY+' button='+level;
		}
	}
	
});
