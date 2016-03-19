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
           strDate=strDate.trim()+" 00:00:00";//ע�⣺�м�ֻ��һ���ո�
        }
        if(strDate.matches("^\\s*\\d{4}-\\d{2}-\\d{2}\\s\\d{2}\\:\\d{2}\\s*$")){
           strDate=strDate.trim()+":00";//ע�⣺�м�ֻ��һ���ո�
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
    
    //��ȡId
    String strId=request.getParameter("id");
    int[] ids=null;//��ʱΪ1
    if(strId!=null&&!strId.trim().equals("")){
      ids=new int[1];//��ʱΪ1
      ids[0]=Integer.parseInt(strId);
    }
    
    //����
    int isRoot=Integer.parseInt(request.getParameter("isRoot"));
   
    //��ȡ�ؼ���
    String keyWord=request.getParameter("keyWord");
    
    //��ȡ�Ա�

    String sex=request.getParameter("sex");

    //��ȡ�绰
    String strPhone=request.getParameter("phone");
    int phone=0;
    if(strPhone!=null&&!strPhone.trim().equals("")){
      phone=Integer.parseInt(strPhone);
    }
 
     //��ȡ��ַ
     String addr=request.getParameter("addr");
     
    //��ȡ�ϼ����ڷ�Χ
    Timestamp startRDate=adjustDate(request,"startRDate"); 
    Timestamp endRDate=adjustDate(request,"endRDate");

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
        <th>����</th>
        <th>�Ա�</th>
        <th>����</th>
        <th>�绰</th>
        <th>��ַ</th>
        <th>ע��ʱ��</th>
        <th>����</th>
        <th>����</th>
        <th>�޸�</th>
        <th>ɾ��</th>

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
        <td><%=admin.getIsRoot()==0?"��ͨ����Ա":"��������Ա" %></td>
        <td><%=admin.getAdminDesc() %></td>
        <td><a href="adminModify.jsp?id=<%=admin.getId() %>" target="detail">����</a></td>
        <td><a href="adminDelete.jsp?id=<%=admin.getId() %>" target="detail">ɾ��</a></td>

      </tr>
      <%
        
       }
       %>
    </table>    
                    ��<%=pageNo %>ҳ
                   ��<%=pageCount %>ҳ
      <a href="adminSearchResult.jsp?pageNo=1&pageCount=<%=pageCount %><%="&"+strParamValues %>" onclick=" return linkClick(this)" >��ҳ</a>&nbsp            
      <a href="adminSearchResult.jsp?pageNo=<%=pageNo-1 %>&pageCount=<%=pageCount %><%="&"+strParamValues %>" onclick=" return linkClick(this)">��һҳ</a>&nbsp
      
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
      <a href="adminSearchResult.jsp?pageNo=<%=pageNo+1 %>&pageCount=<%=pageCount %><%="&"+strParamValues %>" onclick=" return linkClick(this)" >��һҳ</a>&nbsp
      <a href="adminSearchResult.jsp?pageNo=<%=pageCount%>&pageCount=<%=pageCount %><%="&"+strParamValues %>" onclick=" return linkClick(this)" >ĩҳ</a>

  </body>
</html>
