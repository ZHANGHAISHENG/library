<%@ page language="java" import="java.util.*" pageEncoding="GB18030"%>
<%@page import="manager.*"%>
<%@page import="bean.*" %>
<%@page import="java.sql.*" %>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%
   request.setCharacterEncoding("GB18030"); 
   String action=request.getParameter("action");
   int  id=Integer.parseInt(request.getParameter("id"));
   Administrator  admin=new Administrator(); 
 
   if(action!=null&&action.trim().equals("adminModify")){
   
     int isRoot=Integer.parseInt(request.getParameter("isRoot"));   

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
      
     admin.setId(id);
     admin.setAdminName(name);
     admin.setSex(sex);
     admin.setAdminPassword(password);
     admin.setPhone(phone);
     admin.setAddr(addr);
     admin.setRdate(new Timestamp(System.currentTimeMillis()));
     admin.setIsRoot(isRoot);
     admin.setAdminDesc(desc);

     boolean b=AdministratorManager.getInstance().modify(admin); 
     if(b){
       %>
		    <script>
		       window.parent.main.location.reload();
		    </script>
		  <%
	     out.println("�޸ĳɹ�");
	  }else{
	    out.println("�޸�ʧ��");
	  }
     
   }else{ 
     admin=AdministratorManager.getInstance().loadById(id);  
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
    <center><h1>�޸Ĺ���Ա��Ϣ</h1></center>
			<form name="form" action="adminModify.jsp" method="post" >
				<input type="hidden" name="action" value="adminModify"></input>
				<input type="hidden" name="id" value=<%=id %>></input>
				<table align="center" border="1">
				   <tr>
				      <td>id��</td>
				      <td>
				        <input type="text" name="id" id="id" size="30"  value=<%=id %>  disabled></input>
						<span id="idTip"></span>
				      </td>
				   </tr>
				   <tr>
				      <td>����Ա����</td>
				      <td>
				        <select name="isRoot" id="isRoot">
				          <option value="1" <%=admin.getIsRoot()==1?"selected":"" %>>��������Ա</option>
				          <option value="0" <%=admin.getIsRoot()==0?"selected":"" %>>��ͨ����Ա</option>
				        </select>
						<span id="levelTip"></span>
				      </td>
				   </tr>
				   <tr>
				      <td>���֣�</td>
				      <td>
				        <input type="text" name="name" id="name" size="30" value=<%=admin.getAdminName() %> onblur="checkForName()"></input>
						<span id="nameTip"></span>
				      </td>
				   </tr>
				   <tr>
				      <td>�Ա�</td>
				      <td>
				        <select name="sex" id="sex">
				          <option value="��" <%=admin.getSex()=="��"?"selected":"" %> >��</option>
				          <option value="Ů" <%=admin.getSex()=="Ů"?"selected":"" %>>Ů</option>
				        </select>
						<span id="sexTip"></span>
				      </td>
				   </tr>
				    <tr>
				      <td>���룺</td>
				      <td>
				        <input type="text" name="password" id="password" size="30" value=<%=admin.getAdminPassword() %> onblur=""></input>
						<span id="passwordTip"></span>
				      </td>
				   </tr>
				   <tr>
				      <td>����ȷ�ϣ�</td>
				      <td>
				        <input type="password" name="pConfirm" id="pConfirm" size="30" value=<%=admin.getAdminPassword() %> onblur="checkForPassword()"></input>
						<span id="pConfirmTip"></span>
				      </td>
				   </tr>
				   <tr>
				      <td>�绰��</td>
				      <td>
				        <input type="text" name="phone" id="phone" size="30" value=<%=admin.getPhone() %> onblur="checkForPhone()"></input>
						<span id="phoneTip"></span>
				      </td>
				   </tr>
				  
				   <tr>
				      <td>סַ��</td>
				      <td>
				        <textarea name="addr" rows="5"
								cols="50"><%=admin.getAddr()%>
							</textarea>
				      </td>
				   </tr>
				   <tr>
						<td>����Ա����</td>
						<td>
							<textarea name="desc" rows="10"
								cols="50"><%=admin.getAdminDesc() %>
							</textarea>
						</td>
					</tr>
					<tr align="center">
						<td colspan="2">
							<input type="submit" value="�޸�" >
							</td>
					</tr>
				</table>

			</form>
		</body>
  </body>
</html>
