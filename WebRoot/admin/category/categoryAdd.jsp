<%@page import="manager.CategoryManager"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="bean.Category"%>
<%@ page language="java" import="java.util.*" pageEncoding="GB18030"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%
   request.setCharacterEncoding("GB18030");
   String action=request.getParameter("action");
   String strPId=request.getParameter("pId");
   int pId=Integer.parseInt(strPId);
   %>
    <c:if test="${param.pId==0}"> <!-- 判断是否是menu.jsp中链接过来 -->
      <script src="../js/detailClear.js"></script>
    </c:if>
   <% 
   
   if(action!=null&&action.trim().equals("categoryAdd")){
      Category c=new Category();
      String cateName=request.getParameter("cateName");
      String cateDescr=request.getParameter("cateDescr");
     
      c.setPid(pId);
      c.setCateName(cateName);
      c.setIsleaf(0);
      c.setPdate(new Timestamp(System.currentTimeMillis()));
      c.setCateDesc(cateDescr);
      CategoryManager.getInstance().addChild(c);
      out.println("类别添加成功！");
      if(pId!=0){
          
        %>
           
        <script>
        window.parent.main.location.reload();
       </script>
      <% }


}%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  <%--   <base href="<%=basePath%>">  --%>
    
    <title>My JSP 'categoryAdd.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

    <script src="../js/categoryCheckData.js"></script>
   

  </head>

  <body>
    <center><h1>添加类别</h1></center>
     <form  id="form" action="categoryAdd.jsp" method="post" onsubmit="return isvalidate" >
     <input type="hidden" name="action" value="categoryAdd"></input>
     <input type="hidden" name="pId" value=<%=strPId %>></input>

       <table align="center" border="1">
        <tr>
          <td>类别名称</td>
          <td>
             <input type="text" id="cateName" name="cateName" size="50" onblur="validate()"></input>
             <span id="cateNameTip"></span>
          </td>
        </tr>
        
        <tr>
          <td>类别描叙</td>
          <td><textarea  id="cateDescr" name="cateDescr" rows="20"  cols="50"></textarea></td>
        </tr>
        
        <tr align="center">
           <td colspan="2"><input type="submit" value="添加" ></td>
        </tr>
      
      </table>
         
     </form>
      
  </body>
</html>
