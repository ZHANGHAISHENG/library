<%@ page language="java" import="java.util.*" pageEncoding="gb18030"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<HTML>

<HEAD>

<TITLE></TITLE>
<META http-equiv=Content-Type content="text/html; charset=gb2312">
<LINK href="script/style.css" type=text/css rel=stylesheet>
<SCRIPT LANGUAGE="JavaScript">
function frameCtrl(para){
	parent.parent.content.rows=para;
}
function dispmenu(){
		parent.mleft.cols='20%,*';
	    parent.mtitle.location.reload();
}
</script>
<META content="MSHTML 6.00.2600.0" name=GENERATOR></HEAD>
<BODY bgColor=#0096e1 leftMargin=0 topMargin=0 marginwidth="0" marginheight="0">
<table cellspacing=0 cellpadding=0 width="100%" border=0 class="header" height="20">
  <tbody> 
  <tr bgcolor="#0096e1"> 
    <td valign=middle noWrap width="98%" bgcolor="#0096e1">&nbsp;
			<a href="#"  onclick="dispmenu()">
			<img src="images/righticon.gif" border =0 alt="显示菜单列表" style="visibility:hidden" name="show">
			</a>
    </td>
    <td valign=middle noWrap width="2%" bgcolor="#0096e1">
    	<a href="#" onclick="frameCtrl('20,*,100%')"><img src="images/upcoin.gif" border=0 alt="全屏显示上半部分"></a>
    	&nbsp;
    	<a href="#" onclick="frameCtrl('20,100%,*')"><img src="images/downcoin.gif" border=0 alt="全屏显示下半部分"></a>
    	&nbsp;
    	<a href="#" onclick="frameCtrl('20,50%,*')"><img src="images/splitcoin.gif" border=0 alt="分屏显示"></a>
    	&nbsp;
    </td>
  </tr>
  </tbody> 
</table>
</BODY></HTML>
