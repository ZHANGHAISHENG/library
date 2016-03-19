<%@page import="java.net.URLEncoder"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="manager.ReaderManager"%>
<%@ page language="java" import="java.util.*" pageEncoding="GB18030"%>
<%@page import="java.sql.Timestamp"%>
<%@ page import="bean.*"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<%
    request.setCharacterEncoding("GB18030");
    int pageNo=1;
    int pageSize=10;
    int pageCount=0;
    
    String strPageNo=request.getParameter("pageNo");
    String strPageCount=request.getParameter("pageCount");
    String strParamValues="";
    //获取Id
    String rId=request.getParameter("rId");
    String[] rIds=null;//暂时为1
    if(rId!=null&&!rId.trim().equals("")){
      rIds=new String[1];//暂时为1
      rIds[0]=rId;
    }
    
    

    //获取关键字
    String keyWord=request.getParameter("keyWord");
    
    //获取性别

    String rSex=request.getParameter("rSex");

    //获取电话
    String strRPhone=request.getParameter("rPhone");
    int rPhone=0;
    if(strRPhone!=null&&!strRPhone.trim().equals("")){
      rPhone=Integer.parseInt(strRPhone);
    }
 
    
    //获取Email
     String rEmail=request.getParameter("rEmail");
     //获取地址
     String rAddr=request.getParameter("rAddr");
     
    //获取上架日期范围
    String strStartRDate=request.getParameter("startDate");
    String strEndRDate=request.getParameter("endDate");
    Timestamp startRDate=null; 
    Timestamp endRDate=null;

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

    
//对startRDate ,endRDate作调整
    if(strStartRDate!=null&&!strStartRDate.trim().equals("")){
   
        if(strStartRDate.matches("^\\s*\\d{4}-\\d{2}-\\d{2}\\s*$")){
           strStartRDate=strStartRDate.trim()+" 00:00:00";//注意：中间只有一个空格
        }
        if(strStartRDate.matches("^\\s*\\d{4}-\\d{2}-\\d{2}\\s\\d{2}\\:\\d{2}\\s*$")){
           strStartRDate=strStartRDate.trim()+":00";//注意：中间只有一个空格
        }

        startRDate=Timestamp.valueOf(strStartRDate);
    }
    
    if(strEndRDate!=null&&!strEndRDate.trim().equals("")){
        if(strEndRDate.matches("^\\s*\\d{4}-\\d{2}-\\d{2}\\s*$")){
           strEndRDate=strEndRDate.trim()+" 00:00:00";//注意：中间只有一个空格
        }
        if(strEndRDate.matches("^\\s*\\d{4}-\\d{2}-\\d{2}\\s\\d{2}\\:\\d{2}\\s*$")){
           strEndRDate=strEndRDate.trim()+":00";//注意：中间只有一个空格
        }
        endRDate=Timestamp.valueOf(strEndRDate);
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
     ArrayList<Reader> readers=new ArrayList<Reader>();
         
     pageCount=ReaderManager.getInstance().fineReaders(readers, keyWord, rIds,
                                                       rSex, rPhone, rEmail, rAddr,
                                                       startRDate, endRDate,
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
               
         aObject.href="readerSearchResult.jsp?pageNo="+pageNo+"&pageCount=<%=pageCount %><%="&"+strParamValues %>";
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
        <th>email</th>
        <th>地址</th>
        <th>添加时间</th>
        <th>描叙</th>
        <th>修改</th>
        <th>删除</th>

      </tr>
      <%
       
       for(Iterator<Reader> it=readers.iterator();it.hasNext();){
              Reader r=it.next();     
       %>
       <tr>
        <td><%=r.getId() %></td>
        <td><%=r.getrName() %></td>
        <td><%=r.getSex() %></td>
        <td><%=r.getrPassword()==null?"&nbsp":r.getrPassword() %></td>
        <td><%=r.getPhone()+"&nbsp"%></td>
        <td><%=r.getEmail()==null?"&nbsp":r.getEmail() %></td>
        <td><%=r.getAddr()==null?"&nbsp":r.getAddr() %></td>
        <td><%=r.getRdate()%></td>
        <td><%=r.getRdescr()==null?"&nbsp":r.getRdescr() %></td>
        <td><a href="readerModify.jsp?rId=<%=r.getId() %>" target="detail">更新</a></td>
        <td><a href="readerDelete.jsp?rId=<%=r.getId() %>" target="detail">删除</a></td>

      </tr>
      <%
        
       }
       %>
    </table>    
                    第<%=pageNo %>页
                   共<%=pageCount %>页
      <a href="readerSearchResult.jsp?pageNo=1&pageCount=<%=pageCount %><%="&"+strParamValues %>" onclick=" return linkClick(this)" >首页</a>&nbsp            
      <a href="readerSearchResult.jsp?pageNo=<%=pageNo-1 %>&pageCount=<%=pageCount %><%="&"+strParamValues %>" onclick=" return linkClick(this)">上一页</a>&nbsp
      
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
      <a href="readerSearchResult.jsp?pageNo=<%=pageNo+1 %>&pageCount=<%=pageCount %><%="&"+strParamValues %>" onclick=" return linkClick(this)" >下一页</a>&nbsp
      <a href="readerSearchResult.jsp?pageNo=<%=pageCount%>&pageCount=<%=pageCount %><%="&"+strParamValues %>" onclick=" return linkClick(this)" >末页</a>

  </body>
</html>
