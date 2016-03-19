<%@ page language="java" import="java.util.*" pageEncoding="GB18030"%>
<%@page import="manager.*"%>
<%@page import="bean.*"%>
<%@page import="java.sql.*"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<%
  request.setCharacterEncoding("GB18030");
     Reader reader=(Reader)session.getAttribute("reader"); 
  BookBasket bBasket=(BookBasket)request.getSession().getAttribute("bookBasket");
  String action=request.getParameter("action");
  System.out.println("bBasket"+bBasket);
  if(bBasket==null||bBasket.getBooks().size()==0){
    out.println("请添加要借阅的图书");
    return;
  }
  
  if(action!=null&&!action.trim().equals("")){
     //书单参数
      Timestamp oDate=new Timestamp(System.currentTimeMillis());
      String bbDesc=null;
      
     //书单
      BorrowBook bbook=new BorrowBook();
	      bbook.setrId(reader.getId());
	      bbook.setoDate(oDate);
	      bbook.setbBdesc(bbDesc);//null;
      
      //书单项参数
      String[] strBIds=BookBasketManager.getInstance().getStrAllbookIds(bBasket).split(";");
      int[] bIds=new int[strBIds.length];
      for(int i=0;i<strBIds.length;i++){
         bIds[i]=Integer.parseInt(strBIds[i]);
      }
      int state=0;
      Timestamp oSuccessDate=null;
      Timestamp overdueDate=null;
      Timestamp returnBookDate=null;
      String bbiDesc=null;
      

	  //书单项    
	  ArrayList<BorrowBookItem> bbookItems=new ArrayList<BorrowBookItem>();
	
	  for(int i=0;i<strBIds.length;i++){
	    BorrowBookItem bbookItem=new BorrowBookItem();
	    bbookItem.setbId(bIds[i]);
	    bbookItem.setState(state);
	    bbookItem.setoSuccessDate(oSuccessDate);//null;
	    bbookItem.setoVerdueDate(overdueDate);//null;
	    bbookItem.setReturnBookDate(returnBookDate);//null;
	    bbookItem.setbBIDesc(bbiDesc);//null;
	    bbookItems.add(bbookItem);
	  }
	  
	  bbook.setBorrowBookItems(bbookItems);
	  
     if( BorrowBookManager.getInstance().addBorrowBook(bbook)){
        bBasket.getBooks().clear();//清空书篮子
        out.println("添加书单成功");

     }else{
        out.println("添加书单失败");
        
      }
    
  }
   
 %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <%-- <base href="<%=basePath%>">  --%>
    
    <title>My JSP 'bookBasket.jsp' starting page</title>
    
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
  <center><h1>预约图书</h1></center>
<form name="form" action="bookBasket.jsp" method="post" onsubmit=""><!-- 应该还要再次检测图书有没有被预约，因为浏览器期间可能会有人抢先了 -->
  <input type="hidden" name="action" value="bookBasket"></input>
    <table border="1" align="center" >
      <tr>
        <th>iD</th>
        <th>所属类别</th>
        <th>图书名称</th>
        <th>作者</th>
        <th>版本</th>
        <th>删除</th>
      </tr>
      <%
       
       for(Book b:bBasket.getBooks()){  
       %>
       <tr>
        <td><%=b.getId() %></td>
        <td><%=CategoryManager.getInstance().loadById(b.getCateId()).getCateName() %></td>
        <td><%=b.getBookName() %></td>
        <td><%=b.getAuthorName() %></td>
        <td><%=b.getBookVersion() %></td>
        <td><a href="removeItem.jsp?bId=<%=b.getId() %>" >删除</a></td>
      </tr>
      <%
        
       }
       %>
       <tr >
			<td colspan="6" align="center">
				<input type="submit" value="确定预约" >
			</td>
	  </tr>
    </table> 
   </form>
  </body>
</html>
