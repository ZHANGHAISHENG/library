function linkClick(linkObject) {      
	
    var formObject = document.createElement('form');   //创建form对象
     document.body.appendChild(formObject);   //将form对象添加到body中
     formObject.setAttribute('method', 'post');   //或者是：formObject.method="post";
     var url = linkObject.href;   
     var uri = '';   
     var i = url.indexOf('?');   
      
   //从超链接中截取URL,并添加到action属性
     if(i == -1) {   
        formObject.action = url;   
     } else {   
        formObject.action = url.substring(0, i);   //截取到下表为i-1位置
     }   
               
     if( i >= 0 && url.length >= i + 1) {   
        uri = url.substring(i + 1, url.length);  //截取参数部分的字符串 
     }   
  
     var sa = uri.split('&');   
               
 	//添加form对象的参数
     for(var i = 0; i < sa.length; i++) {   
       var isa = sa[i].split('=');         
       var inputObject = document.createElement('input');   
       inputObject.setAttribute('type', 'hidden'); //inputObject.type="hidden";  
       inputObject.setAttribute('name', isa[0]);   
       inputObject.setAttribute('value', isa[1]);   
       formObject.appendChild(inputObject);   
     }   
      
 	//提交form
     formObject.submit();   
     
 	//一定要 return false; 防止 超链接过去         
     return false;   
}  
