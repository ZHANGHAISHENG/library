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

public class CategoryBarChart extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		        //��ȡDataSet
		         int  cateId=Integer.parseInt(request.getParameter("cateId"));

		         CategoryDataset dataSet=BorrowBookManager.getInstance().getCategoryDateset(cateId);
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
	

}
