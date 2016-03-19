package bean;

import java.sql.Timestamp;
import java.util.ArrayList;

import manager.CategoryManager;

public class Category {
   private int id;
   private int  pid;
   private String cateName;
   private int grade;
   private int isleaf;// isleaf：0叶子节点，1非叶子节点
   private Timestamp pdate;
   private String cateDesc;
   
   public Category(){}

	public int getId() {
		return id;
	}
	
	public void setId(int id) {
		this.id = id;
	}
	
	public int getPid() {
		return pid;
	}
	
	public void setPid(int pid) {
		this.pid = pid;
	}
	
	public String getCateName() {
		return cateName;
	}
	
	public void setCateName(String cateName) {
		this.cateName = cateName;
	}
	
	public int getGrade() {
		return grade;
	}
	
	public void setGrade(int grade) {
		this.grade = grade;
	}
	
	public int getIsleaf() {
		return this.isleaf;
	}
	
	public void setIsleaf(int isleaf) {
		this.isleaf = isleaf;
	}
	
	public Timestamp getPdate() {
		return this.pdate;
	}
	
	public void setPdate(Timestamp pdate) {
		this.pdate = pdate;
	}
	
	public String getCateDesc() {
		return this.cateDesc;
	}
	
	public void setCateDesc(String cateDesc) {
		this.cateDesc = cateDesc;
	}
   
	public boolean isLeaf(){
		return (isleaf==0)? true :false;
	}
	public Category load(){
		return CategoryManager.getInstance().loadById(this.id);
	}
	public Boolean isExist(){
		return CategoryManager.getInstance().isExist(this);
	}
	public boolean addChild(Category c){
		return CategoryManager.getInstance().addChild(c);
	}
	public boolean addChilds(ArrayList<Category> cates){
		return CategoryManager.getInstance().addChilds(cates);
	}
   
   
}
