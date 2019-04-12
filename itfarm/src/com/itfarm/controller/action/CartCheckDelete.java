package com.itfarm.controller.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.itfarm.dao.ProductDAO;

public class CartCheckDelete implements Action {

	public CartCheckDelete() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String[] checks = request.getParameterValues("checkOne");
		System.out.println(checks);
		ProductDAO pDao = ProductDAO.getInstance();

		int checklen = checks.length;

		try {
			for (int i = 0; i < checklen; i++) {
				String chks = checks[i];
				String cid = chks.split(",")[0];
				System.out.println(checks[i]);
				// pDao.deleteOneCart(checks[i]);
				pDao.deleteOneCart(cid);
			}
		} catch (Exception ex) {
			System.out.println("exception occured");
		}

		response.setCharacterEncoding("EUC-KR");
		PrintWriter writer = response.getWriter();
		writer.println("<script type='text/javascript'>");
		writer.println("alert('상품이 삭제되었습니다.');");
		writer.println("location.href='Product?command=cart_list';");
		writer.println("</script>");
		writer.flush();

	}

}
