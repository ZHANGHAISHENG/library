<%@page import="manager.BorrowBookManager"%>
<%@page import="manager.BorrowBookItemManager"%>
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
      int rId=Integer.parseInt(request.getParameter("rId"));
      String[] strBIds=request.getParameter("bIds").split(";");
      String notExistBIds="";
      for(int i=0;i<strBIds.length;i++){
        int bId=Integer.parseInt(strBIds[i]);
        
        if(!BorrowBookManager.getInstance().readerHasBorrowThisBook(rId, bId) ){
             notExistBIds+=strBIds[i]+";";
        }
      }
      int latest=notExistBIds.lastIndexOf(";");
      if(latest!=-1){
        notExistBIds=notExistBIds.substring(0,latest);
      }
      
      response.getWriter().write(notExistBIds);

      
  

 %>