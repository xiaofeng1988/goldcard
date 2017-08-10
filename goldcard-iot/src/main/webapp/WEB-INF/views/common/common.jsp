<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!-- UI向后台请求根路径rootPath -->
<c:set var="rootPath" value="${pageContext.request.contextPath}/api" scope="application" />
	<meta http-equiv="X-UA-Compatible" content="IE=11; IE=10; IE=9; IE=8; IE=7; IE=EDGE">
	<link href="${pageContext.request.contextPath}/static/images/favicon.ico" rel="shortcut icon" type="image/x-icon" />
    <link id="easyuiTheme" rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/js/easyui/themes/default/easyui.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/js/easyui/themes/icon.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/js/easyui/themes/easyextend.css" />
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery-1.8.0.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/datagrid-groupview.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/common/EasyUIDefault.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/common/draglimit.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/easyui/locale/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/easyuiextend.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/static/js/common/DatagridAutoRowCount.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/static/js/common/dateUtil.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/static/js/common/validate.js"></script>