package manager;

import com.sun.org.apache.bcel.internal.generic.IF_ACMPEQ;

import bean.Book;
import bean.BookBasket;
import dao.BookDAO;

public class BookBasketManager {
 private static BookBasketManager bm=null;
	 
	 static{
		 if(bm==null){
			 bm=new BookBasketManager();
		 }

	 }
	 private BookBasketManager(){
		 
	 }
	 
	 public static  BookBasketManager getInstance(){
		   return bm; 
	 }
	 
	 public boolean isbNumExceed(BookBasket bBasket){
		 if(bBasket.getNum()>10){//暂且为10，之后再配置文件总设置
			 return false;
		 }
		 return true;
	 }
	 
	public String  getStrAllbookIds(BookBasket bBasket){
		String strIds="";
		for(Book b:bBasket.getBooks()){
			strIds+=b.getId()+";";
		}  
		int last=strIds.lastIndexOf(";");
		if(last>0){
			strIds=strIds.substring(0, last);
		}
		return strIds;
	}
	
	
	public boolean bookInBasket(BookBasket bBasket,Book b){
		if(bBasket.getBooks().contains(b)){
			return true;
		}else{
			return false;
		}
	}
}
