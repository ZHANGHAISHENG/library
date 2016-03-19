	//  --AJAX ----------------------------------------------------------------
	var xmlHttp;
	var isvalidate=false;
	
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
                   return false;
				}

			}
		}		
		return xmlHttp;
	}
	
	function validate() {

	 //判空
       if(document.getElementById("cateName").value.search(/^\s*\s*$/)!=-1){
        document.getElementById("cateNameTip").innerHTML="<font color='red'>类别名称不能为空</font>";
        return false;
      }
	 //判断类别名是否已存在   
        var cateName=document.getElementById("cateName") ;
        var pId=document.getElementById("pId");
        
        var url="validate.jsp?pId="+escape(pId.value)+"&cateName="+cateName.value;

        xmlHttp=getXMLHttpRequest();//注意：在此不能写getXMLHttpRequest
        if(xmlHttp==null){//浏览器不支持AJAX
           return false;
        }
        
		xmlHttp.open("GET",url,true);
		xmlHttp.onreadystatechange=callBack; //注意：不能写callBack()
		xmlHttp.send(null); //注意：一定要写上 */

	}

	function callBack(){
	  
	  if(xmlHttp.readyState==4){ //xmlHttp.status==200代表找到了请求的页面，并正确返回
	    
	     if(xmlHttp.status==200){    
	      
	       var msg=xmlHttp.responseXML.getElementsByTagName("msg")[0];

	       isvalidate=setMsg(msg.childNodes[0].nodeValue);
	     }
	     
	  }
	}
	
	function setMsg(msg){
	  
	  if(msg=="invalid"){
	    document.getElementById("cateNameTip").innerHTML="<font color='red'>无效!该类别下已经拥有此类别，请重新输入</font>";
        
        return false;
	  }else{
	    document.getElementById("cateNameTip").innerHTML="<font color='blue'>有效</font>";
         return true;
	  
	  }

	}
	
	