//利用JS引入外部文件，如果用jsp的include的话不能使用${pageContext.request.contextPath}，
//只能写死路径，这样对项目的维护不利
document.writeln('<!--JQuery核心类库-->');
document.writeln('<script href="js/jquery-1.8.0.min.js" type="text/javascript"></script>');
document.writeln('<!--EasyUI-->');
document.writeln('<link rel="stylesheet" type="text/css" href="js/easyui/themes/default/easyui.css">');
document.writeln('<link rel="stylesheet" type="text/css" href="js/easyui/themes/icon.css">');
document.writeln('<script type="text/javascript" href="js/easyui/jquery.easyui.min.js"></script>');

document.writeln('<link rel="stylesheet" type="text/css" href="js/easyui/themes/easyextend.css"/>');
document.writeln('<script type="text/javascript" href="js/datagrid-groupview.js"></script>');
document.writeln('<script type="text/javascript" href="js/common/EasyUIDefault.js"></script>');
document.writeln('<script type="text/javascript" href="js/common/draglimit.js"></script>');
document.writeln('<script type="text/javascript" href="js/easyui/locale/easyui-lang-zh_CN.js"></script>');
