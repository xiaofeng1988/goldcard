/**
 * 杨琪:扩展jquery，实现获取url参数
 */
(function($) {
	$.getUrlParam = function(name)
	{
		var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
		//search 属性是一个可读可写的字符串，可设置或返回当前 URL 的查询部分（问号 ? 之后的部分）。
		var r = window.location.search.substr(1).match(reg);
		if (r != null)
			//unescape() 函数可对通过 escape() 编码的字符串进行解码。
			//该函数的工作原理是这样的：通过找到形式为 %xx 和 %uxxxx 的字符序列（x 表示十六进制的数字），用 Unicode 字符 \u00xx 和 \uxxxx 替换这样的字符序列进行解码。
			//ECMAScript v3 已从标准中删除了 unescape() 函数，并反对使用它，因此应该用 decodeURI() 和 decodeURIComponent() 取而代之。
			return unescape(r[2]);
		return null;
	}
})(jQuery);