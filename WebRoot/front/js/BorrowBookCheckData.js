
	
	
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
		                   alert("您的浏览器不支持AJAX!");
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
		       
		        xmlHttp=getXMLHttpRequest();//注意：在此不能写getXMLHttpRequest
		        if(xmlHttp==null){ //浏览器不支持AjAX
		           return false;
		        }
				xmlHttp.open("GET",url,true);
				xmlHttp.onreadystatechange=callBackparseRId; //注意：不能写callBack()
				xmlHttp.send(null); //注意：一定要写上 */
		        
			}
			
			function callBackparseRId(){
		
			  if(xmlHttp.readyState==4){ //xmlHttp.status==200代表找到了请求的页面，并正确返回
			  
			     if(xmlHttp.status==200){    
			      isRIdRight=parseRId(xmlHttp.responseText );
			     }
			     
			  }
			}
			function parseRId(text){
			     text=text.replace(/(^\s*)|(\s*$)/g,"");
			   
                 if(text=="invalid"){
                      document.getElementById("rIdTip").innerHTML="<font color='red'>读者不存在</font>";
                     return false;
                 }else{
                     document.getElementById("rIdTip").innerHTML="<font color='blue'>有效</font>";
                       return true;
                 }
                 
			} 

	         function checkForRId(){
	   	            
	                var rIdObject=document.getElementById("rId");
	                 
			    	if(rIdObject.value.search(/^\s*\s*$/)!=-1){
			          document.getElementById("rIdTip").innerHTML="<font color='red'>Id号不能为空</font>";
			          return false;
			       }else{
			         isRIdExist();//验证是否存在该ID号
                     return isRIdRight;

			       }
	            
	         }
 /* ---------------------------------------checkForBIds-------------------------------------------------------------- */			
		    function isBIdsExist() {
		    	var rIdObject= document.getElementById("rId");
			    var bIdsObject=document.forms["form"].bIds;
		        var url="bIdsValidate.jsp?bIds="+escape(bIdsObject.value)+"&rId="+escape(rIdObject.value);
		       
		        xmlHttp=getXMLHttpRequest();//注意：在此不能写getXMLHttpRequest
		        if(xmlHttp==null){ //浏览器不支持AjAX
		           return false;
		        }
				xmlHttp.open("GET",url,true);
				xmlHttp.onreadystatechange=callBackparseBIds; //注意：不能写callBack()
				xmlHttp.send(null); //注意：一定要写上 
		        
			}
			
			function callBackparseBIds(){
		
			  if(xmlHttp.readyState==4){ //xmlHttp.status==200代表找到了请求的页面，并正确返回
			  
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
                		 str+="<font color='red'>id为："+groups[0]+"的书不存在</font>";                		 
                	 }
                	 if(groups[1].length!=0){
                		 str+="<font color='blue'>id为："+groups[1]+"的书已经借阅并且未还</font>";
                	 }               	 
                	 document.getElementById("bIdsTip").innerHTML=str;
    				
                     return false;
                 }else{
                
                     document.getElementById("bIdsTip").innerHTML="<font color='blue'>有效</font>";
                       return true;
                 }
                 
			} 

         function checkForBIds(){
	   	             
	                var bIdsObject=document.getElementById("bIds");
	                /*alert(bIdsObject.value.search(/((\d+;)*\d+$)|((\d+;)*\d+;$)/));*/
			    	if(bIdsObject.value.search(/(^(\d+;)*\d+$)|(^(\d+;)*\d+;$)/)==-1){			    	
			          document.getElementById("bIdsTip").innerHTML="<font color='red'>书Id号不能为空且只能是bid1;bid2;bid3...格式</font>";
			          return false;
			       }else{
			         isBIdsExist();//验证是否存在该ID号
			        
                     return isBIdsRight;

			       }
	            
	      }
         
         
/* -------------------------------------checkForDate-----------------------------------*/
    	  function checkForDate(dateObject){

	        	  if(dateObject.value.search(/^\s*\d{4}-\d{2}-\d{2}\s\d{2}:\d{2}\s*$/)!=-1){
	        		    document.getElementById(dateObject.id+"Tip").innerHTML="<font color='blue'>有效</font>";
	 	               // form.startDate.name="startDate";
	 	                return true;
	 	          }
	        	 
	 	          if(dateObject.value.search(/(^\s*\d{4}-\d{2}-\d{2}\s*$)|(^\s*\d{4}-\d{2}-\d{2}\s\d{2}:\d{2}:\d{2}\s*$)/)!=-1){
	 	        	 document.getElementById(dateObject.id+"Tip").innerHTML="<font color='blue'>有效</font>";
	                 return true;
	 	              
	 	          }
	 	          
	 	          document.getElementById(dateObject.id+"Tip").innerHTML="<font color='red'>正确的格式为：yyyy-mm-dd hh:mm:ss</font>";
	 	          return false;
	  
	  }
         
/* -----------------------------search-----------------------------------------*/
         function checkForIdAtSearch(idObject){
 	    	if(idObject.value.search(/(^(\d+;)*\d+$)|(^(\d+;)*\d+;$)|(^\s*\s*$)/)==-1){			    	
 	            document.getElementById(idObject.id+"Tip").innerHTML="<font color='red'>只能是bid1;bid2;bid3...格式或不填</font>";
 	         return false;
 	       }else{
 	           document.getElementById(idObject.id+"Tip").innerHTML="<font color='blue'>有效</font>";
 	         return true;
 	       }
 	  }
 	  
 	  function checkForDateAtSearch(dateObject){
 	              if(dateObject.value.search(/^\s*\s*$/)!=-1){
 	        		  document.getElementById(dateObject.id+"Tip").innerHTML="<font color='blue'>有效</font>";
 	 	                return true;
 	        	  }
 	        	  
 	        	  if(dateObject.value.search(/^\s*\d{4}-\d{2}-\d{2}\s\d{2}:\d{2}\s*$/)!=-1){
 	        		    document.getElementById(dateObject.id+"Tip").innerHTML="<font color='blue'>有效</font>";
 	 	               // form.startDate.name="startDate";
 	 	                return true;
 	 	          }
 	        	 
 	 	          if(dateObject.value.search(/(^\s*\d{4}-\d{2}-\d{2}\s*$)|(^\s*\d{4}-\d{2}-\d{2}\s\d{2}:\d{2}:\d{2}\s*$)/)!=-1){
 	 	        	 document.getElementById(dateObject.id+"Tip").innerHTML="<font color='blue'>有效</font>";
  	                 return true;
 	 	              
 	 	          }
 	 	          
 	 	          document.getElementById(dateObject.id+"Tip").innerHTML="<font color='red'>正确的格式为：yyyy-mm-dd hh:mm:ss</font>";
 	 	          return false;
 	  
 	  }
 	  
