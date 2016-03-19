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
		//��ȡDateset
		   Timestamp startODate=adjustDate(request,"startODate");
		   Timestamp endODate=adjustDate(request,"endODate");
		   CategoryDataset dataSet=BorrowBookManager.getInstance().getTimeCategoryDateset(startODate, endODate);
		
		//��ʾ��ʽ���Ƿ�Ϊ3DЧ����  
		String style = request.getParameter("style");  
		String fileName = null;     //����ͼƬ���ļ���  
		if(style != null && "3d".equals(style)){  
		    //��ȡ����ͼƬ������  
		    fileName = ServletUtilities.saveChartAsJPEG(  
		            BarChartUtil.createChart(true,dataSet), 500,
		300, request.getSession());  

		}else{  
		    fileName = ServletUtilities.saveChartAsJPEG(  
		    		BarChartUtil.createChart(false,dataSet), 500, 
		300, request.getSession());  
		}  
		
		//��ͼƬ���
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
	           strDate=strDate.trim()+" 00:00:00";//ע�⣺�м�ֻ��һ���ո�
	        }
	        if(strDate.matches("^\\s*\\d{4}-\\d{2}-\\d{2}\\s\\d{2}\\:\\d{2}\\s*$")){
	           strDate=strDate.trim()+":00";//ע�⣺�м�ֻ��һ���ո�
	        }
	          
	         date=Timestamp.valueOf(strDate);
	    }
	     return date;
	  }

}
