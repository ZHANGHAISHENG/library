<%@page import="manager.*"%>
<%@ page language="java" import="java.util.*" pageEncoding="GB18030"%>
<%@page import="java.sql.Timestamp"%>
<%@ page import="bean.*"%>


<%!
  public Timestamp adjustDate(HttpServletRequest request,String strQueryDate){  
     String strDate=request.getParameter(strQueryDate);   
     Timestamp date=null;
     if(strDate!=null&&!strDate.trim().equals("")){
   
        if(strDate.matches("^\\s*\\d{4}-\\d{2}-\\d{2}\\s*$")){
           strDate=strDate.trim()+" 00:00:00";//注意：中间只有一个空格
        }
        if(strDate.matches("^\\s*\\d{4}-\\d{2}-\\d{2}\\s\\d{2}\\:\\d{2}\\s*$")){
           strDate=strDate.trim()+":00";//注意：中间只有一个空格
        }
          
         date=Timestamp.valueOf(strDate);
    }
     return date;
  }
%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<%
    request.setCharacterEncoding("GB18030");
    int pageNo=1;
    int pageSize=4;
    int pageCount=0;
    
    String strPageNo=request.getParameter("pageNo");
    String strPageCount=request.getParameter("pageCount");
    String strParamValues="";
    
    //获取Id
    String strId=request.getParameter("id");
    int[] ids=null;//暂时为1
    if(strId!=null&&!strId.trim().equals("")){
      ids=new int[1];//暂时为1
      ids[0]=Integer.parseInt(strId);
    }
    
    //级别
    int isRoot=Integer.parseInt(request.getParameter("isRoot"));
   
    //获取关键字
    String keyWord=request.getParameter("keyWord");
    
    //获取性别

    String sex=request.getParameter("sex");

    //获取电话
    String strPhone=request.getParameter("phone");
    int phone=0;
    if(strPhone!=null&&!strPhone.trim().equals("")){
      phone=Integer.parseInt(strPhone);
    }
 
     //获取地址
     String addr=request.getParameter("addr");
     
    //获取上架日期范围
    Timestamp startRDate=adjustDate(request,"startRDate"); 
    Timestamp endRDate=adjustDate(request,"endRDate");

    //判断是pageNo否越界
    if(strPageCount!=null&&!strPageCount.trim().equals("")){
       pageCount=Integer.parseInt(strPageCount);
    }
    
    if(strPageNo!=null&&!strPageNo.trim().equals("")){
       pageNo=Integer.parseInt(strPageNo);
       if(pageNo<1){
         pageNo=1;
       }
       if(pageNo>pageCount){
         pageNo=pageCount;
       }
    }

 //获取所有的参数，为分页做准备
       
      Enumeration<String> pamaNames=request.getParameterNames();
      
      while(pamaNames.hasMoreElements()){
           String pamaName=pamaNames.nextElement();
           if(!pamaName.trim().equals("pageNo")&&!pamaName.trim().equals("pageCount")){
               String[] pamaValues=request.getParameterValues(pamaName);
	           for(int i=0;i<pamaValues.length;i++){
	             strParamValues+=pamaName+"="+pamaValues[i]+"&";
	           }
            }
      }

       System.out.println("strParamValues="+strParamValues);
       
    //执行搜索
     ArrayList<Administrator> admins=new ArrayList<Administrator>();
         
     pageCount=AdministratorManager.getInstance().findAdmins(admins, ids, keyWord, 
														      sex, phone, addr, 
														      startRDate, endRDate, isRoot,
														      pageNo, pageSize);


 %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
   <%--  <base href="<%=basePath%>"> --%>
    
    <title>My JSP 'bookSearchContent.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
    <script src="../js/linkTransToForm.js"></script>
    
	<script>
 
	  function LinkToSkipPage(){

	     var select=document.getElementById("pageNo");
	     var i=select.selectedIndex;
	     var pageNo=select.options[i].value;    
         var aObject=document.getElementById("select");
               
         aObject.href="adminSearchResult.jsp?pageNo="+pageNo+"&pageCount=<%=pageCount %><%="&"+strParamValues %>";
         linkClick(aObject);
	  }
	
	</script>

  </head>
  
  <body>
      <table border="1" align="center" >
      <tr>
        <th>ID</th>
        <th>名字</th>
        <th>性别</th>
        <th>密码</th>
        <th>电话</th>
        <th>地址</th>
        <th>注册时间</th>
        <th>级别</th>
        <th>描叙</th>
        <th>修改</th>
        <th>删除</th>

      </tr>
      <%
       
       for(Iterator<Administrator> it=admins.iterator();it.hasNext();){
              Administrator admin=it.next();     
       %>
       <tr>
        <td><%=admin.getId() %></td>
        <td><%=admin.getAdminName() %></td>
        <td><%=admin.getSex() %></td>
        <td><%=admin.getAdminPassword() %></td>
        <td><%=admin.getPhone() %></td>
        <td><%=admin.getAddr() %></td>
        <td><%=admin.getRdate() %></td>
        <td><%=admin.getIsRoot()==0?"普通管理员":"超级管理员" %></td>
        <td><%=admin.getAdminDesc() %></td>
        <td><a href="adminModify.jsp?id=<%=admin.getId() %>" target="detail">更新</a></td>
        <td><a href="adminDelete.jsp?id=<%=admin.getId() %>" target="detail">删除</a></td>

      </tr>
      <%
        
       }
       %>
    </table>    
                    第<%=pageNo %>页
                   共<%=pageCount %>页
      <a href="adminSearchResult.jsp?pageNo=1&pageCount=<%=pageCount %><%="&"+strParamValues %>" onclick=" return linkClick(this)" >首页</a>&nbsp            
      <a href="adminSearchResult.jsp?pageNo=<%=pageNo-1 %>&pageCount=<%=pageCount %><%="&"+strParamValues %>" onclick=" return linkClick(this)">上一页</a>&nbsp
      
      <a id="select" href=""></a>
      <select name="pageNo" id="pageNo" onchange=" LinkToSkipPage()">
        <%  for(int i=1;i<=pageCount;i++){
            if(i==pageNo){%>
             <option value=<%=i %> selected><%=i %></option>
             <%}else{ %>
              <option value=<%=i %>><%=i %></option>
          
      <%        }
       } %>
        
      </select>
      <a href="adminSearchResult.jsp?pageNo=<%=pageNo+1 %>&pageCount=<%=pageCount %><%="&"+strParamValues %>" onclick=" return linkClick(this)" >下一页</a>&nbsp
      <a href="adminSearchResult.jsp?pageNo=<%=pageCount%>&pageCount=<%=pageCount %><%="&"+strParamValues %>" onclick=" return linkClick(this)" >末页</a>

  </body>
</html>
