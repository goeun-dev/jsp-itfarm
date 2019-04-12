package com.itfarm.controller.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.itfarm.dao.ProductDAO;
import com.itfarm.dto.MemberVO;

public class CartDelete implements Action {

	public CartDelete() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");
		String mid = loginUser.getUserid();

		ProductDAO pDao = ProductDAO.getInstance();

		pDao.deleteAllCart(mid);

		response.setCharacterEncoding("EUC-KR");
		PrintWriter writer = response.getWriter();
		writer.println("<script type='text/javascript'>");
		writer.println("alert('장바구니에서 상품이 삭제되었습니다.');");
		writer.println("location.href='Product?command=cart_list';");
		writer.println("</script>");
		writer.flush();

	}

}
