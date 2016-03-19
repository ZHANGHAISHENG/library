<%@page import="manager.*"%>
<%@page import="bean.*"%>
<%@ page language="java" import="java.util.*" pageEncoding="GB18030"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%
    int tId= Integer.parseInt(request.getParameter("tId"));
    Ticket ticket=TicketManager.getInstance().loadById(tId);
   
 %>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
<%--     <base href="<%=basePath%>"> --%>
    
    <title>My JSP 'ticketDetail.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
  <body>
       <table border="1" align="center"  >
        <tr>
	        <th >书名：</th>
	        <th >金额：</th>
	        <th >描叙</th>
	        <th >删除</th>
	        <th >修改</th>
	    </tr>
       <%
          if(ticket!=null){
           ArrayList<TicketItem> tItems=ticket.getTicketItems();
          for(int i=0;i<tItems.size();i++){  
            TicketItem tItem=tItems.get(i);
            Book b=BookManager.getInstance().loadById(tItem.getBid());
        %>
		       <tr>
		       <td ><%=b.getBookName()%></td>
		       <td ><%=tItem.getMoney() %></td>
		       <td ><%=tItem.getTtDesc() %>&nbsp</td>
		       <td ><a href="../ticketItem/ticketItemDelete.jsp?tId=<%=ticket.getId() %>&tItemId=<%=tItem.getId() %>" target="detail">删除</a></td>
		       <td ><a href="../ticketItem/ticketItemUpdate.jsp?tId=<%=ticket.getId() %>&tItemId=<%=tItem.getId() %>" target="detail">修改</a></td>
		       </tr>

        <%} 
        }%>
          </table>  
  </body>
</html>
