package com.itfarm.controller.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.itfarm.dao.ProductDAO;
import com.itfarm.dto.CartVO;
import com.itfarm.dto.MemberVO;

public class CartList implements Action {

	public CartList() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ProductDAO pDao = ProductDAO.getInstance();

		HttpSession session = request.getSession();
		MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");
		String mid = loginUser.getUserid();
		String[] cid = null;

		List<CartVO> cartList = pDao.selectAllCarts(mid, cid);

		if (cartList.isEmpty()) {
			request.setAttribute("cartEmpty", "장바구니에 저장된 상품이 없습니다.");
		}
		
		request.setAttribute("cartList", cartList);

		RequestDispatcher dispatcher = request.getRequestDispatcher("product/productCart.jsp");
		dispatcher.forward(request, response);
	}
}
