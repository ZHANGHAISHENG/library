<script src="../js/detailClear.js"></script>
<%@ page language="java" import="java.util.*" pageEncoding="GB18030"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <%-- <base href="<%=basePath%>"> --%>
    
    <title>My JSP 'borrowBookSearch.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
    
	<script src="../js/Calendar.js"></script>
	<script src="../js/ticketCheckData.js"></script>
	


	<script>
	  function checkDate(){
	      var len=document.forms["form"].length;
 	      var Objects=new Array(8);

	      Objects[0]=document.forms["form"].tIds;   
	      Objects[1]=document.forms["form"].rIds;
	      Objects[2]=document.forms["form"].tItemIds;
	      Objects[3]=document.forms["form"].bIds;
	      Objects[4]=document.forms["form"].openStartDate;
	      Objects[5]=document.forms["form"].openEndDate;
	      Objects[6]=document.forms["form"].deleteStartDate;
	      Objects[7]=document.forms["form"].deleteEndDate;
	     
	      var str="";
	      for(var i=0;i<8;i++){
	         if(i<4){
	           str+="(!checkForIdAtSearch(Objects["+i+"])?checkForIdAtSearch(Objects["+i+"]):\n";
	         }else{
	           if(i<8-1){
	             str+="(!checkForDateAtSearch(Objects["+i+"])?checkForDateAtSearch(Objects["+i+"]):\n";
	           }else{
	              str+="checkForDateAtSearch(Objects["+i+"])\n";
	              for(var j=0;j<8-1;j++){
	                str+=")\n";
	              }
	           }
	         }
	      } 

	      return eval(str);  
	     
	  } 
	</script>

  </head>
  <body>
    <form  name="form" id="form" action="ticketSearchResult.jsp" method="post" onsubmit="return checkDate()">
      <table align="center" border="1">
         <tr>
              <td>罚单ID:<br>格式如：(123;123...)</td>
              <td><input type="text" name="tIds" id="tIds" size="30" onblur="checkForIdAtSearch(this)"></input>
                  <span id="tIdsTip"></span>
              </td>
              <td></td>
          </tr> 
          
          <tr>
              <td>读者ID:<br>格式如：(123;123...)</td>
              <td><input type="text" name="rIds" id="rIds" size="30" onblur="checkForIdAtSearch(this)"></input>
                  <span id="rIdsTip"></span>
              </td>
              <td></td>
          </tr>
         
          
          <tr>
              <td>罚单项ID:<br>格式如：(123;123...)</td>
              <td><input type="text" name="tItemIds" id="tItemIds" size="30"  onblur="checkForIdAtSearch(this)"></input>
                  <span id="tItemIdsTip"></span>
              </td>
              <td></td>
          </tr>
          
           <tr>
              <td>书的ID:<br>格式如：(123;123...)</td>
              <td><input type="text" name="bIds" id="bIds" size="30" onblur="checkForIdAtSearch(this)"></input>
                  <span id="bIdsTip"></span>
              </td>
              <td></td>
          </tr>
          
           <tr>
               <td>关键字:</td>
               <td><input type="text" name="keyWord" size="30" maxlength="30"></input></td>
               <td></td>
           </tr> 
           
           <tr>
               <td>罚单的状态:</td>
               <td>
                 <select name="state"  id="state">
                    <option value="-1">全部</option>
                    <option value="0">欠款</option>
                    <option value="1">已还款</option>

                 </select>
               </td>
               <td></td>
           </tr> 
           
           <tr>
                <td>开出罚单时间:</td>
                <td>起始时间:<input type="text" name="openStartDate"  id="openStartDate" size="20" onblur="checkForDateAtSearch(this)" onClick="setDayHM(this);" ></input>
                    <span id="openStartdateTip"></span>
                </td>
                <td>终止时间:<input type="text" name="openEndDate" id="openEndDate" size="20" onblur="checkForDateAtSearch(this)" onClick="setDayHM(this);" ></input>
                    <span id="openEndDateTip"></span>
                </td>
          </tr> 
          
          <tr>
                <td>消除罚单时间:</td>
                <td>起始时间:<input type="text" name="deleteStartDate"  id="deleteStartDate" size="20" onblur="checkForDateAtSearch(this)" onClick="setDayHM(this);" ></input>
                    <span id="sStartDateTip"></span>
                </td>
                <td>终止时间:<input type="text" name="deleteEndDate" id="deleteEndDate" size="20" onblur="checkForDateAtSearch(this)" onClick="setDayHM(this);" ></input>
                    <span id="deleteEndDateTip"></span>
                </td>
          </tr> 
          
        
         
          <tr align="right"> 
                  <td colspan="3">
                  <input type="submit" value="搜"></input>
                  </td>
           </tr>       
       
      </table>
    </form>

  </body>
</html>






