package manager;


import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Locale;
import java.util.TimeZone;

import org.jfree.data.category.CategoryDataset;
import org.jfree.data.category.DefaultCategoryDataset;
import org.jfree.data.general.DefaultPieDataset;



import bean.BorrowBook;
import bean.BorrowBookItem;
import bean.Category;
import bean.Ticket;
import bean.TicketItem;
import dao.BorrowBookDAO;


public class BorrowBookManager {
	 private BorrowBookDAO dao=null;
	 private static BorrowBookManager bbm=null;
	 
	 static{
		 if(bbm==null){
			 bbm=new BorrowBookManager();
			 bbm.setDao(new BorrowBookDAO());
		 }

	 }
	 private BorrowBookManager(){
		 
	 }
	 
	   public static  BorrowBookManager getInstance(){
		   return bbm; 
	   }
	 
	public BorrowBookDAO getDao() {
		return dao;
	}
	public void setDao(BorrowBookDAO dao) {
		this.dao = dao;
	}
	
	
	public BorrowBook loadById(int id){
		return dao.loadById(id);
	}
	public BorrowBook loadByRId(int rId){
		return dao.loadByRId(rId);
	}
	public boolean readerHasBorrowThisBook(int rId,int bId){
		return dao.readerHasBorrowThisBook(rId, bId);
	}
	public boolean isExist(BorrowBook bbook){
		return dao.isExist(bbook);
	}
	public boolean addBorrowBook(BorrowBook bbook){
		return dao.addBorrowBook(bbook);
	}
	public boolean addBorrowBooks(ArrayList<BorrowBook> bbooks){
		return dao.addBorrowBooks(bbooks);
	}
    
	public boolean  deleteBorrowBookById(int id){
		return dao.deleteBorrowBookById(id);
	}
	
	public void  deleteBorrowBookByRId(Connection conn,String rId) throws SQLException{
		 dao.deleteBorrowBookByRId(conn,rId);
	}
	public boolean  deleteBorrowBookByRId(int rId){
		return dao.deleteBorrowBookByRId(rId);
	}
	public boolean  deleteBorrowBookByOdate(Timestamp startODate,Timestamp endODate){
		return dao.deleteBorrowBookByOdate(startODate, endODate);
	}
	
/*	public void  addBorrowBookItems(Connection conn,BorrowBook bbook,ArrayList<BorrowBookItem> bbookItems) throws SQLException{
		 dao.addBorrowBookItems(conn,bbook, bbookItems);
	}*/
	public boolean  removeBorrowBookItems(ArrayList<BorrowBookItem> bbookItems){
		return dao.removeBorrowBookItems(bbookItems);
	}
	
	
	  
	public int  getBorrowBooks(ArrayList<BorrowBook> bbooks,int pageNo,int pageSize){
		return dao.getBorrowBooks(bbooks, pageNo, pageSize);
	}      
	
	
	public ArrayList<BorrowBook>  getBorrowBooksByRids( String[] rIds){
		return dao.getBorrowBooksByRids(rIds);
	}   
	
	public ArrayList<BorrowBookItem> getByTickIdBbItemOverDate(String  rId){
		
		return dao.getByTickIdBbItemOverDate(rId);
	}
	
	public ArrayList<BorrowBookItem> getByTickIdBbItemOverDateByTicket(Ticket ticket){//与罚单项建立一一关系
		
	  return  dao.getByTickIdBbItemOverDateByTicket(ticket);
	}
	
	public ArrayList<BorrowBook>  getBorrowBooksByRidsAndTicketItemId(String[] rIds,ArrayList<TicketItem> itemIds) {
		
		return dao.getBorrowBooksByRidsAndTicketItemId(rIds, itemIds);
	}
	public int  getBorrowBooksByRids(ArrayList<BorrowBook>bbooks,String[] rIds,int pageNo, int pageSize) {//通过
		return dao.getBorrowBooksByRids(bbooks, rIds, pageNo, pageSize);
	}
	public ArrayList<BorrowBook> getOverDateBorrowBook(int intDay){
		return dao.getOverDateBorrowBook(intDay);
	}
	public int findBorrowBooks(ArrayList<BorrowBook> bbooks,
						       int[] ids,
						       String[] rIds,
						       String keyWord,
                               Timestamp startODate,
                               Timestamp endODate,
                               int[] bbookItemIds,
                               int[] bIds,
                               int state,
                               Timestamp sStartDate,
                               Timestamp sEndDate,
                               Timestamp overDueStartDate,
                               Timestamp overDueEndDate,
                               Timestamp returnBookStartDate,
                               Timestamp returnBookEndDate,
                               int pageNo,
                               int pageSize){
		return dao.findBorrowBooks(bbooks, ids, rIds, keyWord, 
				                   startODate, endODate, bbookItemIds,
				                   bIds, state, sStartDate, sEndDate, 
				                   overDueStartDate, overDueEndDate,
				                   returnBookStartDate,returnBookEndDate,
				                   pageNo, pageSize);
		
	}
	public int getBorrowBookByRIdsAndState(ArrayList<BorrowBook> bbooks,String[] rIds, int state, int pageNo,int pageSize){
	   return dao.getBorrowBookByRIdsAndState(bbooks, rIds, state, pageNo, pageSize);
	}
	public int getBorrowBookByOpenDayTime(ArrayList<BorrowBook> bbooks,Timestamp startODate,Timestamp endODate ){
	    return dao.getBorrowBookByOpenDayTime(bbooks, startODate, endODate);
	}
	
