<%@page import="com.sun.faces.renderkit.html_basic.HtmlBasicRenderer.Param"%>
<%@ page language="java" import="java.util.*" pageEncoding="GB18030"%>
<%@page import="manager.*"%>
<%@page import="java.sql.Timestamp"%>
<%@ page import="bean.*"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<%
    request.setCharacterEncoding("GB18030");
    Reader reader=(Reader)session.getAttribute("reader"); 
    int pageNo=1;
    int pageSize=10;
    int pageCount=0;
    
    String strPageNo=request.getParameter("pageNo");
    String strPageCount=request.getParameter("pageCount");
    String strParamValues="";
    
    int  state=Integer.parseInt(request.getParameter("state"));

    //��ȡrIds
    String[] rIds={reader.getId()};

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
     pageCount=BorrowBookManager.getInstance().getBorrowBookByRIdsAndState(bbooks, rIds,state, pageNo, pageSize);


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
               
         aObject.href="history.jsp?pageNo="+pageNo+"&pageCount=<%=pageCount %><%="&"+strParamValues %>";
         linkClick(aObject);
	  }
	
	</script>

  </head>
  
  <body>
  
      <form  name="form" id="form" action="history.jsp" method="post">
          <select name="state">
              <option value="-1" ${param.state==-1? "selected":""}>ȫ��</option>
              <option value="0"  ${param.state==0? "selected":""}>ԤԼ��</option>
              <option value="1"  ${param.state==1? "selected":""}>������</option>
              <option value="2"  ${param.state==2? "selected":""}>�ѳ���</option>
              <option value="3"  ${param.state==3? "selected":""}>�ѻ�</option>
          </select>
         <input type="submit" value="ȷ��"></input>
      </form>
       

      <table border="1" align="center" >
      <tr>
        <th>�鵥ID</th>
        <th>��������</th>        		     
        <th width="730">�鵥��
            <table border="1" align="center" width="730">
	            <th width="100">������</th>
		        <th width="100">״̬��</th>
		        <c:choose>
                  <c:when test="${param.state==-1}" >
                    <th width="140">����ʱ�䣺</th>
			        <th width="130">����ʱ�䣺</th>
			        <th width="130">����ʱ�䣺</th>
                  </c:when>
                  <c:otherwise>
                       <c:choose>
		                  <c:when test="${param.state==1}" >
		                    <th width="140">����ʱ�䣺</th>
		                  </c:when>
		                  <c:otherwise>
		                      <c:choose>
				                  <c:when test="${param.state==2}" >
				                    <th width="130">����ʱ�䣺</th>
				                  </c:when>
				                  <c:otherwise>
				                       <c:if test="${param.state==3}">
				                          <th width="130">����ʱ�䣺</th>
				                       </c:if>
				                      
				                  </c:otherwise>
		                      </c:choose>
		                  </c:otherwise>
	                  </c:choose>
                  </c:otherwise>
               </c:choose>
		        
		        <th width="130">����</th>
             </table>
        </th>
        <th>ԤԼʱ�䣺</th>
        <th>�鵥����</th>

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
		       <td width="100"><%=b.getBookName()%></td>
		       <td width="100"><%=(bbookItem.getState()==0)?"ԤԼ��":(bbookItem.getState()==1?"������":
		        (bbookItem.getState()==2?"����":"�ѻ�"))%>
		       </td>
		      <c:choose>
                  <c:when test="${param.state==-1}" >
                    <td width="140"><%=bbookItem.getoSuccessDate()==null?"":bbookItem.getoSuccessDate()%>&nbsp</td>
		            <td width="130"><%=bbookItem.getoVerdueDate()==null?"":bbookItem.getoVerdueDate() %>&nbsp</td>
		            <td width="130"><%=bbookItem.getReturnBookDate()==null?"":bbookItem.getReturnBookDate()%>&nbsp</td>
                  </c:when>
                  <c:otherwise>
                       <c:choose>
		                  <c:when test="${param.state==0}" >
		                    <td width="140"><%=bbookItem.getoSuccessDate()==null?"":bbookItem.getoSuccessDate() %>&nbsp</td>
		                  </c:when>
		                  <c:otherwise>
		                      <c:choose>
				                  <c:when test="${param.state==1}" >
				                    <td width="130"><%=bbookItem.getoVerdueDate()==null?"":bbookItem.getoVerdueDate() %>&nbsp</td>
				                  </c:when>
				                  <c:otherwise>
				                      <td width="130"><%=bbookItem.getReturnBookDate()==null?"":bbookItem.getReturnBookDate() %>&nbsp</td>
				                  </c:otherwise>
		                      </c:choose>
		                  </c:otherwise>
	                  </c:choose>
                  </c:otherwise>
               </c:choose>
		      
		       <td width="130">
		         <%if(bbookItem.getbBIDesc()!=null&&!bbookItem.getbBIDesc().trim().equals("null")){ %>
		            <%=bbookItem.getbBIDesc()%>
		         <%} %>
		      &nbsp</td>
		
		   </tr>
   
        <%} %>
          </table>  
         </td>  
          <td><%=bbook.getoDate()==null?"":bbook.getoDate()%>&nbsp</td>
          <td >
           <%if(bbook.getbBdesc()!=null&&!bbook.getbBdesc().trim().equals("null")){ %>
		            <%=bbook.getbBdesc()%>
		         <%} %>&nbsp
		   </td>
       </tr>
      <%
        
       }
       %>
     </table>
     <center>  
                    ��<%=pageNo %>ҳ
                   ��<%=pageCount %>ҳ
      <a href="history.jsp?pageNo=1&pageCount=<%=pageCount %><%="&"+strParamValues %>" onclick=" return linkClick(this)" >��ҳ</a>&nbsp            
      <a href="history.jsp?pageNo=<%=pageNo-1 %>&pageCount=<%=pageCount %><%="&"+strParamValues %>" onclick=" return linkClick(this)">��һҳ</a>&nbsp
      
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
      
      <a href="history.jsp?pageNo=<%=pageNo+1 %>&pageCount=<%=pageCount %><%="&"+strParamValues %>" onclick=" return linkClick(this)" >��һҳ</a>&nbsp
      <a href="history.jsp?pageNo=<%=pageCount%>&pageCount=<%=pageCount %><%="&"+strParamValues %>" onclick=" return linkClick(this)" >ĩҳ</a>
      </center>
  </body>
</html>
