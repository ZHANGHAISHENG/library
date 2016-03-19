
	
	
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
 /* ---------------------------------------checkForRId-------------------------------------------------------------- */			
		   function isRIdExist() {
		   
			    var rIdObject=document.getElementById("rId");
                
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
                	 if(text==""){
                       document.getElementById("rIdTip").innerHTML="<font color='red'>该读者没有图书超期</font>";  
                       return false;
                	 }else{
                		 addCheckBook(text);
                		 document.getElementById("rIdTip").innerHTML="<font color='blue'>有效</font>";
                         return true;
                	 }
                    
                 }
                 
			} 
			function addCheckBook( text){			
				var books=text.split(";");

				//删除原来的图书checkBox
				var divObjectTemp=document.getElementById("CheckBoxs");
				if(divObjectTemp!=null){
					document.getElementById("book").removeChild(divObjectTemp);
				}
				
				//添加图书checkBox
				var divObject = document.createElement('div');				
				divObject.setAttribute('id', 'CheckBoxs'); 
				document.getElementById("book").appendChild(divObject);
				for(var i=0;i<books.length;i++){
	
					var book=books[i].split("_");
					var spanObject = document.createElement('span'); //方便添加文本

					spanObject.setAttribute('id', 'span'+book[0]); 
					spanObject.innerHTML=(book[2]=='exist'?
						                      "<font color='#c0c0c0'>"+book[1]+"</font>":
							              book[1]);
					
					var inputObject = document.createElement('input');
				    inputObject.setAttribute('type', 'checkbox'); 
				    inputObject.setAttribute('name', 'bIds'); 
				  //失效：  inputObject.setAttribute('checked', book[2]=='exist'?"checked":""); 
				    inputObject.setAttribute('disabled', book[2]=='exist'?true:false); 
				    inputObject.setAttribute('value', book[0]); 
				    
					spanObject.appendChild(inputObject);
					divObject.appendChild(spanObject);
				}
				
				 
			}
			/*function parseXML(bIds){
				  
				   var childNodes=bIds.childNodes;
				   var category2=document.getElementById("category2");
				   for( i=0;i<childNodes.length;i++){
					   
				       var child=childNodes[i];
				       category2.options[i].text=strPre+child.childNodes[1].childNodes[0].nodeValue;
				       category2.options[i].value=child.childNodes[0].childNodes[0].nodeValue;
				   
				   }
				
				}*/

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
		    	var rIdObject=document.forms["form"].rId;
		    	if(rIdObject.value.search(/^\s*\s*$/)!=-1){
		    		 document.getElementById("rIdTip").innerHTML="<font color='red'>请填写读者Id</font>";
		    		return false;
		    	}
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
                 if(text!=""){
                      document.getElementById("bIdsTip").innerHTML="<font color='red'>该读者没有借Id号为："+text+"的书</font>";
                     return false;
                 }else{
                
                     document.getElementById("bIdsTip").innerHTML="<font color='blue'>有效</font>";
                       return true;
                 }
                 
			} 
			
         function checkForBIds(){
	   	             
	                var Objects=document.getElementById("book");
	                var divObject=Objects.childNodes[1];
	                var spanObjects=divObject.childNodes;
	                for(var i=0;i<spanObjects.length;i++){
	                	var inputObjects=spanObjects[i].childNodes;
	                	//alert(inputObjects[1].nodeName+"---"+inputObjects[1].disabled+"--"+inputObjects[1].checked);
	                	if(inputObjects[1].disabled==false&&inputObjects[1].checked==true){
	                		return true;
	                	}
	                }
	                return false;
	      }
         
         
/* -------------------------------------checkForDate-----------------------------------*/
    	  function checkForDate(dateObject){
	        	  if(dateObject.value.search(/(^\s*\d{4}-\d{2}-\d{2}\s*$)|(^\s*\d{4}-\d{2}-\d{2}\s\d{2}:\d{2}\s*$)/)!=-1){
	        		    document.getElementById(dateObject.id+"Tip").innerHTML="<font color='blue'>有效</font>";
	 	               // form.startDate.name="startDate";
	 	                return true;
	 	          }        
	 	          if(dateObject.value.search(/(^\s*\d{4}-\d{2}-\d{2}\s\d{2}:\d{2}:\d{2}\.\d{1}\s*$)|(^\s*\d{4}-\d{2}-\d{2}\s\d{2}:\d{2}:\d{2}\s*$)/)!=-1){
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
 	  
