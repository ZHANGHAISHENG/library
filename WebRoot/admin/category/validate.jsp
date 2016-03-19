<%@page import="bean.Category"%>
<%@page import="manager.CategoryManager"%>
<%@ page language="java" import="java.util.*" pageEncoding="GB18030"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%
  request.setCharacterEncoding("GB18030");
  
  response.setContentType("text/xml"); //若是以xml的方式输出，一定要写上此句
  response.setHeader("Cache-Control","no-store");//http1.1
  response.setHeader("Pragma", "no-cache");//http1.0
  response.setDateHeader("Expires", 0);//永不过期
  
  String cateName=new String(request.getParameter("cateName").getBytes("iso-8859-1"),"GB18030");
  System.out.println("cateName="+cateName);
  int pId=Integer.parseInt(request.getParameter("pId"));
  Category c=new Category();
  c.setCateName(cateName);
  c.setPid(pId);
  StringBuffer buf=new StringBuffer();
  if(c.isExist()){ //缺陷：没有修改类别名称也应该返回ok!
    
     buf.append("<msg>invalid</msg>");
  }else{
      buf.append("<msg>ok</msg>");
  
  }
  buf.insert(0,"<?xml version='1.0' encoding='GB18030'?>");
  response.getWriter().write(buf.toString().trim());
  
   

 %>
 
 