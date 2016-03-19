<%@page import="manager.*"%>
<%@ page language="java" import="java.util.*" pageEncoding="GB18030"%>
<%@page import="bean.*" %>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%
      response.setHeader("Cache-Control","no-store");//http1.1 
	  response.setHeader("Pragma", "no-cache");//http1.0
	  response.setDateHeader("Expires", 0);//永不过期
	  
      request.setCharacterEncoding("GB18030");
      
      String rId=request.getParameter("rId");
      
      Ticket ticket=new Ticket();
      ticket.setRid(rId);
      
      Reader r=new Reader();
      r.setId(rId);
      
      String[] rIds=new String[1];
      rIds[0]=rId;
      StringBuffer bookMessage=new StringBuffer();
      if(!ReaderManager.getInstance().isExist(r)){//判断是否存在该读者
         response.getWriter().write("invalid");
         return ;
      }else{
          //获取关于该读者的所有借书书单
          ArrayList<BorrowBook> bbooks=BorrowBookManager.getInstance().getBorrowBooksByRids(rIds);
           
         //输出所借书信息

         
         //取出所有的书单
         for(BorrowBook it:bbooks){
           ArrayList<BorrowBookItem> bbItem=it.getBorrowBookItems();
           
           //书单项
           for(BorrowBookItem it1:bbItem){
              Book b=BookManager.getInstance().loadById(it1.getbId());
              System.out.println(b.getBookName()+"_"+it1.getState());
              //该书没有超期或已经返还
              if(it1.getState()!=2){
                 continue;
               }
               
              //不存在该读者的罚单或者是存在该读者的罚单，但不存在关于该罚单项
              if(!TicketManager.getInstance().isExist(ticket)||!TicketItemManger.getInstance().isExist(b.getId(), rId)){
              
                 bookMessage.append(b.getId()+"_"+b.getBookName()+"_notExist"+";");
                 
              }else{//存在该读者的罚单，并且存在关于该罚单项
	             bookMessage.append(b.getId()+"_"+b.getBookName()+"_exist"+";");
              }  
           }

         }
         if(bookMessage.length()>0){
          bookMessage.replace(bookMessage.length()-1, bookMessage.length(), "");//去掉最后的";"
         }
         bookMessage.trimToSize();
      }
             
         response.getWriter().write(bookMessage.toString());
%>