	public int getBorrowBookByBookRootCateId(int bookRootCateId,ArrayList<BorrowBook> bbooks){
	     return dao.getBorrowBookByBookRootCateId(bookRootCateId, bbooks);
	}
	
	
 
	public DefaultPieDataset getCategoryPieDataset(int cateId){
		
		   DefaultPieDataset dataset = new DefaultPieDataset();   
	      
	       ArrayList<Category> categories =CategoryManager.getInstance().getDirectChildsByPid(cateId);
	       
		     for(Category category: categories){
		    	 int bookNum=getBorrowBookByBookRootCateId(category.getId(),null);
		    	 
		    	 dataset.setValue(category.getCateName() ,bookNum); 
		     }
  
	       return dataset;   
	
	}

	public CategoryDataset getCategoryDateset(int cateId){
		
		 DefaultCategoryDataset dataset = new DefaultCategoryDataset();   
		 Category c=CategoryManager.getInstance().loadById(cateId);
		 ArrayList<Category> categories =CategoryManager.getInstance().getDirectChildsByPid(cateId);
	       
	     for(Category category: categories){
	    	 int bookNum=getBorrowBookByBookRootCateId(category.getId(),null);
	    	 System.out.println("name="+category.getCateName());
	    	 dataset.addValue(bookNum,c.getCateName()+"类图书借阅柱形图" ,category.getCateName()); 
	     }

	     return dataset;   
	}
	

	//获取折线图或直方图的数据集
	public CategoryDataset getTimeCategoryDateset(Timestamp startODate,Timestamp endODate){
		DefaultCategoryDataset dataset = new DefaultCategoryDataset();   
		 System.out.println(startODate+"----"+endODate);//2014-09-17 08:00:00.0----2014-12-17 08:00:00.0
		 //用日历操作年月日
		  //TimeZone.getDefault(),Locale.getDefault() 作用几乎没有，伤心
         Calendar startCalendar=Calendar.getInstance(TimeZone.getDefault(),Locale.getDefault());
         startCalendar.setTime(startODate);
         ///2014------------8--------17,只有月份取出是有问题，但对月份操作在转换回Timestamp就没事
         System.out.println(startCalendar.get(Calendar.YEAR)+"------------"+startCalendar.get(Calendar.MONTH)+"--------"+startCalendar.get(Calendar.DAY_OF_MONTH));
         Calendar endCalendar=Calendar.getInstance(TimeZone.getDefault(),Locale.getDefault());
         endCalendar.setTime(endODate);
        
         Timestamp tempStart=startODate;
         Timestamp tempEnd;
      
		   String columnKey="";
		   int next;
		   int interval = 1;
         //获取数据集
         while(interval!=0){

       	  if(endCalendar.get(Calendar.YEAR)-startCalendar.get(Calendar.YEAR)>=1){//以年为单位
       		  columnKey=String.valueOf(startCalendar.get(Calendar.YEAR))+"年";
       		  next= startCalendar.get(Calendar.YEAR)+1;
       		  startCalendar.set(Calendar.YEAR,next);
       		  interval=endCalendar.get(Calendar.YEAR)-next;
       	  }else{
           	  
           	  if(endCalendar.get(Calendar.MONTH)-startCalendar.get(Calendar.MONTH)>=1){//以月为单位
           		  columnKey=String.valueOf(startCalendar.get(Calendar.MONTH)+1)+"月";
           		  next= startCalendar.get(Calendar.MONTH)+1;
           		  startCalendar.set(Calendar.MONTH,next);
           		  interval=endCalendar.get(Calendar.MONTH)-next;
           		
           		 
           	  }else{//以周为单位
           		  columnKey=String.valueOf(startCalendar.get(Calendar.WEEK_OF_MONTH))+"周";
           		  next= startCalendar.get(Calendar.WEEK_OF_MONTH)+1;
           		  startCalendar.set(Calendar.WEEK_OF_MONTH,next);
           		  interval=endCalendar.get(Calendar.WEEK_OF_MONTH)-next;
           		  
           	  }
             }
       	  
   		  tempEnd=Timestamp.valueOf( new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").format(startCalendar.getTime()));
   		  //获取这段时间内的借阅量
 		      int bookNum=getBorrowBookByOpenDayTime(null,tempStart,tempEnd);
 		   
	  		  //添加到数据集
	  		    dataset.addValue(bookNum,"图书借阅折线图" ,columnKey); 
	  		  //重置tempStart
	  		  tempStart=tempEnd;
         }

	     return dataset;  
	}


	
	
}
