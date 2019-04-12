package com.itfarm.controller.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.itfarm.dao.ProductDAO;
import com.itfarm.dto.MemberVO;
import com.itfarm.dto.SaleVO;

public class OrderList implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String url = "mypage/mypage.jsp";
		ProductDAO pDao = ProductDAO.getInstance();
		HttpSession session = request.getSession();
		MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");
		String userid = loginUser.getUserid();
		String saleid = "";
		String status = request.getParameter("status");
		int sts = Integer.parseInt(status);
		System.out.println(status);
		List<SaleVO> orderList = pDao.selectAllOrders(userid, saleid, sts);
		request.setAttribute("orderList", orderList);
		if (sts == 1) {
			url = "product/orderList.jsp";
		} else if (sts == 2) {
			url = "product/refundList.jsp";
		}
		if (orderList.isEmpty()) {
			request.setAttribute("emp", "주문 내역이 없습니다.");
		}

		System.out.println(url);
		RequestDispatcher dispatcher = request.getRequestDispatcher(url);
		dispatcher.forward(request, response);
	}

}
