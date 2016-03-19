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
    //��ȡId
    String rId=request.getParameter("rId");
    String[] rIds=null;//��ʱΪ1
    if(rId!=null&&!rId.trim().equals("")){
      rIds=new String[1];//��ʱΪ1
      rIds[0]=rId;
    }
    
    

    //��ȡ�ؼ���
    String keyWord=request.getParameter("keyWord");
    
    //��ȡ�Ա�

    String rSex=request.getParameter("rSex");

    //��ȡ�绰
    String strRPhone=request.getParameter("rPhone");
    int rPhone=0;
    if(strRPhone!=null&&!strRPhone.trim().equals("")){
      rPhone=Integer.parseInt(strRPhone);
    }
 
    
    //��ȡEmail
     String rEmail=request.getParameter("rEmail");
     //��ȡ��ַ
     String rAddr=request.getParameter("rAddr");
     
    //��ȡ�ϼ����ڷ�Χ
    String strStartRDate=request.getParameter("startDate");
    String strEndRDate=request.getParameter("endDate");
    Timestamp startRDate=null; 
    Timestamp endRDate=null;

    //�ж���pageNo��Խ��
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

    
//��startRDate ,endRDate������
    if(strStartRDate!=null&&!strStartRDate.trim().equals("")){
   
        if(strStartRDate.matches("^\\s*\\d{4}-\\d{2}-\\d{2}\\s*$")){
           strStartRDate=strStartRDate.trim()+" 00:00:00";//ע�⣺�м�ֻ��һ���ո�
        }
        if(strStartRDate.matches("^\\s*\\d{4}-\\d{2}-\\d{2}\\s\\d{2}\\:\\d{2}\\s*$")){
           strStartRDate=strStartRDate.trim()+":00";//ע�⣺�м�ֻ��һ���ո�
        }

        startRDate=Timestamp.valueOf(strStartRDate);
    }
    
    if(strEndRDate!=null&&!strEndRDate.trim().equals("")){
        if(strEndRDate.matches("^\\s*\\d{4}-\\d{2}-\\d{2}\\s*$")){
           strEndRDate=strEndRDate.trim()+" 00:00:00";//ע�⣺�м�ֻ��һ���ո�
        }
        if(strEndRDate.matches("^\\s*\\d{4}-\\d{2}-\\d{2}\\s\\d{2}\\:\\d{2}\\s*$")){
           strEndRDate=strEndRDate.trim()+":00";//ע�⣺�м�ֻ��һ���ո�
        }
        endRDate=Timestamp.valueOf(strEndRDate);
    }

 //��ȡ���еĲ�����Ϊ��ҳ��׼��
       
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
       
    //ִ������
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
        <th>����</th>
        <th>�Ա�</th>
        <th>����</th>
        <th>�绰</th>
        <th>email</th>
        <th>��ַ</th>
        <th>���ʱ��</th>
        <th>����</th>
        <th>�޸�</th>
        <th>ɾ��</th>

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
        <td><a href="readerModify.jsp?rId=<%=r.getId() %>" target="detail">����</a></td>
        <td><a href="readerDelete.jsp?rId=<%=r.getId() %>" target="detail">ɾ��</a></td>

      </tr>
      <%
        
       }
       %>
    </table>    
                    ��<%=pageNo %>ҳ
                   ��<%=pageCount %>ҳ
      <a href="readerSearchResult.jsp?pageNo=1&pageCount=<%=pageCount %><%="&"+strParamValues %>" onclick=" return linkClick(this)" >��ҳ</a>&nbsp            
      <a href="readerSearchResult.jsp?pageNo=<%=pageNo-1 %>&pageCount=<%=pageCount %><%="&"+strParamValues %>" onclick=" return linkClick(this)">��һҳ</a>&nbsp
      
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
      <a href="readerSearchResult.jsp?pageNo=<%=pageNo+1 %>&pageCount=<%=pageCount %><%="&"+strParamValues %>" onclick=" return linkClick(this)" >��һҳ</a>&nbsp
      <a href="readerSearchResult.jsp?pageNo=<%=pageCount%>&pageCount=<%=pageCount %><%="&"+strParamValues %>" onclick=" return linkClick(this)" >ĩҳ</a>

  </body>
</html>
