<%@page import="bean.Administrator"%>
<%@page language="java" import="java.util.*" pageEncoding="GB18030"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%
  request.setCharacterEncoding("GB18030");
  Administrator admin=(Administrator)session.getAttribute("admin");
 %>
<HTML>
<HEAD>

<TITLE></TITLE>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<SCRIPT LANGUAGE="JavaScript" src="js/AdminTree.js"></script>
<STYLE TYPE='text/css'>
.level1 {margin-left:30;cursor:pointer}
.level2 {display:none;margin-left:38;cursor:pointer}
DIV.level1 a:hover {  font-family: "宋体"; font-size: 15pt; color: #0099FF}
DIV.level2 a:hover {  font-family: "宋体"; font-size: 15pt; color: red}
</STYLE>
</HEAD>
<BODY >
<DIV CLASS="level1" ID='Parent1'>
	<A class=OUTDENT  id="" onclick="return expandIt('1')" ><IMG border=0 name=imEx  src="images/arrowUp.gif" id="p1i"> 读者管理</a>
</DIV>

<DIV CLASS="level2" ID='P1Child1'>
    <A href="reader/readerAdd.jsp" id="p1c1a1" target=main><LI>读者注册</LI></a>
<!-- 	<A href="reader/readerList.jsp" id="p1c1a2" target=main ><LI>读者列表</LI></a> -->
	<A href="reader/readerSearch.jsp" id="p1c1a3" target=main><LI>搜索读者</LI></a>

</DIV>

<DIV CLASS="level1" ID='Parent2'>
	<A class=OUTDENT  id="" onclick="return expandIt('2')"><IMG border=0 name=imEx  src="images/arrowUp.gif" id="p2i"> 图书管理</a>
</DIV>

<DIV CLASS="level2" ID='P2Child1'>
	<A href="book/bookAdd.jsp" id="p2c1a1" target=main><LI>图书添加</LI></a>
<!-- 	<A href="book/bookUpdate.jsp" id="p2c1a2" target=main><LI>图书更改</LI></a>
	<A href="book/bookDelete.jsp" id="p2c1a3" target=main><LI>图书删除</LI></a> -->
	<A href="book/bookSortList.jsp" id="p2c1a4" target=main ><LI>图书分类搜索</LI></a>
	<A href="book/bookSearch.jsp" id="p2c1a5" target=main><LI>图书搜索</LI></a>
</DIV>



<DIV CLASS="level1" ID='Parent3'>
	<A class=OUTDENT  id="" onclick="return expandIt('3')" ><IMG border=0 name=imEx  src="images/arrowUp.gif" id="p3i"> 类别管理</a>
</DIV>

<DIV CLASS="level2" ID='P3Child1'>
	<A href="category/categoryList.jsp" id="p3c1a1" target=main ><LI>类别显示</LI></a>
	<A href="category/categoryListTv.jsp" id="p3c1a2" target=main><LI>类别显示TV</LI></a>
	<A href="category/categoryAdd.jsp?pId=0" id="p3c1a3" target=main ><LI>类别添加</LI></a>
	

</DIV>




<DIV CLASS="level1" ID='Parent4'>
	<A class=OUTDENT  id="" onclick="return expandIt('4')"><IMG border=0 name=imEx  src="images/arrowUp.gif" id="p4i">借阅管理</a>
</DIV>

<DIV CLASS="level2" ID='P4Child1'>
<!-- 	<A href="borrowBook/borrowBookList.jsp" id="p4c1a1" target=main ><LI>查看所有的借书书单</LI></a> -->
	<A href="borrowBook/borrowBookAdd.jsp" id="p4c1a2" target=main><LI>添加借书的书单</LI></a>
<!-- 	<A href="borrowBook/borrowBookModify.jsp" id="p4c1a3" target=main><LI>修改借书的书单子项目</LI></a> -->
<!-- 	<A href="borrowBook/borrowBookDelete.jsp" id="p4c1a4" target=main><LI>删除书单</LI></a> -->
	<A href="borrowBook/borrowBookSearch.jsp" id="p4c1a4" target=main><LI>搜索书单 </LI></a>
	<A href="borrowBook/report.jsp" id="p4c1a4" target=main><LI>图书借阅统计</LI></a>
</DIV>

<DIV CLASS="level1" ID='Parent5'>
	<A class=OUTDENT  id="" onclick="return expandIt('5')"><IMG border=0 name=imEx  src="images/arrowUp.gif" id="p5i"> 罚单管理</a>
</DIV>

<DIV CLASS="level2" ID='P5Child1'>
	<A href="ticket/ticketAdd.jsp" id="p5c1a1" target=main><LI>开罚单</LI></a>
<!-- 	<A href="ticket/ticketList.jsp" id="p5c1a2" target=main><LI>罚单列表</LI></a>
 -->
	<A href="ticket/ticketSearch.jsp" id="p5c1a3" target=main><LI>罚单搜索</LI></a>
</DIV>

 <%if(admin.getIsRoot()==1){%>  
<DIV CLASS="level1" ID='Parent6'>
	<A class=OUTDENT  id="" onclick="return expandIt('6')"><IMG border=0 name=imEx  src="images/arrowUp.gif" id="p6i">管理员管理</a>
</DIV>

<DIV CLASS="level2" ID='P6Child1'>
	<A href="manager/adminAdd.jsp" id="p6c1a1" target=main><LI>添加管理员</LI></a>
<!-- 	<A href="manager/adminList.jsp" id="p6c1a2" target=main><LI>管理员列表</LI></a>
 -->
	<A href="manager/adminSearch.jsp" id="p6c1a3" target=main><LI>管理员搜索</LI></a>
</DIV>

 <% } %>  
</BODY>
</html>
