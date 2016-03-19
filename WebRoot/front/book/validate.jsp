<%@page import="manager.BookManager"%>
<%@ page language="java" import="java.util.*" pageEncoding="GB18030"%>
<%@page import="bean.*" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%
	  response.setHeader("Cache-Control","no-store");//http1.1
	  response.setHeader("Pragma", "no-cache");//http1.0
	  response.setDateHeader("Expires", 0);//ÓÀ²»¹ýÆÚ
	  
      request.setCharacterEncoding("GB18030");
      
      int cateId=Integer.parseInt(request.getParameter("cateId"));
      String bookName=new String(request.getParameter("bookName").getBytes("iso-8859-1"),"GB18030");
      Book b=new Book();
      b.setCateId(cateId);
      b.setBookName(bookName);

      if(BookManager.getInstance().isExist(b)){
         response.getWriter().write("invalid");
      }else{
         response.getWriter().write("ok");
      }
      
  

 %>