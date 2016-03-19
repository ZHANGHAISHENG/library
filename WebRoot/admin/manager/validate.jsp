<%@page import="manager.AdministratorManager"%>
<%@page import="manager.ReaderManager"%>
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
      
      int id=Integer.parseInt(request.getParameter("id"));
      Administrator admin=new Administrator();
      admin.setId(id);
      
      if(AdministratorManager.getInstance().isExist(admin)){
         response.getWriter().write("invalid");
      }else{
         response.getWriter().write("ok");
      }
%>