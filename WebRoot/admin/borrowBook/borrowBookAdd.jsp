<script src="../js/detailClear.js"></script>
<%@page import="manager.BorrowBookManager"%>
<%@page import="bean.BorrowBookItem"%>
<%@page import="bean.BorrowBook"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" import="java.util.*" pageEncoding="GB18030"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<%
  request.setCharacterEncoding("GB18030");
  String action=request.getParameter("action");

  if(action!=null&&action.trim().equals("bbookAdd")){
      //�鵥����
      String rId=request.getParameter("rId");
      Timestamp oDate=new Timestamp(System.currentTimeMillis());
      String bbDesc=request.getParameter("bbDesc");
      
      //�鵥�����
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
      
      //�鵥
      BorrowBook bbook=new BorrowBook();
	      bbook.setrId(rId);
	      bbook.setoDate(oDate);
	      bbook.setbBdesc(bbDesc);
	  
	  //�鵥��    
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
	  
     if( BorrowBookManager.getInstance().addBorrowBook(bbook)){
        out.println("����鵥�ɹ�");

     }else{
        out.println("����鵥ʧ��");
        
      }
  }
  
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
   <%--  <base href="<%=basePath%>"> --%>
    
    <title>My JSP 'borrowBookAdd.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<script src="../js/BorrowBookCheckData.js">

		 
	</script>
	<script>
	 function checkDate(){
	 
       return (!checkForRId()? 
	                checkForRId() :
	                checkForBIds());
	        
	      }
	</script>	      
	      

  </head>
  <body>
      <center>
		 <h1>��ӽ����鵥</h1>
	  </center>
      <form name="form" id="form" action="borrowBookAdd.jsp" method="post" onsubmit="return checkDate()">
          <input type="hidden"  name="action" value="bbookAdd"></input>
          <table align="center">
               <tr>
                  <td>����ID��</td>
                  <td><input type="text" size="30" name="rId" id="rId" onblur="checkForRId()"></input>
                  <span id="rIdTip"></span>
                  </td>
               </tr>
               
               <tr>
                  <td>��ID:<br/>
                      (����123;145;456...)��
                  </td>
                  <td><input type="text" size="30" name="bIds" id="bIds" onblur="checkForBIds()"></input>
                   <span id="bIdsTip"></span>
                   </td>
               </tr>
               
               	<tr>
					<td>�鵥����:</td>
					<td>
						<textarea name="bbDesc" id="bbDesc" rows="5"
							cols="50">
						</textarea>
					</td>
				</tr>

				<tr align="center">
					<td colspan="2">
						<input type="submit" value="�ύ" >
					</td>
				</tr>
          </table>
      </form>
  </body>
</html>





