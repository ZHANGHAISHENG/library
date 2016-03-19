package util;

import java.awt.BasicStroke;
import java.awt.Color;
import java.awt.Font;
import java.sql.Timestamp;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import manager.BorrowBookManager;

import org.jfree.chart.ChartFactory;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.plot.CategoryPlot;
import org.jfree.chart.plot.PlotOrientation;
import org.jfree.chart.renderer.category.LineAndShapeRenderer;
import org.jfree.data.category.CategoryDataset;
import org.jfree.data.category.DefaultCategoryDataset;

public class LineChartUtil {
	//����  
    private static final Font PLOT_FONT = new Font("����", Font.BOLD, 15);  


    /**  
     * ������ͼ����  
     * @param is3D �Ƿ�Ϊ3DЧ��  
     * @return JFreeChart����  
     */ 
    public static JFreeChart createChart(boolean is3D,CategoryDataset dataSet) {  
        JFreeChart chart = null;  
        if(is3D){  
            chart = ChartFactory.createLineChart3D(  
                    "ͼ�����ͳ��",   //ͼ�����  
                    "ʱ��",                        //X�����  
                    "����ͼ������",                   //Y�����  
                    dataSet,             //��ͼ���ݼ�  
                    PlotOrientation.VERTICAL,     //���Ʒ���  
                    true,                          //��ʾͼ��  
                    true,                          //���ñ�׼������  
                    false                          //�Ƿ����ɳ�����  
                    );  
        }else{  
            chart = ChartFactory.createLineChart("ͼ�����ͳ��", //ͼ�����  
								                    "ʱ��",                  //X�����  
								                    "����ͼ������",            //Y�����  
								                    dataSet,                 //��ͼ���ݼ�  
								                    PlotOrientation.VERTICAL,    //���Ʒ���  
								                    true,                        //�Ƿ���ʾͼ��  
								                    true,                        //�Ƿ���ñ�׼������  
								                    false                    //�Ƿ����ɳ�����  
								                    );  
        }  
          
        //���ñ�������  
        chart.getTitle().setFont(new Font("����", Font.BOLD, 23));  
        //����ͼ���������  
        chart.getLegend().setItemFont(new Font("����", Font.BOLD, 15));  
        chart.setBackgroundPaint(new Color(192,228,106));   //���ñ���ɫ  
        //��ȡ��ͼ������  
        CategoryPlot plot = chart.getCategoryPlot();  
        plot.getDomainAxis().setLabelFont(PLOT_FONT);     //���ú�������  
        plot.getDomainAxis().setTickLabelFont(PLOT_FONT);//������������ֵ����  
        plot.getRangeAxis().setLabelFont(PLOT_FONT);    //������������  
        plot.setBackgroundPaint(Color.WHITE);         //���û�ͼ������ɫ  
        plot.setRangeGridlinePaint(Color.RED);       //����ˮƽ���򱳾�����ɫ  
        plot.setRangeGridlinesVisible(true);       //�����Ƿ���ʾˮƽ���򱳾���,Ĭ��ֵΪtrue  
        plot.setDomainGridlinePaint(Color.RED);     //���ô�ֱ���򱳾�����ɫ  
        plot.setDomainGridlinesVisible(true);    //�����Ƿ���ʾ��ֱ���򱳾���,Ĭ��ֵΪfalse  
        
        //��ȡ���߶���  
        LineAndShapeRenderer renderer = (LineAndShapeRenderer) plot.getRenderer();  
        BasicStroke realLine = new BasicStroke(1.6f);       //����ʵ��  
        float dashes[] = { 8.0f };                      //������������  
        BasicStroke brokenLine = new BasicStroke(1.6f,      //������ϸ  
								                BasicStroke.CAP_SQUARE,             //�˵���  
								                BasicStroke.JOIN_MITER,                 //�۵���  
								                8.f,                                //�۵㴦��취  
								                dashes,                         //��������  
								                0.0f);                          //����ƫ����  
        renderer.setSeriesStroke(1, brokenLine);     //�������߻���  
        renderer.setSeriesStroke(2, brokenLine);   //�������߻���  
        renderer.setSeriesStroke(3, realLine);    //����ʵ�߻���  
        return chart;  
    }  

}   
