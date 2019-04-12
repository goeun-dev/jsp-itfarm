package com.itfarm.controller.action.admin;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.itfarm.dao.ProductDAO;
import com.itfarm.dto.SaleVO;

public class OrderTotal implements AdminAction {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		ProductDAO pDao = ProductDAO.getInstance();
		List<SaleVO> sVo = pDao.orderTotal();
		List<SaleVO> pVo = pDao.orderPrice(1);
		List<SaleVO> cVo = pDao.orderPrice(2);
		List<SaleVO> rVo = pDao.productRanking();
		request.setAttribute("sVo", sVo);
		request.setAttribute("pVo", pVo);
		request.setAttribute("cVo", cVo);
		request.setAttribute("rVo", rVo);
		RequestDispatcher dispatcher = request.getRequestDispatcher("admin/product/orderTotal.jsp");
		dispatcher.forward(request, response);
	}

}
