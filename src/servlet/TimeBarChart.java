package servlet;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import manager.BorrowBookManager;

import org.jfree.chart.servlet.ServletUtilities;
import org.jfree.data.category.CategoryDataset;

import util.BarChartUtil;
import util.LineChartUtil;


public class TimeBarChart extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//获取Dateset
		   Timestamp startODate=adjustDate(request,"startODate");
		   Timestamp endODate=adjustDate(request,"endODate");
		   CategoryDataset dataSet=BorrowBookManager.getInstance().getTimeCategoryDateset(startODate, endODate);
		
		//显示样式（是否为3D效果）  
		String style = request.getParameter("style");  
		String fileName = null;     //生成图片的文件名  
		if(style != null && "3d".equals(style)){  
		    //获取生成图片的名称  
		    fileName = ServletUtilities.saveChartAsJPEG(  
		            BarChartUtil.createChart(true,dataSet), 500,
		300, request.getSession());  

		}else{  
		    fileName = ServletUtilities.saveChartAsJPEG(  
		    		BarChartUtil.createChart(false,dataSet), 500, 
		300, request.getSession());  
		}  
		
		//将图片输出
		ServletUtilities.sendTempFile(fileName, response);
	}


	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doGet(request, response);
	}
	
	 public static Timestamp adjustDate(HttpServletRequest request,String strQueryDate){  
	     String strDate=request.getParameter(strQueryDate);   
	     Timestamp date=null;
	     if(strDate!=null&&!strDate.trim().equals("")){
	   
	        if(strDate.matches("^\\s*\\d{4}-\\d{2}-\\d{2}\\s*$")){
	           strDate=strDate.trim()+" 00:00:00";//注意：中间只有一个空格
	        }
	        if(strDate.matches("^\\s*\\d{4}-\\d{2}-\\d{2}\\s\\d{2}\\:\\d{2}\\s*$")){
	           strDate=strDate.trim()+":00";//注意：中间只有一个空格
	        }
	          
	         date=Timestamp.valueOf(strDate);
	    }
	     return date;
	  }

}
