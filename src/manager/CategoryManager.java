package manager;

import java.util.ArrayList;

import dao.CategoryDAO;

import bean.Category;

public class CategoryManager {

	   private static  CategoryManager cm=null;
	   private   CategoryDAO DAO=null;
       
	   static{
		   if(cm==null){
			   cm=new CategoryManager();
			   cm.setDao(new CategoryDAO());
		   }
	   }
	   
	   private CategoryManager(){
        
	   }
	   
	   public static  CategoryManager getInstance(){
		   return cm; 
	   }
	   
		public  Category loadById(int id){
			return DAO.loadById(id);
		}
		public  Boolean isExist(Category c){
			return DAO.isExist(c);
		}
		public  boolean addChild(Category c){
			return DAO.addChild(c);
		}
		public  boolean addChilds(ArrayList<Category> cates){
			return DAO.addChilds(cates);
		}
		
		public  boolean  deleteCateById(int id,int pId){
			return DAO.deleteCateById(id,pId);

		}
		public  boolean deleteCatesById(int[] ids){
			return DAO.deleteCatesById(ids);
		}
		public  boolean modifyCategory(Category c){
			return DAO.modifyCategory(c);
		}
		public  boolean modifyCategoris(ArrayList<Category> cates){
			return DAO.modifyCategoris(cates);
		}
		public  Category getCategorisByid(int id){
			return DAO.getCategorisByid(id);
		}
		public  ArrayList<Category> getCategorisByid(int[] ids){
			return DAO.getCategorisByid(ids);
		}
		public  ArrayList<Category> getCategoryTree(int rootId){
			return DAO.getCategoryTree(rootId);
		}
		public  ArrayList<Category> getDirectChildsByPid(int pId){
			return DAO.getDirectChildsByPid(pId);
		}
	    
	   public CategoryDAO getDao() {
			return DAO;
		}

		public void setDao(CategoryDAO DAO) {
			this.DAO = DAO;
		}
	   

   
   
   
}
