<%@page import="manager.*"%>
<%@page import="bean.*" %>
<%@ page language="java" import="java.util.*" pageEncoding="GB18030"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<%
  request.setCharacterEncoding("GB18030");
  String action=request.getParameter("action");
  String strTId=request.getParameter("tId");
  String strTItemId=request.getParameter("tItemId");
  int tId=-1;
  int tItemId=-1;
  if(strTId!=null&&!strTId.trim().equals("")){
   tId=Integer.parseInt(strTId);
  }
  if(strTItemId!=null&&!strTItemId.trim().equals("")){
   tItemId=Integer.parseInt(strTItemId);
  }
  
  Ticket ticket=null;
  TicketItem tItem=null;
  Book b=null;
  if(action!=null&&!action.trim().equals("")){
     tItem=(TicketItem)request.getSession().getAttribute("tItem");   
     double money=Double.parseDouble(request.getParameter("money"));
     String tIdesc=request.getParameter("tIdesc");
     tItem.setMoney(money);
     tItem.setTtDesc(tIdesc);
     if(TicketItemManger.getInstance().updateTicketItem(tItem)){
         response.sendRedirect("updateSuccess.jsp?tId="+tItem.getTid());
        }else{
       out.println("更新失败");
     }
     return ;
   
  }else{
     ticket=TicketManager.getInstance().loadById(tId);
     
	 for(TicketItem ti: ticket.getTicketItems()){
	   if(ti.getId()==tItemId){
	     tItem=ti;	  
	     request.getSession().setAttribute("tItem", tItem);  
	   }
	 }
     b=BookManager.getInstance().loadById(tItem.getBid());
     

  }
  
  
	 	  
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <%-- <base href="<%=basePath%>"> --%>
    
    <title>My JSP 'tickItemAdd.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<script>
	  function checkForMoney(moneyObject){
	    var money=moneyObject.value.replace(/(^\s+)|(\s+$)/g,"");
	   
	    if(money.search(/^\s*\s*$/)!=-1){
	      document.getElementById("moneyTip").innerHTML="<font color='red'>金额不能为空</font>";
	      return false;
	    }
	    if(money.search(/^\d+(\.\d)*$/)==-1){
	      document.getElementById("moneyTip").innerHTML="<font color='red'>请输入正确格式如：30.8或30</font>";
	      return false;
	    }else{
	       document.getElementById("moneyTip").innerHTML="<font color='blue'>有效</font>";
	       return true;
	    }
	  }
	  
	  function checkDate(){
	    return checkForMoney(window.document.forms["form"].money);
	  }
	
	</script>

  </head>
  
  <body>
    <form id="form" action="ticketItemUpdate.jsp" method="post" onsubmit="return checkDate()">
      <input type="hidden" name="action" value="tItemUpdate"></input>
      <table border="1" align="center"  >
        <tr>
	        <td >书名：</td>
	        <td ><%=b.getBookName()%></td>
	    </tr>
	    <tr>
	        <td>金额：</td>
	        <td >
	          <input type="text" name="money" id="money" size="20" value=<%=tItem.getMoney() %> onblur="checkForMoney(this)">
	          <span id="moneyTip"></span>
	        </td>
	    </tr>
	    <tr>
	        <td>描叙:</td>
	        <td >
		        <textarea name="tIdesc" id="tIdesc" cols="30" rows="5"><%=tItem.getTtDesc() %>
		        </textarea>
	        </td>
	    </tr> 
	   <tr align="center">
         <td colspan="2"><input type="submit" value="修改"></input></td>
       </tr>
       
	 </table>
	</form>
	
  </body>
</html>