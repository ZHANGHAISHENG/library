
	
	
	        var xmlHttp;
	        var isRIdRight=false;
	        var isBIdsRight=false;
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
 /* ---------------------------------------checkForId-------------------------------------------------------------- */			
		   function isRIdExist() {
		   
			    var rIdObject=document.forms["form"].rId;

		        var url="RIdValidate.jsp?rId="+escape(rIdObject.value);
		       
		        xmlHttp=getXMLHttpRequest();//ע�⣺�ڴ˲���дgetXMLHttpRequest
		        if(xmlHttp==null){ //�������֧��AjAX
		           return false;
		        }
				xmlHttp.open("GET",url,true);
				xmlHttp.onreadystatechange=callBackparseRId; //ע�⣺����дcallBack()
				xmlHttp.send(null); //ע�⣺һ��Ҫд�� */
		        
			}
			
			function callBackparseRId(){
		
			  if(xmlHttp.readyState==4){ //xmlHttp.status==200�����ҵ��������ҳ�棬����ȷ����
			  
			     if(xmlHttp.status==200){    
			      isRIdRight=parseRId(xmlHttp.responseText );
			     }
			     
			  }
			}
			function parseRId(text){
			     text=text.replace(/(^\s*)|(\s*$)/g,"");
			   
                 if(text=="invalid"){
                      document.getElementById("rIdTip").innerHTML="<font color='red'>���߲�����</font>";
                     return false;
                 }else{
                     document.getElementById("rIdTip").innerHTML="<font color='blue'>��Ч</font>";
                       return true;
                 }
                 
			} 

	         function checkForRId(){
	   	            
	                var rIdObject=document.getElementById("rId");
	                 
			    	if(rIdObject.value.search(/^\s*\s*$/)!=-1){
			          document.getElementById("rIdTip").innerHTML="<font color='red'>Id�Ų���Ϊ��</font>";
			          return false;
			       }else{
			         isRIdExist();//��֤�Ƿ���ڸ�ID��
                     return isRIdRight;

			       }
	            
	         }
 /* ---------------------------------------checkForBIds-------------------------------------------------------------- */			
		    function isBIdsExist() {
		    	var rIdObject= document.getElementById("rId");
			    var bIdsObject=document.forms["form"].bIds;
		        var url="bIdsValidate.jsp?bIds="+escape(bIdsObject.value)+"&rId="+escape(rIdObject.value);
		       
		        xmlHttp=getXMLHttpRequest();//ע�⣺�ڴ˲���дgetXMLHttpRequest
		        if(xmlHttp==null){ //�������֧��AjAX
		           return false;
		        }
				xmlHttp.open("GET",url,true);
				xmlHttp.onreadystatechange=callBackparseBIds; //ע�⣺����дcallBack()
				xmlHttp.send(null); //ע�⣺һ��Ҫд�� 
		        
			}
			
			function callBackparseBIds(){
		
			  if(xmlHttp.readyState==4){ //xmlHttp.status==200�����ҵ��������ҳ�棬����ȷ����
			  
			     if(xmlHttp.status==200){    
			      isBIdsRight=parseBIds(xmlHttp.responseText );
			     }
			     
			  }
			}
			

			function parseBIds(text){
				  
			     text=text.replace(/(^\s*)|(\s*$)/g,"");
			    
                 if(text!="_"){               	
                	 var groups=text.split("_");
                	 var str="";
                	 if(groups[0].length!=0){                		 
                		 str+="<font color='red'>idΪ��"+groups[0]+"���鲻����</font>";                		 
                	 }
                	 if(groups[1].length!=0){
                		 str+="<font color='blue'>idΪ��"+groups[1]+"�����Ѿ����Ĳ���δ��</font>";
                	 }               	 
                	 document.getElementById("bIdsTip").innerHTML=str;
    				
                     return false;
                 }else{
                
                     document.getElementById("bIdsTip").innerHTML="<font color='blue'>��Ч</font>";
                       return true;
                 }
                 
			} 

         function checkForBIds(){
	   	             
	                var bIdsObject=document.getElementById("bIds");
	                /*alert(bIdsObject.value.search(/((\d+;)*\d+$)|((\d+;)*\d+;$)/));*/
			    	if(bIdsObject.value.search(/(^(\d+;)*\d+$)|(^(\d+;)*\d+;$)/)==-1){			    	
			          document.getElementById("bIdsTip").innerHTML="<font color='red'>��Id�Ų���Ϊ����ֻ����bid1;bid2;bid3...��ʽ</font>";
			          return false;
			       }else{
			         isBIdsExist();//��֤�Ƿ���ڸ�ID��
			        
                     return isBIdsRight;

			       }
	            
	      }
         
         
