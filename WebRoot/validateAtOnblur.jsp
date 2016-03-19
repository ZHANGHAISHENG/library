
<%@ page language="java" import="java.util.*" pageEncoding="GB18030"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%
      response.setHeader("Cache-Control","no-store");//http1.1 
	  response.setHeader("Pragma", "no-cache");//http1.0
	  response.setDateHeader("Expires", 0);//ÓÀ²»¹ýÆÚ
      request.setCharacterEncoding("GB18030");
      String code=request.getParameter("code");
      String code2=(String)request.getSession().getAttribute("codeValue"); 
   /*    System.out.println("code2=|"+code2+"|"+"___code=|"+code+"|"); */
      if(!code2.trim().equalsIgnoreCase(code)){
         response.getWriter().write("invalid");
      }else{
         response.getWriter().write("ok");
      }
%>