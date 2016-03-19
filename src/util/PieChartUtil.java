package util;

import java.awt.Font;
import java.text.DecimalFormat;
import java.text.NumberFormat;

import org.jfree.chart.ChartFactory;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.axis.CategoryAxis;
import org.jfree.chart.axis.ValueAxis;
import org.jfree.chart.labels.StandardPieSectionLabelGenerator;
import org.jfree.chart.plot.CategoryPlot;
import org.jfree.chart.plot.PiePlot;
import org.jfree.data.general.DefaultPieDataset;

public class PieChartUtil {
	 private static JFreeChart chart=null;
	 
	 public static JFreeChart createChart(boolean is3D,DefaultPieDataset dataSet) {  
		  if(is3D){ 
			   chart = ChartFactory.createPieChart3D(   
		                "ͼ�����ͳ��",    // ����   
		                dataSet,           // ����   
		                true,              
		                false,   
		                false  
		        );   
		  }else{
			   chart = ChartFactory.createPieChart(   
		                "ͼ�����ͳ��",    // ����   
		                dataSet,           // ����   
		                true,              
		                false,   
		                false  
		        );   
		  }
		  
		  //---------------------------------------------�����޷���ʾ���⣺-----------------------------         
          
		    chart.getTitle().setFont(new Font("����",Font.BOLD,20));//���ñ�������
	        PiePlot piePlot= (PiePlot) chart.getPlot();//��ȡͼ���������
	        piePlot.setLabelFont(new Font("����",Font.BOLD,10));
	        chart.getLegend().setItemFont(new Font("����",Font.BOLD,10));//���·�����
	        
	        String unitStyle = "{0}={1}��({2})";
	        //����ͼ����ʾ��ʽ
	        piePlot.setLabelGenerator(new StandardPieSectionLabelGenerator(
	                                        unitStyle,
	                                        NumberFormat.getNumberInstance(),
	                                        new DecimalFormat("0.00%"))
	                                    );
	        //�������ñ�ǩ��ʾ��ʽ
	        piePlot.setLegendLabelGenerator(new StandardPieSectionLabelGenerator(
	                   unitStyle,
	                   NumberFormat.getNumberInstance(),
	                   new DecimalFormat("0.00%")));
           
           return chart;
	  }
	
}
	 

