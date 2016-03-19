<%@page import="manager.BookManager"%>
<%@page import="bean.*"%>
<%@ page language="java" import="java.util.*" pageEncoding="GB18030"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%
  request.setCharacterEncoding("GB18030");
  int bId=Integer.parseInt(request.getParameter("bId"));
  Book b=BookManager.getInstance().loadById(bId);
  BookBasket bBasket=(BookBasket)request.getSession().getAttribute("bookBasket");
  if(!bBasket.isbNumExceed()){
     out.println("一次性只能借阅："+10+"本书"+",无法再添加图书");
  }else{
     if(bBasket.bookInBasket(b)){
          out.println("该书已经添加到了书篮，请重新添加其他图书");
     }else{
	     bBasket.getBooks().add(b);
	     bBasket.setNum(bBasket.getNum()+1);
	     out.println("添加成功");
    }
  }
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <%-- <base href="<%=basePath%>"> --%>
    
    <title>My JSP 'bookAddToBBasket.jsp' starting page</title>
    
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
