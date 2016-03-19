<%@page import="manager.TicketItemManger"%>
<%@ page language="java" import="java.util.*" pageEncoding="GB18030"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%
  request.setCharacterEncoding("GB18030");
  int tId=Integer.parseInt(request.getParameter("tId"));
  int tItemId=Integer.parseInt(request.getParameter("tItemId"));
  if(TicketItemManger.getInstance().removeTicketItemById(tItemId)){ 
   response.sendRedirect("../ticket/ticketDetail.jsp?tId="+tId);
   out.println("É¾³ý³É¹¦");
  }else{
    out.println("É¾³ýÊ§°Ü");
  }
 %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <%-- <base href="<%=basePath%>"> --%>
    
    <title>My JSP 'tickItemAdd.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
  <body>
    
  </body>
</html>
