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
	  response.setDateHeader("Expires", 0);//��������
	  
      request.setCharacterEncoding("GB18030");
      String rId=request.getParameter("rId");
      String[] strBIds=request.getParameter("bIds").split(";");
      String notExistBIds="";
      String haveBorrowBIds="";
      for(int i=0;i<strBIds.length;i++){
        int bId=Integer.parseInt(strBIds[i]);
        
        //�ж�ͼ���Ƿ����
        if(!BookManager.getInstance().isExist(bId) ){
             notExistBIds+=strBIds[i]+";";
        }
        //�ж�ͼ���Ƿ��ѽ��Ĳ���δ��      
        if(BorrowBookItemManager.getInstance().isExist(bId, rId)){
            haveBorrowBIds+=strBIds[i]+";";
        }
      }
      String strMercege=notExistBIds+"_"+haveBorrowBIds;
      response.getWriter().write(strMercege);

      
  

 %>