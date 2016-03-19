package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import util.DB;


import bean.Category;

public class CategoryDAO {
	        
	        public CategoryDAO(){
	        	
	        };
	      
			public  Category loadById(int id){ //通过
				Connection conn=null;
				String sql=null;
				ResultSet rs=null;
			    Category c=new Category();
			    
				 try {
					 sql="select * from category where id="+id;
					 conn=DB.getConn();
					 rs=DB.excuteQuery(conn, sql);
					 if(rs.next()){
						 c.setId(rs.getInt("id"));
						 c.setPid(rs.getInt("pid"));
						 c.setCateName(rs.getString("catename"));
						 c.setGrade(rs.getInt("grade"));
						 c.setIsleaf(rs.getInt("isleaf"));
						 c.setPdate(rs.getTimestamp("pdate"));
						 c.setCateDesc(rs.getString("catedesc"));
						 
					 }
		             return c;
				}catch (Exception e) {
					e.printStackTrace();
					return null;
				}finally{
					
					DB.closeRs(rs);
					DB.closeConn(conn);
				}
			}
			
			public  Boolean isExist(Category c){//通过
				Connection conn=null;
				String sql=null;
				ResultSet rs=null;
	           
			    
				 try {
					 sql="select * from category where catename='"+c.getCateName()
							 +"' and  pid="+c.getPid();
					
					 conn=DB.getConn();
					 rs=DB.excuteQuery(conn, sql);
					 if(rs.next()){
						 return true;
						 
					 }
		             return false;
				}catch (Exception e) {
					e.printStackTrace();
					 return false;
				}finally{
					
					DB.closeRs(rs);
					DB.closeConn(conn);
				}
			}
			
			public  boolean addChild(Category c){//通过
				Connection conn=null;
				String sql=null;
				PreparedStatement pStmt=null;
				ResultSet rs=null;
				int parentGrade;
				 try {
					  conn=DB.getConn();
					  sql="insert into category values(null,?,?,?,?,?,?)";
					  pStmt=DB.getPStmt(conn, sql);
					  
					  
					  boolean b=conn.getAutoCommit();
					  conn.setAutoCommit(false);
                      
					  if(c.getPid()!=0){//判断是否往虚拟的根节点添加子目录
							  //获取父叶子节点grade
							  rs=DB.excuteQuery(conn,"select * from category where id="+c.getPid());
							  rs.next();
							  parentGrade=rs.getInt("grade");
							  	
							   //插入类别
							  pStmt.setInt(1, c.getPid());
							  pStmt.setString(2, c.getCateName());
							  pStmt.setInt(3, parentGrade+1);
							  pStmt.setInt(4,  c.getIsleaf());
							  pStmt.setTimestamp(5, c.getPdate());
							  pStmt.setString(6, c.getCateDesc());
							  
							  pStmt.executeUpdate();
							  
							  //使父叶子节点变成非叶子节点
				              
							    DB.excuteUpdate(conn,"update category set isleaf=1 where id="+c.getPid());
		               }else{
		            	 //插入类别
							  pStmt.setInt(1, c.getPid());
							  pStmt.setString(2, c.getCateName());
							  pStmt.setInt(3, 1);
							  pStmt.setInt(4,  c.getIsleaf());
							  pStmt.setTimestamp(5, c.getPdate());
							  pStmt.setString(6, c.getCateDesc());
							  pStmt.executeUpdate();
		            	   
		               }
					  
					  
					 conn.commit();
					 conn.setAutoCommit(b);
					 return true;
					 
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					try {
						conn.rollback();
					} catch (SQLException e1) {
						// TODO Auto-generated catch block
						e1.printStackTrace();
					}
					e.printStackTrace();
					return false;
				}finally{
					DB.closeRs(rs);
					DB.closePStmt(pStmt);
					DB.closeConn(conn);			
				}
			}
			
			public  boolean addChilds(ArrayList<Category> cates){
				return false;
			}
			
			public  boolean  deleteCateById(int id,int pId){
				
				Connection conn=null;
				String sql=null;
				ResultSet rs=null;
				
				 try {
					 conn=DB.getConn();
					 boolean b=conn.getAutoCommit();
					 conn.setAutoCommit(false);
					//删除自身目录以及子目录
					deleteCateById(conn, id);
						
					//判断是否要将父叶子节点变成叶子节点	
					 	
					 sql="select * from category where pid="+pId;
					 rs=DB.excuteQuery(conn, sql);
					 if(!rs.next()){
						 sql="update category set isleaf=0 where  id="+pId;
						 DB.excuteUpdate(conn, sql);
					 }
					 conn.commit();
					 conn.setAutoCommit(b);
					return true;
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					
					try {
						conn.rollback();
					} catch (SQLException e1) {
						// TODO Auto-generated catch block
						e1.printStackTrace();
					}
					e.printStackTrace();
					return false;
				}finally{
					
					DB.closeRs(rs);
					DB.closeConn(conn);
				}	
				
			}
			
