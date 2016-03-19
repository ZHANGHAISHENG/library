package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import manager.BookManager;
import manager.BorrowBookManager;
import manager.ReaderManager;
import manager.TicketItemManger;
import manager.TicketManager;

import util.DB;

import bean.Book;
import bean.BorrowBook;
import bean.BorrowBookItem;
import bean.Reader;
import bean.Ticket;
import bean.TicketItem;

public class BorrowBookItemDAO {
    
	public BorrowBookItemDAO(){
		
	}
	public BorrowBookItem loadById(int bbookItemId){
		return null;
	}
	public boolean  isExist(int bid,String rId){//通过
		 Connection conn=null;
		    ResultSet  rs=null;
			String sql="select * from borrowbook,borrowbookitem where borrowbook.id=borrowbookitem.bbid " +
					"and  borrowbook.rid='" +rId+"' and borrowbookitem.state!=3 "+" and borrowbookitem.bid="+bid;

			try {
				  conn=DB.getConn();
				  rs=DB.excuteQuery(conn, sql);
				  if(rs.next()){
					  return true;
				  }else{
					  return false;
				  }
			}catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				return false;
			}finally{
				DB.closeRs(rs);
				DB.closeConn(conn);
			}
	}
	public boolean  addBook(BorrowBookItem bbookItem,Book book){
		return false;
	}
	public boolean  addBooks(BorrowBookItem bbookItem,Book[] books){
		return false;
	}
	public boolean addBorrowBookItem(BorrowBook bbook,BorrowBookItem bbookItem){
		return false;
	}
	public void addBorrowBookItems(Connection conn,BorrowBook bbook,ArrayList<BorrowBookItem> bbookItems) throws SQLException{//通过

		PreparedStatement pStmt=null;
		String sql="insert into borrowbookitem values(null,?,?,?,?,?,?,?)";
		try {

			  pStmt=DB.getPStmt(conn, sql);
			  //添加图书
			  for(int i=0;i<bbookItems.size();i++){
				  BorrowBookItem bbookItem=bbookItems.get(i);
				  pStmt.setInt(1, bbook.getId());
				  pStmt.setInt(2, bbookItem.getbId());
				  pStmt.setInt(3, bbookItem.getState());
				  pStmt.setTimestamp(4, bbookItem.getoSuccessDate());
				  pStmt.setTimestamp(5, bbookItem.getoVerdueDate());
				  pStmt.setTimestamp(6,  bbookItem.getReturnBookDate());
				  pStmt.setString(7, bbookItem.getbBIDesc());
				  pStmt.addBatch();
				//修改图书的数量
				  Book b=BookManager.getInstance().loadById(bbookItem.getbId());
				  b.setUnUseBookSum(b.getUnUseBookSum()-1);
				  BookManager.getInstance().updateBook(conn,b);
			  }

			  
			  
			  pStmt.executeBatch();
		}finally{
			DB.closePStmt(pStmt);
		}
	}
	
	public boolean addBorrowBookItems(BorrowBook bbook,ArrayList<BorrowBookItem> bbookItems){//通过

		Connection conn=null;
		PreparedStatement pStmt=null;
		String sql="insert into borrowbookitem values(null,?,?,?,?,?,?,?)";
		try {
              conn=DB.getConn();
			  pStmt=DB.getPStmt(conn, sql);
			  Boolean b=conn.getAutoCommit();
			  conn.setAutoCommit(false);
			  for(int i=0;i<bbookItems.size();i++){
				  BorrowBookItem bbookItem=bbookItems.get(i);
				  pStmt.setInt(1, bbook.getId());
				  pStmt.setInt(2, bbookItem.getbId());
				  pStmt.setInt(3, bbookItem.getState());
				  pStmt.setTimestamp(4, bbookItem.getoSuccessDate());
				  pStmt.setTimestamp(5, bbookItem.getoVerdueDate());
				  pStmt.setTimestamp(6,  bbookItem.getReturnBookDate());
				  pStmt.setString(7, bbookItem.getbBIDesc());
				  pStmt.addBatch();
			  }
			  pStmt.executeBatch();
			  conn.commit();
			  conn.setAutoCommit(b);
			  return true;
		}catch(SQLException e){
			e.printStackTrace();
			try {
				conn.rollback();
				return false;
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
		
		}finally{
			DB.closePStmt(pStmt);
			DB.closePStmt(pStmt);
		}
		return false;
	}
	
	public boolean  removeBorrowBookItemById(int bbookItemId ){
		Connection conn=null;

		String sql="delete from borrowbookitem where id="+bbookItemId;

		try {
			  conn=DB.getConn();
			  DB.excuteUpdate(conn, sql);
			  return true;
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		}finally{

			DB.closeConn(conn);
			
		}
	}
	public void removeBorrowBookItemByBbId(Connection conn, int bbookId) throws SQLException {//通过
		// TODO Auto-generated method stub
		 String sql="delete from borrowbookitem where bbid="+bbookId;
		 DB.excuteUpdate(conn, sql);
	}
	
	public boolean  removeBookById(BorrowBookItem bbookItem,int bbookItemId ){
		return false;
	}
	public boolean  removeBooksById(BorrowBookItem bbookItem,int[] bbookItemIds){
		return false;
	}
	public boolean updateBorrowBookItem(BorrowBookItem bbItem){
		Connection conn=null;
		PreparedStatement pStmt=null;
		String sql="update  borrowbookitem set bbid=?,bid=?,state=?,osuccessdate=?,overduedate=?,returnbookdate=?,bbidesc=? where id="+bbItem.getId();
		try {
              conn=DB.getConn();
              boolean b=conn.getAutoCommit();
              conn.setAutoCommit(false);
              //更新借书项
			  pStmt=DB.getPStmt(conn, sql);
			  
			  pStmt.setInt(1, bbItem.getbBid());
			  pStmt.setInt(2, bbItem.getbId());
			  pStmt.setInt(3, bbItem.getState());
			  pStmt.setTimestamp(4, bbItem.getoSuccessDate());
			  pStmt.setTimestamp(5, bbItem.getoVerdueDate());
			  pStmt.setTimestamp(6, bbItem.getReturnBookDate());
			  pStmt.setString(7, bbItem.getbBIDesc());
              pStmt.executeUpdate();    
              
              //更新罚单项（由超期->其它，删除借书项）
              TicketItem  tItem=TicketManager.getInstance().getTItemByBbItemNotReturn(bbItem);
              if(tItem!=null){//第一次修改状态时并未添加罚单
            	  TicketItemManger.getInstance().removeTicketItemById(conn, tItem.getId());
              } 
              conn.commit();
              conn.setAutoCommit(b);
	          return true;
		}catch(SQLException e){
			e.printStackTrace();
			try {
				conn.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			  return false;
		}finally{
			DB.closePStmt(pStmt);
		}
	     
	}
	
	
	
	public void updateBorrowBookItem(Connection conn,BorrowBookItem bbItem) throws SQLException{
		PreparedStatement pStmt=null;
		String sql="update  borrowbookitem set bbid=?,bid=?,state=?,osuccessdate=?,overduedate=?,returnbookdate=?,bbidesc=? where id="+bbItem.getId();
		try{

              //更新借书项
			  pStmt=DB.getPStmt(conn, sql);
			  pStmt.setInt(1, bbItem.getbBid());
			  pStmt.setInt(2, bbItem.getbId());
			  pStmt.setInt(3, bbItem.getState());
			  pStmt.setTimestamp(4, bbItem.getoSuccessDate());
			  pStmt.setTimestamp(5, bbItem.getoSuccessDate());
			  pStmt.setTimestamp(6, bbItem.getReturnBookDate());
			  pStmt.setString(7, bbItem.getbBIDesc());
              pStmt.executeUpdate();    
              
         
		}finally{
			DB.closePStmt(pStmt);
		}
	     
	}
	
	public void updateBorrowBookItems(Connection conn,ArrayList<BorrowBookItem> bbItems) throws SQLException{
			 //更新借书项
			for(BorrowBookItem bbItem: bbItems){
				updateBorrowBookItem( conn, bbItem);
			}
 
	}

}
