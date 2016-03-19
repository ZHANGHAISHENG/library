<script src="../js/detailClear.js"></script>
<%@page import="manager.*"%>
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
 
   if(action!=null&&action.trim().equals("adminAdd")){
     int  id=Integer.parseInt(request.getParameter("id"));
     int isRoot=Integer.parseInt(request.getParameter("isRoot"));
     System.out.println("isRoot="+isRoot);
     
     String name=request.getParameter("name");
     String sex=request.getParameter("sex");
     String password=request.getParameter("password");

     String strPhone=request.getParameter("phone");
     int phone=0;
     if(strPhone!=null&&!strPhone.trim().equals("")){
       phone=Integer.parseInt(strPhone);
     }
     
     String addr=request.getParameter("addr");
     String desc=request.getParameter("desc");
     
     
     Administrator  admin=new Administrator();  
     admin.setId(id);
     admin.setAdminName(name);
     admin.setSex(sex);
     admin.setAdminPassword(password);
     admin.setPhone(phone);
     admin.setAddr(addr);
     admin.setRdate(new Timestamp(System.currentTimeMillis()));
     admin.setIsRoot(isRoot);
     admin.setAdminDesc(desc);
        
     boolean b=AdministratorManager.getInstance().addAdministrator(admin);
     if(b){
       out.println("管理员添加成功");
     }else{
       out.println("管理员添加失败");
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
	<script src="../js/adminCheckData.js"></script>
	<script>
	     function checkData(){
		  return (!checkForId()?
		           checkForId():
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
    <center><h1>添加管理员</h1></center>
			<form name="form" action="adminAdd.jsp" method="post" onsubmit="return checkData()">
				<input type="hidden" name="action" value="adminAdd"></input>
				<table align="center" border="1">
				   <tr>
				      <td>id：</td>
				      <td>
				        <input type="text" name="id" id="id" size="30" onblur="checkForId()"></input>
						<span id="idTip"></span>
				      </td>
				   </tr>
				   <tr>
				      <td>管理员级别：</td>
				      <td>
				        <select name="isRoot" id="isRoot">
				          <option value="1">超级管理员</option>
				          <option value="0">普通管理员</option>
				        </select>
						<span id="levelTip"></span>
				      </td>
				   </tr>
				   <tr>
				      <td>名字：</td>
				      <td>
				        <input type="text" name="name" id="name" size="30" onblur="checkForName()"></input>
						<span id="nameTip"></span>
				      </td>
				   </tr>
				   <tr>
				      <td>性别：</td>
				      <td>
				        <select name="sex" id="sex">
				          <option value="男">男</option>
				          <option value="女">女</option>
				        </select>
						<span id="sexTip"></span>
				      </td>
				   </tr>
				    <tr>
				      <td>密码：</td>
				      <td>
				        <input type="text" name="password" id="password" size="30" onblur=""></input>
						<span id="passwordTip"></span>
				      </td>
				   </tr>
				   <tr>
				      <td>密码确认：</td>
				      <td>
				        <input type="password" name="pConfirm" id="pConfirm" size="30" onblur="checkForPassword()"></input>
						<span id="pConfirmTip"></span>
				      </td>
				   </tr>
				   <tr>
				      <td>电话：</td>
				      <td>
				        <input type="text" name="phone" id="phone" size="30" onblur="checkForPhone()"></input>
						<span id="phoneTip"></span>
				      </td>
				   </tr>
				  
				   <tr>
				      <td>住址：</td>
				      <td>
				        <textarea name="addr" rows="5"
								cols="50">
							</textarea>
				      </td>
				   </tr>
				   <tr>
						<td>管理员描述</td>
						<td>
							<textarea name="desc" rows="10"
								cols="50">
							</textarea>
						</td>
					</tr>
					<tr align="center">
						<td colspan="2">
							<input type="submit" value="添加" >
							</td>
					</tr>
				</table>

			</form>
		</body>
  </body>
</html>
