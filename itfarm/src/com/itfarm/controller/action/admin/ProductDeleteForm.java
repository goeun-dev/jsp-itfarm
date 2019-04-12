package com.itfarm.controller.action.admin;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.itfarm.dao.ProductDAO;
import com.itfarm.dto.ProductVO;


public class ProductDeleteForm implements AdminAction {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String productNum = request.getParameter("productNum");
		System.out.println(productNum);
		ProductDAO pDao = ProductDAO.getInstance();
		ProductVO pVo = pDao.selectOneProductByNum(productNum);
		System.out.println(pVo);
		request.setAttribute("product", pVo);

		RequestDispatcher dispatcher = request
				.getRequestDispatcher("admin/product/productDelete.jsp");
		dispatcher.forward(request, response);

	}

}
