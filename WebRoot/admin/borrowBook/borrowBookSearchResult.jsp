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
    String[] strIds=request.getParameter("ids").split(";");
    int[] ids=null;
    
    if(strIds!=null&&strIds.length>0&&!strIds[0].trim().equals("")){
       ids=new int[strIds.length];
       for(int i=0;i<strIds.length;i++){ 
          
          ids[i]=Integer.parseInt(strIds[i].trim());
       }
     
    }
    
    //��ȡrIds
    String[] rIds=request.getParameter("rIds").split(";");
    if(rIds.length==1&&rIds[0].trim().equals("")){
      rIds=null;
    }

    
     //��ȡbbookItemIds
    String[] strBbiIds=request.getParameter("bbookItemIds").split(";");

    int[] bbookItemIds=null;
    
    if(strBbiIds!=null&&strBbiIds.length>0&&!strBbiIds[0].trim().equals("")){
        bbookItemIds=new int[strBbiIds.length];
       for(int i=0;i<strBbiIds.length;i++){

          bbookItemIds[i]=Integer.parseInt(strBbiIds[i]);
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
    Timestamp startODate=adjustDate(request,"startODate");
    Timestamp endODate=adjustDate(request,"endODate");

    
    //��ȡ����ɹ�ʱ�䷶Χ
    Timestamp sStartDate=adjustDate(request,"sStartDate");
    Timestamp sEndDate=adjustDate(request,"sEndDate");

    
    //��ȡ���鳬��ʱ�䷶Χ
    Timestamp overDueStartDate=adjustDate(request,"overDueStartDate");
    Timestamp overDueEndDate=adjustDate(request,"overDueEndDate");
    
    //��ȡ��ͼ�鷵��ʱ�䷶Χ
    Timestamp returnBookStartDate=adjustDate(request,"returnBookStartDate");
    Timestamp returnBookEndDate=adjustDate(request,"returnBookEndDate");

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
     ArrayList<BorrowBook> bbooks=new ArrayList<BorrowBook>();
         
     pageCount=BorrowBookManager.getInstance().findBorrowBooks(bbooks, ids, rIds, 
                                                               keyWord, startODate, endODate,
                                                               bbookItemIds, bIds, state, 
                                                               sStartDate, sEndDate, 
                                                               overDueStartDate, overDueEndDate,
                                                               returnBookStartDate,returnBookEndDate,
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
               
         aObject.href="borrowBookSearchResult.jsp?pageNo="+pageNo+"&pageCount=<%=pageCount %><%="&"+strParamValues %>";
         linkClick(aObject);
	  }
	
	</script>

  </head>
  
  <body>
      <table border="1" align="center" >
      <tr>
        <th>�鵥ID</th>
        <th>��������</th>        		     
        <th width="730">�鵥��
            <table border="1" align="center" width="730">
	            <th width="50">������</th>
		        <th width="50">״̬��</th>
		        <th width="140">���ĳɹ�ʱ�䣺</th>
		        <th width="130">����ʱ�䣺</th>
		        <th width="130">����ʱ�䣺</th>
		        <th width="130">����</th>
		        <th width="50">ɾ��</th>
		        <th width="50">�޸�</th>
             </table>
        </th>
        <th>�鵥���ʱ�䣺</th>
        <th>�鵥����</th>
        <th>���</th>
        <th>��ӷ���</th>
        <th>ɾ��</th>
      </tr>
      <%
       
       for(Iterator<BorrowBook> it=bbooks.iterator();it.hasNext();){
              BorrowBook bbook=it.next();
              Reader r=new Reader();
              r.setId(bbook.getrId());
              ArrayList<BorrowBookItem> bbookItems=bbook.getBorrowBookItems();
            
       %>
       <tr>
        <td><%=bbook.getId() %></td>
        <td ><%=r.load().getrName() %></td>
        <td>        
	     <table border="1" align="center" width="730" >

       <%
          for(int i=0;i<bbookItems.size();i++){  
            BorrowBookItem bbookItem=bbookItems.get(i);
            Book b=BookManager.getInstance().loadById(bbookItem.getbId());
        %>

		       <tr>
		       <td width="50"><%=b.getBookName()%></td>
		       <td width="50"><%=(bbookItem.getState()==0)?"ԤԼ��":(bbookItem.getState()==1?"������":
		        (bbookItem.getState()==2?"����":"�ѻ�"))%>
		       </td>
		       <td width="140"><%=bbookItem.getoSuccessDate()==null?"&nbsp":bbookItem.getoSuccessDate() %></td>
		       <td width="130"><%=bbookItem.getoVerdueDate()==null?"&nbsp":bbookItem.getoVerdueDate() %></td>
		       <td width="130"><%=bbookItem.getReturnBookDate()==null?"&nbsp":bbookItem.getReturnBookDate() %></td>
		       <td width="130"><%=bbookItem.getbBIDesc()==null?"&nbsp":bbookItem.getbBIDesc() %></td>
		       <td width="50"><a href="../borrowBookItem/bBookItemDelete.jsp?bbookId=<%=bbook.getId() %>&bbookItemId=<%=bbookItem.getId() %>" target="detail">ɾ��</a></td>
		       <td width="50"><a href="../borrowBookItem/bBookItemModify.jsp?bbookId=<%=bbook.getId() %>&bbookItemId=<%=bbookItem.getId() %>" target="detail">�޸�</a></td>
		       </tr>

        <%} %>
          </table>  
         </td>  
          <td><%=bbook.getoDate() %>&nbsp</td>
          <td ><%=bbook.getbBdesc() %>&nbsp</td>
          <td ><a href="../borrowBookItem/bBookItemAdd.jsp?rId=<%=bbook.getrId() %>&bbookId=<%=bbook.getId() %>" target="detail">����鵥��</a><br/></td>
          <td ><a href="../ticket/ticketAdd.jsp?rId=<%=bbook.getrId() %>" target="detail">��ӷ���</a><br/></td>
          <td ><a href="borrowBookDelete.jsp?bbookId=<%=bbook.getId() %>" target="detail">ɾ��</a></td>
          
       </tr>
      <%
        
       }
       %>
    </table>    
                    ��<%=pageNo %>ҳ
                   ��<%=pageCount %>ҳ
      <a href="borrowBookSearchResult.jsp?pageNo=1&pageCount=<%=pageCount %><%="&"+strParamValues %>" onclick=" return linkClick(this)" >��ҳ</a>&nbsp            
      <a href="borrowBookSearchResult.jsp?pageNo=<%=pageNo-1 %>&pageCount=<%=pageCount %><%="&"+strParamValues %>" onclick=" return linkClick(this)">��һҳ</a>&nbsp
      
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
      <a href="borrowBookSearchResult.jsp?pageNo=<%=pageNo+1 %>&pageCount=<%=pageCount %><%="&"+strParamValues %>" onclick=" return linkClick(this)" >��һҳ</a>&nbsp
      <a href="borrowBookSearchResult.jsp?pageNo=<%=pageCount%>&pageCount=<%=pageCount %><%="&"+strParamValues %>" onclick=" return linkClick(this)" >ĩҳ</a>

  </body>
</html>
