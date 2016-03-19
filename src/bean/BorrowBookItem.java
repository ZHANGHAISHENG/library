package bean;

import java.sql.Timestamp;

import manager.BorrowBookItemManager;

public class BorrowBookItem {
    int id;
    int bBid;
    int bId;
    int state;//--0:ԤԼ״̬,1:����ɹ�״̬��2������״̬
    Timestamp oSuccessDate; //--ԤԼ�ɹ�ʱ��
    Timestamp oVerdueDate; //--����ʱ��
    Timestamp returnBookDate;

	String bBIDesc;
    
    public BorrowBookItem(){
    	
    }

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getbBid() {
		return bBid;
	}

	public void setbBid(int bBid) {
		this.bBid = bBid;
	}

	public int getbId() {
		return bId;
	}

	public void setbId(int bId) {
		this.bId = bId;
	}

	public int getState() {
		return state;
	}

	public void setState(int state) {
		this.state = state;
	}

	public Timestamp getoSuccessDate() {
		return oSuccessDate;
	}

	public void setoSuccessDate(Timestamp oSuccessDate) {
		this.oSuccessDate = oSuccessDate;
	}

	public Timestamp getoVerdueDate() {
		return oVerdueDate;
	}

	public void setoVerdueDate(Timestamp oVerdueDate) {
		this.oVerdueDate = oVerdueDate;
	}
	
    public Timestamp getReturnBookDate() {
		return returnBookDate;
	}

	public void setReturnBookDate(Timestamp returnBookDate) {
		this.returnBookDate = returnBookDate;
	}

	public String getbBIDesc() {
		return bBIDesc;
	}

	public void setbBIDesc(String bBIDesc) {
		this.bBIDesc = bBIDesc;
	}
    
	public BorrowBookItem load(){
		return BorrowBookItemManager.getInstance().loadById(this.id);
	}
/*	public boolean isExist(){
		return BorrowBookItemManager.getInstance().isExist(this);
	}*/
	public boolean updateBorrowBookItem(){
		return BorrowBookItemManager.getInstance().updateBorrowBookItem(this);
	}
}
