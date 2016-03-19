package dao;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Properties;


import manager.BookManager;
import manager.BorrowBookItemManager;
import manager.BorrowBookManager;
import manager.ReaderManager;
import manager.TicketItemManger;
import manager.TicketManager;

import util.DB;

import bean.BorrowBook;
import bean.BorrowBookItem;
import bean.Reader;
import bean.Ticket;
import bean.TicketItem;

public class TicketDAO {

	public TicketDAO(){}
	 public Ticket loadById(int tId){//通过
		 Connection conn=null;
			String sql=null;
			ResultSet rs=null;
			Ticket ticket=null; 
			 try {
				 conn=DB.getConn();	 
				 sql="select  t.id tid,t.rid,t.state,t.opendate,t.deletedate,t.tdesc,titem.*   from " +
				 		" ticket as t,ticketitem as titem where 1=1 and t.id=titem.tid and t.id="+tId;

				 //获取查询的结果
				 rs=DB.excuteQuery(conn, sql);
			     ArrayList<TicketItem> tItems=null;
				 while(rs.next()){
					    TicketItem  tItem=new TicketItem();
					    //添加书单
					    if(rs.isFirst()){
					    	 ticket=new Ticket();
					    	 tItems=new ArrayList<TicketItem>();
			                    ticket.setId(rs.getInt("tid"));
			                    ticket.setRid(rs.getString("rid"));
			                    ticket.setState(rs.getInt("state"));
			                    ticket.setOpendate(rs.getTimestamp("opendate"));
			                    ticket.setEnddate(rs.getTimestamp("deletedate"));
			                    ticket.settDesc(rs.getString("tdesc"));
							 ticket.setTicketItems(tItems);
					    }
					    //添加书单子项目
					    tItem.setId(rs.getInt("id"));
					    tItem.setTid(rs.getInt("tid"));
					    tItem.setBid(rs.getInt("bid"));
					    tItem.setMoney(rs.getDouble("money"));
					    tItem.setTtDesc(rs.getString("tidesc"));
					    tItems.add(tItem);
	   
				 }

	             return ticket;
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				 return ticket;
			}finally{
				
				DB.closeRs(rs);
				DB.closeConn(conn);
			}
	 }
	 public boolean isExist(Ticket ticket){//通过
		    Connection conn=null;
		    ResultSet  rs=null;
			String sql="select * from ticket where state=0 and rid='"+ticket.getRid()+"'";

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
	 public boolean addTicket(Ticket ticket){
		 Connection conn=null;
			PreparedStatement pStmt=null;
			String sql="insert into ticket values(null,?,?,?,?,?)";
			ResultSet rs=null;
			try {
				  conn=DB.getConn();
				  boolean b=conn.getAutoCommit();
				  conn.setAutoCommit(false);
				  
				  //添加罚单
				  pStmt=DB.getPStmt(conn, sql, Statement.RETURN_GENERATED_KEYS);
				  pStmt.setString(1,ticket.getRid() );
				  pStmt.setInt(2,ticket.getState() );
				  pStmt.setTimestamp(3, ticket.getOpendate());
				  pStmt.setTimestamp(4, ticket.getEnddate());
				  pStmt.setString(5,ticket.gettDesc() );
				  pStmt.executeUpdate();
				  
				  rs=pStmt.getGeneratedKeys();
				  rs.next();
				  ticket.setId(rs.getInt(1));

				  //添加罚单子项目
				   TicketItemManger.getInstance().addTicketItems(conn, ticket, ticket.getTicketItems());
				  
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
	 public void addTicket(Connection conn,Ticket ticket,ArrayList<BorrowBookItem> bbItems) throws SQLException{
			PreparedStatement pStmt=null;
			String sql="insert into ticket values(null,?,?,?,?,?)";
			ResultSet rs=null;
				  //添加罚单
				  pStmt=DB.getPStmt(conn, sql, Statement.RETURN_GENERATED_KEYS);
				  pStmt.setString(1,ticket.getRid() );
				  pStmt.setInt(2,ticket.getState() );
				  pStmt.setTimestamp(3, ticket.getOpendate());
				  pStmt.setTimestamp(4, ticket.getEnddate());
				  pStmt.setString(5,ticket.gettDesc() );
				  pStmt.executeUpdate();
				  
				  rs=pStmt.getGeneratedKeys();
				  rs.next();
				  ticket.setId(rs.getInt(1));

				  //添加罚单子项目
				   TicketItemManger.getInstance().addTicketItems(conn, ticket, ticket.getTicketItems());
				   //更新借书项
				   BorrowBookItemManager.getInstance().updateBorrowBookItems(conn, bbItems);

	 }
	 public boolean addTickets(ArrayList<Ticket> tickets){
		 return false;
	 }

	 public boolean deleteTicketById(int tId ){
		    Connection conn=null;
			String sqlTicket="delete from ticket where id='"+tId+"'";
			String sqlTItem="delete from ticketitem where tid='"+tId+"'";
			try {
				  conn=DB.getConn();
				  boolean b=conn.getAutoCommit();
				  conn.setAutoCommit(false);
				  DB.excuteUpdate(conn, sqlTItem);
				  DB.excuteUpdate(conn, sqlTicket);	
				  
				  //修改借书项状态
				  Ticket ticket=loadById(tId);
				  System.out.println("ticketState="+ticket.getState());
				  if(ticket.state==0){
					  //找到该读者超期的借书项,漏洞--一个导致该读者所有的超期图书变为已还
					 // ArrayList<BorrowBookItem> bbItems=BorrowBookManager.getInstance().getByTickIdBbItemOverDate(ticket.getRid());
					  ArrayList<BorrowBookItem> bbItems=BorrowBookManager.getInstance().getByTickIdBbItemOverDateByTicket(ticket);
					  for(BorrowBookItem bbItem:bbItems){
				    	  bbItem.setState(3);
				    	  BorrowBookItemManager.getInstance().updateBorrowBookItem(conn, bbItem);
				      }
				  
				  }
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
	 
	 
	public void deleteTicketByRId(Connection conn, String rId) throws SQLException {//通过
		// TODO Auto-generated method stub
		      
			  String sql="delete from ticket where rid='"+rId+"'";
			  //删除罚单项
			  String sqlId="select id from ticket where rid='"+rId+"'";
			  ResultSet rs=DB.excuteQuery(conn, sqlId);
			  while(rs.next()){
				  TicketItemManger.getInstance().removeTicketItemById(conn,rs.getInt(1));
			  }
			  
              //删除罚单
			  DB.excuteUpdate(conn, sql);				  
	}
	 
	 public boolean  deleteTicketsById(int[] tIds){
		 return false;
	 }
	 public boolean modifyTicket(Ticket  ticket){//通过
		 Connection conn=null;
			PreparedStatement pStmt=null;
			String sql="update ticket set  rid=?,state=?,opendate=?,deletedate=?,tdesc=? where id="+ticket.getId();
			try {
				  conn=DB.getConn();
				  boolean b=conn.getAutoCommit();
				  conn.setAutoCommit(false);
				  //修改罚单
				  pStmt=DB.getPStmt(conn, sql);
				  pStmt.setString(1, ticket.getRid());
				  pStmt.setInt(2,ticket.getState() );
				  pStmt.setTimestamp(3, ticket.getOpendate());
				  pStmt.setTimestamp(4, ticket.getEnddate());
				  pStmt.setString(5,ticket.gettDesc() );
				  pStmt.executeUpdate();
				  
				  //修改借书项状态
				  if(ticket.state==1){
					  //找到该读者超期的借书项,漏洞--一个导致该读者所有的超期图书变为已还
					 // ArrayList<BorrowBookItem> bbItems=BorrowBookManager.getInstance().getByTickIdBbItemOverDate(ticket.getRid());
					  ArrayList<BorrowBookItem> bbItems=BorrowBookManager.getInstance().getByTickIdBbItemOverDateByTicket(ticket);
					  for(BorrowBookItem bbItem:bbItems){
				    	  bbItem.setState(3);
				    	  BorrowBookItemManager.getInstance().updateBorrowBookItem(conn, bbItem);
				      }
				  
				  }
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
				DB.closePStmt(pStmt);
				DB.closeConn(conn);
				
			}
	 }
	 
	 public ArrayList<Ticket> getTicketByRId(String rId){ //通过
		 
		    ArrayList<Ticket> tickets=new ArrayList<Ticket>();
		    Connection conn=null;
			String sql=null;
			ResultSet rs=null;
			 try {
				 conn=DB.getConn();
				 
				 sql="select  t.id tid,t.rid,t.state,t.opendate,t.deletedate,t.tdesc,titem.*   from ticket as t,ticketitem as titem where 1=1 and t.id=titem.tid and t.rid like '%"+rId+"%'";

				 //获取查询的结果

				 rs=DB.excuteQuery(conn, sql);

			    Ticket ticket=null; 
			    ArrayList<TicketItem> tItems=null;
				 while(rs.next()){
					    TicketItem  tItem=new TicketItem();
					    //添加书单
					    if(rs.isFirst()||tickets.get(tickets.size()-1).getId()!=rs.getInt("tid")){
					    	 ticket=new Ticket();
					    	 tItems=new ArrayList<TicketItem>();
			                    ticket.setId(rs.getInt("tid"));
			                    ticket.setRid(rs.getString("rid"));
			                    ticket.setState(rs.getInt("state"));
			                    ticket.setOpendate(rs.getTimestamp("opendate"));
			                    ticket.setEnddate(rs.getTimestamp("deletedate"));
			                    ticket.settDesc(rs.getString("tdesc"));
							 ticket.setTicketItems(tItems);
							 tickets.add(ticket);
					    }
					    //添加书单子项目
					    tItem.setId(rs.getInt("id"));
					    tItem.setTid(rs.getInt("tid"));
					    tItem.setBid(rs.getInt("bid"));
					    tItem.setMoney(rs.getDouble("money"));
					    tItem.setTtDesc(rs.getString("tidesc"));
					    tItems.add(tItem);
	   
				 }

	             return tickets;
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				 return null;
			}finally{
				
				DB.closeRs(rs);
				DB.closeConn(conn);
			}
	 }
	 
	 public TicketItem getTItemByBbItemNotReturn(BorrowBookItem bbItem){//与借书项建立一一对应关系
		 
		 BorrowBook bbook=BorrowBookManager.getInstance().loadById(bbItem.getbBid());
         Reader r=ReaderManager.getInstance().loadById(bbook.getrId());
        //对该读者所有的未缴款罚单进行搜索(建立在一次性一本图书只能借一本的基础上)
         ArrayList<Ticket> tickets=TicketManager.getInstance().getTicketByRId(r.getId());     
         System.out.println(tickets.size());
         for(Ticket it: tickets){
       	  if(it.getState()==0){
       		  ArrayList<TicketItem> tItems=it.getTicketItems();
       		  for(TicketItem tItem:tItems){
       			  if(tItem.getBid()==bbItem.getbId()){
       				return tItem;
       			  }
       			  
       		  }
       	  }
         }
         
         return null;
	 }
	 public int getTickets(ArrayList<Ticket> tickets){
		 return 0;
	 }
	 public int getTickets(ArrayList<Ticket> tickets,int pageNo ,int pageSize ){
		 return 0;
	 }
	 

	 
	 public int findTickets(ArrayList<Ticket> tickets ,
			                 String  keyWord,
							 int[] tIds,
							 String[] rIds,
							 int[] tItemIds,
							 int[] bIds ,
							 int state,
							 Timestamp openStartDate,
							 Timestamp openEndDate,
							 Timestamp deleteStartDate,
							 Timestamp deleteEndDate,
							 int pageNo,int pageSize){//未通过
		 Connection conn=null;
			String sql=null;
			String sqlCount=null;
			ResultSet rs=null;
			ResultSet rsCount=null;
	        int pageCount;
			 try {
				 conn=DB.getConn();
				 
				 sql="select  t.id tid,t.rid,t.state,t.opendate,t.deletedate,t.tdesc,titem.*   from ticket as t,ticketitem as titem where 1=1 and t.id=titem.tid ";


				 //罚单Id
				 String strIds="";
				 if(tIds!=null&&tIds.length>0){
					 strIds=" and t.id in(";
					  for(int i=0;i<tIds.length;i++){
						  if(i<tIds.length-1){
							  strIds+=tIds[i]+",";
						  }else{
							  strIds+=tIds[i]+") ";
						  }
					  }
					  sql+=strIds;
				 }
				 
				 //读者Id
				 String strRIds="";
				 if(rIds!=null&&rIds.length>0){
					 strRIds=" and t.rid in(";
					  for(int i=0;i<rIds.length;i++){
						  if(i<rIds.length-1){
							  strRIds+="'"+rIds[i]+"',";
						  }else{
							  strRIds+="'"+rIds[i]+"') ";
						  }
					  }
					  sql+=strRIds;
				 }
				 
				 // 罚单子项目Id
				 String strTItems="";
				 if(tItemIds!=null&&tItemIds.length>0){
					 strTItems=" and titem.id in(";
					  for(int i=0;i<tItemIds.length;i++){
						  if(i<tItemIds.length-1){
							  strTItems+=tItemIds[i]+",";
						  }else{
							  strTItems+=tItemIds[i]+") ";
						  }
					  }
					  sql+=strTItems;
				 }
				 
				// 书的Id
				 String strBooks="";
				 if(bIds!=null&&bIds.length>0){
					 strBooks=" and titem.bid in(";
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
					 sql+=" and t.state="+state+"  ";
				 }


				 
				 //关键字
				 if(keyWord!=null&&!keyWord.trim().equals("")){
					 sql+=" and ( t.tdesc like '%"+keyWord+"%' "+" or titem.tidesc like '%"+keyWord+"%'  ) ";

				 }

				 //开出罚时间
				 if(openStartDate!=null){
					 sql+=" and (t.opendate>='"+new SimpleDateFormat("yyy-MM-dd").format(openStartDate)+"') ";
				 }
				 
				 if(openEndDate!=null){
					 sql+=" and (t.opendate<='"+new SimpleDateFormat("yyy-MM-dd").format(openEndDate)+"') ";
				 }
				 
				//罚单消除时间
				 if(deleteStartDate!=null){
					 sql+=" and (t.deletedate>='"+new SimpleDateFormat("yyy-MM-dd").format(deleteStartDate)+"') ";
				 }
				 
				 if(deleteEndDate!=null){
					 sql+=" and (t.deletedate<='"+new SimpleDateFormat("yyy-MM-dd").format(deleteEndDate)+"') ";
				 }
				 

				
	             sqlCount=sql.replaceFirst("t\\.id tid,t\\.rid,t\\.state,t\\.opendate,t\\.deletedate,t\\.tdesc,titem\\.\\*","count(*)");
				 sql+=" limit " +(pageNo-1)*pageSize+" ,"+pageSize;

				 //获取页面总数				
				
				 rsCount=DB.excuteQuery(conn, sqlCount);
				 rsCount.next();
				 pageCount=(rsCount.getInt(1)+pageSize-1)/pageSize;
				 
			
	             
				 
				 //获取查询的结果

				 rs=DB.excuteQuery(conn, sql);

			    Ticket ticket=null; 
			    ArrayList<TicketItem> tItems=null;
				 while(rs.next()){
					    TicketItem  tItem=new TicketItem();
					    //添加罚单
					    if(rs.isFirst()||tickets.get(tickets.size()-1).getId()!=rs.getInt("tid")){
					    	 ticket=new Ticket();
					    	 tItems=new ArrayList<TicketItem>();
			                    ticket.setId(rs.getInt("tid"));
			                    ticket.setRid(rs.getString("rid"));
			                    ticket.setState(rs.getInt("state"));
			                    ticket.setOpendate(rs.getTimestamp("opendate"));
			                    ticket.setEnddate(rs.getTimestamp("deletedate"));
			                    ticket.settDesc(rs.getString("tdesc"));
							 ticket.setTicketItems(tItems);
							 tickets.add(ticket);
					    }
					    //添加罚单子项目
					    tItem.setId(rs.getInt("id"));
					    tItem.setTid(rs.getInt("tid"));
					    tItem.setBid(rs.getInt("bid"));
					    tItem.setMoney(rs.getDouble("money"));
					    tItem.setTtDesc(rs.getString("tidesc"));
					    tItems.add(tItem);
	   
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

	 
	 public boolean autoAddTicket(int intDay){
		 Connection conn=null;
		 //获取 超期的书单（只包含超期的书单项）
		 ArrayList<BorrowBook> bbooks=BorrowBookManager.getInstance().getOverDateBorrowBook(intDay);
		 //为每个超期读者构建一张罚单对象
		  Ticket ticket=null;
		  ArrayList<TicketItem> tItems=null;
		  String rId=null;
		  if(bbooks.size()==0){//不存在超期的罚单项
			  return false;
		  }
		 try {
			conn=DB.getConn();
			boolean b=conn.getAutoCommit();
			conn.setAutoCommit(false);
			//构建该读者的罚单对象集合
			  for(BorrowBook bb:bbooks){
				  if(rId!=bb.getrId()){ //当罚单的读者id与下一张书单不一致时添加罚单
					  ticket=new Ticket();
					  tItems=new ArrayList<TicketItem>(); 
	                  ticket.setRid(bb.getrId());
	                  ticket.setState(0);
	                  ticket.setOpendate(new Timestamp(System.currentTimeMillis()));
	                  ticket.setEnddate(null);
	                  ticket.settDesc("无");
	                 
				  }
				 //构建罚单项对象
				  for(BorrowBookItem bbi: bb.getBorrowBookItems()){
					  TicketItem tItem=new TicketItem();
					    tItem.setBid(bbi.getbId());
					    tItem.setMoney(30);//暂且为30
					    tItem.setTtDesc("无");
					    tItems.add(tItem);
				  }
	             ticket.setTicketItems(tItems);

	              //添加罚单
		          addTicket(conn, ticket, bb.getBorrowBookItems());
			  }
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
	 
	 
	 public boolean autoManagerTicket(){	 
			int intDay=360;
			int checkDay =1;
			Properties ticketPro=new Properties();
			InputStream inStream=this.getClass().getClassLoader().getResourceAsStream("properties/TicketManagerParam.properties");
			try {
				ticketPro.load(inStream);	
				String strIntDay=ticketPro.getProperty("intDay");
				if(strIntDay!=null&&!strIntDay.equals("")){
					intDay=Integer.parseInt(strIntDay);
				}
			} catch (IOException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			
		    while(true){
		       try {
				Thread.sleep(checkDay*1000*10);//20秒
				autoAddTicket(intDay);
				System.out.println("..........罚单自动处理时间间隔为："+checkDay+"天");
				System.out.println("..........超期时间="+intDay);
			   } catch (InterruptedException e) {
				e.printStackTrace();
			   }
		    }
		   
	 }

}
