package com.itfarm.controller.action.admin;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.itfarm.dao.ProductDAO;
import com.itfarm.dto.ProductVO;


public class OrderSearch implements AdminAction {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String url = "admin/product/productList.jsp";
		String name = request.getParameter("searchName");
		String category = request.getParameter("searchCategory");
		ProductDAO pDao = ProductDAO.getInstance();
		List<ProductVO> productList = pDao.searchProduct(name, category);
		request.setAttribute("productList", productList);
		request.setAttribute("searchName", name);
		request.setAttribute("searchCategory", category);
		RequestDispatcher dispatcher = request.getRequestDispatcher(url);
		dispatcher.forward(request, response);
	}

}
