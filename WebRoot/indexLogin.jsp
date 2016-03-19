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
				    alert("用户名或密码不正确");
				    //document.getElementById("uIdErr").innerHTML="<font color='red'>用户名或密码不正确</font>";
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
				    alert("用户名或密码不正确");
				    //document.getElementById("uIdErr").innerHTML="<font color='red'>用户名或密码不正确</font>";
				 </script>
            <% }
        }  
  }

%>

	 

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>library首页</title>
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
	         document.getElementById("confirmCodeTip").innerHTML="<font color='red'>请输入正确的验证码</font>";
	      }
	      return isValidate;
	   }
	</script>
</head>

<body>

<div class="contener"  align="center" style="background-color:#FFF; "  >
  <!----------------------------------------------------title-------------------------------------------------------------------------------->
  <div class="title">
    <div class="introductionPic"> <img src="images/librayTitle.PNG" alt="吉林大学珠海学院" width="1098" height="136" align="middle" /> </div>
    &nbsp;
    <div id="menu">
      <table width="1084"  >
        <tr>
          <td><ul id="MenuBar1" class="MenuBarHorizontal">
            <li><a href="#">首页</a></li>
            <li><a href="#" class="MenuBarItemSubmenu">读者服务</a>
              <ul>
                <li><a href="#">科学服务</a></li>
                <li><a href="#">读者荐购</a></li>
                <li><a href="#">超期催还</a></li>
                <li><a href="#">常见问题</a></li>
                <li><a href="#">软件下载</a></li>
                </ul>
              </li>
            <li><a class="MenuBarItemSubmenu" href="#">本馆概况</a>
              <ul>
                <li><a class="MenuBarItemSubmenu" href="#">本馆简介</a>
                  <ul>
                    <li><a href="#">项目 3.1.1</a></li>
                    <li><a href="#">项目 3.1.2</a></li>
                    </ul>
                  </li>
                <li><a href="#">规章制度</a></li>
                <li><a href="#">开馆时间</a></li>
                <li><a href="#">组织结构</a></li>
                <li><a href="#">馆藏分布</a></li>
                </ul>
              </li>
            <li><a href="#" class="MenuBarItemSubmenu">电子资源</a>
              <ul>
                <li><a href="#">中国知网</a></li>
                <li><a href="#">超新星移动图书馆</a></li>
                <li><a href="#">超星百链云图书馆 </a></li>
                <li><a href="#">汉斯出版社电子期刊 </a></li>
                <li><a href="#">MyET英语多媒体资源库 </a></li>
                </ul>
              </li>
            <li><a href="#" class="MenuBarItemSubmenu">本馆动态</a>
              <ul>
                <li><a href="#">图书馆关于调整开馆时间的通知</a></li>
                <li><a href="#">图书馆设廉洁书籍专架</a></li>
                <li><a href="#">图书馆国庆节开馆时间安排</a></li>
                </ul>
              </li>
            <li><a href="#" class="MenuBarItemSubmenu">特色文献</a>
              <ul>
                <li><a href="#"><br />
                  MyET英语多媒体资源库</a></li>
                <li><a href="#">上海图书馆电子报纸导读 </a></li>
                <li><a href="#">图书馆关于清理读者遗留物品的通知</a></li>
                <li><a href="#"><br />
                  图书馆&quot;素质计划&quot;系列讲座之五</a></li>
                </ul>
              </li>
            <li><a href="#" class="MenuBarItemSubmenu">公共查询</a>
              <ul>
                <li><a href="#">Emerald回溯期刊数据库</a></li>
                <li><a href="#">英文万卷书</a></li>
                <li><a href="#">Emerald回溯期刊数据库</a></li>
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
        <div align="left"><img src="images/home.PNG" width="29" height="27" /><a href="">首页</a> <span> &gt; </span><a href="">中文数据库</a></div>
      </div>
    </div>
    <div class="List-Middle" style="margin:0 auto; width: 1100px;">
      <div class="List-Middle-left">
        <div class="List-Middle-left-box1" > <br />
          <div align="left" style="background-color:#9C0; width:200px; height:25px; margin: 0 auto; margin-top: 6px;" > <img src = "images/arrow.PNG" width="27" height="26" /><a href="" target="_blank">书目检索</a> </div>
          <br/>
          <div align="left" style="background-color:#9C0; width: 200px; height: 25px; margin: 0 auto;"> <img src="images/arrow.PNG" width="27" height="26" /><a href="" target="_blank">我的图书馆</a> </div>
          <br/>
          <div align="left" style="background-color:#9C0; width: 200px; height: 25px; margin: 0 auto;"> <img src="images/arrow.PNG" width="27" height="26" /><a href="" target="_blank">CNKI Scholar</a> </div>
          <br/>
        </div>
        <br />
        <div class="List-Middle-left-box2" >
          <div id="Leftbox2title" style="background-color:#063; color: #FFF;"> <strong>本栏目列表</strong> </div>
          <div align="left" border:1px="border:1px" solid="solid" #3e02ff;>
            <li><a href="" >中文数据库</a></li>
            <li><a href="" >外文数据库</a></li>
            <li><a href="">试用数据库</a ></li>
          </div>
        </div>
      </div>
      <div class="List-Middle-right">

         <div class="login_mylibrary">
           登录我的图书馆
         <hr />
         
        </div >
       <div align="center">

          <div class="login">
   <form  name="form" action="indexLogin.jsp" method="post" onsubmit="return checkDate()">
    <input type="hidden" name="action" value="action"></input>
     <table  border="0" width="">


    <tr><td>用户Id：</td>
	    <td><input  type="text" name="uId" id="uId" value='<%=uId==null?"":uId %>' size="30"  maxlength="20">
		<span id="uIdErr"></span>
		</td>
	 </tr>

	 <tr>
	 <td>密码:</td>
	    <td><input  type="password" name="pwd" size="30" value='<%=pwd==null?"":uId %>'  maxlength="20">
		<span id="pwdErr"></span>
		</td>
		
	 </tr>
	 
	 <tr>
		<td>验证码：</td>
		<td>
		<input type="text" name="confirmCode" id="confirmCode" size="10" onblur="checkForConfirmCode()">	   
		    <img src="${pageContext.request.contextPath}/validCodeServlet" id="imageYZ" alt="换一张" 
	                 onclick="reloadValidCode(this)"> 看不清?
	        <input type="button" value="换一张" onclick="refresh();"></input><br/>
	        <span id="confirmCodeTip"></span>
	                 
		</td>
	
	</tr>
	 
	 <tr align="center">
	  <td></td>
	  <td colspan="2">
	                        读者<input  type="radio" name="user" checked="checked"  value="reader">&nbsp&nbsp&nbsp
	                        管理员<input  type="radio" name="user"   value="manager">
	  </td>
	  
	 </tr>
	

	  <tr>
	  <td></td>
	   <td align="left">
	       <input type="submit" value="确定">  
	   </td>
	 </tr>
   </table>
  </form>
          </div>

          <div class="login_Tooltip ">提示：
            <ul>
              <li>读者用户名为读者的证件号,条码号或者您的Email,具体可以自行选择 </li>
              <li><br />
              </li>
              <li>读者信息查询的初始密码有两种可能情况：<br />
                <br />
                1.读者证件号（一般即为您的学号） <br />
                2.借书证上的条形码号 </li>
              <li><br />
              </li>
              <li>密码在进入系统后可由读者重新设置 </li>
              <li><br />
              </li>
              <li>Email由您自行设定，登陆后可以修改 </li>
              <li><br />
              </li>
              <li>密码取回需要您首先验证您的Email</li>
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
    <p> 学院主页丨中国国家图书馆丨中国高等教育文献保障系统丨中国高校人文社会科学文献中心丨珠海市国际信息检索中心 Copyright © 2013 吉林</p>
    <div class="Footer-links"></div>
    电话：0756-7626255 广东珠海 金湾草堂 </div>
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
