<script src="../js/detailClear.js"></script>
<%@ page language="java" import="java.util.*" pageEncoding="GB18030"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  <%--   <base href="<%=basePath%>"> --%>
    
    <title>My JSP 'bookSortList.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  

  <frameset cols="20%,*"  rows="*"  name="bSlist" framespacing="1" >
    <frame name="bSlistLeft"  src="bookSortListLeft.jsp"  scrolling="yes" >  
    <frame name="bSlistRight" src="bookSortListRight.jsp"  scrolling="yes" >
  </frameset>

</html>
