package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import manager.BookManager;
import manager.BorrowBookItemManager;
import manager.CategoryManager;
import manager.TicketItemManger;

import util.DB;

import bean.Book;
import bean.BorrowBook;
import bean.BorrowBookItem;
import bean.Category;
import bean.Ticket;
import bean.TicketItem;



public class BorrowBookDAO {
	
	public BorrowBookDAO(){
		
	}
	
	public BorrowBook loadById(int id){//通过
		Connection conn=null;
		String sql=null;
		ResultSet rs=null;
		BorrowBook bbook=null;
		 try {
			 conn=DB.getConn();
			 
			 sql="select  bbook.id bbookid,bbook.rid,bbook.odate,bbook.bbdesc,bbitem.* from borrowbook as bbook,borrowbookitem as bbitem " +
			 		"where 1=1 and bbook.id=bbitem.bbid and bbook.id="+id;

			 //获取查询的结果

			 rs=DB.excuteQuery(conn, sql);
			 bbook=new BorrowBook();
		     ArrayList<BorrowBookItem> bbitems=new ArrayList<BorrowBookItem>();
			 while(rs.next()){

				    BorrowBookItem  bbitem=new BorrowBookItem();
				    //书单
			    	bbook.setBorrowBookItems(bbitems);
			    	
                    bbook.setId(rs.getInt("bbookid"));
					bbook.setrId(rs.getString("rid"));
					bbook.setoDate(rs.getTimestamp("odate"));
					bbook.setbBdesc(rs.getString("bbdesc"));
					

				    //添加书单子项目
				    bbitem.setId(rs.getInt("id"));
				    bbitem.setbBid(rs.getInt("bbid"));
				    bbitem.setbId(rs.getInt("bid"));
				    bbitem.setState(rs.getInt("state"));
				    bbitem.setoSuccessDate(rs.getTimestamp("osuccessdate"));
				    bbitem.setoVerdueDate(rs.getTimestamp("overduedate"));
				    bbitem.setReturnBookDate(rs.getTimestamp("returnbookdate"));
				    bbitem.setbBIDesc(rs.getString("bbidesc"));
				    bbitems.add(bbitem);
   
			 }

             return bbook;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			 return bbook;
		}finally{
			
			DB.closeRs(rs);
			DB.closeConn(conn);
		}
	}
	
	public BorrowBook loadByRId(int rId){//通过
		Connection conn=null;
		String sql=null;
		ResultSet rs=null;
		BorrowBook bbook=null;
		 try {
			 conn=DB.getConn();
			 
			 sql="select  bbook.id bbookid,bbook.rid,bbook.odate,bbook.bbdesc,bbitem.* from borrowbook as bbook,borrowbookitem as bbitem " +
			 		"where 1=1 and bbook.id=bbitem.bbid and bbook.rid="+rId;

			 //获取查询的结果

			 rs=DB.excuteQuery(conn, sql);
			 bbook=new BorrowBook();
		     ArrayList<BorrowBookItem> bbitems=new ArrayList<BorrowBookItem>();
			 while(rs.next()){

				    BorrowBookItem  bbitem=new BorrowBookItem();
				    //书单
			    	bbook.setBorrowBookItems(bbitems);
			    	
                    bbook.setId(rs.getInt("bbookid"));
					bbook.setrId(rs.getString("rid"));
					bbook.setoDate(rs.getTimestamp("odate"));
					bbook.setbBdesc(rs.getString("bbdesc"));
					

				    //添加书单子项目
				    bbitem.setId(rs.getInt("id"));
				    bbitem.setbBid(rs.getInt("bbid"));
				    bbitem.setbId(rs.getInt("bid"));
				    bbitem.setState(rs.getInt("state"));
				    bbitem.setoSuccessDate(rs.getTimestamp("osuccessdate"));
				    bbitem.setoVerdueDate(rs.getTimestamp("overduedate"));
				    bbitem.setReturnBookDate(rs.getTimestamp("returnbookdate"));
				    bbitem.setbBIDesc(rs.getString("bbidesc"));
				    bbitems.add(bbitem);
   
			 }

             return bbook;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			 return bbook;
		}finally{
			
			DB.closeRs(rs);
			DB.closeConn(conn);
		}
	}
	
	public boolean readerHasBorrowThisBook(int rId,int bId){//通过
		BorrowBook bbook=loadByRId(rId);
		ArrayList<BorrowBookItem> bbookItems=bbook.getBorrowBookItems();
		for(BorrowBookItem bbookItem:bbookItems){
			if(bbookItem.getbId()==bId){
				return true;
			}
		}
		return false;
	}
	
