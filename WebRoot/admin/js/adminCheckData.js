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
		                   alert("您的浏览器不支持AJAX!");
		                   return null;
						}
		
					}
				}		
				return xmlHttp;
			}
			
		   function isIdExist() {
		   
			    var idObject=document.forms["form"].id;

		        var url="validate.jsp?id="+escape(idObject.value);
		       
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
			    	 isIdRight=parse(xmlHttp.responseText );
			     }
			     
			  }
			}
			function parse(text){
			     text=text.replace(/(^\s*)|(\s*$)/g,"");
			   
                 if(text=="invalid"){
                      document.getElementById("idTip").innerHTML="<font color='red'>管理员已存在</font>";
                     return false;
                 }else{
                     document.getElementById("idTip").innerHTML="<font color='blue'>有效</font>";
                       return true;
                 }
                 
			} 
			
	/* ---------------------------------------AJAXENd-------------------------------------------------------------- */
	
	         function checkForId(){
	   	            
	                var idObject=document.getElementById("id");
			    	if(idObject.value.search(/^\s*\s*$/)!=-1){
			          document.getElementById("idTip").innerHTML="<font color='red'>Id号不能为空</font>";
			          return false;
			       }else{
			         isIdExist();//验证是否存在该ID号
                     return isIdRight;

			       }
	            
	         }
	         
	         function checkForName(){
	            var nObject=document.getElementById("name");
			    if(nObject.value.search(/^\s*\s*$/)!=-1){ //判空
			       document.getElementById("nameTip").innerHTML="<font color='red'>用户名不能为空</font>";
			       return false;
			    }else{ 
			       document.getElementById("nameTip").innerHTML="<font color='blue'>有效</font>";
                    return true;
			       }
	         }
	         
	         function checkForPassword(){
	         
	                var pObject=document.getElementById("password");
	                var pCObject=document.getElementById("pConfirm");
	                var pValue=pObject.value.replace(/(^\s+)|(\s+$)/,"");
	                var pCValue=pCObject.value.replace(/(^\s+)|(\s+$)/,"");
	                
			    	if(pValue!=pCValue){
			          document.getElementById("passwordTip").innerHTML="<font color='red'>两次密码输入不一致，请重新输入</font>";
                      document.getElementById("pConfirmTip").innerHTML="<font color='red'>两次密码输入不一致，请重新输入</font>";
			          return false;
			        }else{
			         document.getElementById("passwordTip").innerHTML="<font color='blue'>有效</font>";
			         document.getElementById("pConfirmTip").innerHTML="<font color='blue'>有效</font>";
			         return true;
			       }
	         }
	         function checkForPhone(){
	        	    var phoneObject=document.getElementById("phone");
	        	    var phoneValue=phoneObject.value.replace(/(^\s+)|(\s+$)/,"");
	        	    
			    	if(phoneValue.search(/\D/)!=-1){
			           document.getElementById("phoneTip").innerHTML="<font color='red'>电话只能为数子或为不填</font>";
			          return false;
			       }else{
			    	   document.getElementById("phoneTip").innerHTML="<font color='blue'>有效</font>";
				       return true;
			       }
	         }
	         

	         
	         
	           function   checkForStartDate(){
	        	  if(form.startDate.value.search(/^\s*\s*$/)!=-1){
	        		  document.getElementById("startDateTip").innerHTML="<font color='blue'>有效</font>";
	 	                return true;
	        	  }
	        	  
	        	  if(form.startDate.value.search(/^\s*\d{4}-\d{2}-\d{2}\s\d{2}:\d{2}\s*$/)!=-1){
	        		    document.getElementById("startDateTip").innerHTML="<font color='blue'>有效</font>";
	 	               // form.startDate.name="startDate";
	 	                return true;
	 	          }
	        	 
	 	          if(form.startDate.value.search(/(^\s*\d{4}-\d{2}-\d{2}\s*$)|(^\s*\d{4}-\d{2}-\d{2}\s\d{2}:\d{2}:\d{2}\s*$)/)!=-1){
	 	        	 document.getElementById("startDateTip").innerHTML="<font color='blue'>有效</font>";
 	                 return true;
	 	              
	 	          }
	 	          
		 	          document.getElementById("startDateTip").innerHTML="<font color='red'>正确的格式为：yyyy-mm-dd hh:mm:ss</font>";
		 	          return false;
	 	          
	 	          
	           }
	          
	            function checkForEndDate(){
	               if(form.endDate.value.search(/^\s*\s*$/)!=-1){
		        		  document.getElementById("endDateTip").innerHTML="<font color='blue'>有效</font>";
		 	                return true;
		           }
	        	   if(form.endDate.value.search(/^\s*\d{4}-\d{2}-\d{2}\s\d{2}:\d{2}\s*$/)!=-1){
	        		    document.getElementById("endDateTip").innerHTML="<font color='blue'>有效</font>";
	 	                return true;
	 	           }

	 	          if(form.endDate.value.search(/(^\s*\d{4}-\d{2}-\d{2}\s*$)|(^\s*\d{4}-\d{2}-\d{2}\s\d{2}:\d{2}:\d{2}\s*$)/)!=-1){
	 	        	  document.getElementById("endDateTip").innerHTML="<font color='blue'>有效</font>";    
	 	               return false;
	 	          }
	 	          
	 	          document.getElementById("endDateTip").innerHTML="<font color='red'>正确的格式为：yyyy-mm-dd hh:mm:ss</font>";
	 	          return false;
	           }
	            
	            
	            
	            
	           
	   