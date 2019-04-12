package com.itfarm.controller.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.itfarm.dao.ProductDAO;
import com.itfarm.dto.ProductVO;


public class ProductList implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ProductDAO pDao = ProductDAO.getInstance();
		String category = request.getParameter("category");
		String order = request.getParameter("order");
		int intOrder = Integer.parseInt(order);
		List<ProductVO> productList = pDao.selectAllProducts(category, intOrder);
		List<ProductVO> rankList = pDao.selectAllProducts(category, 4);
		
		request.setAttribute("rankList", rankList);
		request.setAttribute("productList", productList);
		request.setAttribute("category", category);
		request.setAttribute("order", order);
		RequestDispatcher dispatcher = request.getRequestDispatcher("product/productList.jsp");
		dispatcher.forward(request, response);

	}

}
