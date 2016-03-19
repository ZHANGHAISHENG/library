package servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import util.ValidCodeUtils;

public class ValidCodeServlet extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public ValidCodeServlet() {
		super();
	}

	public void doGet(HttpServletRequest request, HttpServletResponse response)  
            throws ServletException, IOException {  
        try {  
        	
            ValidCodeUtils.getImage(request, response);  

        } catch (Exception e) {  
            e.printStackTrace();  
        }  
    }  
  
    public void doPost(HttpServletRequest request, HttpServletResponse response)  
            throws ServletException, IOException {  
        doGet(request, response);  
    }  

}
