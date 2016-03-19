<%@page import="manager.CategoryManager"%>
<%@ page language="java" import="java.util.*" pageEncoding="GB18030"%>
<%@page import="bean.*"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<%
 List<Category> categorys=CategoryManager.getInstance().getCategoryTree(0);

 %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <%-- <base href="<%=basePath%>"> --%>
    
    <title>My JSP 'CategoryList.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<script language="javascript" src="../js/TV20.js"></script>
	
	<script language="javascript">
	 var isVisible=false;
     function t(key,parentKey){

          window.parent.frames["bSlistRight"].location.href="../book/bookSearchResult.jsp?cateId="+key;
          
          
     }
     
	</script>

  </head>
  
  <body >
      
      <script language="javascript">

     addNode(-1,0,"È«²¿","../images/top.gif");
    
    <%
     for(Iterator<Category> it=categorys.iterator();it.hasNext();){
      Category c=it.next();
    %>
     addNode(<%=c.getPid() %>,<%=c.getId() %>,"<%=c.getCateName() %>","../images/top.gif");
    <%}%>

	showTV();
	
	addListener( "dblclick" , "modify" );
	addListener( "click" , "t" );

    </script>
 
  </body>
</html>
