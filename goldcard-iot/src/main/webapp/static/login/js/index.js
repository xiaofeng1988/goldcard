// JavaScript Document
var h=window.innerHeight
|| document.documentElement.clientHeight
|| document.body.clientHeight;
//$("body").css("min-width","1250px");

$("#tabBtns li").each(function(i){
	$(this).click(function(){
		$(this).addClass("curt").siblings().removeClass();
		$(".wrap").eq(i).fadeIn("fast").siblings().fadeOut("fast");
	})
	//if(i==0){
		//$("html").css("background","url(static/login/image/bg.jpg) 0 0 repeat-x");
		//$("body").css("background","url(static/login/image/btm.png) 0 bottom repeat-x;");
		//if(h > 720)
		//{
			//$("html").css("background-image","url(image/h-bg.jpg)");
		//}
	//}
})