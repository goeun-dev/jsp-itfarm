package com.itfarm.controller.action.admin;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.itfarm.dao.ProductDAO;
import com.itfarm.dto.ProductVO;

public class ProductList implements AdminAction {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ProductDAO pDao = ProductDAO.getInstance();

		String category = "";
		int intOrder = 1;
		List<ProductVO> productList = pDao.selectAllProducts(category, intOrder);
		if (productList.isEmpty()) {
			request.setAttribute("emp", "상품이 없습니다.");
		}
		request.setAttribute("productList", productList);
		RequestDispatcher dispatcher = request.getRequestDispatcher("admin/product/productList.jsp");
		dispatcher.forward(request, response);
	}

}
