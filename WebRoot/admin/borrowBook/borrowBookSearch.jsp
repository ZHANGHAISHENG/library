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
	<script src="../js/BorrowBookCheckData.js"></script>
	<script>
	
	  function checkDate(){
	  
 /* ------------------------------------------------------  ��ʽһ��------------------------------------------------------ */
/* 	      var Objects=new Array(12);
	      // alert(Objects);
	      Objects[0]=document.forms["form"].ids;
	      
	      Objects[1]=document.forms["form"].rIds;
	      Objects[2]=document.forms["form"].bbookItemIds;
	      Objects[3]=document.forms["form"].bIds;
	      Objects[4]=document.forms["form"].startODate;
	      Objects[5]=document.forms["form"].endODate;
	      Objects[6]=document.forms["form"].sStartDate;
	      Objects[7]=document.forms["form"].sEndDate;
	      Objects[8]=document.forms["form"].overDueStartDate;
	      Objects[9]=document.forms["form"].overDueEndDate;
	      Objects[10]=document.forms["form"].returnBookStartDate;
	      Objects[11]=document.forms["form"].returnBookEndDate;
	     
	      var str="";
	      for(var i=0;i<10;i++){
	         if(i<4){
	           str+="(!checkForIdAtSearch(Objects["+i+"])?checkForIdAtSearch(Objects["+i+"]):";
	         }else{
	           if(i<10){
	             str+="(!checkForDateAtSearch(Objects["+i+"])?checkForDateAtSearch(Objects["+i+"]):";
	           }else{
	              str+="checkForDateAtSearch(Objects["+i+"]";
	              for(var j=0;j<11;j++){
	                str+=")";
	              }
	           }
	         }
	      }
	      alert(eval(str));
	      return eval(str);  */
 /*---------------------------------------------------------------  ��ʽ���� ------------------------------------------------------*/
	     var idsObject=document.forms["form"].ids;
	     var rIdsObject=document.forms["form"].rIds;
	     var bbookItemIdsObject=document.forms["form"].bbookItemIds;
	     var bIdsObject=document.forms["form"].bIds;
	     var startODateObject=document.forms["form"].startODate;
	     var endODateObject=document.forms["form"].endODate;
	     var sStartDateObject=document.forms["form"].sStartDate;
	     var sEndDateObject=document.forms["form"].sEndDate;
	     var overDueStartDateObject=document.forms["form"].overDueStartDate;
	     var overDueEndDateObject=document.forms["form"].overDueEndDate;

	     
	     return (!checkForIdAtSearch(idsObject)?checkForIdAtSearch(idsObject):
	              (!checkForIdAtSearch(rIdsObject)?checkForIdAtSearch(rIdsObject):
	                (!checkForIdAtSearch(bbookItemIdsObject)?checkForIdAtSearch(bbookItemIdsObject):
	                   (!checkForIdAtSearch(bIdsObject)?checkForIdAtSearch(bIdsObject):
	                     (!checkForDateAtSearch(startODateObject)?checkForDateAtSearch(startODateObject):
	                       (!checkForDateAtSearch(endODateObject)?checkForDateAtSearch(endODateObject):
	                         (!checkForDateAtSearch(sStartDateObject)?checkForDateAtSearch(sStartDateObject):
	                           (!checkForDateAtSearch(sEndDateObject)?checkForDateAtSearch(sStartDateObject):
	                             (!checkForDateAtSearch(overDueStartDateObject)?checkForDateAtSearch(sStartDateObject):
	                               (!checkForDateAtSearch(overDueEndDateObject)?checkForDateAtSearch(overDueEndDateObject):
	                                (!checkForDateAtSearch(returnBookStartDate)?checkForDateAtSearch(returnBookStartDate):
	                                   checkForDateAtSearch(returnBookEndDate)
	                                )
	                               )
	                             )
	                           )
	                         )
	                       )
	                     )
	                   )
	                )
	              )
	             ); 
	  } 
	</script>

  </head>
  <body>
    <center><h1>�����鵥����</h1></center>
    <form  name="form" id="form" action="borrowBookSearchResult.jsp" method="post" onsubmit="return checkDate()">
      <table align="center" border="1">
         <tr>
              <td>�����鵥ID:<br>��ʽ�磺(123;123...)</td>
              <td><input type="text" name="ids" id="ids" size="30" onblur="checkForIdAtSearch(this)"></input>
                  <span id="idsTip"></span>
              </td>
              <td></td>
          </tr> 
          
          <tr>
              <td>����ID:<br>��ʽ�磺(123;123...)</td>
              <td><input type="text" name="rIds" id="rIds" size="30" onblur="checkForIdAtSearch(this)"></input>
                  <span id="rIdsTip"></span>
              </td>
              <td></td>
          </tr>
         
          
          <tr>
              <td>������ID:<br>��ʽ�磺(123;123...)</td>
              <td><input type="text" name="bbookItemIds" id="bbookItemIds" size="30" onblur="checkForIdAtSearch(this)"></input>
                  <span id="bbookItemIdsTip"></span>
              </td>
              <td></td>
          </tr>
          
           <tr>
              <td>���ID:<br>��ʽ�磺(123;123...)</td>
              <td><input type="text" name="bIds" id="bIds" size="30" onblur="checkForIdAtSearch(this)"></input>
                  <span id="bIdsTip"></span>
              </td>
              <td></td>
          </tr>
          
           <tr>
               <td>�ؼ���:</td>
               <td><input type="text" name="keyWord" size="30" maxlength="30"></input></td>
               <td></td>
           </tr> 
           
           <tr>
               <td>�������״̬:</td>
               <td>
                 <select name="state"  id="state">
                    <option value="-1">ȫ��</option>
                    <option value="0">ͼ��ԤԼ��</option>
                    <option value="1">ͼ����ĳɹ�</option>
                    <option value="2">ͼ�鳬��</option>
                    <option value="3">ͼ���ѻ�</option>
                 </select>
               </td>
               <td></td>
           </tr> 
           
           <tr>
                <td>�鵥��ϵͳʱ��:</td>
                <td>��ʼʱ��:<input type="text" name="startODate"  id="startODate" size="20" onblur="checkForDateAtSearch(this)" onClick="setDayHM(this);" ></input>
                    <span id="startODateTip"></span>
                </td>
                <td>��ֹʱ��:<input type="text" name="endODate" id="endODate" size="20" onblur="checkForDateAtSearch(this)" onClick="setDayHM(this);" ></input>
                    <span id="endODateTip"></span>
                </td>
          </tr> 
          
          <tr>
                <td>ͼ����ĳɹ�ʱ��:</td>
                <td>��ʼʱ��:<input type="text" name="sStartDate"  id="sStartDate" size="20" onblur="checkForDateAtSearch(this)" onClick="setDayHM(this);" ></input>
                    <span id="sStartDateTip"></span>
                </td>
                <td>��ֹʱ��:<input type="text" name="sEndDate" id="sEndDate" size="20" onblur="checkForDateAtSearch(this)" onClick="setDayHM(this);" ></input>
                    <span id="sEndDateTip"></span>
                </td>
          </tr> 
          
          <tr>
                <td>ͼ�鳬��ʱ��:</td>
                <td>��ʼʱ��:<input type="text" name="overDueStartDate"  id="overDueStartDate" size="20" onblur="checkForDateAtSearch(this)" onClick="setDayHM(this);" ></input>
                    <span id="overDueStartDateTip"></span>
                </td>
                <td>��ֹʱ��:<input type="text" name="overDueEndDate" id="overDueEndDate" size="20" onblur="checkForDateAtSearch(this)" onClick="setDayHM(this);" ></input>
                    <span id="overDueEndDateTip"></span>
                </td>
          </tr> 
          
          <tr>
                <td>ͼ�鷵��ʱ��:</td>
                <td>��ʼʱ��:<input type="text" name="returnBookStartDate"  id="returnBookStartDate" size="20" onblur="checkForDateAtSearch(this)" onClick="setDayHM(this);" ></input>
                    <span id="returnBookStartDateTip"></span>
                </td>
                <td>��ֹʱ��:<input type="text" name="returnBookEndDate" id="returnBookEndDate" size="20" onblur="checkForDateAtSearch(this)" onClick="setDayHM(this);" ></input>
                    <span id="returnBookEndDateTip"></span>
                </td>
          </tr> 
          
         
          <tr align="right"> 
                  <td colspan="3">
                  <input type="submit" value="��"></input>
                  </td>
           </tr>       
       
      </table>
    </form>

  </body>
</html>






