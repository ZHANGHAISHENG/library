<%@page import="manager.BookManager"%>
<%@page import="manager.CategoryManager"%>
<%@page language="java" import="java.sql.*, java.util.* ,java.sql.Date" pageEncoding="GB18030"%>
<%@page import="bean.*" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
 
	<%

		request.setCharacterEncoding("GB18030"); 
		String action=request.getParameter("action");
		int bookId=Integer.parseInt(request.getParameter("id"));
		
		String strCateId=request.getParameter("cateId");
		int cateId=0;
		if(strCateId!=null&&!strCateId.trim().equals("")){
		  cateId=Integer.parseInt(strCateId);
		}
		Book b=null;
		
		if(action!=null&&action.equals("bookUpdate")){
            
			String bookName=request.getParameter("bookName");
			String authorName=request.getParameter("authorName");
			String bookVersion=request.getParameter("bookVersion");
			int bookSum=Integer.parseInt(request.getParameter("bookSum")); 
			String bDesc=request.getParameter("bookDesc");
            b=new Book();
            b.setId(bookId);
			b.setCateId(cateId);
			b.setBookName(bookName);
			b.setAuthorName(authorName);
			b.setBookVersion(bookVersion);
			b.setSum(bookSum);
			b.setpDate(new Timestamp(System.currentTimeMillis()));
			b.setbDesc(bDesc);
			
			if(BookManager.getInstance().updateBook(b)==true){
			   out.println("图书修改成功!");
			   
	%>
	  <script>
        window.parent.main.location.reload();
      </script>	   
	<%
			}else{
			   out.println("图书修改失败!");
			}
         }else{
           b=BookManager.getInstance().loadById(bookId);
           
         }


	%>
	<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
	<html>
		<head>
			<%-- <base href="<%=basePath%>"> --%>

			<title>My JSP 'CategoryAdd.jsp' starting page</title>

				<meta http-equiv="pragma" content="no-cache">
				<meta http-equiv="cache-control" content="no-cache">
				<meta http-equiv="expires" content="0">
				<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
				<meta http-equiv="description"content="This is my page">
			<!--
				<link rel="stylesheet" type="text/css" href="styles.css">
			-->
			
			<script src="../js/bookCheckData.js"></script>
            <script>
               function checkData(){

                 if(document.forms["form"].bookName.value=="<%=b.getBookName() %>"){
                   return checkForBookSum();
                 }else{
                   return (!checkForBookName()?
                            checkForBookName():
                            checkForBookSum()
                          );
                 }
               }
            
            </script>
			
		</head>

		<body>
			<center>
				<h1>更新图书</h1>
			</center>
		<form name="form" action="bookUpdate.jsp" method="post" onsubmit="return checkData()">
				<input type="hidden" name="action" value="bookUpdate"></input>
				<input type="hidden" name="id" value=<%=b.getId() %>></input>
				<table align="center" border="1">
				
				    <tr>
						<td>所属类别名称</td>
					    
					  <td>
					  
				       <select name="cateId" id="cateId">
						   <% 
						      List<Category> categorys=CategoryManager.getInstance().getCategoryTree(0);
						       
						      int index=0;
						      for(Iterator<Category> it=categorys.iterator();it.hasNext();){
						         Category c=it.next();
						         String preStr="";
						         
						         for(int i=1;i<c.getGrade();i++){
						           preStr+="---";
						         }  
						   %>
						  
						     <option value=<%=c.getId() %> 
						            <%=c.getId()==b.getCateId()? "selected" :"" %>
						            <%=c.isLeaf()==false? "disabled":"" %>
						      >
						      <%=preStr+c.getCateName() %>
						      </option> 
						   
						  <%}%>
						  
						  </td>
						  
					  </select>
				    </tr>
					<tr>
						<td>图书名称</td>
						<td>
							<input type="text" name="bookName" id="bookName" size="30"  value=<%=b.getBookName() %>
							 onblur=" (this.value=='<%=b.getBookName() %>' )? '':checkForBookName()"></input>
							<span id="bookNameTip"></span>
						</td>
					</tr >
					<tr>
						<td>作者</td>
						<td>
							<input type="text" name="authorName" size="30" value=<%=b.getAuthorName() %>></input>
						</td>
					</tr>
					<tr>
						<td>版本</td>
						<td>
							<input type="text" name="bookVersion" size="30" value=<%=b.getBookVersion() %>></input>
						</td>
					</tr>
					
					<tr>
						<td>总量</td>
						<td>
							<input type="text" name="bookSum" id="bookSum" size="10"  value=<%=b.getSum() %> onblur="checkForBookSum();"></input>
							<span name="bookSum" id="bookSumTip"></span>
						</td>
					</tr>
					
					<tr>
						<td>图书描述</td>
						<td>
							<textarea name="bookDesc" rows="10"
								cols="50"><%=b.getbDesc() %></textarea>
						</td>
						 
					</tr>

					

					<tr>
						<td colspan="2">
							<input type="submit" value="提交" >
							</td>
					</tr>

				</table>

			</form>

		</body>
</html>