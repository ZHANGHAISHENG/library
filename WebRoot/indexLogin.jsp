<%@page import="manager.AdministratorManager"%>
<%@ page language="java" import="java.util.*" pageEncoding="GB18030"%>
<%@page import="manager.ReaderManager"%>
<%@page import="bean.*"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

%>

<%
  request.setCharacterEncoding("GB18030");
  String action=request.getParameter("action");

  String uId=request.getParameter("uId");
  String pwd=request.getParameter("pwd");
  String user=request.getParameter("user");
  if(action!=null&&!action.trim().equals("")){

        Reader r=new Reader();
        Administrator admin=new Administrator();
        boolean b=false;
        boolean isReader=true;

        if(user!=null&&user.trim().equals("manager")){
            int adminId=Integer.parseInt(uId);
            b=AdministratorManager.getInstance().loginCheck(admin,adminId,pwd);
            isReader=false;
            if(b){
                System.out.println("admin="+admin+"isRoot="+admin.getIsRoot());
                session.setAttribute("admin" ,admin);
                response.sendRedirect("admin/adminIndex.jsp");
                 return ;
            }else{%>
                 <script>
				    alert("�û��������벻��ȷ");
				    //document.getElementById("uIdErr").innerHTML="<font color='red'>�û��������벻��ȷ</font>";
				 </script>
            <% }
        }else{         
             b=ReaderManager.getInstance().loginCheck(r,uId, pwd);
             if(b){
                 BookBasket basket=new BookBasket();
	          basket.setNum(0);
	          basket.setBooks(new ArrayList<Book>());
	          session.setAttribute("bookBasket", basket);
	          session.setAttribute("reader" ,r);
		      response.sendRedirect("front/indexMyLibrary.jsp");
		      return ;
             }else{%>
                 <script>
				    alert("�û��������벻��ȷ");
				    //document.getElementById("uIdErr").innerHTML="<font color='red'>�û��������벻��ȷ</font>";
				 </script>
            <% }
        }  
  }

%>

	 

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>library��ҳ</title>
<style type="text/css">
div.List-Middle-left {	border:1px solid  #0C0;
	border-left:solid;
	float:left;
	height:500px;
	width:300px;
	background-color: #FFF;
}
div.List-Middle-left-box1 {	border:1px solid #0C0;
	border-left:solid;
}
div.List-Middle-left-box2 {	border:1px solid #0C0;
	border-left:solid;
	margin-top: 12px;
}
div.List-Middle-right {	border:1px solid #0C0;
	border-left:solid;
	height:500px;
	width:720px;
	float:right;
}
div.login{
	border-left:0;
	height:400px;
	width:380px;
	background-color: #FFF;
	float:left;
	}
	
div.login_Tooltip{
	height:400px;
	width:300px;
	float:right;
	}


</style>
<script src="SpryAssets/SpryMenuBar.js" type="text/javascript"></script>
<link href="SpryAssets/SpryMenuBarHorizontal.css" rel="stylesheet" type="text/css" />
<style type="text/css">
body,td,th {
	color: #009;
}
</style>

	<script src="js/validateCode.js"></script>
	<script>
	   function checkDate(){
	      if(!isValidate){
	         document.getElementById("confirmCodeTip").innerHTML="<font color='red'>��������ȷ����֤��</font>";
	      }
	      return isValidate;
	   }
	</script>
</head>

<body>

