package filter;

import java.io.IOException;


import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import bean.Administrator;



public class AdminURLFilter implements Filter {
  
	private HttpServletRequest request2;
	private HttpServletResponse response2;
   

	public void init(FilterConfig filterConfig) throws ServletException {
		// TODO Auto-generated method stub
	}


	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		// TODO Auto-generated method stub
		request2=(HttpServletRequest)request;
		response2=(HttpServletResponse) response;
		HttpSession session=request2.getSession();
		Administrator admin=(Administrator) session.getAttribute("admin");

		if(admin!=null){
			chain.doFilter(request, response);
		}else{
			
			response2.sendRedirect("/library2.0/indexLogin.jsp"); 
		}
		
	
	}


	public void destroy() {
		// TODO Auto-generated method stub
		
	}
	
	


}
