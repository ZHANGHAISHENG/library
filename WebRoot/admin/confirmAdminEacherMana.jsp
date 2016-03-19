
<%@ page language="java" import="java.util.*" pageEncoding="GB18030"%>
<%@page import="bean.*"%>

<%
      if((Administrator)session.getAttribute("admin")==null){
          response.sendRedirect("../../indexLogin.jsp");
      }
 %>
