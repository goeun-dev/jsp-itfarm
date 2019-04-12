package com.itfarm.controller.action;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.itfarm.dao.ProductDAO;

public class DeliveryNo implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String saleid = request.getParameter("saleid");
		ProductDAO pDao = ProductDAO.getInstance();
		
		String dno = pDao.deliveryNo(saleid);

		request.setAttribute("dno", dno);
		RequestDispatcher dispatcher = request
				.getRequestDispatcher("product/delivery.jsp");
		dispatcher.forward(request, response);

	}

}
