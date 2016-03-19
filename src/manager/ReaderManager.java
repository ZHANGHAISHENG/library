package manager;

import java.sql.Timestamp;
import java.util.ArrayList;

import bean.Reader;
import dao.ReaderDAO;



public class ReaderManager {
	   private ReaderDAO dao=null;
	   private static ReaderManager rm=null;
	  
	   static{
		 if(rm==null){
			 rm=new ReaderManager();
			 rm.setDao(new ReaderDAO());
		 }

	   }
	   private ReaderManager(){
		 
	   }
	 
	   public static  ReaderManager getInstance(){
		   return rm; 
	   }
	 
	   public ReaderDAO getDao() {
			return dao;
	   }
	   public void setDao(ReaderDAO dao) {
			this.dao = dao;
	   }
		
	   public  Reader loadById(String id ){
		    return dao.loadById(id);
	   }
	   public  boolean isExist(Reader reader){
		   return dao.isExist(reader);
	   }
	   public  boolean addReader(Reader reader){
		   return dao.addReader(reader);
	   }  
	   public  boolean addReaders(ArrayList<Reader> readers){
		   return dao.addReaders(readers);
	   }
	   public  boolean deleteReaderById(String id ) {
		   return dao.deleteReaderById(id);
	   }
	   public  boolean deleteReadersById(int[] ids){
		   return dao.deleteReadersById(ids);
	   }
	   public  boolean modifyReader(Reader reader){
		   return dao.modifyReader(reader);
	   }

	   public int getReaders(ArrayList<String> readers,int[] ids,int pageNo,int pageSize){
		   return dao.getReaders(readers, ids, pageNo, pageSize);
	   }
	   
	   public int   fineReaders(ArrayList<Reader> readers,
			                   String keyWord,
			                   String[] rIds,
							   String rSex,
							   int rPhone,
							   String rEmail ,
							   String rAddr,
				               Timestamp startRDate,
				               Timestamp endRDate,
				               int pageNo,
				               int pageSize){
		   return   dao.fineReaders(readers,keyWord ,rIds ,rSex,rPhone, rEmail, rAddr, startRDate, endRDate, pageNo, pageSize);
	   }
	    
	   public boolean loginCheck(Reader r ,String uId,String pwd){
		   return dao.loginCheck(r,uId, pwd);
	   }
		

}
