<%@ page language="java" import="java.util.*" pageEncoding="GB18030"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>



<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
<%--     <base href="<%=basePath%>"> --%>
    
    <title>My JSP 'borrowBookAddSuccess.jsp' starting page</title>
    
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
     ԤԼ����ͼ��ʧ�ܣ�<br/>
     <script type="text/javascript">
	  var i=3;
      function go(){
           i--;
           document.getElementById("num").innerHTML="<font color='red' size=10>"+i+"</font>���ʵ����ת,����ת���ɹ�������������:";
           if(i<=0){
             window.location.href="bookBasket.jsp";
             window.clearInterval("go()");
           }
      
      }
    window.setInterval("go()", 1000);
    </script>
        
    <div id="num">
       <span><font color='red' size=10>3</font>���ʵ����ת,����ת���ɹ�������������:</span>
    </div>
    <a href="bookBasket.jsp">�����ת</a>
  </body>
</html>
