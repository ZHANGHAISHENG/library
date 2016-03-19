package bean;

import java.sql.Timestamp;
import java.util.ArrayList;

import manager.TicketManager;

public class Ticket {
	public int  id;
	public String rid;
	public int state;//-0:Î´½É¿î 1£ºÒÑ½É¿î
	public Timestamp  opendate;
	public Timestamp deletedate;
	public double sumMoney;
	public String tDesc;
	
	public ArrayList<TicketItem> TicketItems;
	
	public Ticket(){
		
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public int getState() {
		return state;
	}
	public void setState(int state) {
		this.state = state;
	}
	public Timestamp getOpendate() {
		return opendate;
	}
	public void setOpendate(Timestamp opendate) {
		this.opendate = opendate;
	}
	public Timestamp getEnddate() {
		return deletedate;
	}
	public void setEnddate(Timestamp deletedate) {
		this.deletedate = deletedate;
	}
	public String gettDesc() {
		return tDesc;
	}
	public void settDesc(String tDesc) {
		this.tDesc = tDesc;
	}
	public double getSumMoney() {
		return sumMoney;
	}
	public void setSumMoney(double sumMoney) {
		this.sumMoney = sumMoney;
	}
	public ArrayList<TicketItem> getTicketItems() {
		return TicketItems;
	}
	public void setTicketItems(ArrayList<TicketItem> ticketItems) {
		TicketItems = ticketItems;
	}
	
	public Ticket load(){
		return TicketManager.getInstance().loadById(id);
	}
	
	public boolean isExist(){
		return TicketManager.getInstance().isExist(this);
	}
}
