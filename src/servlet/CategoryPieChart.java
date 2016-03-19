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
		//��ȡDateSet
		 int  cateId=Integer.parseInt(request.getParameter("cateId"));
		 DefaultPieDataset dataSet=BorrowBookManager.getInstance().getCategoryPieDataset(cateId);
		 
		 //��ʾ��ʽ���Ƿ�Ϊ3DЧ����  
			String style = request.getParameter("style");  
			String fileName = null;     //����ͼƬ���ļ���  
			if(style != null && "3d".equals(style)){  
			    //��ȡ����ͼƬ������  
			    fileName = ServletUtilities.saveChartAsJPEG(  
			            PieChartUtil.createChart(true,dataSet), 500,300, request.getSession());  

			}else{  
			    fileName = ServletUtilities.saveChartAsJPEG(  
			    		PieChartUtil.createChart(false,dataSet), 500, 300, request.getSession());  
			}  
			
			//��ͼƬ���
			ServletUtilities.sendTempFile(fileName, response);
	}


	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doGet(request, response);
	}
}
