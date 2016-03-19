<%@ page language="java" import="java.util.*" pageEncoding="GB18030"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="manager.CategoryManager"%>
<%@ page import="bean.*"%>
<%@page import="manager.BookManager"%>
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
    
    //��ȡ�ؼ���
    String keyWord=request.getParameter("keyWord");
    if(keyWord!=null){
    keyWord=keyWord.trim();
    }
    
    //��ȡ���Id
    int cateId=Integer.parseInt(request.getParameter("cateId"));
    int[] cateIds=null;//��ʱΪ1
    System.out.println("cateId="+cateId);
    
    //��ȡ�ϼ����ڷ�Χ
    String strStartDate=request.getParameter("startDate");
    String strEndDate=request.getParameter("endDate");
    Timestamp startDate=null; 
    Timestamp endDate=null;
    
    //��ȡͼ������
    String strBookSum=request.getParameter("bookSum");
    String strUnUseBookSum=request.getParameter("unUseBookSum");
    
    int bookSum=0;
    int unUseBookSum=0;
    
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

    
    if(cateId!=0){
       cateIds=new int[1];
       cateIds[0]=cateId;
    }

    if(strStartDate!=null&&!strStartDate.trim().equals("")){
   
        if(strStartDate.matches("^\\s*\\d{4}-\\d{2}-\\d{2}\\s*$")){
           strStartDate=strStartDate.trim()+" 00:00:00";//ע�⣺�м�ֻ��һ���ո�
        }
        if(strStartDate.matches("^\\s*\\d{4}-\\d{2}-\\d{2}\\s\\d{2}\\:\\d{2}\\s*$")){
           strStartDate=strStartDate.trim()+":00";//ע�⣺�м�ֻ��һ���ո�
        }

        startDate=Timestamp.valueOf(strStartDate);
    }
    
    if(strEndDate!=null&&!strEndDate.trim().equals("")){
        if(strEndDate.matches("^\\s*\\d{4}-\\d{2}-\\d{2}\\s*$")){
           strEndDate=strEndDate.trim()+" 00:00:00";//ע�⣺�м�ֻ��һ���ո�
        }
        if(strEndDate.matches("^\\s*\\d{4}-\\d{2}-\\d{2}\\s\\d{2}\\:\\d{2}\\s*$")){
           strEndDate=strEndDate.trim()+":00";//ע�⣺�м�ֻ��һ���ո�
        }
        endDate=Timestamp.valueOf(strEndDate);
    }
    
    if(strBookSum!=null&&!strBookSum.trim().equals("")){
       bookSum=Integer.parseInt(strBookSum);
    }
    
    if(strUnUseBookSum!=null&&!strUnUseBookSum.trim().equals("")){
       unUseBookSum=Integer.parseInt(strUnUseBookSum);
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
     ArrayList<Book> books=new ArrayList<Book>();

     pageCount=BookManager.getInstance().finBooks(books,keyWord,cateIds, bookSum,unUseBookSum,startDate,endDate,
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
               
         aObject.href="bookSearchResult.jsp?pageNo="+pageNo+"&pageCount=<%=pageCount %><%="&"+strParamValues %>";
         linkClick(aObject);
	  }
	
	</script>

  </head>
  
  <body>
      <table border="1" align="center" >
      <tr>
        <th>iD</th>
        <th>�������</th>
        <th>ͼ������</th>
        <th>����</th>
        <th>�汾</th>
        <th>����</th>
        <th>ʣ��δʹ�õ�����</th>
        <th>�ϼ�ʱ��</th>
        <th>����</th>
        <th>�޸�</th>
        <th>ɾ��</th>
        <th>�������</th>
      </tr>
      <%
       
       for(Iterator<Book> it=books.iterator();it.hasNext();){
              Book b=it.next();     
       %>
       <tr>
        <td><%=b.getId() %></td>
        <td><%=CategoryManager.getInstance().loadById(b.getCateId()).getCateName() %></td>
        <td><%=b.getBookName() %></td>
        <td><%=b.getAuthorName() %></td>
        <td><%=b.getBookVersion() %></td>
        <td><%=b.getSum() %></td>
        <td><%=b.getUnUseBookSum() %></td>
        <td><%=b.getpDate() %></td>
        <td><%=b.getbDesc() %></td>
        <td><a href="bookUpdate.jsp?id=<%=b.getId() %>&cateId=<%=b.getCateId() %>" target="detail">����</a></td>
        <td><a href="bookDelete.jsp?id=<%=b.getId() %>" target="detail">ɾ��</a></td>
        <td><a href="bookBorrowImformation.jsp?id=<%=b.getId() %>" target="detail">�������</a></td>
      </tr>
      <%
        
       }
       %>
    </table>    
                    ��<%=pageNo %>ҳ
                   ��<%=pageCount %>ҳ
      <a href="bookSearchResult.jsp?pageNo=1&pageCount=<%=pageCount %><%="&"+strParamValues %>" onclick=" return linkClick(this)">��ҳ</a>&nbsp            
      <a href="bookSearchResult.jsp?pageNo=<%=pageNo-1 %>&pageCount=<%=pageCount %><%="&"+strParamValues %>" onclick=" return linkClick(this)">��һҳ</a>&nbsp
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
      <a href="bookSearchResult.jsp?pageNo=<%=pageNo+1 %>&pageCount=<%=pageCount %><%="&"+strParamValues %>" onclick=" return linkClick(this)">��һҳ</a>&nbsp
      <a href="bookSearchResult.jsp?pageNo=<%=pageCount%>&pageCount=<%=pageCount %><%="&"+strParamValues %>" onclick=" return linkClick(this)">ĩҳ</a>

  </body>
</html>
