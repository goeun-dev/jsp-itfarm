package com.itfarm.controller.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.itfarm.dao.ProductDAO;

public class CartDeleteOne implements Action {

	public CartDeleteOne() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id=request.getParameter("id");

		ProductDAO pDao = ProductDAO.getInstance();

		pDao.deleteOneCart(id);

		response.setCharacterEncoding("EUC-KR");
		PrintWriter writer = response.getWriter();
		writer.println("<script type='text/javascript'>");
		writer.println("alert('상품이 삭제되었습니다.');");
		writer.println("location.href='Product?command=cart_list';");
		writer.println("</script>");
		writer.flush();

	}

}
