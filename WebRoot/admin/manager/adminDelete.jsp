<%@page import="manager.AdministratorManager"%>
<%@ page language="java" import="java.util.*" pageEncoding="GB18030"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%
   request.setCharacterEncoding("GB18030"); 
   String action=request.getParameter("action");
   int  id=Integer.parseInt(request.getParameter("id"));
   if(AdministratorManager.getInstance().deleteAdminById(id)){
    //  response.sendRedirect("deleteSuccess.jsp?id="+id);
    out.println("É¾³ý³É¹¦");
    %>
		    <script>
		       window.parent.main.location.reload();
		    </script>
   <%
   }else{  
     out.println("É¾³ýÊ§°Ü");
   }

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <%-- <base href="<%=basePath%>"> --%>
    
    <title>My JSP 'adminAdd.jsp' starting page</title>
    
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
