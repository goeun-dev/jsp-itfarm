package com.itfarm.controller.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.itfarm.dao.ProductDAO;

public class CartUpdate implements Action{

	public CartUpdate() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("id");
		int num = Integer.parseInt(request.getParameter("num"));
		System.out.println(num);
		ProductDAO pDao = ProductDAO.getInstance();
		pDao.updateCart(id, num);
		
		int count = Integer.parseInt(request.getParameter("count"));
		
		if (count < num) {
			response.setCharacterEncoding("EUC-KR");
			PrintWriter writer = response.getWriter();
			writer.println("<script type='text/javascript'>");
			writer.println("alert('현재 수량이 부족하여 구매하실 수 없습니다. 재고 수량: "+count+"개');");
			writer.println("history.back();");
			writer.println("</script>");
			writer.flush();

			return;
		}
		response.setCharacterEncoding("EUC-KR");
		PrintWriter writer = response.getWriter();
		writer.println("<script type='text/javascript'>");
		writer.println("alert('변경되었습니다.');");
		writer.println("opener.parent.location.reload();");
		writer.println("self.close();");
		writer.println("</script>");
		writer.flush();
		
	}

}
