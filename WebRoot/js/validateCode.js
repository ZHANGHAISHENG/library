function reloadValidCode(o) { 
    /*·��д��ʧЧ��o.src = "${pageContext.request.contextPath }/validCodeServlet?timed=" + new Date().getMilliseconds();*/
    o.src = "validCodeServlet?timed=" + new Date().getMilliseconds(); 

} 

function refresh() { 
   document.getElementById("imageYZ").src = "validCodeServlet?timed=" + new Date().getMilliseconds(); 
} 

var isValidate=false;

function checkForConfirmCode(){//��֤��֤���Ƿ���ȷ
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
               alert("�����������֧��AJAX!");
               return null;
			}

		}
	}		
	return xmlHttp;
}

function ConfirmCode() {
	var codeObject=document.getElementById("confirmCode");
	if(codeObject.value.search(/^\s*\s*$/)!=-1){//�пգ�ԭ���ϲ��ã�����ʱ���޷����ӵ�validateAtOnblur.jsp
		document.getElementById("confirmCodeTip").innerHTML="<font color='red'>��������ȷ����֤��</font>";
        return false;
	}
    var url="validateAtOnblur.jsp?code="+codeObject.value;
    xmlHttp=getXMLHttpRequest();//ע�⣺�ڴ˲���дgetXMLHttpRequest
    if(xmlHttp==null){ //�������֧��AjAX
       return false;
    }
	xmlHttp.open("GET",url,true);
	xmlHttp.onreadystatechange=callBack; //ע�⣺����дcallBack()
	xmlHttp.send(null); //ע�⣺һ��Ҫд�� */
    
}

function callBack(){

  if(xmlHttp.readyState==4){ //xmlHttp.status==200�����ҵ��������ҳ�棬����ȷ����
     if(xmlHttp.status==200){    
 	   
    	 isValidate= parse(xmlHttp.responseText );
     }
     
  }
}
function parse(text){
     text=text.replace(/(^\s*)|(\s*$)/g,"");

     if(text=="invalid"){
          document.getElementById("confirmCodeTip").innerHTML="<font color='red'>��������ȷ����֤��</font>";
         return false;
     }else{
         document.getElementById("confirmCodeTip").innerHTML="<font color='blue'>��Ч</font>";
           return true;
     }
     
} 