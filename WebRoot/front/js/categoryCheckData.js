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
                   alert("�����������֧��AJAX!");
                   return false;
				}

			}
		}		
		return xmlHttp;
	}
	
	function validate() {

	 //�п�
       if(document.getElementById("cateName").value.search(/^\s*\s*$/)!=-1){
        document.getElementById("cateNameTip").innerHTML="<font color='red'>������Ʋ���Ϊ��</font>";
        return false;
      }
	 //�ж�������Ƿ��Ѵ���   
        var cateName=document.getElementById("cateName") ;
        var pId=document.getElementById("pId");
        
        var url="validate.jsp?pId="+escape(pId.value)+"&cateName="+cateName.value;

        xmlHttp=getXMLHttpRequest();//ע�⣺�ڴ˲���дgetXMLHttpRequest
        if(xmlHttp==null){//�������֧��AJAX
           return false;
        }
        
		xmlHttp.open("GET",url,true);
		xmlHttp.onreadystatechange=callBack; //ע�⣺����дcallBack()
		xmlHttp.send(null); //ע�⣺һ��Ҫд�� */

	}

	function callBack(){
	  
	  if(xmlHttp.readyState==4){ //xmlHttp.status==200�����ҵ��������ҳ�棬����ȷ����
	    
	     if(xmlHttp.status==200){    
	      
	       var msg=xmlHttp.responseXML.getElementsByTagName("msg")[0];

	       isvalidate=setMsg(msg.childNodes[0].nodeValue);
	     }
	     
	  }
	}
	
	function setMsg(msg){
	  
	  if(msg=="invalid"){
	    document.getElementById("cateNameTip").innerHTML="<font color='red'>��Ч!��������Ѿ�ӵ�д��������������</font>";
        
        return false;
	  }else{
	    document.getElementById("cateNameTip").innerHTML="<font color='blue'>��Ч</font>";
         return true;
	  
	  }

	}
	
	