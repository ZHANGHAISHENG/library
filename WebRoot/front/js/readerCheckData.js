/* ---------------------------------------AJAXSTART-------------------------------------------------------------- */
	
	
	        var xmlHttp;
	        var isRNameRight=false;
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
			
		   function isRIdExist() {
		   
			    var rIdObject=document.forms["form"].rId;

		        var url="validate.jsp?rId="+escape(rIdObject.value);
		       
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
			      isRNameRight=parse(xmlHttp.responseText );
			     }
			     
			  }
			}
			function parse(text){
			     text=text.replace(/(^\s*)|(\s*$)/g,"");
			   
                 if(text=="invalid"){
                      document.getElementById("rIdTip").innerHTML="<font color='red'>�����Ѵ���</font>";
                     return false;
                 }else{
                     document.getElementById("rIdTip").innerHTML="<font color='blue'>��Ч</font>";
                       return true;
                 }
                 
			} 
			
	/* ---------------------------------------AJAXENd-------------------------------------------------------------- */
	
	         function checkForId(){
	   	            
	                var rIdObject=document.getElementById("rId");
			    	if(rIdObject.value.search(/^\s*\s*$/)!=-1){
			          document.getElementById("rIdTip").innerHTML="<font color='red'>Id�Ų���Ϊ��</font>";
			          return false;
			       }else{
			         isRIdExist();//��֤�Ƿ���ڸ�ID��
                     return isRNameRight;

			       }
	            
	         }
	         
	         function checkForRName(){
	            var rNObject=document.getElementById("rName");
			    if(rNObject.value.search(/^\s*\s*$/)!=-1){ //�п�
			       document.getElementById("rNameTip").innerHTML="<font color='red'>�û�������Ϊ��</font>";
			       return false;
			    }else{ 
			       document.getElementById("rNameTip").innerHTML="<font color='blue'>��Ч</font>";
                    return true;
			       }
	         }
	         
	         function checkForRPassword(){
	         
	                var rPObject=document.getElementById("rPassword");
	                var rPCObject=document.getElementById("rPConfirm");
	                var rPValue=rPObject.value.replace(/(^\s+)|(\s+$)/,"");
	                var rPCValue=rPCObject.value.replace(/(^\s+)|(\s+$)/,"");
	                
			    	if(rPValue!=rPCValue){
			          document.getElementById("rPasswordTip").innerHTML="<font color='red'>�����������벻һ�£�����������</font>";
                      document.getElementById("rPConfirmTip").innerHTML="<font color='red'>�����������벻һ�£�����������</font>";
			          return false;
			        }else{
			         document.getElementById("rPasswordTip").innerHTML="<font color='blue'>��Ч</font>";
			         document.getElementById("rPConfirmTip").innerHTML="<font color='blue'>��Ч</font>";
			         return true;
			       }
	         }
	         function checkForPhone(){
	        	    var rPhoneObject=document.getElementById("rPhone");
	        	    var rPhoneValue=rPhoneObject.value.replace(/(^\s+)|(\s+$)/,"");
	        	    
			    	if(rPhoneValue.search(/\D/)!=-1){
			           document.getElementById("rPhoneTip").innerHTML="<font color='red'>�绰ֻ��Ϊ���ӻ�Ϊ����</font>";
			          return false;
			       }else{
			    	   document.getElementById("rPhoneTip").innerHTML="<font color='blue'>��Ч</font>";
				       return true;
			       }
	         }
	         
	         function checkForREmail(){
	               var rEmailObject=document.getElementById("rEmail");
	               var rEmailValue=rEmailObject.value.replace(/(^\s+)|(\s+$)/,"");
	               if(rEmailValue==""){
	            	    document.getElementById("rEmailTip").innerHTML="<font color='blue'>��Ч</font>";
	                 return true;
	               }

	               if(rEmailValue.search(/^[\w.-]+@[\w.-]+\.[\w]+$/)==-1){

	                  document.getElementById("rEmailTip").innerHTML="<font color='red'>��ʽ����ȷ</font>";
	                  return false;
	               }else{
	                  document.getElementById("rEmailTip").innerHTML="<font color='blue'>��Ч</font>";
	                  return true;
	               }
	         }
	         
	         
	           function   checkForStartDate(){
	        	  if(form.startDate.value.search(/^\s*\s*$/)!=-1){
	        		  document.getElementById("startDateTip").innerHTML="<font color='blue'>��Ч</font>";
	 	                return true;
	        	  }
	        	  
	        	  if(form.startDate.value.search(/^\s*\d{4}-\d{2}-\d{2}\s\d{2}:\d{2}\s*$/)!=-1){
	        		    document.getElementById("startDateTip").innerHTML="<font color='blue'>��Ч</font>";
	 	               // form.startDate.name="startDate";
	 	                return true;
	 	          }
	        	 
	 	          if(form.startDate.value.search(/(^\s*\d{4}-\d{2}-\d{2}\s*$)|(^\s*\d{4}-\d{2}-\d{2}\s\d{2}:\d{2}:\d{2}\s*$)/)!=-1){
	 	        	 document.getElementById("startDateTip").innerHTML="<font color='blue'>��Ч</font>";
 	                 return true;
	 	              
	 	          }
	 	          
		 	          document.getElementById("startDateTip").innerHTML="<font color='red'>��ȷ�ĸ�ʽΪ��yyyy-mm-dd hh:mm:ss</font>";
		 	          return false;
	 	          
	 	          
	           }
	          
	            function checkForEndDate(){
	               if(form.endDate.value.search(/^\s*\s*$/)!=-1){
		        		  document.getElementById("endDateTip").innerHTML="<font color='blue'>��Ч</font>";
		 	                return true;
		           }
	        	   if(form.endDate.value.search(/^\s*\d{4}-\d{2}-\d{2}\s\d{2}:\d{2}\s*$/)!=-1){
	        		    document.getElementById("endDateTip").innerHTML="<font color='blue'>��Ч</font>";
	 	                return true;
	 	           }

	 	          if(form.endDate.value.search(/(^\s*\d{4}-\d{2}-\d{2}\s*$)|(^\s*\d{4}-\d{2}-\d{2}\s\d{2}:\d{2}:\d{2}\s*$)/)!=-1){
	 	        	  document.getElementById("endDateTip").innerHTML="<font color='blue'>��Ч</font>";    
	 	               return false;
	 	          }
	 	          
	 	          document.getElementById("endDateTip").innerHTML="<font color='red'>��ȷ�ĸ�ʽΪ��yyyy-mm-dd hh:mm:ss</font>";
	 	          return false;
	           }
	            
	            
	            
	            
	           
	   