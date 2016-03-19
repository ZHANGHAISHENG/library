package bean;

import java.sql.Timestamp;

import sun.awt.image.OffScreenImage;

import manager.BookManager;

public class Book {
	private int id;
	private int cateId;
	private String bookName;
	private String authorName;
	private String bookVersion;
	private int sum;
	private int unUseBookSum;
	private Timestamp pDate;
	private String bDesc;
	
	
	public Book(){
		
	}


	public int getId() {
		return id;
	}


	public void setId(int id) {
		this.id = id;
	}


	public int getCateId() {
		return cateId;
	}


	public void setCateId(int cateId) {
		this.cateId = cateId;
	}


	public String bbookItem() {
		return bookName;
	}

	public String getBookName() {
		return bookName;
	}
	public void setBookName(String bookName) {
		this.bookName = bookName;
	}


	public String getAuthorName() {
		return authorName;
	}


	public void setAuthorName(String authorName) {
		this.authorName = authorName;
	}


	public String getBookVersion() {
		return bookVersion;
	}


	public void setBookVersion(String bookVersion) {
		this.bookVersion = bookVersion;
	}


	public int getSum() {
		return sum;
	}


	public void setSum(int sum) {
		this.sum = sum;
	}


	public int getUnUseBookSum() {
		return unUseBookSum;
	}


	public void setUnUseBookSum(int unUseBookSum) {
		this.unUseBookSum = unUseBookSum;
	}


	public Timestamp getpDate() {
		return pDate;
	}


	public void setpDate(Timestamp pDate) {
		this.pDate = pDate;
	}


	public String getbDesc() {
		return bDesc;
	}


	public void setbDesc(String bDesc) {
		this.bDesc = bDesc;
	}
	
	public Book   load(){
		return BookManager.getInstance().loadById(this.id)   ;
	}
	public boolean   isExist(){
		return BookManager.getInstance().isExist(this);
	}
	
	 public int hashCode(){//²¢Î´µ÷ÓÃ

		   return bookName.hashCode();
	   }



	@Override
	public boolean equals(Object book) {
		// TODO Auto-generated method stub

		try{
			Book b=null;
			if(book instanceof Book){
				b=(Book)book;
			} 
			if(b.getId()==this.id){
				  return true;
			}
			
			}catch(ClassCastException e){
				e.printStackTrace();
			}
			
			return false;
	}


	

}