			public  void  deleteCateById(Connection conn,int id) throws SQLException{//未通过：//删除该类别下的产品
				String sql="select * from category where pid="+id;
				ResultSet rs=null;
				int leaf;
				int chilId;
				 try {
					 rs=DB.excuteQuery(conn, sql);
					 
					 while(rs.next()){
						   chilId=rs.getInt("id");
						   leaf=rs.getInt("isleaf");
					        if(leaf!=0){//非叶子节点就执行递归	
					        	deleteCateById(conn,chilId);
					        }else{
						        DB.excuteUpdate(conn, "delete from book where cateid="+chilId);//删除该类别下的图书
						        DB.excuteUpdate(conn,"delete from category where id="+chilId); //删除子节点
					        }
					 }
					 // DB.excuteUpdate(conn, "delete from book where cateid="+id);//删除该类别下的图书,此句在此不需有
					 DB.excuteUpdate(conn,"delete from category where id="+id); //删除根节点
			
				}finally{
					DB.closeRs(rs);
				}
			}
			
			
			
			public  boolean deleteCatesById(int[] ids){
				return false;
			}
			public  boolean modifyCategory(Category c){//通过
				Connection conn=null;
				String sql=null;
				 try {
					  conn=DB.getConn();
					  sql="update category set catename='"+c.getCateName()+
							  "', catedesc='"+c.getCateDesc()+"' where id="+c.getId();
					  
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
			public  boolean modifyCategoris(ArrayList<Category> cates){
				return false;
			}
			public  Category getCategorisByid(int id){
				return null;
			}
			public  ArrayList<Category> getCategorisByid(int[] ids){
				return null;
			}
			
			public  ArrayList<Category> getCategoryTree(int rootId){  //不包括根节点
				Connection conn=null;
			    try {
					conn=DB.getConn();	
					ArrayList<Category> cates=new ArrayList<Category>();
					getCategoryTree(conn,cates, rootId);//将conn作为参数传过去防止conn过多导致效率低
					return cates;
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
					return null;
				}finally{
					
					DB.closeConn(conn);
				}
			}
			
			public  void getCategoryTree(Connection conn,List<Category> cates,int rootId){
				
				String sql="select * from category where pid="+rootId;

				ResultSet rs=null;
				 try {
					 rs=DB.excuteQuery(conn, sql);
					 
					 while(rs.next()){
						    Category c=new Category();
							     c.setId(rs.getInt("id"));
								 c.setPid(rs.getInt("pid"));
								 c.setCateName(rs.getString("catename"));
								 c.setGrade(rs.getInt("grade"));
								 c.setIsleaf(rs.getInt("isleaf"));
								 c.setPdate(rs.getTimestamp("pdate"));
								 c.setCateDesc(rs.getString("catedesc"));
					        cates.add(c);  
					        if(!c.isLeaf()){//非叶子节点就执行递归	
					        	getCategoryTree(conn,cates,c.getId());
					        }
					 }
		            
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}finally{		
					DB.closeRs(rs);
				}
				
			}
		
		public  ArrayList<Category> getDirectChildsByPid(int pId){//通过
			Connection conn=null;
			String sql=null;
			ResultSet rs=null;
		    ArrayList<Category> categories=new ArrayList<Category>();
		    
			 try {
				 sql="select * from category where pid="+pId;
				 conn=DB.getConn();
				 rs=DB.excuteQuery(conn, sql);
				 while(rs.next()){
					 Category c=new Category();
					 c.setId(rs.getInt("id"));
					 c.setPid(rs.getInt("pid"));
					 c.setCateName(rs.getString("catename"));
					 c.setGrade(rs.getInt("grade"));
					 c.setIsleaf(rs.getInt("isleaf"));
					 c.setPdate(rs.getTimestamp("pdate"));
					 c.setCateDesc(rs.getString("catedesc"));
					 categories.add(c);
					 
				 }
	             return categories;
			}catch (Exception e) {
				e.printStackTrace();
				return categories;
			}finally{
				
				DB.closeRs(rs);
				DB.closeConn(conn);
			}
		}
	   
		   
}
