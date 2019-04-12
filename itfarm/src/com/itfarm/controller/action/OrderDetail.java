package com.itfarm.controller.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.itfarm.dao.ProductDAO;
import com.itfarm.dto.SaleVO;

public class OrderDetail implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String saleid = request.getParameter("saleid");
		ProductDAO pDao = ProductDAO.getInstance();
		List<SaleVO> orderList = pDao.selectOrderDetailByNum(saleid);
		
		request.setAttribute("orderList", orderList);
		RequestDispatcher dispatcher = request.getRequestDispatcher("product/orderDetail.jsp");
		dispatcher.forward(request, response);

	}

}
