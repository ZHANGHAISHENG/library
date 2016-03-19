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
		                "图书借阅统计",    // 标题   
		                dataSet,           // 数据   
		                true,              
		                false,   
		                false  
		        );   
		  }else{
			   chart = ChartFactory.createPieChart(   
		                "图书借阅统计",    // 标题   
		                dataSet,           // 数据   
		                true,              
		                false,   
		                false  
		        );   
		  }
		  
		  //---------------------------------------------中文无法显示问题：-----------------------------         
          
		    chart.getTitle().setFont(new Font("黑体",Font.BOLD,20));//设置标题字体
	        PiePlot piePlot= (PiePlot) chart.getPlot();//获取图表区域对象
	        piePlot.setLabelFont(new Font("黑体",Font.BOLD,10));
	        chart.getLegend().setItemFont(new Font("黑体",Font.BOLD,10));//最下方文字
	        
	        String unitStyle = "{0}={1}本({2})";
	        //设置图例显示样式
	        piePlot.setLabelGenerator(new StandardPieSectionLabelGenerator(
	                                        unitStyle,
	                                        NumberFormat.getNumberInstance(),
	                                        new DecimalFormat("0.00%"))
	                                    );
	        //设置引用标签显示样式
	        piePlot.setLegendLabelGenerator(new StandardPieSectionLabelGenerator(
	                   unitStyle,
	                   NumberFormat.getNumberInstance(),
	                   new DecimalFormat("0.00%")));
           
           return chart;
	  }
	
}
	 

