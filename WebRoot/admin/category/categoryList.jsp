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
    <center><h1>����б�</h1></center>
     <table border="1" align="center" >
      <tr>
        <th>ID</th>
        <th>����� ID</th>
        <th>����</th>
        <th>����</th>
        <th>���ʱ��</th>
        <th>��������</th>
        <th>�޸�</th>
        <th>ɾ��</th>
        <th>���ͼ��</th>
        <th>����</th>
        
        
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
        <td><a  href="categoryAdd.jsp?pId=<%=c.getId()%>" target="detail">��������</a></td>
        <td><a  href="categoryModify.jsp?id=<%=c.getId() %>&pId=<%=c.getPid() %>" target="detail" >�޸�</a></td>
        <td><a  href="categoryDelete.jsp?id=<%=c.getId() %>&pId=<%=c.getPid() %>" target="detail" >ɾ�����</a></td>
        
        <%
           if(c.getIsleaf()==0){
         %>
        <td><a href="../book/bookAdd.jsp?cateId=<%=c.getId() %>" target="detail">�ٴ���������ͼ��</a></td>
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
