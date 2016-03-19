package bean;

import java.util.ArrayList;

import manager.BookBasketManager;

public class BookBasket {
	 
	 private ArrayList<Book> books;
	 private int num;
	 private int maxNum;

	public BookBasket(){
		
	}

	public ArrayList<Book> getBooks() {
		return books;
	}

	public void setBooks(ArrayList<Book> books) {
		this.books = books;
	}

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}
	
	public int getMaxNum() {
		return maxNum;
	}

	public void setMaxNum(int maxNum) {
		this.maxNum = maxNum;
	}
	
	 public boolean isbNumExceed(){
	   return BookBasketManager.getInstance().isbNumExceed(this); 
	 }
	 
	 public String  getStrAllbookIds(){
		 return BookBasketManager.getInstance().getStrAllbookIds(this);
	 }

	 public boolean bookInBasket(Book b){
		 return BookBasketManager.getInstance().bookInBasket(this, b);
	 }
}
