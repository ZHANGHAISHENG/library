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
           strDate=strDate.trim()+" 00:00:00";//ע�⣺�м�ֻ��һ���ո�
        }
        if(strDate.matches("^\\s*\\d{4}-\\d{2}-\\d{2}\\s\\d{2}\\:\\d{2}\\s*$")){
           strDate=strDate.trim()+":00";//ע�⣺�м�ֻ��һ���ո�
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
    int pageNo=1;
    int pageSize=10;
    int pageCount=0;
    
    String strPageNo=request.getParameter("pageNo");
    String strPageCount=request.getParameter("pageCount");
    String strParamValues="";
    

    //��ȡIds
    String[] strTIds=request.getParameter("tIds").split(";");
    int[] tIds=null;
    
    if(strTIds!=null&&strTIds.length>0&&!strTIds[0].trim().equals("")){
       tIds=new int[strTIds.length];
       for(int i=0;i<strTIds.length;i++){ 
          
          tIds[i]=Integer.parseInt(strTIds[i].trim());
       }
     
    }
    
    //��ȡrIds
    String[] rIds=request.getParameter("rIds").split(";");
    if(rIds.length==1&&rIds[0].trim().equals("")){
      rIds=null;
    }

    
     //��ȡtItemIds
    String[] strTItemIds=request.getParameter("tItemIds").split(";");

    int[] tItemIds=null;
    
    if(strTItemIds!=null&&strTItemIds.length>0&&!strTItemIds[0].trim().equals("")){
        tItemIds=new int[strTItemIds.length];
       for(int i=0;i<strTItemIds.length;i++){

          tItemIds[i]=Integer.parseInt(strTItemIds[i]);
       }
     
    }
    
    //��ȡbIds
    String[] strBIds=request.getParameter("bIds").split(";");

    int[] bIds=null;
    
    if(strBIds!=null&&strBIds.length>0&&!strBIds[0].trim().equals("")){
        bIds=new int[strBIds.length];
       for(int i=0;i<strBIds.length;i++){
          bIds[i]=Integer.parseInt(strBIds[i]);
       }
     
    }

    //��ȡ�ؼ���keyWord
    String keyWord=request.getParameter("keyWord");
    
    //��ȡ״̬state

    String strState=request.getParameter("state");
    int state=-1;
    if(strState!=null&&!strState.trim().equals("")){
       state=Integer.parseInt(strState);
    }

     
    //��ȡ�鵥����ʱ�䷶Χ
    Timestamp openStartDate=adjustDate(request,"openStartDate");
    Timestamp openEndDate=adjustDate(request,"openEndDate");

    
    //��ȡ����ɹ�ʱ�䷶Χ
    Timestamp deleteStartDate=adjustDate(request,"deleteStartDate");
    Timestamp deleteEndDate=adjustDate(request,"deleteEndDate");

   

    //�ж���pageNo��Խ��
    if(strPageCount!=null&&!strPageCount.trim().equals("")){
       pageCount=Integer.parseInt(strPageCount);
    }
    
    if(strPageNo!=null&&!strPageNo.trim().equals("")){
       pageNo=Integer.parseInt(strPageNo);
       if(pageNo<1){
         pageNo=1;
       }
       if(pageNo>pageCount){
         pageNo=pageCount;
       }
    }

    
 //��ȡ���еĲ�����Ϊ��ҳ��׼��
       
      Enumeration<String> pamaNames=request.getParameterNames();
      
      while(pamaNames.hasMoreElements()){
           String pamaName=pamaNames.nextElement();
           if(!pamaName.trim().equals("pageNo")&&!pamaName.trim().equals("pageCount")){
               String[] pamaValues=request.getParameterValues(pamaName);
	           for(int i=0;i<pamaValues.length;i++){
	             strParamValues+=pamaName+"="+pamaValues[i]+"&";
	           }
            }
      }
       
    //ִ������
     ArrayList<Ticket> tickets=new ArrayList<Ticket>();
         
     pageCount=TicketManager.getInstance().findTickets(tickets,
								                     keyWord, tIds, rIds, tItemIds, bIds, 
								                     state, openStartDate, openEndDate,
								                     deleteStartDate, deleteEndDate,
								                     pageNo, pageSize);

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
    <script src="../js/linkTransToForm.js"></script>
    
	<script>
 
	  function LinkToSkipPage(){

	     var select=document.getElementById("pageNo");
	     var i=select.selectedIndex;
	     var pageNo=select.options[i].value;    
         var aObject=document.getElementById("select");
               
         aObject.href="ticketSearchResult.jsp?pageNo="+pageNo+"&pageCount=<%=pageCount %><%="&"+strParamValues %>";
         linkClick(aObject);
	  }
	
	</script>

  </head>
  
  <body>
      <table border="1" align="center" >
      <tr>
        <th>����ID</th>
        <th>��������</th>   
        <th>״̬</th>     		     
        <th>��������ʱ�䣺</th>
        <th>�ɿ�ʱ�䣺</th>
        <th>��������</th>
        <th>���</th>
        <th>ɾ��</th>
        <th>�޸�</th>
        <th>��ϸ</th>

      </tr>
      <%
       
       for(Iterator<Ticket> it=tickets.iterator();it.hasNext();){
              Ticket ticket=it.next();
              Reader r=new Reader();
              r.setId(ticket.getRid());
              ArrayList<TicketItem> tItems=ticket.getTicketItems();           
       %>
       <tr>
         <td><%=ticket.getId() %></td>
         <td ><%=r.load().getrName() %></td> 
         <td><%=ticket.getState()==0?"δ�ɿ�":"�ѽɿ�" %></td>      
         <td><%=ticket.getOpendate() %>&nbsp</td>
         <td ><%=ticket.getEnddate() %>&nbsp</td>
         <td><%=ticket.gettDesc() %></td>
         <td ><a href="../ticketItem/ticketItemAdd.jsp?tId=<%=ticket.getId() %>" target="detail">��ӷ�����</a><br/></td>
         <td ><a href="ticketDelete.jsp?tId=<%=ticket.getId() %>" target="detail">ɾ��</a></td>
         <td ><a href="ticketModify.jsp?tId=<%=ticket.getId() %>" target="detail">�޸�</a></td>
         <td ><a href="ticketDetail.jsp?tId=<%=ticket.getId() %>" target="detail">��ϸ</a></td>
       </tr>
      <%
        
       }
       %>
    </table>    
                    ��<%=pageNo %>ҳ
                   ��<%=pageCount %>ҳ
      <a href="ticketSearchResult.jsp?pageNo=1&pageCount=<%=pageCount %><%="&"+strParamValues %>" onclick=" return linkClick(this)" >��ҳ</a>&nbsp            
      <a href="ticketSearchResult.jsp?pageNo=<%=pageNo-1 %>&pageCount=<%=pageCount %><%="&"+strParamValues %>" onclick=" return linkClick(this)">��һҳ</a>&nbsp
      
      <a id="select" href=""></a>
      <select name="pageNo" id="pageNo" onchange=" LinkToSkipPage()">
        <%  for(int i=1;i<=pageCount;i++){
            if(i==pageNo){%>
             <option value=<%=i %> selected><%=i %></option>
             <%}else{ %>
              <option value=<%=i %>><%=i %></option>
          
      <%        }
       } %>
        
      </select>
      <a href="ticketSearchResult.jsp?pageNo=<%=pageNo+1 %>&pageCount=<%=pageCount %><%="&"+strParamValues %>" onclick=" return linkClick(this)" >��һҳ</a>&nbsp
      <a href="ticketSearchResult.jsp?pageNo=<%=pageCount%>&pageCount=<%=pageCount %><%="&"+strParamValues %>" onclick=" return linkClick(this)" >ĩҳ</a>

  </body>
</html>
