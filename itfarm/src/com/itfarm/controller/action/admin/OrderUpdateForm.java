package com.itfarm.controller.action.admin;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.itfarm.dao.ProductDAO;
import com.itfarm.dto.SaleVO;

public class OrderUpdateForm implements AdminAction {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String saleid = request.getParameter("saleid");
		ProductDAO pDao = ProductDAO.getInstance();
		List<SaleVO> sVo = pDao.selectOrderDetailByNum(saleid);
		request.setAttribute("sale", sVo);
		RequestDispatcher dispatcher = request
				.getRequestDispatcher("admin/product/orderUpdate.jsp");
		dispatcher.forward(request, response);
	}

}
