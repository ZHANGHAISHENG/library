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
	      
			public  Category loadById(int id){ //ͨ��
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
			
			public  Boolean isExist(Category c){//ͨ��
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
			
			public  boolean addChild(Category c){//ͨ��
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
                      
					  if(c.getPid()!=0){//�ж��Ƿ�������ĸ��ڵ������Ŀ¼
							  //��ȡ��Ҷ�ӽڵ�grade
							  rs=DB.excuteQuery(conn,"select * from category where id="+c.getPid());
							  rs.next();
							  parentGrade=rs.getInt("grade");
							  	
							   //�������
							  pStmt.setInt(1, c.getPid());
							  pStmt.setString(2, c.getCateName());
							  pStmt.setInt(3, parentGrade+1);
							  pStmt.setInt(4,  c.getIsleaf());
							  pStmt.setTimestamp(5, c.getPdate());
							  pStmt.setString(6, c.getCateDesc());
							  
							  pStmt.executeUpdate();
							  
							  //ʹ��Ҷ�ӽڵ��ɷ�Ҷ�ӽڵ�
				              
							    DB.excuteUpdate(conn,"update category set isleaf=1 where id="+c.getPid());
		               }else{
		            	 //�������
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
					//ɾ������Ŀ¼�Լ���Ŀ¼
					deleteCateById(conn, id);
						
					//�ж��Ƿ�Ҫ����Ҷ�ӽڵ���Ҷ�ӽڵ�	
					 	
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
			
			public  void  deleteCateById(Connection conn,int id) throws SQLException{//δͨ����//ɾ��������µĲ�Ʒ
				String sql="select * from category where pid="+id;
				ResultSet rs=null;
				int leaf;
				int chilId;
				 try {
					 rs=DB.excuteQuery(conn, sql);
					 
					 while(rs.next()){
						   chilId=rs.getInt("id");
						   leaf=rs.getInt("isleaf");
					        if(leaf!=0){//��Ҷ�ӽڵ��ִ�еݹ�	
					        	deleteCateById(conn,chilId);
					        }else{
						        DB.excuteUpdate(conn, "delete from book where cateid="+chilId);//ɾ��������µ�ͼ��
						        DB.excuteUpdate(conn,"delete from category where id="+chilId); //ɾ���ӽڵ�
					        }
					 }
					 // DB.excuteUpdate(conn, "delete from book where cateid="+id);//ɾ��������µ�ͼ��,�˾��ڴ˲�����
					 DB.excuteUpdate(conn,"delete from category where id="+id); //ɾ�����ڵ�
			
				}finally{
					DB.closeRs(rs);
				}
			}
			
			
			
			public  boolean deleteCatesById(int[] ids){
				return false;
			}
			public  boolean modifyCategory(Category c){//ͨ��
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
			
			public  ArrayList<Category> getCategoryTree(int rootId){  //���������ڵ�
				Connection conn=null;
			    try {
					conn=DB.getConn();	
					ArrayList<Category> cates=new ArrayList<Category>();
					getCategoryTree(conn,cates, rootId);//��conn��Ϊ��������ȥ��ֹconn���ർ��Ч�ʵ�
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
					        if(!c.isLeaf()){//��Ҷ�ӽڵ��ִ�еݹ�	
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
		
		public  ArrayList<Category> getDirectChildsByPid(int pId){//ͨ��
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
