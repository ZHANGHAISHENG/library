package util;

import java.awt.Color;  
import java.awt.Font;  
import java.awt.Graphics;  
import java.awt.image.BufferedImage;  
import java.util.Random;  
  
import javax.imageio.ImageIO;  
import javax.servlet.http.HttpServletRequest;  
import javax.servlet.http.HttpServletResponse;  
/** 
 * <b>function:</b> ��֤�����ɹ����� 
 * @project NetWorkService 
 * @package com.hoo.util  
 * @fileName ValidCodeUtils.java 
 * @createDate 2010-8-3 ����03:05:50 
 * @author hoojo 
 */  
@SuppressWarnings("unused")  
public class ValidCodeUtils {  
    /********************************************************************* 
     * ��֤���� 
     */  
    public static int WIDTH = 60;  
    /*** 
     * ��֤��߶� 
     */  
    public static int HEIGHT = 20;  
      
    /********************************************************************** 
     * ��֤�뱳����ɫCOLOR_FC_BG Ӧ��С��COLOR_BC_BG 
     */  
    public static int COLOR_FC_BG = 200;  
    /*** 
     * ��֤�뱳����ɫCOLOR_FC_BG Ӧ��С��COLOR_BC_BG 
     */  
    public static int COLOR_BC_BG = 250;  
      
    /********************************************************************** 
     * ��֤�뱳����������ɫCOLOR_FC_LINE Ӧ��С��COLOR_BC_LINE 
     */  
    public static int COLOR_FC_LINE = 160;  
    /*** 
     * ��֤�뱳����������ɫCOLOR_FC_LINE Ӧ��С��COLOR_BC_LINE 
     */  
    public static int COLOR_BC_LINE = 200;  
      
    /*************************************************************************** 
     * ��֤����ɫCOLOR_FC_CODE Ӧ��С��COLOR_BC_CODE 
     */  
    public static int COLOR_FC_CODE = 20;  
    /*** 
     * ��֤����ɫCOLOR_FC_CODE Ӧ��С��COLOR_BC_CODE 
     */  
    public static int COLOR_BC_CODE = 170;  
      
    /*************************************************************************** 
     * ������ָ����Χ�ڵ���ɫ 
     * @param fc ��Χfc colorֵ С��255 
     * @param bc ��Χbc colorֵ С��255 
     * @return Color 
     */  
    private static Color getRandColor(int fc, int bc) {  
        Random random = new Random();  
        if (fc < 0)  
            fc = 0;  
        if (bc < 0)  
            bc = 1;  
        if (fc > 255)  
            fc = 255;  
        if (bc > 255)  
            bc = 255;  
        if (bc == fc)   
            bc += 10;  
        int temp = 0;  
        if (bc < fc) {  
            temp = bc;  
            bc = fc;  
            fc = temp;  
        }  
        int r = fc + random.nextInt(bc - fc);  
        int g = fc + random.nextInt(bc - fc);  
        int b = fc + random.nextInt(bc - fc);  
        return new Color(r, g, b);  
    }  
  
    /** 
     * <b>function:</b> ����ͼƬ���� 
     * @createDate 2010-8-3 ����03:06:22 
     * @author hoojo 
     * @param request HttpServletRequest 
     * @param response HttpServletResponse 
     * @return boolean 
     * @throws Exception 
     */  
    public static boolean getImage(HttpServletRequest request, HttpServletResponse response) throws Exception{  
        response.reset();  
        response.setContentType("image/jpeg");  
        // ����ҳ�治����  
        response.setHeader("Pragma", "No-cache");  
        response.setHeader("Cache-Control", "no-cache");  
        response.setDateHeader("Expires", 0);  
        // ���ڴ��д���ͼ��       
        BufferedImage image = new BufferedImage(WIDTH, HEIGHT, BufferedImage.TYPE_INT_RGB);  
  
        // ��ȡͼ��������  
        Graphics img = image.getGraphics();  
        // ���������  
        Random random = new Random();  
  
        // �趨����ɫ  
        img.setColor(getRandColor(COLOR_FC_BG, COLOR_BC_BG));  
        img.fillRect(0, 0, WIDTH, HEIGHT);  
  
        // �趨����  
        img.setFont(new Font("Times New Roman", Font.PLAIN, 18));  
  
        // ���߿�  
        // g.setColor(new Color());  
        // g.drawRect(0,0,width-1,height-1);  
  
        // �������155�������ߣ�ʹͼ���е���֤�벻�ױ���������̽�⵽  
        img.setColor(getRandColor(COLOR_FC_LINE, COLOR_BC_LINE));  
        for (int i = 0; i < 155; i++) {  
            int x = random.nextInt(WIDTH);  
            int y = random.nextInt(HEIGHT);  
            int xl = random.nextInt(12);  
            int yl = random.nextInt(12);  
            img.drawLine(x, y, x + xl, y + yl);  
        }  
  
        // ȡ�����������֤��(4λ����)  
        String codeValue = "";  
        for (int i = 0; i < 4; i++) {  
            //String rand = String.valueOf(random.nextInt(10));  
            String rand = getRandomChar();  
            codeValue = codeValue.concat(rand);  
            img.setFont(getRandomFont());//�������  
            // ����֤����ʾ��ͼ����  
            img.setColor(getRandColor(COLOR_FC_CODE, COLOR_BC_CODE));  
           // img.drawString(rand, 13 * i + 6, 16);  
            img.drawString(rand, 13 * i, 16);
        }  
        request.getSession().setAttribute("codeValue", codeValue);  
        // ͼ����Ч  
        img.dispose();  
        // ���ͼ��ҳ��  
        return ImageIO.write(image, "JPEG", response.getOutputStream());  
    }  
      
    /** 
     * ��������ַ�������д��Сд������ 
     * <b>function:</b> ���� 
     * @createDate 2010-8-23 ����10:33:55 
     * @author hoojo 
     * @return 
     */  
    public static String getRandomChar() {  
        int index = (int) Math.round(Math.random() * 2);  
        String randChar = "";  
        switch (index) {  
        case 0://��д�ַ�  
            randChar = String.valueOf((char)Math.round(Math.random() * 25 + 65));  
            break;  
        case 1://Сд�ַ�  
            randChar = String.valueOf((char)Math.round(Math.random() * 25 + 97));  
            break;  
        default://����  
            randChar = String.valueOf(Math.round(Math.random() * 9));  
            break;  
        }  
        return randChar;  
    }  
      
    /** 
     * <b>function:</b> ����������塢���ִ�С 
     * @createDate 2010-8-23 ����10:44:22 
     * @author hoojo 
     * @return 
     */  
    public static Font getRandomFont() {  
        String[] fonts = {"Georgia", "Verdana", "Arial", "Tahoma", "Time News Roman", "Courier New", "Arial Black", "Quantzite"};  
        int fontIndex = (int)Math.round(Math.random() * (fonts.length - 1));  
        int fontSize = (int) Math.round(Math.random() * 4 + 16);  
        return new Font(fonts[fontIndex], Font.PLAIN, fontSize);  
    }  
}  
