package com.itfarm.controller.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.itfarm.dao.ProductDAO;
import com.itfarm.dto.SaleVO;

public class ProductReturnForm implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("id");
		
		request.setAttribute("id", id);
		ProductDAO pDao = ProductDAO.getInstance();
		List<SaleVO> orderList = pDao.selectOrderDetailByNum(id);

		request.setAttribute("orderList", orderList);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("product/return.jsp");
		dispatcher.forward(request, response);
	}

}
