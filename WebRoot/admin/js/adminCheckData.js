/* ---------------------------------------AJAXSTART-------------------------------------------------------------- */
	
	
	        var xmlHttp;
	        var isIdRight=false;
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
			
		   function isIdExist() {
		   
			    var idObject=document.forms["form"].id;

		        var url="validate.jsp?id="+escape(idObject.value);
		       
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
			    	 isIdRight=parse(xmlHttp.responseText );
			     }
			     
			  }
			}
			function parse(text){
			     text=text.replace(/(^\s*)|(\s*$)/g,"");
			   
                 if(text=="invalid"){
                      document.getElementById("idTip").innerHTML="<font color='red'>����Ա�Ѵ���</font>";
                     return false;
                 }else{
                     document.getElementById("idTip").innerHTML="<font color='blue'>��Ч</font>";
                       return true;
                 }
                 
			} 
			
	/* ---------------------------------------AJAXENd-------------------------------------------------------------- */
	
	         function checkForId(){
	   	            
	                var idObject=document.getElementById("id");
			    	if(idObject.value.search(/^\s*\s*$/)!=-1){
			          document.getElementById("idTip").innerHTML="<font color='red'>Id�Ų���Ϊ��</font>";
			          return false;
			       }else{
			         isIdExist();//��֤�Ƿ���ڸ�ID��
                     return isIdRight;

			       }
	            
	         }
	         
	         function checkForName(){
	            var nObject=document.getElementById("name");
			    if(nObject.value.search(/^\s*\s*$/)!=-1){ //�п�
			       document.getElementById("nameTip").innerHTML="<font color='red'>�û�������Ϊ��</font>";
			       return false;
			    }else{ 
			       document.getElementById("nameTip").innerHTML="<font color='blue'>��Ч</font>";
                    return true;
			       }
	         }
	         
	         function checkForPassword(){
	         
	                var pObject=document.getElementById("password");
	                var pCObject=document.getElementById("pConfirm");
	                var pValue=pObject.value.replace(/(^\s+)|(\s+$)/,"");
	                var pCValue=pCObject.value.replace(/(^\s+)|(\s+$)/,"");
	                
			    	if(pValue!=pCValue){
			          document.getElementById("passwordTip").innerHTML="<font color='red'>�����������벻һ�£�����������</font>";
                      document.getElementById("pConfirmTip").innerHTML="<font color='red'>�����������벻һ�£�����������</font>";
			          return false;
			        }else{
			         document.getElementById("passwordTip").innerHTML="<font color='blue'>��Ч</font>";
			         document.getElementById("pConfirmTip").innerHTML="<font color='blue'>��Ч</font>";
			         return true;
			       }
	         }
	         function checkForPhone(){
	        	    var phoneObject=document.getElementById("phone");
	        	    var phoneValue=phoneObject.value.replace(/(^\s+)|(\s+$)/,"");
	        	    
			    	if(phoneValue.search(/\D/)!=-1){
			           document.getElementById("phoneTip").innerHTML="<font color='red'>�绰ֻ��Ϊ���ӻ�Ϊ����</font>";
			          return false;
			       }else{
			    	   document.getElementById("phoneTip").innerHTML="<font color='blue'>��Ч</font>";
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
	            
	            
	            
	            
	           
	   