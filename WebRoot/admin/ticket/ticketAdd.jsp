<script src="../js/detailClear.js"></script>
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
  String rId=request.getParameter("rId");//当从borrowBookSearchResult链接过来时需要存在此参数，或提交时

  if(action!=null&&action.trim().equals("ticketAdd")){
      //参数      
      String tDesc=request.getParameter("tDesc");
      
      //书单项参数
      /* String[] strBIds=request.getParameter("bIds").split(";");*/
      String[] strBIds=request.getParameterValues("bIds");
      int[] bIds=new int[strBIds.length];
      for(int i=0;i<strBIds.length;i++){
         bIds[i]=Integer.parseInt(strBIds[i]);
      } 
     
      int state=0;
      Timestamp openDate=new Timestamp(System.currentTimeMillis());
      Timestamp deleteDate=null;
      String tItemDesc=request.getParameter("tItemDesc");
      
      //罚单
      Ticket ticket=new Ticket();
          ticket.setRid(rId);
          ticket.setState(state);
          ticket.setOpendate(openDate);
          ticket.setEnddate(deleteDate);
          ticket.settDesc(tDesc);
	  //书单项    
	  ArrayList<TicketItem> tItems=new ArrayList<TicketItem>();
	
	  for(int i=0;i<strBIds.length;i++){
	    TicketItem tItem=new TicketItem();
	    tItem.setBid(bIds[i]);
	    tItem.setMoney(30); //暂时为30
	    tItem.setTtDesc(tItemDesc);
	    tItems.add(tItem);
	  }
	  
	  ticket.setTicketItems(tItems);
	  
     if( TicketManager.getInstance().addTicket(ticket)){
        out.println("添加罚单成功");
      }else{
        out.println("添加罚单失败");
        
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
      var b=true;
	 //检查读者ID是否为空           
	    
	   if(document.getElementById("rId").value.search(/^\s*\s*$/)!=-1){
	         document.getElementById("rIdTip").innerHTML="<font color='red'>Id号不能为空</font>";
	         b=false;
	   }
        if(b){
         b=checkForBIds();
       }; 

       return b;
     }
	</script>	      
	      

  </head>
  <body onload="checkForRId()">
      <center>
		 <h1>添加罚单</h1>
	  </center>
      <form name="form" id="form" action="ticketAdd.jsp" method="post" onsubmit="return checkDate()">
          <input type="hidden"  name="action" value="ticketAdd"></input>
          <table align="center">
               <tr>
                  <td>读者ID：</td>
                  <td><input type="text" size="30" name="rId" id="rId" value='<%=(rId!=null?rId:"") %>' onblur="checkForRId()"></input>
                  <span id="rIdTip"></span>
                  </td>
               </tr>
               
               <tr>
                 <td>书ID:<br/>
                       <!-- (例：123;145;456...)： -->
                  </td>
                  <td id="book">
                  <!-- <input type="text" size="30" name="bIds" id="bIds" onblur="checkForBIds()"></input>
                   <span id="bIdsTip"></span>-->
                   </td> 
               </tr>
               
               	<tr>
					<td>罚单描述:</td>
					<td>
						<textarea name="tDesc" id="tDesc" rows="5"
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





