<%@ page language="java" import="java.util.*" pageEncoding="GB18030"%>
<%@page import="bean.*"%>

<%
      Administrator admin=(Administrator)session.getAttribute("admin");     
      if(admin==null){
          response.sendRedirect("../indexLogin.jsp");
      }
 %>
