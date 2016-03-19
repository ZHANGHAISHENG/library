package manager;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;

import bean.Ticket;
import bean.TicketItem;

import dao.TicketItemDAO;



public class TicketItemManger {
	 private TicketItemDAO dao=null;
	 private static TicketItemManger tim=null;
	 
	 static{
		 if(tim==null){
			 tim=new TicketItemManger();
			 tim.setDao(new TicketItemDAO());
		 }

	 }
	 private TicketItemManger(){
		 
	 }
	 
	   public static  TicketItemManger getInstance(){
		   return tim; 
	   }
	 
	public TicketItemDAO getDao() {
		return dao;
	}
	public void setDao(TicketItemDAO dao) {
		this.dao = dao;
	}
	
	public TicketItem  loadById(int tItemId){
		return dao.loadById(tItemId);
	}
	public boolean  isExist(TicketItem tItem){
		return dao.isExist(tItem);
	}
	public boolean  isExist(int bid,String rId){
		return dao.isExist(bid,rId);
	}
	public boolean  addTicketItem(Ticket ticket,TicketItem tItem){
		return dao.addTicketItem(ticket,tItem);
	}
	public boolean  addTicketItems(Ticket ticket,ArrayList<TicketItem>tItems){
		return dao.addTicketItems(ticket,tItems);
	}
	public void  addTicketItem(Connection conn,Ticket ticket,TicketItem tItem){
		  dao.addTicketItem(conn,ticket, tItem);
	}
	public void  addTicketItems(Connection conn,Ticket ticket,ArrayList<TicketItem> tItems) throws SQLException{
		 dao.addTicketItems(conn,ticket, tItems);
	}
	
	public void removeTicketItemById(Connection conn,int id) throws SQLException{
		 dao.removeTicketItemById(conn,id);
	}

	public boolean removeTicketItemById(int tItemId){
		return dao.removeTicketItemById(tItemId);
	}
	public boolean  removeTicketItemsById(int[] tItemIds){
		return dao.removeTicketItemsById(tItemIds);
	}

	public  boolean updateTicketItem(TicketItem tItem){
		return dao.updateTicketItem(tItem);
	}

	public ArrayList<TicketItem>  getTicketItemsByTid(int tItemId) {
		return null;
	}
}
