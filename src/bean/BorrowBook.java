package bean;

import java.sql.Timestamp;
import java.util.ArrayList;

import manager.BorrowBookManager;

public class BorrowBook {
	private int id;
	private String rId ;
	private Timestamp oDate;
	private String bBdesc;
	private ArrayList<BorrowBookItem> bbookItems;
	
	public BorrowBook(){}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getrId() {
		return rId;
	}

	public void setrId(String rId) {
		this.rId = rId;
	}

	public Timestamp getoDate() {
		return oDate;
	}

	public void setoDate(Timestamp oDate) {
		this.oDate = oDate;
	}

	public String getbBdesc() {
		return bBdesc;
	}

	public void setbBdesc(String bBdesc) {
		this.bBdesc = bBdesc;
	}

	public ArrayList<BorrowBookItem> getBorrowBookItems() {
		return bbookItems;
	}

	public void setBorrowBookItems(ArrayList<BorrowBookItem> bbookItems) {
		this.bbookItems = bbookItems;
	}
	
	public BorrowBook load(){
		return BorrowBookManager.getInstance().loadById(id);
	}
	
	public boolean isExist(){
		return BorrowBookManager.getInstance().isExist(this);
	}
	
/*	public void addBorrowBookItems(ArrayList<BorrowBookItem>bbookItems){
		 BorrowBookManager.getInstance().addBorrowBookItems(this, bbookItems);
	}*/

}
