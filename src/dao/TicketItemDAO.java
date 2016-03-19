package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.sun.java.swing.plaf.windows.WindowsBorders.DashedBorder;

import util.DB;

import bean.BorrowBookItem;
import bean.Ticket;
import bean.TicketItem;

public class TicketItemDAO {
  public TicketItemDAO(){}
  
  public TicketItem  loadById(int tItemId){
		return null;
	}
  
	public boolean isExist(TicketItem tItem) {
		// TODO Auto-generated method stub
		return false;
	}
	
	public boolean  isExist(int bid,String rId){//通过
		   Connection conn=null;
		    ResultSet  rs=null;
			String sql="select * from ticket,ticketitem where ticket.id=ticketitem.tid and  ticket.rid='" +rId+
					"' and ticketitem.bid="+bid;

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
	public boolean  addTicketItem(Ticket ticket,TicketItem tItem){
		return false;
	}
	public boolean  addTicketItems(Ticket ticket,ArrayList<TicketItem>tItems){//通过
		Connection conn=null;
		PreparedStatement pStmt=null;
		String sql="insert into ticketitem values(null,?,?,?,?)";
		try {
			  conn=DB.getConn();
		      pStmt=DB.getPStmt(conn, sql);
		      boolean b=conn.getAutoCommit();
		      conn.setAutoCommit(false);
			  for(int i=0;i<tItems.size();i++){
				  TicketItem tItem=tItems.get(i);
				  pStmt.setInt(1,ticket.getId());
				  pStmt.setInt(2, tItem.getBid());
				  pStmt.setDouble(3, tItem.getMoney());
				  pStmt.setString(4,tItem.getTtDesc());
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
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			return false;
		}finally{
			DB.closePStmt(pStmt);
			DB.closeConn(conn);
		}
	}
	public void  addTicketItem(Connection conn,Ticket ticket,TicketItem tItem){
		
	}
	public void  addTicketItems(Connection conn,Ticket ticket,ArrayList<TicketItem> tItems) throws SQLException{
		PreparedStatement pStmt=null;
		String sql="insert into ticketitem values(null,?,?,?,?)";
		      pStmt=DB.getPStmt(conn, sql);
			  for(int i=0;i<tItems.size();i++){
				  TicketItem tItem=tItems.get(i);
				  pStmt.setInt(1,ticket.getId());
				  pStmt.setInt(2, tItem.getBid());
				  pStmt.setDouble(3, tItem.getMoney());
				  pStmt.setString(4,tItem.getTtDesc());
				  pStmt.addBatch();
			  }
			  
			  pStmt.executeBatch();
	}

	public boolean removeTicketItemById(int tItemId){//通过
		Connection conn=null;

		String sql="delete from ticketitem where id="+tItemId;
		try {
			      conn=DB.getConn();
		          DB.excuteUpdate(conn, sql);
                  return true;
		}catch(SQLException e){
			e.printStackTrace();
			return false;
		}finally{
			DB.closeConn(conn);
		}
	}
	

	public void removeTicketItemById(Connection conn, int id) throws SQLException {//通过
		// TODO Auto-generated method stub
		  String sql="delete from ticketitem where id="+id;
	      DB.excuteUpdate(conn, sql);
	}
	
	

	
	public boolean  removeTicketItemsById(int[] tItemIds){
		return false;
	}

	public  boolean updateTicketItem(TicketItem tItem){//通过
		Connection conn=null;
		PreparedStatement pStmt=null;
		String sql="update ticketitem set tid=?, bid=?,money=?,tidesc=?  where id="+tItem.getId();
		try {
			      conn=DB.getConn();
		          pStmt=DB.getPStmt(conn, sql);		
				  pStmt.setInt(1, tItem.getTid());
				  pStmt.setInt(2, tItem.getBid());
				  pStmt.setDouble(3, tItem.getMoney());
				  pStmt.setString(4,tItem.getTtDesc());
				  pStmt.executeUpdate();
                  return true;
		}catch(SQLException e){
			e.printStackTrace();
			return false;
		}finally{
			DB.closePStmt(pStmt);
			DB.closeConn(conn);
		}
	}

	public ArrayList<TicketItem>  getTicketItemsByTid(int tItemId) {
		return null;
	}



}
