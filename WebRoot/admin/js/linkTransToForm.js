function linkClick(linkObject) {      
	
    var formObject = document.createElement('form');   //����form����
     document.body.appendChild(formObject);   //��form������ӵ�body��
     formObject.setAttribute('method', 'post');   //�����ǣ�formObject.method="post";
     var url = linkObject.href;   
     var uri = '';   
     var i = url.indexOf('?');   
      
   //�ӳ������н�ȡURL,����ӵ�action����
     if(i == -1) {   
        formObject.action = url;   
     } else {   
        formObject.action = url.substring(0, i);   //��ȡ���±�Ϊi-1λ��
     }   
               
     if( i >= 0 && url.length >= i + 1) {   
        uri = url.substring(i + 1, url.length);  //��ȡ�������ֵ��ַ��� 
     }   
  
     var sa = uri.split('&');   
               
 	//���form����Ĳ���
     for(var i = 0; i < sa.length; i++) {   
       var isa = sa[i].split('=');         
       var inputObject = document.createElement('input');   
       inputObject.setAttribute('type', 'hidden'); //inputObject.type="hidden";  
       inputObject.setAttribute('name', isa[0]);   
       inputObject.setAttribute('value', isa[1]);   
       formObject.appendChild(inputObject);   
     }   
      
 	//�ύform
     formObject.submit();   
     
 	//һ��Ҫ return false; ��ֹ �����ӹ�ȥ         
     return false;   
}  
