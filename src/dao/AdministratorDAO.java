package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import util.DB;
import bean.Administrator;

public class AdministratorDAO {
  public AdministratorDAO(){
	  
  }
  
	public Administrator loadById(int id){//通过
		Connection conn=null;
		String sql=null;
		ResultSet rs=null;
		Administrator admin=null;
		 try {
			 conn=DB.getConn();			 
			 sql="select  * from administrator where id="+id;
			 
			 //获取查询的结果
			 rs=DB.excuteQuery(conn, sql);
			 if(rs.next()){
				    admin=new Administrator();
					admin.setId(rs.getInt("id"));
					admin.setAdminName(rs.getString("adminname"));
					admin.setSex(rs.getString("sex"));
					admin.setAdminPassword(rs.getString("adminpassword"));
					admin.setPhone(rs.getInt("phone"));
					admin.setAddr(rs.getString("addr"));
					admin.setRdate(rs.getTimestamp("rdate"));
					admin.setIsRoot(rs.getInt("isroot"));
					admin.setAdminDesc(rs.getString("admindesc"));
			 }

             return admin;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return admin;
		}finally{
			
			DB.closeRs(rs);
			DB.closeConn(conn);
		}
	}
	
	public boolean isExist(Administrator admin){//通过
		    Connection conn=null;
		    ResultSet rs=null;
			String sql=null;
			try {
				  sql="select * from  administrator where id="+admin.getId();
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
	public boolean isRoot(Administrator admin){
		return false;
	}
	public boolean addAdministrator(Administrator admin){//通过
		    Connection conn=null;
			PreparedStatement pStmt=null;
			String sql="insert into administrator values(?,?,?,?,?,?,?,?,?)";
			try {
				  conn=DB.getConn();
				  pStmt=DB.getPStmt(conn, sql);
				  pStmt.setInt(1,admin.getId() );
			      pStmt.setString(2,admin.getAdminName() );
			      pStmt.setString(3,admin.getSex() );
			      pStmt.setString(4,admin.getAdminPassword() );
			      pStmt.setInt(5,admin.getPhone() );
			      pStmt.setString(6,admin.getAddr() );
			      pStmt.setTimestamp(7,admin.getRdate() );
			      pStmt.setInt(8, admin.getIsRoot());
			      pStmt.setString(9,admin.getAdminDesc() );				  
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
	public boolean deleteAdminById(int id){//通过
		    Connection conn=null;
			String sql="delete from  administrator where id="+id;
			try {
				  conn=DB.getConn();
				  DB.excuteUpdate(conn, sql);
				  return true;
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				return false;
			}finally{
				DB.closeConn(conn);
				
			}
	}
	public boolean deleteAdminsById(int[] ids){
		return false;
	}
	public boolean modify(Administrator admin){//通过
		  Connection conn=null;
			PreparedStatement pStmt=null;
			String sql="update administrator set adminname=?,sex=?,adminpassword=?," +
					"phone=?,addr=?,rdate=?,isroot=?,admindesc=? where id="+admin.getId();
			try {
				  conn=DB.getConn();
				  pStmt=DB.getPStmt(conn, sql);
			      pStmt.setString(1,admin.getAdminName() );
			      pStmt.setString(2,admin.getSex() );
			      pStmt.setString(3,admin.getAdminPassword() );
			      pStmt.setInt(4,admin.getPhone() );
			      pStmt.setString(5,admin.getAddr() );
			      pStmt.setTimestamp(6,admin.getRdate() );
			      pStmt.setInt(7, admin.getIsRoot());
			      pStmt.setString(8,admin.getAdminDesc() );				  
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
	public Administrator getRootAdmin(){
		return null;
	}
	public ArrayList<Administrator> getAdminBynName(String[] names){
		return null;
	}
	public int getAdmins(ArrayList<Administrator> admins,int pageNo,int pageSizse){
		return 0;
	}
	public int findAdmins(ArrayList<Administrator> admins, //通过
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
		Connection conn=null;
		String sql=null;
		String sqlCount=null;
		ResultSet rs=null;
		ResultSet rsCount=null;
        int pageCount;
		 try {
			 conn=DB.getConn();
			 
			 sql="select  * from administrator where 1=1 ";

			 
			 String strId="";
			 
			 //管理员Id
			 if(ids!=null&&ids.length>0){
				 strId=" and id in(";
				  for(int i=0;i<ids.length;i++){
					  if(i<ids.length-1){
						  strId+=ids[i]+",";
					  }else{
						  strId+=ids[i]+") ";
					  }
				  }
				  sql+=strId;
			 }
			 
			 
			 //关键字
			 if(keyWord!=null&&!keyWord.trim().equals("")){
				 sql+=" and ( adminname like '%"+keyWord+"%' "+" or admindesc like '%"+keyWord+"%')";

			 }
			 
            //性别
             if(sex!=null&&!sex.trim().equals("")){
				 sql+=" and sex like '%"+sex+"%' ";
			 }
			 
			 //电话
             
             if(phone!=0){
            	 sql+=" and phone="+phone;
				 }

			 //地址
			 if(addr!=null&&!addr.trim().equals("")){
				 sql+=" and addr like '%"+addr+"%' ";
			 }
             
             //是否为管理员
			 
			 if(isRoot!=-1){
				 sql+=" and isroot="+isRoot;
			 }
			 
			
			 //注册时间
			 if(rStartDate!=null){
				 sql+=" and (rdate>='"+new SimpleDateFormat("yyy-MM-dd").format(rStartDate)+"') ";
			 }
			 
			 if(rEndDate!=null){
				 sql+=" and (rdate<='"+new SimpleDateFormat("yyy-MM-dd").format(rEndDate)+"') ";
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
					Administrator admin=new Administrator();
					admin.setId(rs.getInt("id"));
					admin.setAdminName(rs.getString("adminname"));
					admin.setSex(rs.getString("sex"));
					admin.setAdminPassword(rs.getString("adminpassword"));
					admin.setPhone(rs.getInt("phone"));
					admin.setAddr(rs.getString("addr"));
					admin.setRdate(rs.getTimestamp("rdate"));
					admin.setIsRoot(rs.getInt("isroot"));
					admin.setAdminDesc(rs.getString("admindesc"));
                    admins.add(admin);
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
	
	public boolean loginCheck(Administrator admin, int uId, String pwd){//未通过
		Connection conn=null;
		String sql=null;
		ResultSet rs=null;
		 try {
			 conn=DB.getConn();			 
			 sql="select  * from administrator where id="+uId+"  and adminpassword='"+pwd+"'";
			 System.out.println(sql);
			 //获取查询的结果
			 rs=DB.excuteQuery(conn, sql);
			 if(rs.next()){
					admin.setId(rs.getInt("id"));
					admin.setAdminName(rs.getString("adminname"));
					admin.setSex(rs.getString("sex"));
					admin.setAdminPassword(rs.getString("adminpassword"));
					admin.setPhone(rs.getInt("phone"));
					admin.setAddr(rs.getString("addr"));
					admin.setRdate(rs.getTimestamp("rdate"));
					admin.setIsRoot(rs.getInt("isroot"));
					admin.setAdminDesc(rs.getString("admindesc"));
					return true;
			 }

             return false;
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
