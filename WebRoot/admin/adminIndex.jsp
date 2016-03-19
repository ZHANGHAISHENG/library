<%@page language="java" import="java.util.*" pageEncoding="GB18030"%>
<%-- <%@include file="confirmAdmin.jsp" %> --%>

<html>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

%>

<head>

<title>library后台</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">


</head>

<frameset rows="29,*"   cols="*" frameborder="0" border="0" framespacing="0">
  <frame name="top" scrolling="NO" noresize src="top.jsp">
  <frameset cols="20%,*"  rows="*" scrolling="NO" name="mleft">
    <frame name="menu" src="menu.jsp"  scrolling="NO" >
    <frameset rows="20,100%,*" cols="*" name="content" frameborder="yes"  framespacing="1" >
      <frame src="title.jsp" noresize scrolling="NO" name="mtitle">
      <frame src=""   name="main" scrolling="YES">
      <frame src=""  name="detail">
    </frameset>
  </frameset>
</frameset>
<noframes>
</noframes>
</html>