<%@ page language="java" import="java.util.*" pageEncoding="gb18030"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>

<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link rel="stylesheet" href="script/style.css" type="text/css">
</head>
<script >
var i=1;
function hidemenu(){
     
	 parent.mleft.cols='*,100%';
	 parent.mtitle.show.style.visibility="visible";
	 //parent.mtitle.location.reload();会导致parent.mtitle.show.style.visibility="visible";失效
     
}
</script>
<body bgcolor="#0096e1" text="#000000">
<table width="100%" border="0" cellspacing="0" cellpadding="0" height="100%">

  <tr valign="bottom" align="right"> 
    <td colspan="3" height="40" bgcolor="#0096e1">
	<a href="#" onclick="hidemenu()"><img src="images/lefticon.gif" border=0 alt="隐藏菜单列表"></a>&nbsp;</td>
  </tr>

  <tr> 
    <td width="96%" bgcolor='#9CF'>
	   <IFRAME  name="LIST" WIDTH="100%" HEIGHT="100%" MARGINWIDTH=0 MARGINHEIGHT=0 HSPACE=0    VSPACE=0 FRAMEBORDER=0 SCROLLING=auto SRC="adminTree.jsp"> 
      </IFRAME>
	 </td>
  </tr>

</table>
</body>
</html>


