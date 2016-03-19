<%@ page language="java" import="java.util.*" pageEncoding="GB18030"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%
request.setCharacterEncoding("GB18030");
int tId= Integer.parseInt(request.getParameter("tId"));
out.println("更新成功");
 %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <%-- <base href="<%=basePath%>"> --%>
    
    <title>My JSP 'updateSuccess.jsp' starting page</title>
    
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
     <script type="text/javascript">
	  var i=3;
      function go(){
           i--;
           document.getElementById("num").innerHTML="<font color='red' size='5'>"+i+"秒后实现跳转</font>";
           if(i<=0){
             window.location.href="../ticket/ticketDetail.jsp?tId="+<%=tId%>;
             window.clearInterval("go()");
           }
      
      }
      
      window.setInterval("go()", 1000);

    </script>
     <div>
       <span id="num"><font color="red" size="5">3秒后实现跳转</font></span>
     </div>
     
  </body>
</html>
