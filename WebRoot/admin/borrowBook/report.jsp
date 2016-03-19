<script src="../js/detailClear.js"></script>
<%@page import="manager.CategoryManager"%>
<%@ page language="java" import="java.util.*" pageEncoding="GB18030"%>
<%@page import="bean.*"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<%
 List<Category> categorys=CategoryManager.getInstance().getCategoryTree(0);

 %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  <%--  <base href="<%=basePath%>"> --%>
   
    <title>My JSP 'report.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  	<script language="javascript" src="../js/TV20.js"></script>
  	<script src="../js/Calendar.js"></script>
	<script src="../js/BorrowBookCheckData.js"></script>
	<script>
	 
		 function checkDate(){
		  alert();
	       var startODateObject=document.forms["form"].startODate;
	       var endODateObject=document.forms["form"].endODate;

	       return  (!checkForDateAtSearch(startODateObject)?checkForDateAtSearch(startODateObject):
	                  checkForDateAtSearch(endODateObject)
	             ); 
	  } 
	</script>
  <body>
  
    <!-- 无法实现onsubmit ,用readonly替代-->
     <form  name="form" id="form"  method="post" onsubmit="return checkData()" target="detail">
      <center>
                    样式：3d<input type="radio" id="style1" name="style" value="3d" checked/>&nbsp 2d<input  type="radio" id="style2" name="style" value="2d"/>
      </center>
      
       <table align="center" border="1">
       <tr>
       
       <td>from:<input type="text" name="startODate"  id="startODate" size="20" readonly="readonly" onblur="checkForDateAtSearch(this)" onClick="setDayHM(this);" ></input>
           <span id="startODateTip"></span>
       </td>

        <td>to:<input type="text" name="endODate" id="endODate" size="20" readonly="readonly"  onblur="checkForDateAtSearch(this)" onClick="setDayHM(this);" ></input>
        <span id="endODateTip"></span>
        </td>
        </tr>
        
          <tr align="center"> 
                  <td >
                     <input type="button" value="折线图"         
                      onclick="javascript:document.form.action='../../servlet/TimeLineChart';document.form.submit()"/>
                  </td>
                  
                  <td >
                     <input type="button" value="柱形图"         
                      onclick="javascript:document.form.action='../../servlet/TimeBarChart';document.form.submit()"/>
                  </td>
          </tr>  
           
       </table>
       
       
      </form>
      
      

          
    <script language="javascript">
    
      function pie(key,parentKey){
            var object=document.getElementById("style1");

            if(object.checked){
               window.parent.frames["detail"].location.href="../../servlet/CategoryPieChart?cateId="+key+"&style=3d";
            }else{
               window.parent.frames["detail"].location.href="../../servlet/CategoryPieChart?cateId="+key+"&style=2d";
            }
    
     }
     
     function bar(key,parentKey){
       var object=document.getElementById("style1");
       if(object.checked){
               window.parent.frames["detail"].location.href="../../servlet/CategoryBarChart?cateId="+key+"&style=3d";
            }else{
               window.parent.frames["detail"].location.href="../../servlet/CategoryBarChart?cateId="+key+"&style=2d";
            }
     } 

     addNode(-1,0,"全部","../images/top.gif");
    
    <%
     for(Iterator<Category> it=categorys.iterator();it.hasNext();){
      Category c=it.next();
    %>
     addNode(<%=c.getPid() %>,<%=c.getId() %>,"<%=c.getCateName() %>","../images/top.gif");
    <%}%>

	showTV();
	
	addListener( "click" , "pie" );
	addListener( "dblclick" , "bar" );

    </script>
      
  </body>
  
</html>
