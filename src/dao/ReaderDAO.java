package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import javax.security.auth.message.callback.PrivateKeyCallback.Request;

import manager.BorrowBookManager;
import manager.TicketItemManger;
import manager.TicketManager;

import util.DB;

import bean.Book;
import bean.Reader;

public class ReaderDAO {
	    public ReaderDAO(){
	    	
	    }
    
       public  Reader loadById(String id ){//通过
    	   Connection conn=null;
		    ResultSet rs=null;
			String sql="select * from reader where id='"+id+"'";
			Reader r=null;
			try {
				  conn=DB.getConn();
				  rs=DB.excuteQuery(conn, sql);

				  if(rs.next()){
					  r=new Reader();
					  r.setId(rs.getString("id"));
					  r.setrName(rs.getString("rname"));
					  r.setSex(rs.getString("sex"));
					  r.setrPassword(rs.getString("rpassword"));
					  r.setPhone(rs.getInt("phone"));
					  r.setEmail(rs.getString("email"));
					  r.setAddr(rs.getString("addr"));
					  r.setRdate(rs.getTimestamp("rdate"));
					  r.setRdescr(rs.getString("rdscr"));//注意：不是rdescr

					  return r;
				  }else{
					  return r;
				  }
				  
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				return r;
			}finally{
				DB.closeRs(rs);
				DB.closeConn(conn);
				
			}
	   }
       
	   public  boolean isExist(Reader reader){//通过
		    Connection conn=null;
		    ResultSet rs=null;
			String sql="select * from reader where id='"+reader.getId()+"'";
			try {
				  conn=DB.getConn();
				  rs=DB.excuteQuery(conn, sql);
				  if(rs.next()){
					  return true;
				  }else{
					  return false;
				  }
				  
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				return false;
			}finally{
				DB.closeRs(rs);
				DB.closeConn(conn);
				
			}
	   }
	   
