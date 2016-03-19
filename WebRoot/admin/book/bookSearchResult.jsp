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
    
    //获取关键字
    String keyWord=request.getParameter("keyWord");
    if(keyWord!=null){
    keyWord=keyWord.trim();
    }
    
    //获取类别Id
    int cateId=Integer.parseInt(request.getParameter("cateId"));
    int[] cateIds=null;//暂时为1
    System.out.println("cateId="+cateId);
    
    //获取上架日期范围
    String strStartDate=request.getParameter("startDate");
    String strEndDate=request.getParameter("endDate");
    Timestamp startDate=null; 
    Timestamp endDate=null;
    
    //获取图书数量
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
           strStartDate=strStartDate.trim()+" 00:00:00";//注意：中间只有一个空格
        }
        if(strStartDate.matches("^\\s*\\d{4}-\\d{2}-\\d{2}\\s\\d{2}\\:\\d{2}\\s*$")){
           strStartDate=strStartDate.trim()+":00";//注意：中间只有一个空格
        }

        startDate=Timestamp.valueOf(strStartDate);
    }
    
    if(strEndDate!=null&&!strEndDate.trim().equals("")){
        if(strEndDate.matches("^\\s*\\d{4}-\\d{2}-\\d{2}\\s*$")){
           strEndDate=strEndDate.trim()+" 00:00:00";//注意：中间只有一个空格
        }
        if(strEndDate.matches("^\\s*\\d{4}-\\d{2}-\\d{2}\\s\\d{2}\\:\\d{2}\\s*$")){
           strEndDate=strEndDate.trim()+":00";//注意：中间只有一个空格
        }
        endDate=Timestamp.valueOf(strEndDate);
    }
    
    if(strBookSum!=null&&!strBookSum.trim().equals("")){
       bookSum=Integer.parseInt(strBookSum);
    }
    
    if(strUnUseBookSum!=null&&!strUnUseBookSum.trim().equals("")){
       unUseBookSum=Integer.parseInt(strUnUseBookSum);
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
        <th>所属类别</th>
        <th>图书名称</th>
        <th>作者</th>
        <th>版本</th>
        <th>总量</th>
        <th>剩余未使用的总量</th>
        <th>上架时间</th>
        <th>描叙</th>
        <th>修改</th>
        <th>删除</th>
        <th>借阅情况</th>
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
        <td><a href="bookUpdate.jsp?id=<%=b.getId() %>&cateId=<%=b.getCateId() %>" target="detail">更新</a></td>
        <td><a href="bookDelete.jsp?id=<%=b.getId() %>" target="detail">删除</a></td>
        <td><a href="bookBorrowImformation.jsp?id=<%=b.getId() %>" target="detail">借阅情况</a></td>
      </tr>
      <%
        
       }
       %>
    </table>    
                    第<%=pageNo %>页
                   共<%=pageCount %>页
      <a href="bookSearchResult.jsp?pageNo=1&pageCount=<%=pageCount %><%="&"+strParamValues %>" onclick=" return linkClick(this)">首页</a>&nbsp            
      <a href="bookSearchResult.jsp?pageNo=<%=pageNo-1 %>&pageCount=<%=pageCount %><%="&"+strParamValues %>" onclick=" return linkClick(this)">上一页</a>&nbsp
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
      <a href="bookSearchResult.jsp?pageNo=<%=pageNo+1 %>&pageCount=<%=pageCount %><%="&"+strParamValues %>" onclick=" return linkClick(this)">下一页</a>&nbsp
      <a href="bookSearchResult.jsp?pageNo=<%=pageCount%>&pageCount=<%=pageCount %><%="&"+strParamValues %>" onclick=" return linkClick(this)">末页</a>

  </body>
</html>
