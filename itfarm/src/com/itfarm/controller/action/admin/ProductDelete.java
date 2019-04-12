package com.itfarm.controller.action.admin;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.itfarm.dao.ProductDAO;


public class ProductDelete implements AdminAction {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int productNum = Integer.parseInt(request.getParameter("productNum"));
		System.out.println(productNum);
		ProductDAO pDao = ProductDAO.getInstance();
		pDao.deleteProduct(productNum);
		
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
