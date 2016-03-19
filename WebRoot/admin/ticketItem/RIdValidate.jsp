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
	  response.setDateHeader("Expires", 0);//��������
	  
      request.setCharacterEncoding("GB18030");
      
      String rId=request.getParameter("rId");
      
      Ticket ticket=new Ticket();
      ticket.setRid(rId);
      
      Reader r=new Reader();
      r.setId(rId);
      
      String[] rIds=new String[1];
      rIds[0]=rId;
      StringBuffer bookMessage=new StringBuffer();
      if(!ReaderManager.getInstance().isExist(r)){//�ж��Ƿ���ڸö���
         response.getWriter().write("invalid");
         return ;
      }else{
          //��ȡ���ڸö��ߵ����н����鵥
          ArrayList<BorrowBook> bbooks=BorrowBookManager.getInstance().getBorrowBooksByRids(rIds);
           
         //�����������Ϣ

         
         //ȡ�����е��鵥
         for(BorrowBook it:bbooks){
           ArrayList<BorrowBookItem> bbItem=it.getBorrowBookItems();
           
           //�鵥��
           for(BorrowBookItem it1:bbItem){
              Book b=BookManager.getInstance().loadById(it1.getbId());
              System.out.println(b.getBookName()+"_"+it1.getState());
              //����û�г��ڻ��Ѿ�����
              if(it1.getState()!=2){
                 continue;
               }
               
              //�����ڸö��ߵķ��������Ǵ��ڸö��ߵķ������������ڹ��ڸ÷�����
              if(!TicketManager.getInstance().isExist(ticket)||!TicketItemManger.getInstance().isExist(b.getId(), rId)){
              
                 bookMessage.append(b.getId()+"_"+b.getBookName()+"_notExist"+";");
                 
              }else{//���ڸö��ߵķ��������Ҵ��ڹ��ڸ÷�����
	             bookMessage.append(b.getId()+"_"+b.getBookName()+"_exist"+";");
              }  
           }

         }
         if(bookMessage.length()>0){
          bookMessage.replace(bookMessage.length()-1, bookMessage.length(), "");//ȥ������";"
         }
         bookMessage.trimToSize();
      }
             
         response.getWriter().write(bookMessage.toString());
%>