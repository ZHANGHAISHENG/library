package bean;

import java.sql.Timestamp;

import manager.AdministratorManager;

public class Administrator {
	    private int  id;
	    private String adminName;
	    private String  sex;
	    private String adminPassword;
	    private int phone;
	    private String addr;
	    private Timestamp rdate;
	    private int isRoot;
	    private String adminDesc;
	    public Administrator(){
		   
	    }
		public int getId() {
			return id;
		}
		public void setId(int id) {
			this.id = id;
		}
		public String getAdminName() {
			return adminName;
		}
		public void setAdminName(String adminName) {
			this.adminName = adminName;
		}
		public String getSex() {
			return sex;
		}
		public void setSex(String sex) {
			this.sex = sex;
		}
		public String getAdminPassword() {
			return adminPassword;
		}
		public void setAdminPassword(String adminPassword) {
			this.adminPassword = adminPassword;
		}
		public int getPhone() {
			return phone;
		}
		public void setPhone(int phone) {
			this.phone = phone;
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
		public int getIsRoot() {
			return isRoot;
		}
		public void setIsRoot(int isRoot) {
			this.isRoot = isRoot;
		}
		public String getAdminDesc() {
			return adminDesc;
		}
		public void setAdminDesc(String adminDesc) {
			this.adminDesc = adminDesc;
		}
	    
		public Administrator load(){
			return AdministratorManager.getInstance().loadById(id);
		}
		public boolean isExist(){
			return AdministratorManager.getInstance().isExist(this);
		}
	   
}
