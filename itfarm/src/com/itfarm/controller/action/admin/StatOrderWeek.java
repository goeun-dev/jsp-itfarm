package com.itfarm.controller.action.admin;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.itfarm.dao.ProductDAO;
import com.itfarm.dto.SaleVO;

public class StatOrderWeek implements AdminAction {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String week = request.getParameter("week");

		ProductDAO pDao = ProductDAO.getInstance();
		Map<String, Object> weekRevenue = pDao.getWeakRevenue(week, 1);
		Map<String, Object> weekRefundRevenue = pDao.getWeakRevenue(week, 2);
		List<SaleVO> sVo = pDao.getWeekRevenueTable("2018");
		List<SaleVO> rateChange = pDao.getWeekRateChange();

		request.setAttribute("weekRevenue", weekRevenue);
		request.setAttribute("weekRefundRevenue", weekRefundRevenue);
		request.setAttribute("week", week);
		request.setAttribute("sVo", sVo);
		request.setAttribute("rc", rateChange);

		RequestDispatcher dispatcher = request.getRequestDispatcher("admin/stats/orderWeek.jsp");
		dispatcher.forward(request, response);
	}

}
