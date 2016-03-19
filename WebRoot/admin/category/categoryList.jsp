<script src="../js/detailClear.js"></script>
<%@ page language="java" import="java.util.*" pageEncoding="GB18030"%>
<%@page import="manager.*" %>
<%@page import="bean.*" %>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<%

 request.setCharacterEncoding("GB18030");

 List<Category> cates=CategoryManager.getInstance().getCategoryTree(0);
 
 
 
 %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
   <%--  <base href="<%=basePath%>"> --%>
    
    <title>My JSP 'categoryList.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
  <body>
    <center><h1>类别列表</h1></center>
     <table border="1" align="center" >
      <tr>
        <th>ID</th>
        <th>父类别 ID</th>
        <th>名称</th>
        <th>级别</th>
        <th>添加时间</th>
        <th>添加子类别</th>
        <th>修改</th>
        <th>删除</th>
        <th>添加图书</th>
        <th>描叙</th>
        
        
      </tr>
      <%
       String preStr;
       for(Iterator<Category> it=cates.iterator();it.hasNext();){
       
           Category c=it.next(); 
            preStr="";
           for(int i=1;i<c.getGrade();i++){
           preStr+="--";
           }
           
       %>
       <tr>
        <td><%=c.getId() %></td>
        <td><%=c.getPid() %></td>
        <td><%=preStr+c.getCateName() %></td>
        <td><%=c.getGrade()%></td>
        <td><%=c.getPdate() %></td>
        <td><a  href="categoryAdd.jsp?pId=<%=c.getId()%>" target="detail">添加子类别</a></td>
        <td><a  href="categoryModify.jsp?id=<%=c.getId() %>&pId=<%=c.getPid() %>" target="detail" >修改</a></td>
        <td><a  href="categoryDelete.jsp?id=<%=c.getId() %>&pId=<%=c.getPid() %>" target="detail" >删除类别</a></td>
        
        <%
           if(c.getIsleaf()==0){
         %>
        <td><a href="../book/bookAdd.jsp?cateId=<%=c.getId() %>" target="detail">再此类别中添加图书</a></td>
        <%
          }else{
          %>
          <td>------------------</td>
         <%} %>   

         <td><%=c.getCateDesc() %></td>
        
      </tr>
      <%
       }
       %>
    </table>
  </body>
</html>
