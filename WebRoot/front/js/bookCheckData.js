
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
		                   alert("�����������֧��AJAX!");
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
			      isBookNameRight=parse(xmlHttp.responseText );
			     }
			     
			  }
			}
			function parse(text){
			     text=text.replace(/(^\s*)|(\s*$)/g,"");

                 if(text=="invalid"){
                      document.getElementById("bookNameTip").innerHTML="<font color='red'>��������Ѿ����ڸ�ͼ��</font>";
                     
                     return false;
                 }else{
                     document.getElementById("bookNameTip").innerHTML="<font color='blue'>��Ч</font>";

                       return true;
                 }
                 
			} 
			
			 function checkForBookName(){

			    var bNObject=document.getElementById("bookName");
			    if(bNObject.value.search(/^\s*\s*$/)!=-1){ //�п�
			       document.getElementById("bookNameTip").innerHTML="<font color='red'>��������Ϊ��</font>";

			       return false;
			    }else{ 
                    bookNameOnBlur();//��֤�Ƿ��ڸ�������Ѿ����ڸ�ͼ��
                    return isBookNameRight;
			       }
			  }
			  
			  function checkForBookSum(){
			        var bSObject=document.getElementById("bookSum");
			    	if(bSObject.value.search(/(^\s*\s*$)|(\D)/)!=-1){
			          document.getElementById("bookSumTip").innerHTML="<font color='red'>�����������Ϊ����ֻ��Ϊ����</font>";

			          return false;
			       }else{
			         document.getElementById("bookSumTip").innerHTML="<font color='blue'>��Ч</font>";

			         return true;
			       }
			     
			  }
			  
	
			  
			  function checkForBookNameAndSum(){
				  return (!checkForBookName()? 
						  checkForBookName() :
						  checkForBookSum());

			  }
	        

	