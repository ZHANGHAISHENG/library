<script src="../js/detailClear.js"></script>
<%@ page language="java" import="java.util.*" pageEncoding="GB18030"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
   <%--  <base href="<%=basePath%>"> --%>
    
    <title>adminSearch</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  <script src="../js/Calendar.js"></script>
  <script src="../js/adminCheckData.js"></script>
	<script>
		  function checkForIdAtSearch(){
	         var idObject=document.getElementById("id");
	    	 if(idObject.value.search(/\D/)!=-1){
	          document.getElementById("idTip").innerHTML="<font color='red'>Idֻ��Ϊ��������</font>";
	          return false;
	        }else{
	          document.getElementById("idTip").innerHTML="<font color='blue'>��Ч</font>";
	          return true;
	        }
		   }
	   
	     function checkData(){
		  return (!checkForIdAtSearch()?
		           checkForIdAtSearch():
		          (!checkForName()?
			           checkForName():
			           (!checkForPassword()?
			             checkForPassword():
				         checkForPhone()
			           )
		           
		          )
		   );
		}
	</script>

  </head>
  
  
  <body>
    <center><h1>��������Ա</h1></center>
			<form name="form" action="adminSearchResult.jsp" method="post" onsubmit="return checkData()">
				<table align="center" border="1">
				   <tr>
				      <td>id��</td>
				      <td>
				        <input type="text" name="id" id="id" size="30" onblur="checkForIdAtSearch()"></input>
						<span id="idTip"></span>
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
				      <td>����Ա����</td>
				      <td>
				        <select name="isRoot" id="isRoot">				          
				          <option value="-1">ȫ��</option>
				          <option value="0">��ͨ����Ա</option>
				          <option value="1">��������Ա</option>
				        </select>
						<span id="levelTip"></span>
				      </td>
				   </tr>
		
				   <tr>
				      <td>�Ա�</td>
				      <td>
				        <select name="sex" id="sex">
				         <option value="">ȫ��</option>
				          <option value="��">��</option>
				          <option value="Ů">Ů</option>
				        </select>
						<span id="sexTip"></span>
				      </td>
				   </tr>
				   <tr>
				      <td>�绰��</td>
				      <td>
				        <input type="text" name="phone" id="phone" size="30" onblur="checkForPhone()"></input>
						<span id="phoneTip"></span>
				      </td>
				   </tr>
				   
				     <td>ע��ʱ��:</td>
	                   <td>��ʼʱ��:<input type="text" name="startRDate"   id="startRDate" size="20" readonly="readonly" onblur="checkForStartDate()" onClick="setDayHM(this);" ></input>
	                       <span id="rStartDateTip"></span>
	                   </td>
	                   <td>��ֹʱ��:<input type="text" name="endRDate"  id="endRDate" size="20" readonly="readonly" onblur="checkForEndDate()" onClick="setDayHM(this);" ></input>
	                       <span id="rEndDateTip"></span>
	                   </td>
	                </tr> 
				  
				   <tr>
				      <td>סַ��</td>
				      <td>
				        <textarea name="addr" rows="5"
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
  </body>
</html>
