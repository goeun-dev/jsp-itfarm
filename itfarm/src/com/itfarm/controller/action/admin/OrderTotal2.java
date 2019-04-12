package com.itfarm.controller.action.admin;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.itfarm.dao.ProductDAO;
import com.itfarm.dto.SaleVO;

public class OrderTotal2 implements AdminAction {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		ProductDAO pDao = ProductDAO.getInstance();
		List<SaleVO> rVo = pDao.getproductCountRank(1);
		List<SaleVO> productCountRank1 = pDao.getproductCountRank(1);
		List<SaleVO> productCountRank2 = pDao.getproductCountRank(2);
		List<SaleVO> categoryRank = pDao.categoryRank(1);

		request.setAttribute("rVo", rVo); 
		
		request.setAttribute("productCountRank1", productCountRank1);
		request.setAttribute("productCountRank2", productCountRank2);
		request.setAttribute("categoryRank", categoryRank);
		RequestDispatcher dispatcher = request.getRequestDispatcher("admin/stats/orderTotal2.jsp");
		dispatcher.forward(request, response);
	}

}
