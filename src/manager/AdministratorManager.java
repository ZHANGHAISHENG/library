package manager;

import java.sql.Timestamp;
import java.util.ArrayList;

import bean.Administrator;
import dao.AdministratorDAO;


public class AdministratorManager {
	 private AdministratorDAO dao=null;
	 private static AdministratorManager adm=null;
	 
	 static{
		 if(adm==null){
			 adm=new AdministratorManager();
			 adm.setDao(new AdministratorDAO());
		 }

	 }
	 private AdministratorManager(){
		 
	 }
	 
	   public static  AdministratorManager getInstance(){
		   return adm; 
	   }
	 
	public AdministratorDAO getDao() {
		return dao;
	}
	public void setDao(AdministratorDAO dao) {
		this.dao = dao;
	}
	
	public Administrator loadById(int id){
		return dao.loadById(id);
	}
	public boolean isExist(Administrator admin){
		return dao.isExist(admin);
	}
	public boolean isRoot(Administrator admin){
		return dao.isRoot(admin);
	}
	public boolean addAdministrator(Administrator admin){
		return dao.addAdministrator(admin);
	}
	public boolean deleteAdminById(int id){
		return dao.deleteAdminById(id);
	}
	public boolean deleteAdminsById(int[] ids){
		return dao.deleteAdminsById(ids);
	}
	public boolean modify(Administrator admin){
		return dao.modify(admin);
	}
	public Administrator getRootAdmin(){
		return dao.getRootAdmin();
	}
	public ArrayList<Administrator> getAdminBynName(String[] names){
		return dao.getAdminBynName(names);
	}
	public int getAdmins(ArrayList<Administrator> admins,int pageNo,int pageSizse){
		return dao.getAdmins(admins, pageNo, pageSizse);
	}
	public int findAdmins(ArrayList<Administrator> admins,
			int[] ids,
			String keyWord,
			String sex,
			int phone,
			String addr,
            Timestamp rStartDate,
            Timestamp rEndDate,
            int isRoot,
            int pageNo,
            int pageSize){
		return dao.findAdmins(admins,ids, keyWord, sex,
				             phone, addr, rStartDate, rEndDate, 
				             isRoot, pageNo, pageSize);
	}
	
	public boolean loginCheck(Administrator admin, int uId, String pwd){
	    return dao.loginCheck(admin, uId, pwd);
	}
}
