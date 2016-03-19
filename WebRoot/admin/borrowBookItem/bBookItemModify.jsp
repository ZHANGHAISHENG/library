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
    } else{
      BorrowBookItem bbookItem=(BorrowBookItem)request.getSession().getAttribute("bbookItem");
      date=strQueryDate.trim().equals("oSuccessDate")? bbookItem.getoSuccessDate():
            (strQueryDate.trim().equals("overDueDate")? bbookItem.getoVerdueDate():
             bbookItem.getReturnBookDate()
            );
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
    int bbookId=Integer.parseInt(request.getParameter("bbookId")) ;
    int bbookItemId=Integer.parseInt(request.getParameter("bbookItemId"));
    BorrowBook bbook=BorrowBookManager.getInstance().loadById(bbookId);
    
    String action=request.getParameter("action");
    
    if(action!=null&&action.trim().equals("bbItemUpdate")){
    
       int bId=Integer.parseInt(request.getParameter("bId"));
       int state=Integer.parseInt(request.getParameter("state"));
       
       //时间处理：

	    Timestamp oSuccessDate=adjustDate(request,"oSuccessDate");
	    Timestamp oVerDueDate=adjustDate(request,"overDueDate");
	    Timestamp returnBookDate=adjustDate(request,"returnBookDate");
        String bbIDesc=request.getParameter("bbIDesc");
           
       BorrowBookItem bbItem=new BorrowBookItem();
       bbItem.setId(bbookItemId);
       bbItem.setbBid(bbookId);
       bbItem.setbId(bId);
       bbItem.setState(state);
       bbItem.setoSuccessDate(oSuccessDate);
       bbItem.setoVerdueDate(oVerDueDate);
       bbItem.setReturnBookDate(returnBookDate);
       bbItem.setbBIDesc(bbIDesc);
       
       if(bbItem.updateBorrowBookItem()){//由于是new 出来的bbItem,所下面无法再reload后刷新
         %>
		    <script>
		       window.parent.main.location.reload();
		    </script>
		  <%
	    out.println("修改成功");
	  }else{
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
	--><script src="../js/Calendar.js"></script>
     	
     	<script src="../js/BorrowBookCheckData.js"></script>
     	<script >
     	
     	   function statechange(){
     	      var state=document.forms["form"].state.value;
     	      var oSuccessDate=document.forms["form"].oSuccessDate;
	          var overDueDate=document.forms["form"].overDueDate;
	          var returnBookDate=document.forms["form"].returnBookDate;
     	      switch(state){  
     	       case '0':   oSuccessDate.disabled=true;overDueDate.disabled=true;returnBookDate.disabled=true;
     	          break;
	           case '1':   oSuccessDate.disabled=false;overDueDate.disabled=false;returnBookDate.disabled=true;
	              break;
	           case '2':   oSuccessDate.disabled=true;overDueDate.disabled=false;returnBookDate.disabled=true;
	              break;
	           case '3':   oSuccessDate.disabled=true;overDueDate.disabled=true;returnBookDate.disabled=false;
	              break;

	         }
     	   }
     	
     	   function checkDate(){
     	     var state=document.forms["form"].state;
     	     var oSuccessDate=document.forms["form"].oSuccessDate;
	         var overDueDate=document.forms["form"].overDueDate;
	         var returnBookDate=document.forms["form"].returnBookDate;
	         
	         switch(state.value){
	           case '0': return true;
	           case '1': return !checkForDate(oSuccessDate)?checkForDate(oSuccessDate):checkForDate(overDueDate);  break;
	           case '2': return checkForDate(overDueDate);  break;
	           case '3': return checkForDate(returnBookDate);  break;
	           default:  return false;
	         }
     	   }
     	</script>
  </head>
  
  <body onload="statechange()">
    <form name="form" action="bBookItemModify.jsp" method="post"  onsubmit="return checkDate()" >
     <input type="hidden" name="action" value="bbItemUpdate"></input>
     <input type="hidden" name="bbookId" value=<%=bbookId %>></input>
     <input type="hidden" name="bbookItemId" value=<%=bbookItemId %>></input>
      <table border="1" align="center" >
      
      <%       
       if(bbook!=null){
              ArrayList<BorrowBookItem> bbookItems=bbook.getBorrowBookItems();
              Reader r=new Reader();
              r.setId(bbook.getrId()); 
              r.load();
              
              //获取书单项
              BorrowBookItem bbookItem=new BorrowBookItem();
              for(int i=0;i<bbookItems.size();i++){
	              if(bbookItems.get(i).getId()==bbookItemId){
		                 bbookItem=bbookItems.get(i);
		                 request.getSession().setAttribute("bbookItem", bbookItem);
		                 break;
		       
		      
		          } 
              }
              Book b=BookManager.getInstance().loadById(bbookItem.getbId());
 
       %>
       <tr>
	        <td>书单ID</td>
	        <td><%=bbook.getId() %></td>
       </tr>
       <tr>
	        <td>读者名称</td>    
	        <td><%=r.load().getrName() %></td>
       </tr>

           <tr>
	           <td>书名：</td>
		       <td><%=b.getBookName()%>
		       <input type="hidden" name="bId" id="bId" value=<%=b.getId()%>></input>
		       </td>
	       </tr>
	       
	       <tr>
	       	   <td>状态：</td>
		       <td>
	
		           <select name="state" id="state" onchange=" statechange()" >
			        <option value="0" <%=bbookItem.getState()==0?"selected":"" %>>预约中</option>
			        <option value="1" <%=bbookItem.getState()==1?"selected":"" %>>借阅中</option>
			        <option value="2" <%=bbookItem.getState()==2?"selected":"" %>>超期</option>
			        <option value="3" <%=bbookItem.getState()==3?"selected":"" %>>已还</option>
			      </select>
		       </td>
	       </tr>
	       
	       <tr>
		       <td>借阅成功时间：</td>
		       <td>
		        <input type="text" size="30" name="oSuccessDate" id="oSuccessDate"  value="<%=bbookItem.getoSuccessDate()!=null?bbookItem.getoSuccessDate().toString():"" %>"   onblur="checkForDate(this)" onClick="setDayHM(this)"></input>
                <span id="oSuccessDateTip"></span>
		       
               </td>
	       </tr>
	       
	       <tr>
		       <td>超期时间：</td>
		       <td>
		        <input type="text" size="30" name="overDueDate" id="overDueDate" value="<%=bbookItem.getoVerdueDate()!=null? bbookItem.getoVerdueDate().toString():"" %>" onblur="checkForDate(this)" onClick="setDayHM(this)"></input>
                <span id="overDueDateTip"></span>
		       </td>
	       </tr>
	       
	       <tr>
		       <td>图书返还时间：</td>
		       <td>

		        <input type="text" size="30" name="returnBookDate" id="returnBookDate" value="<%=bbookItem.getReturnBookDate()!=null? bbookItem.getReturnBookDate().toString():"" %>" onblur="checkForDate(this)" onClick="setDayHM(this)"></input>
                <span id="returnBookDateTip"></span>
		       </td>
	       </tr>
	       
	       <tr align="left">
              <td>书单项描叙:</td>
              <td>
	              <textarea name="bbIDesc" id="bbIDesc"  rows="5" cols="50" ><%=bbookItem.getbBIDesc() %>
	              </textarea>
              </td>  
	       </tr>       
           <tr>  
              <td>书单入库时间：</td>
              <td><%=bbook.getoDate() %>&nbsp</td>
           </tr>
           
           <tr align="left">
              <td>书单描叙:</td>
              <td >
	              <textarea rows="5" cols="50"  disabled ><%=bbook.getbBdesc()%>
	              </textarea>
              </td>
           </tr> 
      <%  
       }
       %>

       <tr align="center">
         <td colspan="9"><input type="submit" value="修改"></input></td>
       </tr>
    </table>    
    </form>   

  </body>
</html>