/* -------------------------------------checkForDate-----------------------------------*/
    	  function checkForDate(dateObject){

	        	  if(dateObject.value.search(/^\s*\d{4}-\d{2}-\d{2}\s\d{2}:\d{2}\s*$/)!=-1){
	        		    document.getElementById(dateObject.id+"Tip").innerHTML="<font color='blue'>��Ч</font>";
	 	               // form.startDate.name="startDate";
	 	                return true;
	 	          }
	        	 
	 	          if(dateObject.value.search(/(^\s*\d{4}-\d{2}-\d{2}\s*$)|(^\s*\d{4}-\d{2}-\d{2}\s\d{2}:\d{2}:\d{2}\s*$)/)!=-1){
	 	        	 document.getElementById(dateObject.id+"Tip").innerHTML="<font color='blue'>��Ч</font>";
	                 return true;
	 	              
	 	          }
	 	          
	 	          document.getElementById(dateObject.id+"Tip").innerHTML="<font color='red'>��ȷ�ĸ�ʽΪ��yyyy-mm-dd hh:mm:ss</font>";
	 	          return false;
	  
	  }
         
/* -----------------------------search-----------------------------------------*/
         function checkForIdAtSearch(idObject){
 	    	if(idObject.value.search(/(^(\d+;)*\d+$)|(^(\d+;)*\d+;$)|(^\s*\s*$)/)==-1){			    	
 	            document.getElementById(idObject.id+"Tip").innerHTML="<font color='red'>ֻ����bid1;bid2;bid3...��ʽ����</font>";
 	         return false;
 	       }else{
 	           document.getElementById(idObject.id+"Tip").innerHTML="<font color='blue'>��Ч</font>";
 	         return true;
 	       }
 	  }
 	  
 	  function checkForDateAtSearch(dateObject){
 	              if(dateObject.value.search(/^\s*\s*$/)!=-1){
 	        		  document.getElementById(dateObject.id+"Tip").innerHTML="<font color='blue'>��Ч</font>";
 	 	                return true;
 	        	  }
 	        	  
 	        	  if(dateObject.value.search(/^\s*\d{4}-\d{2}-\d{2}\s\d{2}:\d{2}\s*$/)!=-1){
 	        		    document.getElementById(dateObject.id+"Tip").innerHTML="<font color='blue'>��Ч</font>";
 	 	               // form.startDate.name="startDate";
 	 	                return true;
 	 	          }
 	        	 
 	 	          if(dateObject.value.search(/(^\s*\d{4}-\d{2}-\d{2}\s*$)|(^\s*\d{4}-\d{2}-\d{2}\s\d{2}:\d{2}:\d{2}\s*$)/)!=-1){
 	 	        	 document.getElementById(dateObject.id+"Tip").innerHTML="<font color='blue'>��Ч</font>";
  	                 return true;
 	 	              
 	 	          }
 	 	          
 	 	          document.getElementById(dateObject.id+"Tip").innerHTML="<font color='red'>��ȷ�ĸ�ʽΪ��yyyy-mm-dd hh:mm:ss</font>";
 	 	          return false;
 	  
 	  }
 	  
