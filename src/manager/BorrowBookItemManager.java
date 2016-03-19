package manager;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;

import bean.Book;
import bean.BorrowBook;
import bean.BorrowBookItem;
import dao.BorrowBookItemDAO;



public class BorrowBookItemManager {
	private BorrowBookItemDAO dao=null;
	 private static BorrowBookItemManager bbim=null;
	 
	 static{
		 if(bbim==null){
			 bbim=new BorrowBookItemManager();
			 bbim.setDao(new BorrowBookItemDAO());
		 }

	 }
	 private BorrowBookItemManager(){
		 
	 }
	 
	   public static  BorrowBookItemManager getInstance(){
		   return bbim; 
	   }
	 
	public BorrowBookItemDAO getDao() {
		return dao;
	}
	public void setDao(BorrowBookItemDAO dao) {
		this.dao = dao;
	}
	
	public BorrowBookItem loadById(int bbookItemId){
		return dao.loadById(bbookItemId);
	}
	public boolean  isExist(int bId,String rId){
		return dao.isExist(bId,rId);
	}
	public boolean  addBook(BorrowBookItem bbookItem,Book book){
		return dao.addBook(bbookItem, book);
	}
	public boolean  addBooks(BorrowBookItem bbookItem,Book[] books){
		return dao.addBooks(bbookItem, books);
	}
	public boolean addBorrowBookItem(BorrowBook bbook,BorrowBookItem bbookItem){
		return dao.addBorrowBookItem(bbook,bbookItem);
	}
	public void addBorrowBookItems(Connection conn,BorrowBook bbook,ArrayList<BorrowBookItem> bbookItems) throws SQLException{
		 dao.addBorrowBookItems(conn,bbook,bbookItems);
	}
	public boolean addBorrowBookItems(BorrowBook bbook,ArrayList<BorrowBookItem> bbookItems){
		 return dao.addBorrowBookItems(bbook, bbookItems);
	}
	public boolean  removeBorrowBookItemById(int bbookItemId ){
		return dao.removeBorrowBookItemById(bbookItemId);
	}
	public void  removeBorrowBookItemByBbId(Connection conn,int bbookId ) throws SQLException{
		 dao.removeBorrowBookItemByBbId(conn,bbookId);
	}
	public boolean  removeBookById(BorrowBookItem bbookItem,int bbookItemId ){
		return dao.removeBookById(bbookItem, bbookItemId);
	}
	public boolean  removeBooksById(BorrowBookItem bbookItem,int[] bbookItemIds){
		return dao.removeBooksById(bbookItem, bbookItemIds);
	}
	public boolean updateBorrowBookItem(BorrowBookItem bbItem){
		return dao.updateBorrowBookItem(bbItem);
	}
	public void updateBorrowBookItem(Connection conn,BorrowBookItem bbItem) throws SQLException{
		dao.updateBorrowBookItem(conn, bbItem);
	}
	public void updateBorrowBookItems(Connection conn,ArrayList<BorrowBookItem> bbItems) throws SQLException{
	   dao.updateBorrowBookItems(conn, bbItems);
	}
}
