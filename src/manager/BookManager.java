package manager;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;

import bean.Book;

import dao.BookDAO;

public class BookManager {
	 
	 private BookDAO dao=null;
	 private static BookManager bm=null;
	 
	 static{
		 if(bm==null){
			 bm=new BookManager();
			 bm.setDao(new BookDAO());
		 }

	 }
	 private BookManager(){
		 
	 }
	 
	   public static  BookManager getInstance(){
		   return bm; 
	   }
	 
	public BookDAO getDao() {
		return dao;
	}
	public void setDao(BookDAO dao) {
		this.dao = dao;
	}
	 
	public Book loadById(int id){
		return dao.loadById(id);
	}
	public boolean isExist(Book b){
		return dao.isExist(b);
	}
	public boolean isExist(int id){
		return dao.isExist(id);
	}
	public boolean addBook(Book b){
		return dao.addBook(b);
	}
	public boolean addBooks(ArrayList<Book> books){
		return dao.addBooks(books);
	}
	public boolean deleteBookById(int id){
		return dao.deleteBookById(id);
	}
	public boolean deleteBooksById(int[] ids){
		return dao.deleteBooksById(ids);
	}
	public boolean deleteBookByCategoryId(int cateId){
		return dao.deleteBookByCategoryId(cateId);
    }
	public boolean updateBook(Book b){
		return dao.updateBook(b);
	}
	public void updateBook(Connection conn,Book b) throws SQLException{
		dao.updateBook(conn, b);
	}
	public boolean updateBooks(ArrayList<Book> books) {
		return dao.updateBooks(books);
	}   
	public void  getBooksByCategoryId(int cateId,ArrayList<Book>books){
		 dao.getBooksByCategoryId(cateId,books);
	}
	public  ArrayList<Book> getAllBooksByRootCateId(int rootCateId){
		 return dao.getAllBooksByRootCateId(rootCateId);
	}
	
	public ArrayList<Book> getBooksByCategoriesId(int[] cateIds,int page,int size){
		return dao.getBooksByCategoriesId(cateIds, page, size);
	}
	public int finBooksByKeyWord(ArrayList<Book> books,String keyWord,int page,int size){
		return dao.finBooksByKeyWord(books, keyWord, page, size);
	}
	public int finBooksByKeyWordAndCateId(ArrayList<Book> books,String keyWord,int cateId,int page,int size){
		return dao.finBooksByKeyWordAndCateId(books, keyWord, cateId, page, size);
	}
	public int  finBooks(ArrayList<Book> books,String keyWord,int[] cateIds,int bookSum,int unUseBookSum,Timestamp startDate,Timestamp endDate,int pageNo,int pageSize){
		return dao.finBooks(books, keyWord, cateIds, bookSum, unUseBookSum, startDate,endDate, pageNo, pageSize);
	}


}
