<%@page import="manager.*"%>
<%@page import="bean.*"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" import="java.util.*" pageEncoding="GB18030"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<%
  request.setCharacterEncoding("GB18030");
  String action=request.getParameter("action");
  int  tId=Integer.parseInt(request.getParameter("tId"));
  Ticket ticket=TicketManager.getInstance().loadById(tId);
  
  if(action!=null&&action.trim().equals("ticketItemAdd")){

      //书单项参数
      //String[] strBIds=request.getParameter("bIds").split(";");
      String[] strBIds=request.getParameterValues("bIds");
      int[] bIds=new int[strBIds.length];
      for(int i=0;i<strBIds.length;i++){
         bIds[i]=Integer.parseInt(strBIds[i]);
      }
      String tItemDesc=request.getParameter("tItemDesc");

	  //罚单项    
	  ArrayList<TicketItem> tItems=new ArrayList<TicketItem>();
	
	  for(int i=0;i<strBIds.length;i++){
	    TicketItem tItem=new TicketItem();
	    tItem.setBid(bIds[i]);
	    tItem.setMoney(30); //暂时为30
	    tItem.setTtDesc(tItemDesc);
	    tItems.add(tItem);
	  }
	  
     if( TicketItemManger.getInstance().addTicketItems(ticket, tItems)){
        out.println("添加罚单项成功");
      }else{
        out.println("添加罚单项失败");
        
      }
  }
  
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
   <%--  <base href="<%=basePath%>"> --%>
    
    <title>My JSP 'borrowBookAdd.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<script src="../js/ticketCheckData.js">

		 
	</script>
	<script>
	 function checkDate(){

       return checkForBIds();
     }

	</script>	      
	      

  </head>
  <body onload="checkForRId()">
      <center>
		 <h1>添加罚单项</h1>
	  </center>
      <form name="form" id="form" action="ticketItemAdd.jsp" method="post" onsubmit="return checkDate()">
          <input type="hidden"  name="action" value="ticketItemAdd"></input>
          <input type="hidden"  name="tId" value=<%=tId%>></input>
          <input type="hidden"  name="rId" id="rId" value=<%=ticket.getRid()%>></input><!-- checkBIds中用来检测该读者是否已借阅的图书并且未还 -->
          <table align="center" >
                <tr>
                  <td>读者ID：</td>
                  <td><input type="text" size="30" value=<%=ticket.getRid() %> disabled></input>
                  <span id="rIdTip"></span>
                  </td>
               </tr>
               
               <tr>
                  <td>书ID:<br/>
                      (例：123;145;456...)：
                  </td>
                  <td id="book">
                   <!--  <input type="text" size="30" name="bIds" id="bIds" onblur="checkForBIds()"></input>
                   <span id="bIdsTip"></span> -->
                   </td>
               </tr>

				<tr>
					<td>罚单项描述:</td>
					<td>
						<textarea name="tItemDesc" id="tItemDesc" rows="5"
							cols="50">
						</textarea>
					</td>
				</tr>
					

				<tr align="center">
					<td colspan="2">
						<input type="submit" value="添加" >
					</td>
				</tr>
          </table>
      </form>
  </body>
</html>





