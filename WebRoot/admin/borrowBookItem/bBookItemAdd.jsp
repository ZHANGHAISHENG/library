<%@page import="manager.BorrowBookItemManager"%>
<%@page import="bean.*"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" import="java.util.*" pageEncoding="GB18030"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%
  request.setCharacterEncoding("GB18030");
  String action=request.getParameter("action");
  int bbookId=Integer.parseInt(request.getParameter("bbookId"));
  String rId=request.getParameter("rId");
  if(action!=null&&action.trim().equals("bbookItemAdd")){
      //书单参数
       BorrowBook bbook=new BorrowBook();
       
       bbook.setId(bbookId);
             //书单项参数
      String[] strBIds=request.getParameter("bIds").split(";");
      int[] bIds=new int[strBIds.length];
      for(int i=0;i<strBIds.length;i++){
         bIds[i]=Integer.parseInt(strBIds[i]);
      }
      int state=0;
      Timestamp oSuccessDate=null;
      Timestamp overdueDate=null;
      Timestamp returnBookDate=null;
      String bbiDesc=request.getParameter("bbiDesc");
      
	  //书单项    
	  ArrayList<BorrowBookItem> bbookItems=new ArrayList<BorrowBookItem>();
	
	  for(int i=0;i<strBIds.length;i++){
	    BorrowBookItem bbookItem=new BorrowBookItem();
	    bbookItem.setbId(bIds[i]);
	    bbookItem.setState(state);
	    bbookItem.setoSuccessDate(oSuccessDate);
	    bbookItem.setoVerdueDate(overdueDate);
	    bbookItem.setReturnBookDate(returnBookDate);
	    bbookItem.setbBIDesc(bbiDesc);
	    bbookItems.add(bbookItem);
	  }
	  
	  bbook.setBorrowBookItems(bbookItems);
	  
     if( BorrowBookItemManager.getInstance().addBorrowBookItems(bbook, bbookItems)){
        out.println("添加书单成功");
     %>
     <script>
       window.parent.main.location.reload();
     </script>
     <%
     }else{
        out.println("添加书单失败");
        
      }
  }
  
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
 <%--    <base href="<%=basePath%>"> --%>
    
    <title>My JSP 'bBookItemDelete.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
    <script src="../js/BorrowBookCheckData.js"></script>
  </head>
  
  <body>
       <center>
		 <h1>添加借书书单</h1>
	  </center>
      <form name="form" id="form" action="bBookItemAdd.jsp" method="post" onsubmit="return checkDate()">
          <input type="hidden"  name="action" value="bbookItemAdd"></input>
          <input type="hidden"  name="bbookId" value=<%=bbookId%>></input>
          <input type="hidden"  name="rId"  id="rId" value=<%=rId%>></input>
          <table align="center">
               
                <tr>
                  <td>读者ID：</td>
                  <td><input type="text" size="30"  value=<%=rId %>  disabled="disabled"></input>
                  <span id="bbIdTip"></span>
                  </td>
               </tr>
               <tr>
                  <td>书单ID：</td>
                  <td><input type="text" size="30"  value=<%=bbookId %> disabled="disabled"></input>
                  <span id="bbIdTip"></span>
                  </td>
               </tr>
               
               <tr>
                  <td>书ID:<br/>
                      (例：123;145;456...)：
                  </td>
                  <td><input type="text" size="30" name="bIds" id="bIds" onblur="checkForBIds()"></input>
                   <span id="bIdsTip"></span>
                   </td>
               </tr>
               

				<tr>
					<td>书单项描述:</td>
					<td>
						<textarea name="bbiDesc" id="bbiDesc" rows="5"
							cols="50">
						</textarea>
					</td>
				</tr>
					

				<tr align="center">
					<td colspan="2">
						<input type="submit" value="提交" >
					</td>
				</tr>
          </table>
      </form>
  </body>
</html>