	   public  boolean addReader(Reader reader){//通过
		   Connection conn=null;
			PreparedStatement pStmt=null;
			String sql="insert into reader values(?,?,?,?,?,?,?,?,?)";
			try {
				  conn=DB.getConn();
				  pStmt=DB.getPStmt(conn, sql);
				  pStmt.setString(1,reader.getId());
				  pStmt.setString(2, reader.getrName());			  
				  pStmt.setString(3,reader.getSex());
				  pStmt.setString(4,reader.getrPassword());
				  pStmt.setInt(5,reader.getPhone());
				  pStmt.setString(6,reader.getEmail());
				  pStmt.setString(7,reader.getAddr());
				  pStmt.setTimestamp(8, reader.getRdate()); 
				  pStmt.setString(9,reader.getRdescr());
				  
				  pStmt.executeUpdate();
				  return true;
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				return false;
			}finally{
				DB.closePStmt(pStmt);
				DB.closeConn(conn);
				
			}

	   }  
	   public  boolean addReaders(ArrayList<Reader> readers){
		    return false;
	   }
	   public  boolean deleteReaderById(String id ) {//通过
		   Connection conn=null;
		   String sql="delete from reader where id='"+id+"'";		   
		   try {  
			      conn=DB.getConn();
                   boolean b=conn.getAutoCommit();
                   conn.setAutoCommit(false);
			      //删除罚单
                   TicketManager.getInstance().deleteTicketByRId(conn, id);
			      //删除借书项
                   BorrowBookManager.getInstance().deleteBorrowBookByRId(conn, id);
			      //删除读者
			       DB.excuteUpdate(conn, sql);
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
	   
	   public  boolean deleteReadersById(int[] ids){
		   return false;
	   }
	   public  boolean modifyReader(Reader reader){//未通过
		    Connection conn=null;
			PreparedStatement pStmt=null;
			String sql="update  reader set rname=?,sex=?,rpassword=?,phone=?," +
					   "email=?,addr=?,rdate=?,rdscr=? where id="+reader.getId();
			try {
				  conn=DB.getConn();
				  pStmt=DB.getPStmt(conn, sql);
				  pStmt.setString(1, reader.getrName());			  
				  pStmt.setString(2,reader.getSex());
				  pStmt.setString(3,reader.getrPassword());
				  pStmt.setInt(4,reader.getPhone());
				  pStmt.setString(5,reader.getEmail());
				  pStmt.setString(6,reader.getAddr());
				  pStmt.setTimestamp(7, reader.getRdate()); 
				  pStmt.setString(8,reader.getRdescr());				  
				  pStmt.executeUpdate();
				  return true;
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				return false;
			}finally{
				DB.closePStmt(pStmt);
				DB.closeConn(conn);
				
			}
	   }

	   public int getReaders(ArrayList<String> readers,int[] ids,int pageNo,int pageSize){
		   return 0;
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
		   
		    Connection conn=null;
			String sql=null;
			String sqlCount=null;
			ResultSet rs=null;
			ResultSet rsCount=null;
	        int pageCount;
			 try {
				 conn=DB.getConn();
				 
				 sql="select  * from reader where 1=1 ";

				 
				 String strId="";
				 
				 //Id
				 if(rIds!=null&&rIds.length>0){
					 strId=" and id in(";
					  for(int i=0;i<rIds.length;i++){
						  if(i<rIds.length-1){
							  strId+="'"+rIds[i]+"',";
						  }else{
							  strId+="'"+rIds[i]+"') ";
						  }
					  }
					  sql+=strId;
				 }
				 
				 //性别
				 
                 if(rSex!=null&&!rSex.trim().equals("")){
					 sql+=" and sex like '%"+rSex+"%' ";
				 }
				 
				 //电话
                 
                 if(rPhone!=0){
                	 sql+=" and phone="+rPhone;
 				 }
				 
				 //email
				 if(rEmail!=null&&!rEmail.trim().equals("")){
					 sql+=" and email like '%"+rEmail+"%' ";
				 }
 
				 //地址
				 if(rAddr!=null&&!rAddr.trim().equals("")){
					 sql+=" and addr like '%"+rAddr+"%' ";
				 }
 
				 
				 //关键字：名字，描叙
				 if(keyWord!=null&&!keyWord.trim().equals("")){
					 sql+=" and ( rname like '%"+keyWord+"%' "+" or rdscr like '%"+keyWord+"%' ) ";

				 }
				 
				
				 //上架时间
				 if(startRDate!=null){
					 sql+=" and (rdate>='"+new SimpleDateFormat("yyy-MM-dd").format(startRDate)+"') ";
				 }
				 
				 if(endRDate!=null){
					 sql+=" and (rdate<='"+new SimpleDateFormat("yyy-MM-dd").format(endRDate)+"') ";
				 }

	             sqlCount=sql.replaceFirst("\\*","count(*)"); 
				 sql+=" limit " +(pageNo-1)*pageSize+" ,"+pageSize;
		 
				 //获取页面总数				
				
				 rsCount=DB.excuteQuery(conn, sqlCount);
				 rsCount.next();
				 pageCount=(rsCount.getInt(1)+pageSize-1)/pageSize;
                        
				 
				 //获取查询的结果

				 rs=DB.excuteQuery(conn, sql);
				 while(rs.next()){
						  Reader r=new Reader();
						  r=new Reader();
						  r.setId(rs.getString("id"));
						  r.setrName(rs.getString("rname"));
						  r.setSex(rs.getString("sex"));
						  r.setrPassword(rs.getString("rpassword"));
						  r.setPhone(rs.getInt("phone"));
						  r.setEmail(rs.getString("email"));
						  r.setAddr(rs.getString("addr"));
						  r.setRdate(rs.getTimestamp("rdate"));
						  r.setRdescr(rs.getString("rdscr"));
						  readers.add(r);
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

	public boolean  loginCheck( Reader r,String uId, String pwd) {
		// TODO Auto-generated method stub
		    Connection conn=null;
		    ResultSet rs=null;
			String sql="select * from reader where id='"+uId+"' and rpassword='"+pwd+"'";
			try {
				  conn=DB.getConn();
				  rs=DB.excuteQuery(conn, sql);
				  if(rs.next()){					 
					  r.setId(rs.getString("id"));
					  r.setrName(rs.getString("rname"));
					  r.setSex(rs.getString("sex"));
					  r.setrPassword(rs.getString("rpassword"));
					  r.setPhone(rs.getInt("phone"));
					  r.setEmail(rs.getString("email"));
					  r.setAddr(rs.getString("addr"));
					  r.setRdate(rs.getTimestamp("rdate"));
					  r.setRdescr(rs.getString("rdscr"));	
					  return true;
			         }else{
				      return false;
			         }
				  
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				return false;
			}finally{
				DB.closeRs(rs);
				DB.closeConn(conn);
				
			}
	}
		
}
