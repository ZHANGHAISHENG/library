<%@page import="manager.CategoryManager"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="bean.Category"%>
<%@ page language="java" import="java.util.*" pageEncoding="GB18030"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%

   request.setCharacterEncoding("GB18030");
   String action=request.getParameter("action");
   String strId=request.getParameter("id");
   int id=Integer.parseInt(strId);
   String strPId=request.getParameter("pId");
   int pId=Integer.parseInt(strPId);
   Category c;
   
   if(action!=null&&action.trim().equals("categoryModify")){
      c=new Category();
      String cateName=request.getParameter("cateName");
      String cateDescr=request.getParameter("cateDescr");
     
      c.setId(id);
      c.setCateName(cateName);

      c.setPdate(new Timestamp(System.currentTimeMillis()));
      c.setCateDesc(cateDescr);
      CategoryManager.getInstance().modifyCategory(c);
      out.println("类别修改成功!");%>
      
       <script>
        window.parent.main.location.reload();
      </script>

<% }else{
  c= CategoryManager.getInstance().loadById(id);
}%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
<%--  <base href=<%=basePath%>> --%>
    
    <title>My JSP 'categoryModify.jsp' starting page</title>
    
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
  
    <center><h1>修改类别</h1></center>
     <form  id="form" action="categoryModify.jsp" method="post" onsubmit="return isvalidate"  >
     <input type="hidden" name="action" value="categoryModify"></input>
     <input type="hidden" name="id" value=<%=strId %>></input>
     <input type="hidden" name="pId" value=<%=strPId %>></input><!-- 只用于validate()判断父类别下是否存在修改后的类别名称 -->
       <table align="center" border="1">
        <tr>
          <td>类别名称</td>
          <td>
             <input type="text" id="cateName" name="cateName" size="50" value=<%=c.getCateName()%> onblur="validate()"></input>
             <span id="cateNameTip"></span>
          </td>
        </tr>
        
        <tr>
          <td>类别描叙</td>
          <td><textarea  id="cateDescr" name="cateDescr" rows="20"  cols="50"><%=c.getCateDesc() %> </textarea></td>
        </tr>
        
        <tr align="center">
           <td colspan="2"><input type="submit" value="提交" ></td>
        </tr>
      
      </table>
         
     </form>
      
  </body>
</html>
