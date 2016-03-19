<%@page import="manager.*"%>
<%@ page language="java" import="java.util.*" pageEncoding="GB18030"%>
<%@page import="java.sql.Timestamp"%>
<%@ page import="bean.*"%>

<%!
  public Timestamp adjustDate(HttpServletRequest request,String strQueryDate){  
     String strDate=request.getParameter(strQueryDate);   
     Timestamp date=null;
     if(strDate!=null&&!strDate.trim().equals("")){
   
        if(strDate.matches("^\\s*\\d{4}-\\d{2}-\\d{2}\\s*$")){
           strDate=strDate.trim()+" 00:00:00";//注意：中间只有一个空格
        }
        if(strDate.matches("^\\s*\\d{4}-\\d{2}-\\d{2}\\s\\d{2}\\:\\d{2}\\s*$")){
           strDate=strDate.trim()+":00";//注意：中间只有一个空格
        }
          
         date=Timestamp.valueOf(strDate);
    }
     return date;
  }
%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<%
    request.setCharacterEncoding("GB18030");
    String action=request.getParameter("action");
    int  tId=Integer.parseInt(request.getParameter("tId"));
    Ticket ticket=TicketManager.getInstance().loadById(tId);
    
    if(action!=null&&action.trim().equals("ticketUpdate")){    
      int  state=Integer.parseInt(request.getParameter("state"));
      Timestamp opendate=adjustDate(request,"opendate");
      Timestamp deleteDate=adjustDate(request,"deleteDate");    
      String desc=request.getParameter("desc");
      
      ticket.setState(state);
      if(opendate!=null){
       ticket.setOpendate(opendate);
      }
      if(deleteDate!=null){
       ticket.setEnddate(deleteDate);
      }
      ticket.settDesc(desc);
      if(TicketManager.getInstance().modifyTicket(ticket)){
        out.println("修改成功");
      %>
      <script>
        window.parent.main.location.reload();
      </script>
     <% }else{
        out.println("修改失败");
      }
    }
 %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
   <%--  <base href="<%=basePath%>"> --%>
    
    <title>My JSP 'bookSearchContent.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<script src="../js/Calendar.js"></script>
	<script src="../js/ticketCheckData.js"></script>
		<script >  	
     	   function statechange(){
     	      var state=document.forms["form"].state.value;
     	      var openDate=document.forms["form"].openDate;
	          var deleteDate=document.forms["form"].deleteDate;
     	      switch(state){  
     	       case '0':   openDate.disabled=false;deleteDate.disabled=true;
     	          break;
	           case '1':   openDate.disabled=true;deleteDate.disabled=false;
	              break;
	         

	         }
     	   }
     	
     	   function checkDate(){
     	
     	      var state=document.forms["form"].state;
              var openDate=document.forms["form"].openDate;
	          var deleteDate=document.forms["form"].deleteDate;
	          if(state.value==0){
	           return checkForDate(openDate);
	          }else{
	           return checkForDate(deleteDate);
	          }
     	   }
     	</script>
    
  </head>
  
  <body onload="statechange()">
  <center><h1>修改罚单</h1></center>
    <form id="form" action="ticketModify.jsp" method="post" onsubmit="return checkDate()">
     <input type="hidden" name="action" value="ticketUpdate"></input>
      <input type="hidden" name="tId" value=<%=ticket.getId() %>></input>
      <table border="1" align="center" >
       <tr>
         <td>罚单ID</td>
         <td><%=ticket.getId() %></td>
       </tr>
       
       <tr>
         <td>读者名称</td>  
         <td ><%=ReaderManager.getInstance().loadById(ticket.getRid()).getrName() %></td> 
       </tr>
       
       <tr>
         <td>状态</td>  
         <td>
           <select name="state" value="state" onchange="statechange()">
             <option value="0" <%=ticket.getState()==0?"selected":"" %> >未缴款</option>
             <option value="1" <%=ticket.getState()==1?"selected":"" %>>已缴款</option>
           </select>
       </tr>
       
       <tr>  
         </td>     
         <td>开出罚单时间：</td> 
         <td><input type="text" name="openDate" id="openDate" value='<%=ticket.getOpendate()!=null?ticket.getOpendate().toString():"" %>' onblur="checkForDate(this)" onClick="setDayHM(this)"></input>
         <span id="openDateTip"></span>
         </td>
       </tr>
      
       <tr>  
         <td>缴款时间：</td>
         <td ><input type="text" name="deleteDate" id="deleteDate" value='<%=ticket.getEnddate()!=null? ticket.getEnddate().toString(): ""%>' onblur="checkForDate(this)"  onClick="setDayHM(this)"></input>
         <span id="deleteDateTip"></span>
         </td>
       </tr>  
       
        <tr>  
         <td>书单描叙:</td>              
              <td >
	              <textarea rows="5" cols="50" name="desc" id="desc" ><%=ticket.gettDesc() %>
	              </textarea>
              </td>
           </tr>
       </tr>
       
        <tr align="center">
         <td colspan="2"><input type="submit" value="修改"></input></td>
       </tr>
    </table>    
   </form>
  </body>
</html>
