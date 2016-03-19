<%@page import="manager.CategoryManager"%>
<%@ page language="java" import="java.util.*" pageEncoding="GB18030"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%
   request.setCharacterEncoding("GB18030");
   

   int id=Integer.parseInt(request.getParameter("id"));
   int pId=Integer.parseInt(request.getParameter("pId"));
   String action =request.getParameter("action");
   System.out.println("id="+id+"  pId="+pId);
   
   if(action!=null&&action.trim().equals("sure")){
       if(CategoryManager.getInstance().deleteCateById(id,pId)){
       out.println("类别删除成功"); 
	   %>
	     <script>
	        window.parent.main.location.reload();
	      </script>
	   <%
	   }else{
	     out.println("类别删除失败");
	   } 
     return ;
   }
  
 %>
     
   
  
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
   <%--  <base href="<%=basePath%>"> --%>
      
    <title>My JSP 'CategoryDelete.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<script>
	  function make_confirm(){
	      var b=confirm("该类别下可能含有子类别或图书,确定要删除吗？");
	      if(b){
	         document.getElementById("form").submit();
	      } 
	  }
	
	</script> 

  </head>
  
  <body onload="return make_confirm()">
  
     <form id="form" action="categoryDelete.jsp"  method="post" >
     
        <input type="hidden" name="action" value="sure"></input>
        <input type="hidden" name="id" value=<%=id %>></input>
        <input type="hidden" name="pId" value=<%=pId %>></input>

     </form>

  </body>
</html>
