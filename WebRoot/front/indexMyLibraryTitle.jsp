<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" import="java.util.*" pageEncoding="GB18030"%>
<%@page import="manager.ReaderManager"%>
<%@page import="bean.*"%>

<%
 request.setCharacterEncoding("GB18030");
%>
<html >
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>indexMyLibraryTitle</title>
</head>

<body bgcolor="#0066FF">
<div id="title" align="center" style="width: 1200 ">
  <div id="titleImg" >
   <img src="images/myLibrary.PNG" width="1200" height="113" alt="��" />
  </div>
  <div id="titleMenu"  >
    <table width="1268" border="0" bgcolor="#99CC00">
      <tr>
        <td width="100" align="left"><a href="exist.jsp" target="mainFrame">�˳�</a></td>
        <td width="215" align="center"><a href="book/bookSearch.jsp" target="mainFrame">��Ŀ����</a></td>
        <td width="215" align="center"><a href="book/bookSortList.jsp" target="mainFrame">��������0�8</a></td>
        <td width="215" align="center"><a href="borrowBook/bookBasket.jsp" target="mainFrame">�ҵ�������</a></td>
        <td width="320" align="center"><a href="borrowBook/historySearch.jsp?" target="mainFrame">������ʷ��¼</a></td>
        <td width="320" align="center">&nbsp;</td>
        <td width="320" align="center"><a href="selfService/readerModify.jsp?" target="mainFrame">�Է���</a></td>
      </tr>
    </table>
  </div> 

</div>
</body>
</html>
