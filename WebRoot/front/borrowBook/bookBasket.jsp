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
    out.println("�����Ҫ���ĵ�ͼ��");
    return;
  }
  
  if(action!=null&&!action.trim().equals("")){
     //�鵥����
      Timestamp oDate=new Timestamp(System.currentTimeMillis());
      String bbDesc=null;
      
     //�鵥
      BorrowBook bbook=new BorrowBook();
	      bbook.setrId(reader.getId());
	      bbook.setoDate(oDate);
	      bbook.setbBdesc(bbDesc);//null;
      
      //�鵥�����
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
      

	  //�鵥��    
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
        bBasket.getBooks().clear();//���������
        out.println("����鵥�ɹ�");

     }else{
        out.println("����鵥ʧ��");
        
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
  <center><h1>ԤԼͼ��</h1></center>
<form name="form" action="bookBasket.jsp" method="post" onsubmit=""><!-- Ӧ�û�Ҫ�ٴμ��ͼ����û�б�ԤԼ����Ϊ������ڼ���ܻ����������� -->
  <input type="hidden" name="action" value="bookBasket"></input>
    <table border="1" align="center" >
      <tr>
        <th>iD</th>
        <th>�������</th>
        <th>ͼ������</th>
        <th>����</th>
        <th>�汾</th>
        <th>ɾ��</th>
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
        <td><a href="removeItem.jsp?bId=<%=b.getId() %>" >ɾ��</a></td>
      </tr>
      <%
        
       }
       %>
       <tr >
			<td colspan="6" align="center">
				<input type="submit" value="ȷ��ԤԼ" >
			</td>
	  </tr>
    </table> 
   </form>
  </body>
</html>
