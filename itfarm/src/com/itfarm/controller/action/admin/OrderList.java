package com.itfarm.controller.action.admin;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.itfarm.dao.ProductDAO;
import com.itfarm.dto.SaleVO;

public class OrderList implements AdminAction {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ProductDAO pDao = ProductDAO.getInstance();
		String startDate = request.getParameter("startDate");
		String endDate = request.getParameter("endDate");
		String userid = request.getParameter("searchName");
		String payment = "";
		String[] statusAy = request.getParameterValues("status1");
		String[] payAy = request.getParameterValues("pay");
		String status = "";
		if (statusAy != null) {
			for (String val : statusAy) {
				status += "" + val + ", ";
			}
		}
		if (payAy != null) {
			for (String p : payAy) {
				payment += "" + p + ", ";
			}
		}
		if (startDate != null) {
			
		}
		List<SaleVO> sList = pDao.adminSelectAllOrders(userid, payment, status, startDate, endDate);
		if (sList.isEmpty()) {
			request.setAttribute("emp", "주문 내역이 없습니다.");
		}
		request.setAttribute("startDate", startDate);
		request.setAttribute("endDate", endDate);
		request.setAttribute("searchName", userid);
		request.setAttribute("sList", sList);
		request.setAttribute("statusAy", statusAy);
		request.setAttribute("payAy", payAy);

		RequestDispatcher dispatcher = request.getRequestDispatcher("admin/product/orderList.jsp");
		dispatcher.forward(request, response);
	}

}