	public boolean isExist(BorrowBook bbook){//未通过
		    Connection conn=null;
		    ResultSet  rs=null;
			String sql="select * from borrowbook where borrowbook.rid="+bbook.getrId();

			try {
				  conn=DB.getConn();
				  rs=DB.excuteQuery(conn, sql);
				  if(rs.next()){
					  return true;
				  }else{
					  return false;
				  }
			}catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				return false;
			}finally{
				DB.closeRs(rs);
				DB.closeConn(conn);
			}
	}
	public boolean addBorrowBook(BorrowBook bbook){//通过
		Connection conn=null;
		PreparedStatement pStmt=null;
		String sql="insert into borrowbook values(null,?,?,?)";
		ResultSet rs=null;
		try {
			  conn=DB.getConn();
			  boolean b=conn.getAutoCommit();
			  conn.setAutoCommit(false);
			  
			  //添加书单
			  pStmt=DB.getPStmt(conn, sql, Statement.RETURN_GENERATED_KEYS);
			  pStmt.setString(1, bbook.getrId());			  
			  pStmt.setTimestamp(2,bbook.getoDate());
			  pStmt.setString(3,bbook.getbBdesc());
			  pStmt.executeUpdate();
			  
			  rs=pStmt.getGeneratedKeys();
			  rs.next();
			  bbook.setId(rs.getInt(1));

			  //添加子项目
			  BorrowBookItemManager.getInstance().addBorrowBookItems(conn,bbook,bbook.getBorrowBookItems()); 
			  
			
			  conn.commit();
			  conn.setAutoCommit(b);
			  return true;
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			try {
				conn.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			return false;
		}finally{
			DB.closeRs(rs);
			DB.closePStmt(pStmt);
			DB.closeConn(conn);
			
		}
	}
	public boolean addBorrowBooks(ArrayList<BorrowBook> bbooks){
		return false;
	}
    
	public boolean  deleteBorrowBookById(int id){
		Connection conn=null;

		String sqlBbook="delete from borrowbook where id="+id;
		String sqlBbookItem="delete from borrowbookitem where bbid="+id;

		try {
			  conn=DB.getConn();			  
			  boolean b=conn.getAutoCommit();
			  conn.setAutoCommit(false);
			  DB.excuteUpdate(conn, sqlBbookItem);
			  DB.excuteUpdate(conn, sqlBbook);
			  
			  
			  conn.commit();
			  conn.setAutoCommit(b);
			  
			  return true;
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			try {
				conn.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			return false;
		}finally{

			DB.closeConn(conn);
			
		}
	}
	

	public void deleteBorrowBookByRId(Connection conn, String rId) throws SQLException {//通过
		// TODO Auto-generated method stub
		  String sql="delete from borrowbook where rid='"+rId+"'";
         
		  //删除罚单项
		  String sqlId="select id from borrowbook where rid='"+rId+"'";
		  ResultSet rs=DB.excuteQuery(conn, sqlId);
		  while(rs.next()){
			  BorrowBookItemManager.getInstance().removeBorrowBookItemByBbId(conn, rs.getInt(1));
		  }
	    //删除书单
		DB.excuteUpdate(conn, sql);
	
	}
	public boolean  deleteBorrowBookByRId(int rId){
		return false;
	}
	public boolean  deleteBorrowBookByOdate(Timestamp startODate,Timestamp endODate){
		return false;
	}
/*	
	public void  addBorrowBookItems(Connection conn,BorrowBook bbook,ArrayList<BorrowBookItem> bbookItems) throws SQLException{//未通过
		 BorrowBookItemManager.getInstance().addBorrowBookItems(conn,bbook, bbookItems) ;
	}*/
	public boolean  removeBorrowBookItems(ArrayList<BorrowBookItem> bbookItems){
		return false;
	}
	  
	public int  getBorrowBooks(ArrayList<BorrowBook> bbooks,int pageNo,int pageSize){
		return 0;
	} 
	
	public ArrayList<BorrowBook> getBorrowBooksByRids(String[] rIds) {//通过
		// TODO Auto-generated method stub
		Connection conn=null;
		String sql=null;
		ResultSet rs=null;
		ArrayList<BorrowBook> bbooks=new ArrayList<BorrowBook>();
		try {
			 conn=DB.getConn();
			 
			 sql="select  bbook.id bbookid,bbook.rid,bbook.odate,bbook.bbdesc,bbitem.* from borrowbook as bbook,borrowbookitem as bbitem where 1=1 and bbook.id=bbitem.bbid ";
			 String strRIds="";
			 if(rIds!=null&&rIds.length>0){
				 strRIds=" and bbook.rid in(";
				  for(int i=0;i<rIds.length;i++){
					  if(i<rIds.length-1){
						  strRIds+=rIds[i]+",";
					  }else{
						  strRIds+=rIds[i]+") ";
					  }
				  }
				  sql+=strRIds;
			 }else{
				 return null;
			 }
			 //获取查询的结果

			 rs=DB.excuteQuery(conn, sql);
			 BorrowBook bbook=null;
			 ArrayList<BorrowBookItem> bbitems=null;
			 while(rs.next()){
				    BorrowBookItem  bbitem=new BorrowBookItem();
				    //添加书单
				    if(rs.isFirst()||bbooks.get(bbooks.size()-1).getId()!=rs.getInt("bbookid")){
				    	 bbook=new BorrowBook();
				    	 bbitems=new ArrayList<BorrowBookItem>();
		                    bbook.setId(rs.getInt("bbookid"));
							bbook.setrId(rs.getString("rid"));
							bbook.setoDate(rs.getTimestamp("odate"));
							bbook.setbBdesc(rs.getString("bbdesc"));
							bbook.setBorrowBookItems(bbitems);
						 bbooks.add(bbook);
				    }
				    //添加书单子项目
				    bbitem.setId(rs.getInt("id"));
				    bbitem.setbBid(rs.getInt("bbid"));
				    bbitem.setbId(rs.getInt("bid"));
				    bbitem.setState(rs.getInt("state"));
				    bbitem.setoSuccessDate(rs.getTimestamp("osuccessdate"));
				    bbitem.setoVerdueDate(rs.getTimestamp("overduedate"));
				    bbitem.setReturnBookDate(rs.getTimestamp("returnbookdate"));
				    bbitem.setbBIDesc(rs.getString("bbidesc"));
				    bbitems.add(bbitem);
			   }

			 }catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();

				}finally{
					
					DB.closeRs(rs);
					DB.closeConn(conn);
				}

			 return bbooks;
	}
	
	
	public ArrayList<BorrowBookItem> getByTickIdBbItemOverDate(String  rId){//与罚单项建立一一关系
		String[] rIds={rId};
		
		//对该读者的借书项进行遍历
		ArrayList<BorrowBook> bbooks=getBorrowBooksByRids(rIds);
		ArrayList<BorrowBookItem> bbItems=new ArrayList<BorrowBookItem>();
		for(BorrowBook bbook : bbooks ){
			ArrayList<BorrowBookItem> bbItems2=bbook.getBorrowBookItems();
			System.out.println("size="+bbItems2.size());
			for(BorrowBookItem it:bbItems2){//搜寻到超期状态的书单项
				if(it.getState()==2){
					bbItems.add(it);
				}
			}
			
		}		
		return bbItems;
	}
	
	
	public ArrayList<BorrowBookItem> getByTickIdBbItemOverDateByTicket(Ticket ticket){//与罚单项建立一一关系
		System.out.println("this is getByTickIdBbItemOverDateByTicket");
		String[] rIds={ticket.getRid()};
		ArrayList<TicketItem> itemIds=ticket.getTicketItems();
		//对该读者的借书项进行遍历
		ArrayList<BorrowBook> bbooks=getBorrowBooksByRidsAndTicketItemId(rIds, itemIds);
		ArrayList<BorrowBookItem> bbItems=new ArrayList<BorrowBookItem>();
		for(BorrowBook bbook : bbooks ){
			ArrayList<BorrowBookItem> bbItems2=bbook.getBorrowBookItems();
			System.out.println("size="+bbItems2.size());
			for(BorrowBookItem it:bbItems2){//搜寻到超期状态的书单项
				if(it.getState()==2){
					bbItems.add(it);
				}
			}
			
		}		
		return bbItems;
	}
	

	public ArrayList<BorrowBook>  getBorrowBooksByRidsAndTicketItemId(String[] rIds,ArrayList<TicketItem> itemIds) {//通过
		// TODO Auto-generated method stub
				Connection conn=null;
				String sql=null;
				ResultSet rs=null;
				ArrayList<BorrowBook> bbooks=new ArrayList<BorrowBook>();
				try {
					 conn=DB.getConn();
					 
					 sql="select  bbook.id bbookid,bbook.rid,bbook.odate,bbook.bbdesc,bbitem.* from borrowbook as bbook,borrowbookitem as bbitem where 1=1 and bbook.id=bbitem.bbid ";
					 String strRIds="";
					 String strBIds="";
					 if(rIds!=null&&rIds.length>0){
						 strRIds=" and bbook.rid in(";
						  for(int i=0;i<rIds.length;i++){
							  if(i<rIds.length-1){
								  strRIds+=rIds[i]+",";
							  }else{
								  strRIds+=rIds[i]+") ";
							  }
						  }
						  sql+=strRIds;
						  
						  strBIds=" and bbitem.bid in( ";
						  for(int i=0;i<rIds.length;i++){
							  if(i<itemIds.size()-1){
								  strBIds+=itemIds.get(i).getBid()+",";
							  }else{
								  strBIds+=itemIds.get(i).getBid()+") ";
							  }
						  }
						  sql+=strBIds;
					 }else{
						 return null;
					 }
					 //获取查询的结果
                    //System.out.println(sql);
					 rs=DB.excuteQuery(conn, sql);
					 BorrowBook bbook=null;
					 ArrayList<BorrowBookItem> bbitems=null;
					 while(rs.next()){
						    BorrowBookItem  bbitem=new BorrowBookItem();
						    //添加书单
						    if(rs.isFirst()||bbooks.get(bbooks.size()-1).getId()!=rs.getInt("bbookid")){
						    	 bbook=new BorrowBook();
						    	 bbitems=new ArrayList<BorrowBookItem>();
				                    bbook.setId(rs.getInt("bbookid"));
									bbook.setrId(rs.getString("rid"));
									bbook.setoDate(rs.getTimestamp("odate"));
									bbook.setbBdesc(rs.getString("bbdesc"));
									bbook.setBorrowBookItems(bbitems);
								 bbooks.add(bbook);
						    }
						    //添加书单子项目
						    bbitem.setId(rs.getInt("id"));
						    bbitem.setbBid(rs.getInt("bbid"));
						    bbitem.setbId(rs.getInt("bid"));
						    bbitem.setState(rs.getInt("state"));
						    bbitem.setoSuccessDate(rs.getTimestamp("osuccessdate"));
						    bbitem.setoVerdueDate(rs.getTimestamp("overduedate"));
						    bbitem.setReturnBookDate(rs.getTimestamp("returnbookdate"));
						    bbitem.setbBIDesc(rs.getString("bbidesc"));
						    bbitems.add(bbitem);
					   }

					 }catch (SQLException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();

						}finally{
							
							DB.closeRs(rs);
							DB.closeConn(conn);
						}

					 return bbooks;
	}
	
	public int  getBorrowBooksByRids(ArrayList<BorrowBook>bbooks,String[] rIds,int pageNo, int pageSize) {//通过
		// TODO Auto-generated method stub
		Connection conn=null;
		String sql=null;
		String sqlCount=null;
		ResultSet rs=null;
		ResultSet rsCount=null;
		int pageCount = 0;
		try {
			 conn=DB.getConn();
			 
			 sql="select  bbook.id bbookid,bbook.rid,bbook.odate,bbook.bbdesc,bbitem.* from borrowbook as bbook,borrowbookitem as bbitem where 1=1 and bbook.id=bbitem.bbid ";
			 String strRIds="";
			 if(rIds!=null&&rIds.length>0){
				 strRIds=" and bbook.rid in(";
				  for(int i=0;i<rIds.length;i++){
					  if(i<rIds.length-1){
						  strRIds+=rIds[i]+",";
					  }else{
						  strRIds+=rIds[i]+") ";
					  }
				  }
				  sql+=strRIds;
			 }else{
				 return pageCount;
			 }
			 //获取页面数
			 sqlCount=sql.replaceFirst("bbook\\.id bbookid,bbook\\.rid,bbook\\.odate,bbook\\.bbdesc,bbitem\\.\\*","count(*)");
			
			 if(pageNo!=0&&pageSize!=0){
            	 sql+=" limit " +(pageNo-1)*pageSize+" ,"+pageSize;
             }           
	
			 //获取页面总数				
			
			 rsCount=DB.excuteQuery(conn, sqlCount);
			 rsCount.next();
			 pageCount=(rsCount.getInt(1)+pageSize-1)/pageSize;

			 //获取查询的结果
			 rs=DB.excuteQuery(conn, sql);			
			 BorrowBook bbook=null;
			 ArrayList<BorrowBookItem> bbitems=null;
			 while(rs.next()){
				    BorrowBookItem  bbitem=new BorrowBookItem();
				    //添加书单
				    if(rs.isFirst()||bbooks.get(bbooks.size()-1).getId()!=rs.getInt("bbookid")){
				    	 bbook=new BorrowBook();
				    	 bbitems=new ArrayList<BorrowBookItem>();
		                    bbook.setId(rs.getInt("bbookid"));
							bbook.setrId(rs.getString("rid"));
							bbook.setoDate(rs.getTimestamp("odate"));
							bbook.setbBdesc(rs.getString("bbdesc"));
							bbook.setBorrowBookItems(bbitems);
						 bbooks.add(bbook);
				    }
				    //添加书单子项目
				    bbitem.setId(rs.getInt("id"));
				    bbitem.setbBid(rs.getInt("bbid"));
				    bbitem.setbId(rs.getInt("bid"));
				    bbitem.setState(rs.getInt("state"));
				    bbitem.setoSuccessDate(rs.getTimestamp("osuccessdate"));
				    bbitem.setoVerdueDate(rs.getTimestamp("overduedate"));
				    bbitem.setReturnBookDate(rs.getTimestamp("returnbookdate"));
				    bbitem.setbBIDesc(rs.getString("bbidesc"));
				    bbitems.add(bbitem);
			   }

			 }catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();

				}finally{
					
					DB.closeRs(rs);
					DB.closeConn(conn);
				}

			 return pageCount;
	}
	
	public ArrayList<BorrowBook> getOverDateBorrowBook(int intDay){
		// TODO Auto-generated method stub
				Connection conn=null;
				String sql=null;
				ResultSet rs=null;
				ArrayList<BorrowBook> bbooks=new ArrayList<BorrowBook>();
				try {
					 conn=DB.getConn();
					 
					 //构建借书状态，且超过期限intDay未还
                    sql="SELECT bbook.id bbookid,bbook.rid,bbook.odate,bbook.bbdesc,bbitem.* FROM borrowbook bbook,borrowbookitem bbitem " +
                    		"WHERE bbook.id=bbitem.bbid AND state=1 AND DATEDIFF(NOW(),bbitem.osuccessdate)>="+intDay+" order by bbook.rid";
                   // System.out.println(sql);
					 //获取查询的结果
					 rs=DB.excuteQuery(conn, sql);
					 BorrowBook bbook=null;
					 ArrayList<BorrowBookItem> bbitems=null;
					 while(rs.next()){
						    BorrowBookItem  bbitem=new BorrowBookItem();
						    //添加书单
						    if(rs.isFirst()||bbooks.get(bbooks.size()-1).getId()!=rs.getInt("bbookid")){
						    	 bbook=new BorrowBook();
						    	 bbitems=new ArrayList<BorrowBookItem>();
				                    bbook.setId(rs.getInt("bbookid"));
									bbook.setrId(rs.getString("rid"));
									bbook.setoDate(rs.getTimestamp("odate"));
									bbook.setbBdesc(rs.getString("bbdesc"));
									bbook.setBorrowBookItems(bbitems);
								 bbooks.add(bbook);
						    }
						    //添加书单子项目
						    bbitem.setId(rs.getInt("id"));
						    bbitem.setbBid(rs.getInt("bbid"));
						    bbitem.setbId(rs.getInt("bid"));
						    bbitem.setState(rs.getInt("state")+1);//将状态改为超期
						    bbitem.setoSuccessDate(rs.getTimestamp("osuccessdate"));
						    bbitem.setoVerdueDate(rs.getTimestamp("overduedate"));
						    bbitem.setReturnBookDate(rs.getTimestamp("returnbookdate"));
						    bbitem.setbBIDesc(rs.getString("bbidesc"));
						    bbitems.add(bbitem);
					   }

					 }catch (SQLException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();

						}finally{
							
							DB.closeRs(rs);
							DB.closeConn(conn);
						}

					 return bbooks;
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
		
		Connection conn=null;
		String sql=null;
		String sqlCount=null;
		ResultSet rs=null;
		ResultSet rsCount=null;
        int pageCount;
		 try {
			 conn=DB.getConn();
			 
			 sql="select  bbook.id bbookid,bbook.rid,bbook.odate,bbook.bbdesc,bbitem.* from borrowbook as bbook,borrowbookitem as bbitem where 1=1 and bbook.id=bbitem.bbid ";


			 //书单Id
			 String strIds="";
			 if(ids!=null&&ids.length>0){
				 strIds=" and bbook.id in(";
				  for(int i=0;i<ids.length;i++){
					  if(i<ids.length-1){
						  strIds+=ids[i]+",";
					  }else{
						  strIds+=ids[i]+") ";
					  }
				  }
				  sql+=strIds;
			 }
			 
			 //读者Id
			 String strRIds="";
			 if(rIds!=null&&rIds.length>0){
				 strRIds=" and bbook.rid in(";
				  for(int i=0;i<rIds.length;i++){
					  if(i<rIds.length-1){
						  strRIds+="'"+rIds[i]+"',";
					  }else{
						  strRIds+="'"+rIds[i]+"') ";
					  }
				  }
				  sql+=strRIds;
			 }
			 
			 // 书单子项目Id
			 String strBbitems="";
			 if(bbookItemIds!=null&&bbookItemIds.length>0){
				 strBbitems=" and bbitem.id in(";
				  for(int i=0;i<bbookItemIds.length;i++){
					  if(i<bbookItemIds.length-1){
						  strBbitems+=bbookItemIds[i]+",";
					  }else{
						  strBbitems+=bbookItemIds[i]+") ";
					  }
				  }
				  sql+=strBbitems;
			 }
			 
			// 书的Id
			 String strBooks="";
			 if(bIds!=null&&bIds.length>0){
				 strBooks=" and bbitem.bid in(";
				  for(int i=0;i<bIds.length;i++){
					  if(i<bIds.length-1){
						  strBooks+=bIds[i]+",";
					  }else{
						  strBooks+=bIds[i]+") ";
					  }
				  }
				  sql+=strBooks;
			 }
			 
			 //状态：
			 if(state!=-1){
				 sql+=" and bbitem.state="+state+"  ";
			 }


			 
			 //关键字
			 if(keyWord!=null&&!keyWord.trim().equals("")){
				 sql+=" and ( bbook.bbdesc like '%"+keyWord+"%' "+" or bbitem.bbidesc like '%"+keyWord+"%'  ) ";

			 }

			 //书单入系统时间
			 if(startODate!=null){
				 sql+=" and (bbook.odate>='"+new SimpleDateFormat("yyy-MM-dd").format(startODate)+"') ";
			 }
			 
			 if(endODate!=null){
				 sql+=" and (bbook.odate<='"+new SimpleDateFormat("yyy-MM-dd").format(endODate)+"') ";
			 }
			 
			//借书成功时间
			 if(sStartDate!=null){
				 sql+=" and (bbitem.osuccessdate>='"+new SimpleDateFormat("yyy-MM-dd").format(sStartDate)+"') ";
			 }
			 
			 if(sEndDate!=null){
				 sql+=" and (bbitem.osuccessdate<='"+new SimpleDateFormat("yyy-MM-dd").format(sEndDate)+"') ";
			 }
			 
			//超期不还时间
			 if(overDueStartDate!=null){
				 sql+=" and (bbitem.overduedate>='"+new SimpleDateFormat("yyy-MM-dd").format(overDueStartDate)+"') ";
			 }
			 
			 if(overDueEndDate!=null){
				 sql+=" and (bbitem.overduedate<='"+new SimpleDateFormat("yyy-MM-dd").format(overDueEndDate)+"') ";
			 }
			 
				//图书返还时间
			 if(returnBookStartDate!=null){
				 sql+=" and (bbitem.returnbookdate>='"+new SimpleDateFormat("yyy-MM-dd").format(returnBookStartDate)+"') ";
			 }
			 
			 if(returnBookEndDate!=null){
				 sql+=" and (bbitem.returnbookdate<='"+new SimpleDateFormat("yyy-MM-dd").format(returnBookEndDate)+"') ";
			 }
			 
			
             sqlCount=sql.replaceFirst("bbook\\.id bbookid,bbook\\.rid,bbook\\.odate,bbook\\.bbdesc,bbitem\\.\\*","count(*)");
			 
             if(pageNo!=0&&pageSize!=0){
            	 sql+=" limit " +(pageNo-1)*pageSize+" ,"+pageSize;
             }
            
			 System.out.println(sql);
			 //获取页面总数				
			
			 rsCount=DB.excuteQuery(conn, sqlCount);
			 rsCount.next();
			 pageCount=(rsCount.getInt(1)+pageSize-1)/pageSize;
			 
		
             
			 
			 //获取查询的结果

			 rs=DB.excuteQuery(conn, sql);

		    BorrowBook bbook=null;
		    ArrayList<BorrowBookItem> bbitems=null;
			 while(rs.next()){
				    BorrowBookItem  bbitem=new BorrowBookItem();
				    //添加书单
				    if(rs.isFirst()||bbooks.get(bbooks.size()-1).getId()!=rs.getInt("bbookid")){
				    	 bbook=new BorrowBook();
				    	 bbitems=new ArrayList<BorrowBookItem>();
		                    bbook.setId(rs.getInt("bbookid"));
							bbook.setrId(rs.getString("rid"));
							bbook.setoDate(rs.getTimestamp("odate"));
							bbook.setbBdesc(rs.getString("bbdesc"));
							bbook.setBorrowBookItems(bbitems);
						 bbooks.add(bbook);
				    }
				    //添加书单子项目
				    bbitem.setId(rs.getInt("id"));
				    bbitem.setbBid(rs.getInt("bbid"));
				    bbitem.setbId(rs.getInt("bid"));
				    bbitem.setState(rs.getInt("state"));
				    bbitem.setoSuccessDate(rs.getTimestamp("osuccessdate"));
				    bbitem.setoVerdueDate(rs.getTimestamp("overduedate"));
				    bbitem.setReturnBookDate(rs.getTimestamp("returnbookdate"));
				    bbitem.setbBIDesc(rs.getString("bbidesc"));
				    bbitems.add(bbitem);

			 }

             return pageCount;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			 return 0;
		}finally{
			
			DB.closeRs(rs);
			DB.closeRs(rsCount);
			DB.closeConn(conn);
		}
	}
	
	
	public int getBorrowBookByRIdsAndState(ArrayList<BorrowBook> bbooks,String[] rIds, int state, int pageNo,int pageSize){
		
		return findBorrowBooks(bbooks, null, rIds, null, null, null, null, null, state, null, null, null, null, null, null, pageNo, pageSize);
		
	}
	
	public int getBorrowBookByOpenDayTime(ArrayList<BorrowBook> bbooks,Timestamp startODate,Timestamp endODate ){
										
			Connection conn=null;
			String sql=null;
			String sqlCount=null;
			ResultSet rs=null;
			ResultSet rsCount=null;
			int bookNum=0;
			try {
				
			conn=DB.getConn();
			
			sql="select  bbook.id bbookid,bbook.rid,bbook.odate,bbook.bbdesc,bbitem.* from borrowbook as bbook,borrowbookitem as bbitem " +
					" where 1=1 and bbook.id=bbitem.bbid ";

			//书单入系统时间
			if(startODate!=null){
			sql+=" and (bbook.odate>='"+new SimpleDateFormat("yyy-MM-dd").format(startODate)+"') ";
			}
			
			if(endODate!=null){
			sql+=" and (bbook.odate<'"+new SimpleDateFormat("yyy-MM-dd").format(endODate)+"') ";
			}

			sqlCount=sql.replaceFirst("bbook\\.id bbookid,bbook\\.rid,bbook\\.odate,bbook\\.bbdesc,bbitem\\.\\*","count(*)");
            
			System.out.println(sqlCount);
			//获取借阅的图书总数			
			
			rsCount=DB.excuteQuery(conn, sqlCount);
			rsCount.next();
			bookNum=rsCount.getInt(1);

			//获取查询的结果
			
			rs=DB.excuteQuery(conn, sql);
			
			BorrowBook bbook=null;
			ArrayList<BorrowBookItem> bbitems=null;
			if(bbooks==null){
				 return bookNum;
			}
			while(rs.next()){
			 BorrowBookItem  bbitem=new BorrowBookItem();
			 //添加书单
			 if(rs.isFirst()||bbooks.get(bbooks.size()-1).getId()!=rs.getInt("bbookid")){
			 	 bbook=new BorrowBook();
			 	 bbitems=new ArrayList<BorrowBookItem>();
			         bbook.setId(rs.getInt("bbookid"));
						bbook.setrId(rs.getString("rid"));
						bbook.setoDate(rs.getTimestamp("odate"));
						bbook.setbBdesc(rs.getString("bbdesc"));
						bbook.setBorrowBookItems(bbitems);
					 bbooks.add(bbook);
			 }
				 //添加书单子项目
				 bbitem.setId(rs.getInt("id"));
				 bbitem.setbBid(rs.getInt("bbid"));
				 bbitem.setbId(rs.getInt("bid"));
				 bbitem.setState(rs.getInt("state"));
				 bbitem.setoSuccessDate(rs.getTimestamp("osuccessdate"));
				 bbitem.setoVerdueDate(rs.getTimestamp("overduedate"));
				 bbitem.setReturnBookDate(rs.getTimestamp("returnbookdate"));
				 bbitem.setbBIDesc(rs.getString("bbidesc"));
				 bbitems.add(bbitem);
			
			}
			return bookNum;
			 
			
			} catch (SQLException e) {
			// TODO Auto-generated catch block
			 e.printStackTrace();
			   return 0;
			}finally{
			
				DB.closeRs(rs);
				DB.closeRs(rsCount);
				DB.closeConn(conn);
			}
	}
	
	
	public int getBorrowBookByBookRootCateId(int bookRootCateId,ArrayList<BorrowBook> bbooks){
		Connection conn=null;
		String sql=null;
		String sqlCount=null;
		ResultSet rs=null;
		ResultSet rsCount=null;
		int bookNum = 0;
		 try {
			 conn=DB.getConn();
			 
			 sql="select  bbook.id bbookid,bbook.rid,bbook.odate,bbook.bbdesc,bbitem.* from borrowbook as bbook,borrowbookitem as bbitem " +
			 		"where 1=1 and bbook.id=bbitem.bbid ";
			 
			 ArrayList<Book> books=null;
			 Category c=CategoryManager.getInstance().loadById(bookRootCateId);
			 if(c.isLeaf()){				
				 books=new ArrayList<Book>();
				 BookManager.getInstance().getBooksByCategoryId(bookRootCateId, books);
			 }else{
				 books=BookManager.getInstance().getAllBooksByRootCateId(bookRootCateId);
			 }
			 
			//书Id
			 String strBookIds="";
			 if(!books.isEmpty()){
				 strBookIds=" and bbitem.bid in(";
				 for(Book b:books){
					 strBookIds+=b.getId()+",";
				 }
				 sql+=strBookIds.substring(0, strBookIds.lastIndexOf(","))+")";
			 }else{
				 return 0;
			 }
			
             
		     sqlCount=sql.replaceFirst("bbook\\.id bbookid,bbook\\.rid,bbook\\.odate,bbook\\.bbdesc,bbitem\\.\\*","count(*)");
		   
		     System.out.println(sqlCount);
			//获取借阅的图书总数			
			
			rsCount=DB.excuteQuery(conn, sqlCount);
			rsCount.next();
			bookNum=rsCount.getInt(1);
            
			if(bbooks==null){
				return bookNum;
			}
		     
            //获取查询的结果
			
			rs=DB.excuteQuery(conn, sql);
			
			BorrowBook bbook=null;
			ArrayList<BorrowBookItem> bbitems=null;
			while(rs.next()){
			 BorrowBookItem  bbitem=new BorrowBookItem();
			 //添加书单
			 if(rs.isFirst()||bbooks.get(bbooks.size()-1).getId()!=rs.getInt("bbookid")){
			 	 bbook=new BorrowBook();
			 	 bbitems=new ArrayList<BorrowBookItem>();
			         bbook.setId(rs.getInt("bbookid"));
						bbook.setrId(rs.getString("rid"));
						bbook.setoDate(rs.getTimestamp("odate"));
						bbook.setbBdesc(rs.getString("bbdesc"));
						bbook.setBorrowBookItems(bbitems);
					 bbooks.add(bbook);
			 }
				 //添加书单子项目
				 bbitem.setId(rs.getInt("id"));
				 bbitem.setbBid(rs.getInt("bbid"));
				 bbitem.setbId(rs.getInt("bid"));
				 bbitem.setState(rs.getInt("state"));
				 bbitem.setoSuccessDate(rs.getTimestamp("osuccessdate"));
				 bbitem.setoVerdueDate(rs.getTimestamp("overduedate"));
				 bbitem.setReturnBookDate(rs.getTimestamp("returnbookdate"));
				 bbitem.setbBIDesc(rs.getString("bbidesc"));
				 bbitems.add(bbitem);
			
			}
			
			  return bookNum;
			
			} catch (SQLException e) {
			// TODO Auto-generated catch block
			 e.printStackTrace();
			   return 0;
			}finally{
			
				DB.closeRs(rs);
				DB.closeRs(rsCount);
				DB.closeConn(conn);
			}
	}

	


}
