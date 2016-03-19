function reloadValidCode(o) { 
    /*路径写法失效：o.src = "${pageContext.request.contextPath }/validCodeServlet?timed=" + new Date().getMilliseconds();*/
    o.src = "validCodeServlet?timed=" + new Date().getMilliseconds(); 

} 

function refresh() { 
   document.getElementById("imageYZ").src = "validCodeServlet?timed=" + new Date().getMilliseconds(); 
} 

var isValidate=false;

function checkForConfirmCode(){//验证验证码是否正确
	ConfirmCode();
}

/*---------------------------------------------------------------------------------*/

var xmlHttp;
function getXMLHttpRequest(){
  var xmlHttp;

  try {
		xmlHttp = new XMLHttpRequest();
		
	} catch (e) {

		try {
			xmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
		} catch (e) {

			try {
				xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
			} catch (e) {
               alert("您的浏览器不支持AJAX!");
               return null;
			}

		}
	}		
	return xmlHttp;
}

function ConfirmCode() {
	var codeObject=document.getElementById("confirmCode");
	if(codeObject.value.search(/^\s*\s*$/)!=-1){//判空，原则上不用，但空时，无法连接到validateAtOnblur.jsp
		document.getElementById("confirmCodeTip").innerHTML="<font color='red'>请输入正确的验证码</font>";
        return false;
	}
    var url="validateAtOnblur.jsp?code="+codeObject.value;
    xmlHttp=getXMLHttpRequest();//注意：在此不能写getXMLHttpRequest
    if(xmlHttp==null){ //浏览器不支持AjAX
       return false;
    }
	xmlHttp.open("GET",url,true);
	xmlHttp.onreadystatechange=callBack; //注意：不能写callBack()
	xmlHttp.send(null); //注意：一定要写上 */
    
}

function callBack(){

  if(xmlHttp.readyState==4){ //xmlHttp.status==200代表找到了请求的页面，并正确返回
     if(xmlHttp.status==200){    
 	   
    	 isValidate= parse(xmlHttp.responseText );
     }
     
  }
}
function parse(text){
     text=text.replace(/(^\s*)|(\s*$)/g,"");

     if(text=="invalid"){
          document.getElementById("confirmCodeTip").innerHTML="<font color='red'>请输入正确的验证码</font>";
         return false;
     }else{
         document.getElementById("confirmCodeTip").innerHTML="<font color='blue'>有效</font>";
           return true;
     }
     
} 