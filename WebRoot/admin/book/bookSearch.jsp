<script src="../js/detailClear.js"></script>
<%@page import="java.sql.Timestamp"%>
<%@page import="manager.CategoryManager"%>
<%@ page language="java" import="java.util.*" pageEncoding="GB18030"%>
<%@ page import="bean.*"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>



<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <%-- <base href="<%=basePath%>"> --%>
    
    <title>My JSP 'bookAdd.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1">
    <meta name="ProgId" content="VisualStudio.HTML">
    <meta name="Originator" content="Microsoft Visual Studio .NET 7.1">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<script src="../js/Calendar.js"></script>
	<script>
	    var isInvalid=true;
        function   checkForStartDate(){

	          if(form.startDate.value.search(/(^\s*\d{4}-\d{2}-\d{2}\s*$)|(^\s*\d{4}-\d{2}-\d{2}\s\d{2}:\d{2}:\d{2}\s*$)/)==-1){
	             isInvalid=false;
	             if(form.startDate.value.search(/^\s*\d{4}-\d{2}-\d{2}\s\d{2}:\d{2}\s*$/)!=-1){
	                isInvalid=true;
	                 document.getElementById("startDateTip").innerHTML="<font color='blue'>��Ч</font>";

	             }else{
	              document.getElementById("startDateTip").innerHTML="<font color='red'>��ȷ�ĸ�ʽΪ��yyyy-mm-dd hh:mm:ss</font>";
	             }
	          }else{ 
	                  document.getElementById("startDateTip").innerHTML="<font color='blue'>��Ч</font>";
	                    isInvalid=true;
	               } 

          }
         
          function checkForEndDate(){

	          if(form.endDate.value.search(/(^\s*\d{4}-\d{2}-\d{2}\s*$)|(^\s*\d{4}-\d{2}-\d{2}\s\d{2}:\d{2}:\d{2}\s*$)/)==-1){
	           isInvalid=false;
	           if(form.endDate.value.search(/^\s*\d{4}-\d{2}-\d{2}\s\d{2}:\d{2}\s*$/)!=-1){
	                isInvalid=true;
	               document.getElementById("endDateTip").innerHTML="<font color='blue'>��Ч</font>";

	             }else{
	              document.getElementById("endDateTip").innerHTML="<font color='red'>��ȷ�ĸ�ʽΪ��yyyy-mm-dd hh:mm:ss</font>";
	             }

	          }else{
	               document.getElementById("endDateTip").innerHTML="<font color='blue'>��Ч</font>";
	               isInvalid=true;
	          } 
          }
          
          
          
         function checkForbookSum(){

              if(form.bookSum.value.search(/(^\s*\d+\s*$)|(^\s*\s*$)/)==-1){
              isInvalid=false; 
              document.getElementById("bookSumTip").innerHTML="<font color='red'>ֻ����������ֵ��ʲô��������</font>";
              }else{
                document.getElementById("bookSumTip").innerHTML="<font color='blue'>��Ч</font>";
                  isInvalid=true;
              }   

         }
         
          
          
          function checkForunUseBookSum(){

              if(form.unUseBookSum.value.search(/(^\s*\d+\s*$)|(^\s*\s*$)/)==-1){
                  isInvalid=false; 
                   document.getElementById("unUseBookSumTip").innerHTML="<font color='red'>ֻ����������ֵ��ʲô��������</font>";
                     isInvalid=true;
              }else{
                  document.getElementById("unUseBookSumTip").innerHTML="<font color='blue'>��Ч</font>";
                    isInvalid=true;
               
              }   
          }
          
          function   checkData(){
            return isInvalid;
          }

   </script>

  </head> 
  

 

  <body >
    <center><h1>ͼ������</h1></center>
    <form id="form" action="bookSearchResult.jsp" method="post" onsubmit="return checkData()" >
         
         <table align="center" border="1">
                
                <tr>
                   <td>�ؼ���:</td>
                   <td><input type="text" name="keyWord" size="30" maxlength="30"></input></td>
                   <td></td>
                </tr> 
                <tr>
                   <td>�������:</td>
                   <td>
                      <select name="cateId">
                         <option value="0">ȫ��</option>
                          <%
                            ArrayList<Category> cates=CategoryManager.getInstance().getCategoryTree(0);
                            String preStr=null;
                            for(Iterator<Category> it=cates.iterator();it.hasNext();){
                                Category c=it.next();
                                preStr="";
                                for(int i=1;i<c.getGrade();i++){
                                  preStr+="--";
                                }
                              %>  
                                <option value=<%=c.getId() %>><%=preStr+c.getCateName() %></option>
                              
                            <% } %>
                          
                      </select>
                   </td>
                   <td></td>
                </tr>

                <tr>
                   <td>�ϼ�ʱ��:</td>
                   <td>��ʼʱ��:<input type="text" name="startDate"  id="startDate" size="20" onblur="checkForStartDate()" onClick="setDayHM(this);" ></input>
                       <span id="startDateTip"></span>
                   </td>
                   <td>��ֹʱ��:<input type="text" name="endDate" id="endDate" size="20" onblur="checkForEndDate()" onClick="setDayHM(this);" ></input>
                       <span id="endDateTip"></span>
                   </td>
                </tr> 
                <tr>
                   <td>ͼ�������:</td>
                   <td><input type="text" name="bookSum" id="bookSum" size="5" onblur="checkForbookSum()"></input>
                       <span id="bookSumTip"></span>
                   </td>
                   <td></td>
                </tr> 
                
                 <tr>
                   <td>ͼ���ʣ������:</td>
                   <td><input type="text"  name="unUseBookSum" id="unUseBookSum" size="5" onblur="checkForunUseBookSum()"></input>
                        <span id="unUseBookSumTip"></span>
                   </td>
                   <td></td>
                 </tr>
                 
                <tr align="right"> 
                       <td colspan="3">
                       <input type="submit" value="��"></input>
                       </td>
                </tr>
                
        </table>   
       </form>    
       <br/>   
    </body>
    </html>               
                   