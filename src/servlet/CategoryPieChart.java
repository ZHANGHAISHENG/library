package servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import manager.BorrowBookManager;

import org.jfree.chart.servlet.ServletUtilities;
import org.jfree.data.general.DefaultPieDataset;

import util.BarChartUtil;
import util.PieChartUtil;

import bean.BorrowBook;

public class CategoryPieChart extends HttpServlet {
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//获取DateSet
		 int  cateId=Integer.parseInt(request.getParameter("cateId"));
		 DefaultPieDataset dataSet=BorrowBookManager.getInstance().getCategoryPieDataset(cateId);
		 
		 //显示样式（是否为3D效果）  
			String style = request.getParameter("style");  
			String fileName = null;     //生成图片的文件名  
			if(style != null && "3d".equals(style)){  
			    //获取生成图片的名称  
			    fileName = ServletUtilities.saveChartAsJPEG(  
			            PieChartUtil.createChart(true,dataSet), 500,300, request.getSession());  

			}else{  
			    fileName = ServletUtilities.saveChartAsJPEG(  
			    		PieChartUtil.createChart(false,dataSet), 500, 300, request.getSession());  
			}  
			
			//将图片输出
			ServletUtilities.sendTempFile(fileName, response);
	}


	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doGet(request, response);
	}
}
