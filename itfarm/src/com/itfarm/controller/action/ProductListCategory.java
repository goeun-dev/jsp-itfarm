package com.itfarm.controller.action;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class ProductListCategory implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//ProductDAO pDao = ProductDAO.getInstance();

		/*List<ProductVO> productList = pDao.selectAllProducts();*/

		//request.setAttribute("productList", productList);

		RequestDispatcher dispatcher = request.getRequestDispatcher("product/productList.jsp");
		dispatcher.forward(request, response);

	}

}
