package manager;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;

import bean.BorrowBookItem;
import bean.Ticket;
import bean.TicketItem;
import dao.TicketDAO;


public class TicketManager {
	 private TicketDAO dao=null;
	 private static TicketManager tm=null;
	 
	 static{
		 if(tm==null){
			 tm=new TicketManager();
			 tm.setDao(new TicketDAO());
		 }

	 }
	 private TicketManager(){
		 
	 }
	 
	   public static  TicketManager getInstance(){
		   return tm; 
	   }
	 
	public TicketDAO getDao() {
		return dao;
	}
	public void setDao(TicketDAO dao) {
		this.dao = dao;
	}
	
	
	 public Ticket loadById(int tId){
		 return dao.loadById(tId);
	 }
	 public boolean isExist(Ticket ticket){
		 return dao.isExist(ticket);
	 }
	 public boolean addTicket(Ticket ticket){
		 return dao.addTicket(ticket);
	 }
	 public void addTicket(Connection conn,Ticket ticket,ArrayList<BorrowBookItem> bbItems) throws SQLException{
		 dao.addTicket(conn, ticket, bbItems);
	 }
	 public boolean addTickets(ArrayList<Ticket> tickets){
		 return dao.addTickets(tickets);
	 }
	 public void deleteTicketByRId(Connection conn,String rId )throws SQLException{
		  dao.deleteTicketByRId(conn,rId);
	 }
	 public boolean deleteTicketById(int tId ){
		 return dao.deleteTicketById(tId);
	 }
	 public boolean  deleteTicketsById(int[] tIds){
		 return dao.deleteTicketsById(tIds);
	 }
	 public boolean modifyTicket(Ticket  ticket){
		 return dao.modifyTicket(ticket);
	 }
	 public ArrayList<Ticket> getTicketByRId(String rId){
		 return dao.getTicketByRId(rId);
		 
	 }
	 public TicketItem getTItemByBbItemNotReturn(BorrowBookItem bbItem){
		 return dao.getTItemByBbItemNotReturn(bbItem);
	 }
	 public int getTickets(ArrayList<Ticket> tickets){
		 return dao.getTickets(tickets);
	 }
	 public int getTickets(ArrayList<Ticket> tickets,int pageNo ,int pageSize ){
		 return dao.getTickets(tickets, pageNo, pageSize);
	 }
	 public int findTickets(ArrayList<Ticket> tickets ,String  keyWord,
							 int[] tIds,String[] rIds,int[] tItemIds,int[] bIds ,
							 int state,Timestamp openStartDate,Timestamp openEndDate,
							 Timestamp deleteStartDate,Timestamp deleteEndDate,
							 int pageNo,int pageSize){
		return  dao.findTickets(tickets, keyWord, 
				                tIds, rIds, tItemIds, bIds, state,
				                openStartDate, openEndDate, deleteStartDate,deleteEndDate,
				                pageNo, pageSize);
	 }
	 
	 public boolean  autoAddTicket(int intDay){
		 
		 return dao.autoAddTicket(intDay);
	 }
	 
	 public boolean autoManagerTicket(){	 
		 return dao.autoManagerTicket();
	 }
	 
}
