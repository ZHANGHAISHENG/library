<%@page import="manager.TicketManager"%>
<%@ page language="java" import="java.util.*" pageEncoding="GB18030"%>
<%
  /* int intDay=1;
  if(TicketManager.getInstance().){//暂时为5
  
    out.println("启动成功!");
  }else{
     out.println("启动失败!");
  } */
  
  out.println("启动成功!");
  TicketManager.getInstance().autoManagerTicket();
  
%>

