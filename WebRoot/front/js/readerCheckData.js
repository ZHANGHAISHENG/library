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
		                   alert("您的浏览器不支持AJAX!");
		                   return null;
						}
		
					}
				}		
				return xmlHttp;
			}
			
		   function isRIdExist() {
		   
			    var rIdObject=document.forms["form"].rId;

		        var url="validate.jsp?rId="+escape(rIdObject.value);
		       
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
			      isRNameRight=parse(xmlHttp.responseText );
			     }
			     
			  }
			}
			function parse(text){
			     text=text.replace(/(^\s*)|(\s*$)/g,"");
			   
                 if(text=="invalid"){
                      document.getElementById("rIdTip").innerHTML="<font color='red'>读者已存在</font>";
                     return false;
                 }else{
                     document.getElementById("rIdTip").innerHTML="<font color='blue'>有效</font>";
                       return true;
                 }
                 
			} 
			
	/* ---------------------------------------AJAXENd-------------------------------------------------------------- */
	
	         function checkForId(){
	   	            
	                var rIdObject=document.getElementById("rId");
			    	if(rIdObject.value.search(/^\s*\s*$/)!=-1){
			          document.getElementById("rIdTip").innerHTML="<font color='red'>Id号不能为空</font>";
			          return false;
			       }else{
			         isRIdExist();//验证是否存在该ID号
                     return isRNameRight;

			       }
	            
	         }
	         
	         function checkForRName(){
	            var rNObject=document.getElementById("rName");
			    if(rNObject.value.search(/^\s*\s*$/)!=-1){ //判空
			       document.getElementById("rNameTip").innerHTML="<font color='red'>用户名不能为空</font>";
			       return false;
			    }else{ 
			       document.getElementById("rNameTip").innerHTML="<font color='blue'>有效</font>";
                    return true;
			       }
	         }
	         
	         function checkForRPassword(){
	         
	                var rPObject=document.getElementById("rPassword");
	                var rPCObject=document.getElementById("rPConfirm");
	                var rPValue=rPObject.value.replace(/(^\s+)|(\s+$)/,"");
	                var rPCValue=rPCObject.value.replace(/(^\s+)|(\s+$)/,"");
	                
			    	if(rPValue!=rPCValue){
			          document.getElementById("rPasswordTip").innerHTML="<font color='red'>两次密码输入不一致，请重新输入</font>";
                      document.getElementById("rPConfirmTip").innerHTML="<font color='red'>两次密码输入不一致，请重新输入</font>";
			          return false;
			        }else{
			         document.getElementById("rPasswordTip").innerHTML="<font color='blue'>有效</font>";
			         document.getElementById("rPConfirmTip").innerHTML="<font color='blue'>有效</font>";
			         return true;
			       }
	         }
	         function checkForPhone(){
	        	    var rPhoneObject=document.getElementById("rPhone");
	        	    var rPhoneValue=rPhoneObject.value.replace(/(^\s+)|(\s+$)/,"");
	        	    
			    	if(rPhoneValue.search(/\D/)!=-1){
			           document.getElementById("rPhoneTip").innerHTML="<font color='red'>电话只能为数子或为不填</font>";
			          return false;
			       }else{
			    	   document.getElementById("rPhoneTip").innerHTML="<font color='blue'>有效</font>";
				       return true;
			       }
	         }
	         
	         function checkForREmail(){
	               var rEmailObject=document.getElementById("rEmail");
	               var rEmailValue=rEmailObject.value.replace(/(^\s+)|(\s+$)/,"");
	               if(rEmailValue==""){
	            	    document.getElementById("rEmailTip").innerHTML="<font color='blue'>有效</font>";
	                 return true;
	               }

	               if(rEmailValue.search(/^[\w.-]+@[\w.-]+\.[\w]+$/)==-1){

	                  document.getElementById("rEmailTip").innerHTML="<font color='red'>格式不正确</font>";
	                  return false;
	               }else{
	                  document.getElementById("rEmailTip").innerHTML="<font color='blue'>有效</font>";
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
	            
	            
	            
	            
	           
	   