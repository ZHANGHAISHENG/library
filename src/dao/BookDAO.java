package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import manager.CategoryManager;

import com.sun.org.apache.regexp.internal.recompile;


import util.DB;

import bean.Book;
import bean.Category;

public class BookDAO {
  public BookDAO(){}
  

	public Book loadById(int id){//通过
		Connection conn=null;
        ResultSet rs=null;
        Book b=new Book();
		String sql="select * from  book where id="+id;

		try {
			  conn=DB.getConn();
			  rs=DB.excuteQuery(conn, sql);
			  if(rs.next()){
				  b.setId(rs.getInt("id"));
				  b.setCateId(rs.getInt("cateid"));
				  b.setBookName(rs.getString("bookname"));
				  b.setAuthorName(rs.getString("authorname"));
				  b.setBookVersion(rs.getString("bookversion"));
				  b.setSum(rs.getInt("booksum"));
				  b.setUnUseBookSum(rs.getInt("unusebooksum"));
				  b.setpDate(rs.getTimestamp("pdate"));
				  b.setbDesc(rs.getString("bdesc"));
			  }
			  return b;
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return null;
		}finally{

			DB.closeConn(conn);
			
		}

	}
	public boolean isExist(Book b){ //通过
		Connection conn=null;
		String sql="select * from book where cateid="+b.getCateId()+"  and bookname='"+b.getBookName()+"'";

		Statement stmt=null;
		ResultSet rs=null;
		try {
			  conn=DB.getConn();
			  stmt=DB.getStmt(conn);
			  rs=DB.excuteQuery(stmt, sql);
			  if(rs.next()){
				  return true;
			  }
			 return false;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		}finally{
			DB.closeRs(rs);
			DB.closeStmt(stmt);
			DB.closeConn(conn);
			
		}

	}
	
