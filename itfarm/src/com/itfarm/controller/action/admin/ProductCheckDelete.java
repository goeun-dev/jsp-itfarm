package com.itfarm.controller.action.admin;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.itfarm.dao.ProductDAO;


public class ProductCheckDelete implements AdminAction {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String[] checks = request.getParameterValues("checkOne");
		System.out.println(checks);
		ProductDAO pDao = ProductDAO.getInstance();
		
		int checklen = checks.length;
		  
		  try {
		   for(int i=0; i<checklen; i++) {
		    System.out.println(checks[i]+";");
		    pDao.deleteProduct(Integer.parseInt(checks[i]));
		   }
		  }
		  catch(Exception ex) {
		   System.out.println("exception occured");
		  }
		
		response.setCharacterEncoding("EUC-KR");
		PrintWriter writer = response.getWriter();
		writer.println("<script type='text/javascript'>");
		writer.println("alert('삭제되었습니다.');");
		writer.println("location.href='Admin?command=product_list';");
		writer.println("</script>");
		writer.flush();
		return;

	}

}
