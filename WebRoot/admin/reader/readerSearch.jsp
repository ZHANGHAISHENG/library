<script src="../js/detailClear.js"></script>
<%@ page language="java" import="java.util.*" pageEncoding="GB18030"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%
     request.setCharacterEncoding("GB18030");

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
   <%--  <base href="<%=basePath%>"> --%>
    
    <title>My JSP 'readerAdd.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<script src="../js/Calendar.js"></script>
    <script src="../js/readerCheckData.js"></script>
    <script>
       function checkForIdAtSearch(){
	        var rIdObject=document.getElementById("rId");
	    	if(rIdObject.value.search(/\D/)!=-1){
	          document.getElementById("rIdTip").innerHTML="<font color='red'>Idֻ��Ϊ��������</font>";
	          return false;
	       }else{
	          document.getElementById("rIdTip").innerHTML="<font color='blue'>��Ч</font>";
	          return true;
	       }
	   }
	   
	    
      function checkData(){
        
         return (!checkForIdAtSearch()?
	             checkForIdAtSearch():
	            (
		             (!checkForPhone()?
		               checkForPhone():
		              (!checkForStartDate()?
		                 checkForStartDate():
		                 (!checkForEndDate()?
		                  checkForEndDate():
		                  checkForREmail()
		                  )
		              )
		              
		             )
	            )  
		   );
      }
    
    </script>
  </head>
  
  <body>
    <center><h1>��������</h1></center>
			<form name="form" action="readerSearchResult.jsp" method="post" onsubmit="return checkData()">
				<table align="center" border="1">
				   <tr>
				      <td>id��</td>
				      <td>
				        <input type="text" name="rId" id="rId" size="30" onblur="checkForIdAtSearch()"></input>
						<span id="rIdTip"></span>
				      </td>
				      
				   </tr>
				   <tr>
				      <td>�ؼ��֣�</td>
				      <td>
				        <input type="text" name="keyWord" id="keyWord" size="30" ></input>
						<span id="keyWordTip"></span>
				      </td>
				   </tr>
				   <tr>
				      <td>�Ա�</td>
				      <td>
				        <select name="rSex" id="rSex">
				         <option value="">ȫѡ</option>
				          <option value="��">��</option>
				          <option value="Ů">Ů</option>
				        </select>
						<span id="rSexTip"></span>
				      </td>

				   </tr>
				   
				   <tr>
				      <td>�绰��</td>
				      <td>
				        <input type="text" name="rPhone" id="rPhone" size="30" onblur="checkForPhone()"></input>
						<span id="rPhoneTip"></span>
				      </td>
				   </tr>
					 <tr>
	                   <td>����ע��ʱ��:</td>
	                   <td>��ʼʱ��:<input type="text" name="startDate"  id="startDate" size="20" onblur="checkForStartDate()" onClick="setDayHM(this);" ></input>
	                       <span id="startDateTip"></span>
	                   </td>
	                   <td>��ֹʱ��:<input type="text" name="endDate" id="endDate" size="20" onblur="checkForEndDate()" onClick="setDayHM(this);" ></input>
	                       <span id="endDateTip"></span>
	                   </td>
	                </tr> 
				   <tr>
				      <td>�����ַ��</td>
				      <td>
				        <input type="text" name="rEmail" id="rEmail" size="50" onblur="checkForREmail()"></input>
						<span id="rEmailTip"></span>
				      </td>
				   </tr>
				   <tr>
				      <td>סַ��</td>
				      <td>
				        <textarea name="rAddr" rows="5"
								cols="50">
							</textarea>
				      </td>
				   </tr>
				  
					<tr align="center">
						<td colspan="2">
							<input type="submit" value="��" >
							</td>
					</tr>
				</table>

			</form>
  </body>
</html>