<div class="contener"  align="center" style="background-color:#FFF; "  >
  <!----------------------------------------------------title-------------------------------------------------------------------------------->
  <div class="title">
    <div class="introductionPic"> <img src="images/librayTitle.PNG" alt="���ִ�ѧ�麣ѧԺ" width="1098" height="136" align="middle" /> </div>
    &nbsp;
    <div id="menu">
      <table width="1084"  >
        <tr>
          <td><ul id="MenuBar1" class="MenuBarHorizontal">
            <li><a href="#">��ҳ</a></li>
            <li><a href="#" class="MenuBarItemSubmenu">���߷���</a>
              <ul>
                <li><a href="#">��ѧ����</a></li>
                <li><a href="#">���߼���</a></li>
                <li><a href="#">���ڴ߻�</a></li>
                <li><a href="#">��������</a></li>
                <li><a href="#">�������</a></li>
                </ul>
              </li>
            <li><a class="MenuBarItemSubmenu" href="#">���ݸſ�</a>
              <ul>
                <li><a class="MenuBarItemSubmenu" href="#">���ݼ��</a>
                  <ul>
                    <li><a href="#">��Ŀ 3.1.1</a></li>
                    <li><a href="#">��Ŀ 3.1.2</a></li>
                    </ul>
                  </li>
                <li><a href="#">�����ƶ�</a></li>
                <li><a href="#">����ʱ��</a></li>
                <li><a href="#">��֯�ṹ</a></li>
                <li><a href="#">�ݲطֲ�</a></li>
                </ul>
              </li>
            <li><a href="#" class="MenuBarItemSubmenu">������Դ</a>
              <ul>
                <li><a href="#">�й�֪��</a></li>
                <li><a href="#">�������ƶ�ͼ���</a></li>
                <li><a href="#">���ǰ�����ͼ��� </a></li>
                <li><a href="#">��˹����������ڿ� </a></li>
                <li><a href="#">MyETӢ���ý����Դ�� </a></li>
                </ul>
              </li>
            <li><a href="#" class="MenuBarItemSubmenu">���ݶ�̬</a>
              <ul>
                <li><a href="#">ͼ��ݹ��ڵ�������ʱ���֪ͨ</a></li>
                <li><a href="#">ͼ����������鼮ר��</a></li>
                <li><a href="#">ͼ��ݹ���ڿ���ʱ�䰲��</a></li>
                </ul>
              </li>
            <li><a href="#" class="MenuBarItemSubmenu">��ɫ����</a>
              <ul>
                <li><a href="#"><br />
                  MyETӢ���ý����Դ��</a></li>
                <li><a href="#">�Ϻ�ͼ��ݵ��ӱ�ֽ���� </a></li>
                <li><a href="#">ͼ��ݹ����������������Ʒ��֪ͨ</a></li>
                <li><a href="#"><br />
                  ͼ���&quot;���ʼƻ�&quot;ϵ�н���֮��</a></li>
                </ul>
              </li>
            <li><a href="#" class="MenuBarItemSubmenu">������ѯ</a>
              <ul>
                <li><a href="#">Emerald�����ڿ����ݿ�</a></li>
                <li><a href="#">Ӣ�������</a></li>
                <li><a href="#">Emerald�����ڿ����ݿ�</a></li>
                </ul>
              </li>
          </ul></td>
</tr>
</table>
      <table width="1084"  >
        <tr> </tr>
      </table>
    </div>
