<%@page import="manager.TicketManager"%>
<%@ page language="java" import="java.util.*" pageEncoding="GB18030"%>
<%
  /* int intDay=1;
  if(TicketManager.getInstance().){//��ʱΪ5
  
    out.println("�����ɹ�!");
  }else{
     out.println("����ʧ��!");
  } */
  
  out.println("�����ɹ�!");
  TicketManager.getInstance().autoManagerTicket();
  
%>

