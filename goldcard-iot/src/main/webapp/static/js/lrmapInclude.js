//利用JS引入外部文件，如果用jsp的include的话不能使用${pageContext.request.contextPath}，
//只能写死路径，这样对项目的维护不利
document.writeln('<link href="js/lrmap/api.css" media="screen" rel="stylesheet" type="text/css"/>');
document.writeln('<!--[if lte IE 8]><link href="js/lrmap/api.ie.css" media="screen" rel="stylesheet" type="text/css" /><![endif]-->');
document.writeln('<!--龙软地图API核心类库 是基于leaflet改写的-->');
document.writeln('<script href="js/lrmap/api_v1_src.js" type="text/javascript"></script>');
document.writeln('<!--针对龙软地图API核心类库封装的地图创建脚本-->');
document.writeln('<script href="js/lrmap/jquery_lrmap_v1.js" type="text/javascript"></script>');
document.writeln('<!--leaflet的label插件的源文件-->');
document.writeln('<script href="js/lrmap/leaflet.label-src.js"></script>');
document.writeln('<!--leaflet的label插件的css文件-->');
document.writeln('<link rel="stylesheet" href="js/lrmap/leaflet.label.css" />');

document.writeln('<!--地图中要显示的数据源-->');
document.writeln('<script href="js/lrmap/zm_gisData.js"></script>');
document.writeln('<!-- 所有JS的配置文件这里是要引用里面的lrmap服务器地址lrmap_host_url -->');
document.writeln('<script href="js/config.js"></script>');


    
	

	
    
	
    
	
    
	
    
	
    
    
    
	
	
	
	
	
