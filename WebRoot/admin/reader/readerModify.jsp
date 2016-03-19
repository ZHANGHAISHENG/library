<%@page import="manager.ReaderManager"%>
<%@ page language="java" import="java.util.*" pageEncoding="GB18030"%>
<%@page import="bean.*" %>
<%@page import="java.sql.*" %>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%

   request.setCharacterEncoding("GB18030"); 
   String action=request.getParameter("action");
   String rId=request.getParameter("rId");
   Reader reader=new Reader();  
   reader.setId(rId);
   reader=reader.load();
   System.out.println("rpws="+reader.getrPassword());
   if(action!=null&&action.trim().equals("readerModify")){
     String rName=request.getParameter("rName");
     String rSex=request.getParameter("rSex");
     String rPassword=request.getParameter("rPassword");
     String strRPhone=request.getParameter("rPhone");
     int rPhone=0;
     if(strRPhone!=null&&!strRPhone.trim().equals("")){
       rPhone=Integer.parseInt(strRPhone);
     }
     
     String rEmail=request.getParameter("rEmail");
     String rAddr=request.getParameter("rAddr");
     String rDescr=request.getParameter("rDescr");
     

     reader.setId(rId);
     reader.setrName(rName);
     reader.setSex(rSex);
     reader.setrPassword(rPassword);
     reader.setPhone(rPhone);
     reader.setEmail(rEmail);
     reader.setAddr(rAddr);
     reader.setRdate(new Timestamp(System.currentTimeMillis()));
     reader.setRdescr(rDescr);
     
     boolean b=ReaderManager.getInstance().modifyReader(reader);
     if(b){
     %>
      <script>window.parent.main.location.reload();</script>
     <%  out.println("读者修改成功");
     }else{
       out.println("读者修改失败");
     }
     
   }

 %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <%-- <base href="<%=basePath%>"> --%>
    
    <title>My JSP 'readerAdd.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<script src="../js/readerCheckData.js"></script>
	<script>
	     function checkData(){
		  return   (!checkForRName()?
			           checkForRName():
			           (!checkForRPassword()?
			             checkForRPassword():
				             (!checkForPhone()?
				              checkForPhone():
				              checkForREmail()
				             )
			           )
		           
		          );
		}
	</script>

  </head>
  
  
  <body>
    <center><h1>读者修改</h1></center>
			<form name="form" action="readerModify.jsp" method="post" onsubmit="return checkData()">
				<input type="hidden" name="action" value="readerModify"></input>
				<input type="hidden" name="rId" value=<%=rId %>></input>
				<table align="center" border="1">
				   <tr>
				      <td>id：</td>
				      <td>
				        <input type="text" name="rId" id="rId" size="30" value=<%=rId %> disabled></input>
				      </td>
				   </tr>
				   <tr>
				      <td>名字：</td>
				      <td>
				        <input type="text" name="rName" id="rName" value=<%=reader.getrName() %> size="30" onblur="checkForRName()"></input>
						<span id="rNameTip"></span>
				      </td>
				   </tr>
				   <tr>
				      <td>性别：</td>
				      <td>
				        <select name="rSex" id="rSex">
				          <option value="男" <%=reader.getSex().trim().equals("男")?"selected":"" %> >男</option>
				          <option value="女" <%=reader.getSex().trim().equals("女")?"selected":""%>>女</option>
				        </select>
						<span id="rSexTip"></span>
				      </td>
				   </tr>
				    <tr>
				      <td>密码：</td>
				      <td>
				        <input type="text" name="rPassword" id="rPassword" value=<%=reader.getrPassword() %> size="30" onblur=""></input>
						<span id="rPasswordTip"></span>
				      </td>
				   </tr>
				   <tr>
				      <td>密码确认：</td>
				      <td>
				        <input type="password" name="rPConfirm" id="rPConfirm" value=<%=reader.getrPassword() %> size="30" onblur="checkForRPassword()"></input>
						<span id="rPConfirmTip"></span>
				      </td>
				   </tr>
				   <tr>
				      <td>电话：</td>
				      <td>
				        <input type="text" name="rPhone" id="rPhone" size="30" value=<%=reader.getPhone() %> onblur="checkForPhone()"></input>
						<span id="rPhoneTip"></span>
				      </td>
				   </tr>
				   <tr>
				      <td>邮箱地址：</td>
				      <td>
				        <input type="text" name="rEmail" id="rEmail" size="50" value='<%=reader.getEmail() %>' onblur="checkForREmail()"></input>
						<span id="rEmailTip"></span>
				      </td>
				   </tr>
				   <tr>
				      <td>住址：</td>
				      <td>
				        <textarea name="rAddr" rows="5"
								cols="50">
								<%=reader.getAddr() %>
							</textarea>
				      </td>
				   </tr>
				   <tr>
						<td>读者描述</td>
						<td>
							<textarea name="rDescr" rows="10"
								cols="50"><%=reader.getRdescr() %>
							</textarea>
						</td>
					</tr>
					<tr >
						<td colspan="2">
							<input type="submit" value="修改" >
							</td>
					</tr>
				</table>

			</form>
		</body>
  </body>
</html>
