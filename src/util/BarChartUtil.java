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
	 //柱状图

	
    public static JFreeChart createChart(boolean is3D,CategoryDataset dataset){

    	   JFreeChart chart = null;  
    	   if(is3D){
    		    chart = ChartFactory.createBarChart3D(   
                       "图书借阅统计", // 标题   
                       "时间",       // 目录轴（水平）   
                       "借阅图书数量",       // 数值轴（垂直）   
                       dataset,    // 数据集   
                       PlotOrientation.VERTICAL,   // 图表方向（水平/垂直）   
                       true,       // 是否显示图例（对于简单的柱状图是必须的）   
                       false,      // 是否生成工具   
                       false       // 是否生成 url 链接   
               );   
               
    	   }else{
    		   chart = ChartFactory.createBarChart(   
                       "图书借阅统计", // 标题   
                       "时间",       // 目录轴（水平）   
                       "借阅图书数量",       // 数值轴（垂直）   
                       dataset,    // 数据集   
                       PlotOrientation.VERTICAL,   // 图表方向（水平/垂直）   
                       true,       // 是否显示图例（对于简单的柱状图是必须的）   
                       false,      // 是否生成工具   
                       false       // 是否生成 url 链接   
               );   
    	   }
          
           
           //---------------------------------------------中文无法显示问题：-----------------------------         
          
           //标题
           chart.getTitle().setFont(new Font("黑体",Font.BOLD,20));//设置标题字体
           
            CategoryPlot plot=chart.getCategoryPlot();//获取图表区域对象
            CategoryAxis domainAxis=plot.getDomainAxis();
            //水平底部列表
            domainAxis.setLabelFont(new Font("黑体",Font.BOLD,14));
            //水平底部标题
            domainAxis.setTickLabelFont(new Font("宋体",Font.BOLD,12));
            //垂直标题
            ValueAxis rangeAxis=plot.getRangeAxis();//获取柱状
            rangeAxis.setLabelFont(new Font("黑体",Font.BOLD,15));
            chart.getLegend().setItemFont(new Font("黑体", Font.BOLD, 15));

            return chart;
          

    }
    
   
    
    
   
}
