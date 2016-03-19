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

    //获取rIds
    String[] rIds={reader.getId()};

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
              <option value="-1" ${param.state==-1? "selected":""}>全部</option>
              <option value="0"  ${param.state==0? "selected":""}>预约中</option>
              <option value="1"  ${param.state==1? "selected":""}>借阅中</option>
              <option value="2"  ${param.state==2? "selected":""}>已超期</option>
              <option value="3"  ${param.state==3? "selected":""}>已还</option>
          </select>
         <input type="submit" value="确定"></input>
      </form>
       

      <table border="1" align="center" >
      <tr>
        <th>书单ID</th>
        <th>读者名称</th>        		     
        <th width="730">书单项
            <table border="1" align="center" width="730">
	            <th width="100">书名：</th>
		        <th width="100">状态：</th>
		        <c:choose>
                  <c:when test="${param.state==-1}" >
                    <th width="140">借阅时间：</th>
			        <th width="130">超期时间：</th>
			        <th width="130">还书时间：</th>
                  </c:when>
                  <c:otherwise>
                       <c:choose>
		                  <c:when test="${param.state==1}" >
		                    <th width="140">借阅时间：</th>
		                  </c:when>
		                  <c:otherwise>
		                      <c:choose>
				                  <c:when test="${param.state==2}" >
				                    <th width="130">超期时间：</th>
				                  </c:when>
				                  <c:otherwise>
				                       <c:if test="${param.state==3}">
				                          <th width="130">还书时间：</th>
				                       </c:if>
				                      
				                  </c:otherwise>
		                      </c:choose>
		                  </c:otherwise>
	                  </c:choose>
                  </c:otherwise>
               </c:choose>
		        
		        <th width="130">描叙</th>
             </table>
        </th>
        <th>预约时间：</th>
        <th>书单描叙</th>

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
		       <td width="100"><%=(bbookItem.getState()==0)?"预约中":(bbookItem.getState()==1?"借阅中":
		        (bbookItem.getState()==2?"超期":"已还"))%>
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
                    第<%=pageNo %>页
                   共<%=pageCount %>页
      <a href="history.jsp?pageNo=1&pageCount=<%=pageCount %><%="&"+strParamValues %>" onclick=" return linkClick(this)" >首页</a>&nbsp            
      <a href="history.jsp?pageNo=<%=pageNo-1 %>&pageCount=<%=pageCount %><%="&"+strParamValues %>" onclick=" return linkClick(this)">上一页</a>&nbsp
      
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
      
      <a href="history.jsp?pageNo=<%=pageNo+1 %>&pageCount=<%=pageCount %><%="&"+strParamValues %>" onclick=" return linkClick(this)" >下一页</a>&nbsp
      <a href="history.jsp?pageNo=<%=pageCount%>&pageCount=<%=pageCount %><%="&"+strParamValues %>" onclick=" return linkClick(this)" >末页</a>
      </center>
  </body>
</html>
