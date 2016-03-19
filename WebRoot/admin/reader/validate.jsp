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
      
      String rId=request.getParameter("rId");
      Reader r=new Reader();
      r.setId(rId);
      
      if(ReaderManager.getInstance().isExist(r)){
         response.getWriter().write("invalid");
      }else{
         response.getWriter().write("ok");
      }
%>