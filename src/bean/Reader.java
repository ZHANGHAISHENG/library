package bean;

import java.sql.Timestamp;

import manager.ReaderManager;

public class Reader {
	private String id;
	private String rName;
	private String sex;
	private String  rPassword;
	private int   phone;
	private String email;
	private String addr;
	private Timestamp rdate;
	private String rdescr;
	
	public Reader(){
		
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getrName() {
		return rName;
	}

	public void setrName(String rName) {
		this.rName = rName;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public String getrPassword() {
		return rPassword;
	}

	public void setrPassword(String rPassword) {
		this.rPassword = rPassword;
	}

	public int getPhone() {
		return phone;
	}

	public void setPhone(int phone) {
		this.phone = phone;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getAddr() {
		return addr;
	}

	public void setAddr(String addr) {
		this.addr = addr;
	}

	public Timestamp getRdate() {
		return rdate;
	}

	public void setRdate(Timestamp rdate) {
		this.rdate = rdate;
	}

	public String getRdescr() {
		return rdescr;
	}

	public void setRdescr(String rdescr) {
		this.rdescr = rdescr;
	}
	
	public Reader load(){
		 return ReaderManager.getInstance().loadById(id);
	}
	
	public boolean isExist(){
		return  ReaderManager.getInstance().isExist(this);
	}



}