	public boolean isExist(int id){ //通过
		Connection conn=null;
		String sql="select * from book where id="+id;

		Statement stmt=null;
		ResultSet rs=null;
		try {
			  conn=DB.getConn();
			  stmt=DB.getStmt(conn);
			  rs=DB.excuteQuery(stmt, sql);
			  if(rs.next()){
				  return true;
			  }
			 return false;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		}finally{
			DB.closeRs(rs);
			DB.closeStmt(stmt);
			DB.closeConn(conn);
			
		}

	}
	public boolean addBook(Book b){//通过
		Connection conn=null;
		PreparedStatement pStmt=null;
		String sql="insert into book values(null,?,?,?,?,?,?,?,?)";
		try {
			  conn=DB.getConn();
			  pStmt=DB.getPStmt(conn, sql);
			  pStmt.setInt(1, b.getCateId());			  
			  pStmt.setString(2,b.getBookName());
			  pStmt.setString(3,b.getAuthorName());
			  pStmt.setString(4,b.getBookVersion());
			  pStmt.setInt(5, b.getSum());
			  pStmt.setInt(6,b.getUnUseBookSum() );
			  pStmt.setTimestamp(7, b.getpDate()); 
			  pStmt.setString(8,b.getbDesc());
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
	
	public boolean addBooks(ArrayList<Book> books){
		return false;
	}
	public boolean deleteBookById(int id){//通过
		Connection conn=null;

		String sql="delete from book where id="+id;

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
	public boolean deleteBooksById(int[] ids){
		return false;
	}
	public boolean deleteBookByCategoryId(int cateId){
		return false;
   }
	public boolean updateBook(Book b){ //没有修改上架时间的功能，通过
		Connection conn=null;
		PreparedStatement pStmt=null;
		String sql="update book  set cateid=?,bookname=?,authorname=?," +
				"bookversion=?,booksum=?,bdesc=?  where id="+b.getId();
		try {
			  conn=DB.getConn();
			  pStmt=DB.getPStmt(conn, sql);
			  pStmt.setInt(1, b.getCateId());			  
			  pStmt.setString(2,b.getBookName());
			  pStmt.setString(3,b.getAuthorName());
			  pStmt.setString(4,b.getBookVersion());
			  pStmt.setInt(5, b.getSum());
			  pStmt.setString(6,b.getbDesc());
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
	
	
	public void updateBook(Connection conn,Book b) throws SQLException{ //用于修改图书的数量
		PreparedStatement pStmt=null;
		String sql="update book  set cateid=?,bookname=?,authorname=?," +
				"bookversion=?,booksum=?,unusebooksum=?,bdesc=?  where id="+b.getId();
		try {
			  conn=DB.getConn();
			  pStmt=DB.getPStmt(conn, sql);
			  pStmt.setInt(1, b.getCateId());			  
			  pStmt.setString(2,b.getBookName());
			  pStmt.setString(3,b.getAuthorName());
			  pStmt.setString(4,b.getBookVersion());
			  pStmt.setInt(5, b.getSum());
			  pStmt.setInt(6, b.getUnUseBookSum());
			  pStmt.setString(7,b.getbDesc());
			  pStmt.executeUpdate();
			
		}finally{
			DB.closePStmt(pStmt);
			
		}

	}
	
	public boolean updateBooks(ArrayList<Book> books) {
		return false;
	}   
	
	//public ArrayList<E>
	
	public void  getBooksByCategoryId(int cateId,ArrayList<Book> books){
		Connection conn=null;
		String sql=null;
		ResultSet rs=null;

		 try {
			 conn=DB.getConn();
			 
			 sql="select  * from book where 1=1  and book.cateid="+cateId;

			 //获取查询的结果

			 rs=DB.excuteQuery(conn, sql);
			 while(rs.next()){
					Book b=new Book();
					b.setId(rs.getInt("id"));
					b.setCateId(rs.getInt("cateid"));
					b.setBookName(rs.getString("bookname"));
					b.setAuthorName(rs.getString("authorname"));
					b.setBookVersion(rs.getString("bookversion"));
					b.setSum(rs.getInt("booksum"));
					b.setUnUseBookSum(rs.getInt("unusebooksum"));
					b.setpDate(rs.getTimestamp("pdate"));
					b.setbDesc(rs.getString("bdesc"));
					books.add(b);
   
			 }
			 
			 
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
	
		}finally{
			
			DB.closeRs(rs);
			DB.closeConn(conn);
		}
	}
	
	
	public void  getBooksByCategoryId(Connection conn,int cateId,ArrayList<Book> books){
		String sql=null;
		ResultSet rs=null;

		 try {
			 
			 sql="select  * from book where 1=1  and book.cateid="+cateId;

			 //获取查询的结果

			 rs=DB.excuteQuery(conn, sql);
			 while(rs.next()){
					Book b=new Book();
					b.setId(rs.getInt("id"));
					b.setCateId(rs.getInt("cateid"));
					b.setBookName(rs.getString("bookname"));
					b.setAuthorName(rs.getString("authorname"));
					b.setBookVersion(rs.getString("bookversion"));
					b.setSum(rs.getInt("booksum"));
					b.setUnUseBookSum(rs.getInt("unusebooksum"));
					b.setpDate(rs.getTimestamp("pdate"));
					b.setbDesc(rs.getString("bdesc"));
					books.add(b);
			 }
			 
			 
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
	
		}finally{
			
			DB.closeRs(rs);
		}
	}
	
	public  ArrayList<Book> getAllBooksByRootCateId(int rootCateId){
		Connection conn=null;
		ArrayList<Category>categories;
		ArrayList<Book> books=new ArrayList<Book>();
		
		try {
			conn=DB.getConn();
			categories=CategoryManager.getInstance().getCategoryTree(rootCateId);
			for(Category category:categories){
				if(category.isLeaf()){
					getBooksByCategoryId(conn,category.getId(), books);
				}
			}
			
			return books;
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return books;
		}finally{
          DB.closeConn(conn);
		}
		
	}
	
	public ArrayList<Book> getBooksByCategoriesId(int[] cateIds,int page,int size){
		return null;
	}
	public int finBooksByKeyWord(ArrayList<Book> books,String keyWord,int page,int size){
		return 0;
	}
	public int finBooksByKeyWordAndCateId(ArrayList<Book> books,String keyWord,int cateId,int page,int size){
		return 0;
	}
	public int  finBooks(ArrayList<Book> books,
						String keyWord,
						int[] cateIds,
						int bookSum,
						int unUseBookSum,
						Timestamp startDate,
						Timestamp endDate,
						int pageNo,
						int pageSize){ //通过
		Connection conn=null;
		String sql=null;
		String sqlCount=null;
		ResultSet rs=null;
		ResultSet rsCount=null;
        int pageCount;
		 try {
			 conn=DB.getConn();
			 
			 sql="select  * from book where 1=1 ";

			 
			 String strId="";
			 
			 //由于类别下面可能含有子类别,并且只有叶子节点下才有图书存在,为提高效率所以需要找到叶子节点
			 ArrayList<Category> categories=new ArrayList<Category>();
			 
	         if(cateIds!=null){
	        	 for(int i=0;i<cateIds.length;i++){
	  				 
	  				 Category c=CategoryManager.getInstance().loadById(cateIds[i]);
	  				 if(c.isLeaf()){
	  					 categories.add(c);
	  				 }else{
	  					 categories.addAll(CategoryManager.getInstance().getCategoryTree(cateIds[i]));
	  				 }
	  				 
	  			 }
	         }
        	  

			 //构建关于类别Id部分的sql语句
			  if(!categories.isEmpty()){
				  strId=" and cateid in(";
				  for(Category category :categories){
						strId+=category.getId()+",";
				  }
				  sql+=strId.substring(0, strId.lastIndexOf(","))+") ";
			  }

			/* 
			 if(cateIds!=null&&cateIds.length>0){
				 strId=" and cateid in(";
				  for(int i=0;i<cateIds.length;i++){
					  if(i<cateIds.length-1){
						  strId+=cateIds[i]+",";
					  }else{
						  strId+=cateIds[i]+") ";
					  }
				  }
				  sql+=strId;
			 }
*/
			 
			 //关键字
			 if(keyWord!=null&&!keyWord.trim().equals("")){
				 sql+=" and ( bookname like '%"+keyWord+"%' "+" or authorname like '%"+keyWord+"%' "+" or bookversion like '%"+keyWord+"%' "+" or bdesc like '%"+keyWord+"%' ) ";

			 }
			 
			
			 //上架时间
			 if(startDate!=null){
				 sql+=" and (pdate>='"+new SimpleDateFormat("yyy-MM-dd").format(startDate)+"') ";
			 }
			 
			 if(endDate!=null){
				 sql+=" and (pdate<='"+new SimpleDateFormat("yyy-MM-dd").format(endDate)+"') ";
			 }
			 
			 
			 if(bookSum!=0){//书的总数
				 sql+=" and (booksum="+bookSum+") ";
			 }
			 
             if(unUseBookSum!=0){//剩余的书的数量
            	 sql+=" and (unusebooksum="+unUseBookSum+") ";
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
					Book b=new Book();
					b.setId(rs.getInt("id"));
					b.setCateId(rs.getInt("cateid"));
					b.setBookName(rs.getString("bookname"));
					b.setAuthorName(rs.getString("authorname"));
					b.setBookVersion(rs.getString("bookversion"));
					b.setSum(rs.getInt("booksum"));
					b.setUnUseBookSum(rs.getInt("unusebooksum"));
					b.setpDate(rs.getTimestamp("pdate"));
					b.setbDesc(rs.getString("bdesc"));
					books.add(b);
   
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
}


