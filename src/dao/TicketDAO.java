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
	 public Ticket loadById(int tId){//ͨ��
		 Connection conn=null;
			String sql=null;
			ResultSet rs=null;
			Ticket ticket=null; 
			 try {
				 conn=DB.getConn();	 
				 sql="select  t.id tid,t.rid,t.state,t.opendate,t.deletedate,t.tdesc,titem.*   from " +
				 		" ticket as t,ticketitem as titem where 1=1 and t.id=titem.tid and t.id="+tId;

				 //��ȡ��ѯ�Ľ��
				 rs=DB.excuteQuery(conn, sql);
			     ArrayList<TicketItem> tItems=null;
				 while(rs.next()){
					    TicketItem  tItem=new TicketItem();
					    //����鵥
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
					    //����鵥����Ŀ
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
	 public boolean isExist(Ticket ticket){//ͨ��
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
				  
				  //��ӷ���
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

				  //��ӷ�������Ŀ
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
				  //��ӷ���
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

				  //��ӷ�������Ŀ
				   TicketItemManger.getInstance().addTicketItems(conn, ticket, ticket.getTicketItems());
				   //���½�����
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
				  
				  //�޸Ľ�����״̬
				  Ticket ticket=loadById(tId);
				  System.out.println("ticketState="+ticket.getState());
				  if(ticket.state==0){
					  //�ҵ��ö��߳��ڵĽ�����,©��--һ�����¸ö������еĳ���ͼ���Ϊ�ѻ�
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
	 
	 
	public void deleteTicketByRId(Connection conn, String rId) throws SQLException {//ͨ��
		// TODO Auto-generated method stub
		      
			  String sql="delete from ticket where rid='"+rId+"'";
			  //ɾ��������
			  String sqlId="select id from ticket where rid='"+rId+"'";
			  ResultSet rs=DB.excuteQuery(conn, sqlId);
			  while(rs.next()){
				  TicketItemManger.getInstance().removeTicketItemById(conn,rs.getInt(1));
			  }
			  
              //ɾ������
			  DB.excuteUpdate(conn, sql);				  
	}
	 
	 public boolean  deleteTicketsById(int[] tIds){
		 return false;
	 }
	 public boolean modifyTicket(Ticket  ticket){//ͨ��
		 Connection conn=null;
			PreparedStatement pStmt=null;
			String sql="update ticket set  rid=?,state=?,opendate=?,deletedate=?,tdesc=? where id="+ticket.getId();
			try {
				  conn=DB.getConn();
				  boolean b=conn.getAutoCommit();
				  conn.setAutoCommit(false);
				  //�޸ķ���
				  pStmt=DB.getPStmt(conn, sql);
				  pStmt.setString(1, ticket.getRid());
				  pStmt.setInt(2,ticket.getState() );
				  pStmt.setTimestamp(3, ticket.getOpendate());
				  pStmt.setTimestamp(4, ticket.getEnddate());
				  pStmt.setString(5,ticket.gettDesc() );
				  pStmt.executeUpdate();
				  
				  //�޸Ľ�����״̬
				  if(ticket.state==1){
					  //�ҵ��ö��߳��ڵĽ�����,©��--һ�����¸ö������еĳ���ͼ���Ϊ�ѻ�
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
	 
	 public ArrayList<Ticket> getTicketByRId(String rId){ //ͨ��
		 
		    ArrayList<Ticket> tickets=new ArrayList<Ticket>();
		    Connection conn=null;
			String sql=null;
			ResultSet rs=null;
			 try {
				 conn=DB.getConn();
				 
				 sql="select  t.id tid,t.rid,t.state,t.opendate,t.deletedate,t.tdesc,titem.*   from ticket as t,ticketitem as titem where 1=1 and t.id=titem.tid and t.rid like '%"+rId+"%'";

				 //��ȡ��ѯ�Ľ��

				 rs=DB.excuteQuery(conn, sql);

			    Ticket ticket=null; 
			    ArrayList<TicketItem> tItems=null;
				 while(rs.next()){
					    TicketItem  tItem=new TicketItem();
					    //����鵥
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
					    //����鵥����Ŀ
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
	 
	 public TicketItem getTItemByBbItemNotReturn(BorrowBookItem bbItem){//��������һһ��Ӧ��ϵ
		 
		 BorrowBook bbook=BorrowBookManager.getInstance().loadById(bbItem.getbBid());
         Reader r=ReaderManager.getInstance().loadById(bbook.getrId());
        //�Ըö������е�δ�ɿ����������(������һ����һ��ͼ��ֻ�ܽ�һ���Ļ�����)
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
							 int pageNo,int pageSize){//δͨ��
		 Connection conn=null;
			String sql=null;
			String sqlCount=null;
			ResultSet rs=null;
			ResultSet rsCount=null;
	        int pageCount;
			 try {
				 conn=DB.getConn();
				 
				 sql="select  t.id tid,t.rid,t.state,t.opendate,t.deletedate,t.tdesc,titem.*   from ticket as t,ticketitem as titem where 1=1 and t.id=titem.tid ";


				 //����Id
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
				 
				 //����Id
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
				 
				 // ��������ĿId
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
				 
				// ���Id
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
				 
				 //״̬��
				 if(state!=-1){
					 sql+=" and t.state="+state+"  ";
				 }


				 
				 //�ؼ���
				 if(keyWord!=null&&!keyWord.trim().equals("")){
					 sql+=" and ( t.tdesc like '%"+keyWord+"%' "+" or titem.tidesc like '%"+keyWord+"%'  ) ";

				 }

				 //������ʱ��
				 if(openStartDate!=null){
					 sql+=" and (t.opendate>='"+new SimpleDateFormat("yyy-MM-dd").format(openStartDate)+"') ";
				 }
				 
				 if(openEndDate!=null){
					 sql+=" and (t.opendate<='"+new SimpleDateFormat("yyy-MM-dd").format(openEndDate)+"') ";
				 }
				 
				//��������ʱ��
				 if(deleteStartDate!=null){
					 sql+=" and (t.deletedate>='"+new SimpleDateFormat("yyy-MM-dd").format(deleteStartDate)+"') ";
				 }
				 
				 if(deleteEndDate!=null){
					 sql+=" and (t.deletedate<='"+new SimpleDateFormat("yyy-MM-dd").format(deleteEndDate)+"') ";
				 }
				 

				
	             sqlCount=sql.replaceFirst("t\\.id tid,t\\.rid,t\\.state,t\\.opendate,t\\.deletedate,t\\.tdesc,titem\\.\\*","count(*)");
				 sql+=" limit " +(pageNo-1)*pageSize+" ,"+pageSize;

				 //��ȡҳ������				
				
				 rsCount=DB.excuteQuery(conn, sqlCount);
				 rsCount.next();
				 pageCount=(rsCount.getInt(1)+pageSize-1)/pageSize;
				 
			
	             
				 
				 //��ȡ��ѯ�Ľ��

				 rs=DB.excuteQuery(conn, sql);

			    Ticket ticket=null; 
			    ArrayList<TicketItem> tItems=null;
				 while(rs.next()){
					    TicketItem  tItem=new TicketItem();
					    //��ӷ���
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
					    //��ӷ�������Ŀ
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
		 //��ȡ ���ڵ��鵥��ֻ�������ڵ��鵥�
		 ArrayList<BorrowBook> bbooks=BorrowBookManager.getInstance().getOverDateBorrowBook(intDay);
		 //Ϊÿ�����ڶ��߹���һ�ŷ�������
		  Ticket ticket=null;
		  ArrayList<TicketItem> tItems=null;
		  String rId=null;
		  if(bbooks.size()==0){//�����ڳ��ڵķ�����
			  return false;
		  }
		 try {
			conn=DB.getConn();
			boolean b=conn.getAutoCommit();
			conn.setAutoCommit(false);
			//�����ö��ߵķ������󼯺�
			  for(BorrowBook bb:bbooks){
				  if(rId!=bb.getrId()){ //�������Ķ���id����һ���鵥��һ��ʱ��ӷ���
					  ticket=new Ticket();
					  tItems=new ArrayList<TicketItem>(); 
	                  ticket.setRid(bb.getrId());
	                  ticket.setState(0);
	                  ticket.setOpendate(new Timestamp(System.currentTimeMillis()));
	                  ticket.setEnddate(null);
	                  ticket.settDesc("��");
	                 
				  }
				 //�������������
				  for(BorrowBookItem bbi: bb.getBorrowBookItems()){
					  TicketItem tItem=new TicketItem();
					    tItem.setBid(bbi.getbId());
					    tItem.setMoney(30);//����Ϊ30
					    tItem.setTtDesc("��");
					    tItems.add(tItem);
				  }
	             ticket.setTicketItems(tItems);

	              //��ӷ���
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
				Thread.sleep(checkDay*1000*10);//20��
				autoAddTicket(intDay);
				System.out.println("..........�����Զ�����ʱ����Ϊ��"+checkDay+"��");
				System.out.println("..........����ʱ��="+intDay);
			   } catch (InterruptedException e) {
				e.printStackTrace();
			   }
		    }
		   
	 }

}
