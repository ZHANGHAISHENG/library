package util;

import java.awt.Font;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.Timestamp;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import manager.BorrowBookManager;

import org.jfree.chart.ChartFactory;
import org.jfree.chart.ChartUtilities;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.axis.CategoryAxis;
import org.jfree.chart.axis.ValueAxis;
import org.jfree.chart.plot.CategoryPlot;
import org.jfree.chart.plot.PlotOrientation;
import org.jfree.data.category.CategoryDataset;
import org.jfree.data.category.DefaultCategoryDataset;


public class BarChartUtil {
	 //��״ͼ

	
    public static JFreeChart createChart(boolean is3D,CategoryDataset dataset){

    	   JFreeChart chart = null;  
    	   if(is3D){
    		    chart = ChartFactory.createBarChart3D(   
                       "ͼ�����ͳ��", // ����   
                       "ʱ��",       // Ŀ¼�ᣨˮƽ��   
                       "����ͼ������",       // ��ֵ�ᣨ��ֱ��   
                       dataset,    // ���ݼ�   
                       PlotOrientation.VERTICAL,   // ͼ����ˮƽ/��ֱ��   
                       true,       // �Ƿ���ʾͼ�������ڼ򵥵���״ͼ�Ǳ���ģ�   
                       false,      // �Ƿ����ɹ���   
                       false       // �Ƿ����� url ����   
               );   
               
    	   }else{
    		   chart = ChartFactory.createBarChart(   
                       "ͼ�����ͳ��", // ����   
                       "ʱ��",       // Ŀ¼�ᣨˮƽ��   
                       "����ͼ������",       // ��ֵ�ᣨ��ֱ��   
                       dataset,    // ���ݼ�   
                       PlotOrientation.VERTICAL,   // ͼ����ˮƽ/��ֱ��   
                       true,       // �Ƿ���ʾͼ�������ڼ򵥵���״ͼ�Ǳ���ģ�   
                       false,      // �Ƿ����ɹ���   
                       false       // �Ƿ����� url ����   
               );   
    	   }
          
           
           //---------------------------------------------�����޷���ʾ���⣺-----------------------------         
          
           //����
           chart.getTitle().setFont(new Font("����",Font.BOLD,20));//���ñ�������
           
            CategoryPlot plot=chart.getCategoryPlot();//��ȡͼ���������
            CategoryAxis domainAxis=plot.getDomainAxis();
            //ˮƽ�ײ��б�
            domainAxis.setLabelFont(new Font("����",Font.BOLD,14));
            //ˮƽ�ײ�����
            domainAxis.setTickLabelFont(new Font("����",Font.BOLD,12));
            //��ֱ����
            ValueAxis rangeAxis=plot.getRangeAxis();//��ȡ��״
            rangeAxis.setLabelFont(new Font("����",Font.BOLD,15));
            chart.getLegend().setItemFont(new Font("����", Font.BOLD, 15));

            return chart;
          

    }
    
   
    
    
   
}
