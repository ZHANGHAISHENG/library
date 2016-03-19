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
    int pageNo=1;
    int pageSize=10;
    int pageCount=0;
    
    String strPageNo=request.getParameter("pageNo");
    String strPageCount=request.getParameter("pageCount");
    String strParamValues="";
    

    //获取Ids
    String[] strTIds=request.getParameter("tIds").split(";");
    int[] tIds=null;
    
    if(strTIds!=null&&strTIds.length>0&&!strTIds[0].trim().equals("")){
       tIds=new int[strTIds.length];
       for(int i=0;i<strTIds.length;i++){ 
          
          tIds[i]=Integer.parseInt(strTIds[i].trim());
       }
     
    }
    
    //获取rIds
    String[] rIds=request.getParameter("rIds").split(";");
    if(rIds.length==1&&rIds[0].trim().equals("")){
      rIds=null;
    }

    
     //获取tItemIds
    String[] strTItemIds=request.getParameter("tItemIds").split(";");

    int[] tItemIds=null;
    
    if(strTItemIds!=null&&strTItemIds.length>0&&!strTItemIds[0].trim().equals("")){
        tItemIds=new int[strTItemIds.length];
       for(int i=0;i<strTItemIds.length;i++){

          tItemIds[i]=Integer.parseInt(strTItemIds[i]);
       }
     
    }
    
    //获取bIds
    String[] strBIds=request.getParameter("bIds").split(";");

    int[] bIds=null;
    
    if(strBIds!=null&&strBIds.length>0&&!strBIds[0].trim().equals("")){
        bIds=new int[strBIds.length];
       for(int i=0;i<strBIds.length;i++){
          bIds[i]=Integer.parseInt(strBIds[i]);
       }
     
    }

    //获取关键字keyWord
    String keyWord=request.getParameter("keyWord");
    
    //获取状态state

    String strState=request.getParameter("state");
    int state=-1;
    if(strState!=null&&!strState.trim().equals("")){
       state=Integer.parseInt(strState);
    }

     
    //获取书单申请时间范围
    Timestamp openStartDate=adjustDate(request,"openStartDate");
    Timestamp openEndDate=adjustDate(request,"openEndDate");

    
    //获取借书成功时间范围
    Timestamp deleteStartDate=adjustDate(request,"deleteStartDate");
    Timestamp deleteEndDate=adjustDate(request,"deleteEndDate");

   

    //判断是pageNo否越界
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

    
 //获取所有的参数，为分页做准备
       
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
       
    //执行搜索
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
        <th>罚单ID</th>
        <th>读者名称</th>   
        <th>状态</th>     		     
        <th>开出罚单时间：</th>
        <th>缴款时间：</th>
        <th>罚单描叙</th>
        <th>添加</th>
        <th>删除</th>
        <th>修改</th>
        <th>明细</th>

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
         <td><%=ticket.getState()==0?"未缴款":"已缴款" %></td>      
         <td><%=ticket.getOpendate() %>&nbsp</td>
         <td ><%=ticket.getEnddate() %>&nbsp</td>
         <td><%=ticket.gettDesc() %></td>
         <td ><a href="../ticketItem/ticketItemAdd.jsp?tId=<%=ticket.getId() %>" target="detail">添加罚单项</a><br/></td>
         <td ><a href="ticketDelete.jsp?tId=<%=ticket.getId() %>" target="detail">删除</a></td>
         <td ><a href="ticketModify.jsp?tId=<%=ticket.getId() %>" target="detail">修改</a></td>
         <td ><a href="ticketDetail.jsp?tId=<%=ticket.getId() %>" target="detail">明细</a></td>
       </tr>
      <%
        
       }
       %>
    </table>    
                    第<%=pageNo %>页
                   共<%=pageCount %>页
      <a href="ticketSearchResult.jsp?pageNo=1&pageCount=<%=pageCount %><%="&"+strParamValues %>" onclick=" return linkClick(this)" >首页</a>&nbsp            
      <a href="ticketSearchResult.jsp?pageNo=<%=pageNo-1 %>&pageCount=<%=pageCount %><%="&"+strParamValues %>" onclick=" return linkClick(this)">上一页</a>&nbsp
      
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
      <a href="ticketSearchResult.jsp?pageNo=<%=pageNo+1 %>&pageCount=<%=pageCount %><%="&"+strParamValues %>" onclick=" return linkClick(this)" >下一页</a>&nbsp
      <a href="ticketSearchResult.jsp?pageNo=<%=pageCount%>&pageCount=<%=pageCount %><%="&"+strParamValues %>" onclick=" return linkClick(this)" >末页</a>

  </body>
</html>