</div>
  <!----------------------------------------------------list_contener------------------------------------------------------------------------>
  <div class="list_contener" >
    <div id="Link" style="text-align:left;width: 1100px; ">
      <div >
        <div align="left"><img src="images/home.PNG" width="29" height="27" /><a href="">��ҳ</a> <span> &gt; </span><a href="">�������ݿ�</a></div>
      </div>
    </div>
    <div class="List-Middle" style="margin:0 auto; width: 1100px;">
      <div class="List-Middle-left">
        <div class="List-Middle-left-box1" > <br />
          <div align="left" style="background-color:#9C0; width:200px; height:25px; margin: 0 auto; margin-top: 6px;" > <img src = "images/arrow.PNG" width="27" height="26" /><a href="" target="_blank">��Ŀ����</a> </div>
          <br/>
          <div align="left" style="background-color:#9C0; width: 200px; height: 25px; margin: 0 auto;"> <img src="images/arrow.PNG" width="27" height="26" /><a href="" target="_blank">�ҵ�ͼ���</a> </div>
          <br/>
          <div align="left" style="background-color:#9C0; width: 200px; height: 25px; margin: 0 auto;"> <img src="images/arrow.PNG" width="27" height="26" /><a href="" target="_blank">CNKI Scholar</a> </div>
          <br/>
        </div>
        <br />
        <div class="List-Middle-left-box2" >
          <div id="Leftbox2title" style="background-color:#063; color: #FFF;"> <strong>����Ŀ�б�</strong> </div>
          <div align="left" border:1px="border:1px" solid="solid" #3e02ff;>
            <li><a href="" >�������ݿ�</a></li>
            <li><a href="" >�������ݿ�</a></li>
            <li><a href="">�������ݿ�</a ></li>
          </div>
        </div>
      </div>
      <div class="List-Middle-right">

         <div class="login_mylibrary">
           ��¼�ҵ�ͼ���
         <hr />
         
        </div >
       <div align="center">

          <div class="login">
   <form  name="form" action="indexLogin.jsp" method="post" onsubmit="return checkDate()">
    <input type="hidden" name="action" value="action"></input>
     <table  border="0" width="">


    <tr><td>�û�Id��</td>
	    <td><input  type="text" name="uId" id="uId" value='<%=uId==null?"":uId %>' size="30"  maxlength="20">
		<span id="uIdErr"></span>
		</td>
	 </tr>

	 <tr>
	 <td>����:</td>
	    <td><input  type="password" name="pwd" size="30" value='<%=pwd==null?"":uId %>'  maxlength="20">
		<span id="pwdErr"></span>
		</td>
		
	 </tr>
	 
	 <tr>
		<td>��֤�룺</td>
		<td>
		<input type="text" name="confirmCode" id="confirmCode" size="10" onblur="checkForConfirmCode()">	   
		    <img src="${pageContext.request.contextPath}/validCodeServlet" id="imageYZ" alt="��һ��" 
	                 onclick="reloadValidCode(this)"> ������?
	        <input type="button" value="��һ��" onclick="refresh();"></input><br/>
	        <span id="confirmCodeTip"></span>
	                 
		</td>
	
	</tr>
	 
	 <tr align="center">
	  <td></td>
	  <td colspan="2">
	                        ����<input  type="radio" name="user" checked="checked"  value="reader">&nbsp&nbsp&nbsp
	                        ����Ա<input  type="radio" name="user"   value="manager">
	  </td>
	  
	 </tr>
	

	  <tr>
	  <td></td>
	   <td align="left">
	       <input type="submit" value="ȷ��">  
	   </td>
	 </tr>
   </table>
  </form>
          </div>

          <div class="login_Tooltip ">��ʾ��
            <ul>
              <li>�����û���Ϊ���ߵ�֤����,����Ż�������Email,�����������ѡ�� </li>
              <li><br />
              </li>
              <li>������Ϣ��ѯ�ĳ�ʼ���������ֿ��������<br />
                <br />
                1.����֤���ţ�һ�㼴Ϊ����ѧ�ţ� <br />
                2.����֤�ϵ�������� </li>
              <li><br />
              </li>
              <li>�����ڽ���ϵͳ����ɶ����������� </li>
              <li><br />
              </li>
              <li>Email���������趨����½������޸� </li>
              <li><br />
              </li>
              <li>����ȡ����Ҫ��������֤����Email</li>
            </ul>
            <p align="left">&nbsp;</p>
           
          </div>
       </div>
      </div>
    </div>
  </div>
  <!----------------------------------------------------Footer------------------------------------------------------------------------>
  <div style="clear:both;"></div>
  <div class="Footer">
    <p> ѧԺ��ҳح�й�����ͼ���ح�й��ߵȽ������ױ���ϵͳح�й���У��������ѧ��������ح�麣�й�����Ϣ�������� Copyright �0�8 2013 ����</p>
    <div class="Footer-links"></div>
    �绰��0756-7626255 �㶫�麣 ������� </div>
  <div class="title">
    <div>
      <table width="1084"  >
        <tr> </tr>
      </table>
    </div>
  </div>
</div>
<script type="text/javascript">
var MenuBar1 = new Spry.Widget.MenuBar("MenuBar1", {imgDown:"SpryAssets/SpryMenuBarDownHover.gif", imgRight:"SpryAssets/SpryMenuBarRightHover.gif"});
</script>
</body>
</html>
