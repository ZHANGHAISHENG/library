
	
	
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
 /* ---------------------------------------checkForRId-------------------------------------------------------------- */			
		   function isRIdExist() {
		   
			    var rIdObject=document.getElementById("rId");
                
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
                	 if(text==""){
                       document.getElementById("rIdTip").innerHTML="<font color='red'>�ö���û��ͼ�鳬��</font>";  
                       return false;
                	 }else{
                		 addCheckBook(text);
                		 document.getElementById("rIdTip").innerHTML="<font color='blue'>��Ч</font>";
                         return true;
                	 }
                    
                 }
                 
			} 
			function addCheckBook( text){			
				var books=text.split(";");

				//ɾ��ԭ����ͼ��checkBox
				var divObjectTemp=document.getElementById("CheckBoxs");
				if(divObjectTemp!=null){
					document.getElementById("book").removeChild(divObjectTemp);
				}
				
				//���ͼ��checkBox
				var divObject = document.createElement('div');				
				divObject.setAttribute('id', 'CheckBoxs'); 
				document.getElementById("book").appendChild(divObject);
				for(var i=0;i<books.length;i++){
	
					var book=books[i].split("_");
					var spanObject = document.createElement('span'); //��������ı�

					spanObject.setAttribute('id', 'span'+book[0]); 
					spanObject.innerHTML=(book[2]=='exist'?
						                      "<font color='#c0c0c0'>"+book[1]+"</font>":
							              book[1]);
					
					var inputObject = document.createElement('input');
				    inputObject.setAttribute('type', 'checkbox'); 
				    inputObject.setAttribute('name', 'bIds'); 
				  //ʧЧ��  inputObject.setAttribute('checked', book[2]=='exist'?"checked":""); 
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
			          document.getElementById("rIdTip").innerHTML="<font color='red'>Id�Ų���Ϊ��</font>";
			          return false;
			       }else{
			         isRIdExist();//��֤�Ƿ���ڸ�ID��
                     return isRIdRight;

			       }
	            
	         }
 /* ---------------------------------------checkForBIds-------------------------------------------------------------- */			
		    function isBIdsExist() {
		    	var rIdObject=document.forms["form"].rId;
		    	if(rIdObject.value.search(/^\s*\s*$/)!=-1){
		    		 document.getElementById("rIdTip").innerHTML="<font color='red'>����д����Id</font>";
		    		return false;
		    	}
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
                 if(text!=""){
                      document.getElementById("bIdsTip").innerHTML="<font color='red'>�ö���û�н�Id��Ϊ��"+text+"����</font>";
                     return false;
                 }else{
                
                     document.getElementById("bIdsTip").innerHTML="<font color='blue'>��Ч</font>";
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
	        		    document.getElementById(dateObject.id+"Tip").innerHTML="<font color='blue'>��Ч</font>";
	 	               // form.startDate.name="startDate";
	 	                return true;
	 	          }        
	 	          if(dateObject.value.search(/(^\s*\d{4}-\d{2}-\d{2}\s\d{2}:\d{2}:\d{2}\.\d{1}\s*$)|(^\s*\d{4}-\d{2}-\d{2}\s\d{2}:\d{2}:\d{2}\s*$)/)!=-1){
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
 	  
