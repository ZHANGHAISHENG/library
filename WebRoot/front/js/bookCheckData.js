
			var xmlHttp;
            var isBookNameRight=false;
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
			
		   function bookNameOnBlur() {
	
			    var x=document.forms["form"].cateId.selectedIndex;
		        var cateId=document.forms["form"].cateId.options[x];
		        var bookName=document.forms["form"].bookName;

		        var url="validate.jsp?cateId="+escape(cateId.value)+"&bookName="+bookName.value;
		       
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
			      isBookNameRight=parse(xmlHttp.responseText );
			     }
			     
			  }
			}
			function parse(text){
			     text=text.replace(/(^\s*)|(\s*$)/g,"");

                 if(text=="invalid"){
                      document.getElementById("bookNameTip").innerHTML="<font color='red'>该类别下已经存在该图书</font>";
                     
                     return false;
                 }else{
                     document.getElementById("bookNameTip").innerHTML="<font color='blue'>有效</font>";

                       return true;
                 }
                 
			} 
			
			 function checkForBookName(){

			    var bNObject=document.getElementById("bookName");
			    if(bNObject.value.search(/^\s*\s*$/)!=-1){ //判空
			       document.getElementById("bookNameTip").innerHTML="<font color='red'>书名不能为空</font>";

			       return false;
			    }else{ 
                    bookNameOnBlur();//验证是否在该类别下已经存在该图书
                    return isBookNameRight;
			       }
			  }
			  
			  function checkForBookSum(){
			        var bSObject=document.getElementById("bookSum");
			    	if(bSObject.value.search(/(^\s*\s*$)|(\D)/)!=-1){
			          document.getElementById("bookSumTip").innerHTML="<font color='red'>书的总量不能为空且只能为整数</font>";

			          return false;
			       }else{
			         document.getElementById("bookSumTip").innerHTML="<font color='blue'>有效</font>";

			         return true;
			       }
			     
			  }
			  
	
			  
			  function checkForBookNameAndSum(){
				  return (!checkForBookName()? 
						  checkForBookName() :
						  checkForBookSum());

			  }
	        

	