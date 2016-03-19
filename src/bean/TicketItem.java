package bean;

import manager.TicketItemManger;


public class TicketItem {
   private int  id;
   private int tid;
   private int bid;
   private double money;
   private String ttDesc;
   
   public TicketItem(){
	   
   }

public int getId() {
	return id;
}

public void setId(int id) {
	this.id = id;
}

public int getTid() {
	return tid;
}

public void setTid(int tid) {
	this.tid = tid;
}

public int getBid() {
	return bid;
}

public void setBid(int bid) {
	this.bid = bid;
}

public double getMoney() {
	return money;
}

public void setMoney(double money) {
	this.money = money;
}

public String getTtDesc() {
	return ttDesc;
}

public void setTtDesc(String ttDesc) {
	this.ttDesc = ttDesc;
}
   

public TicketItem load(){
	return TicketItemManger.getInstance().loadById(id);
}

public boolean isExist(){
	return TicketItemManger.getInstance().isExist(this);
}
   
}
