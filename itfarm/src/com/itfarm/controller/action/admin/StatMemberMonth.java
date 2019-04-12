package com.itfarm.controller.action.admin;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.itfarm.dao.MemberDAO;
import com.itfarm.dao.ProductDAO;
import com.itfarm.dto.SaleVO;

public class StatMemberMonth implements AdminAction {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		Date today = new Date();
		SimpleDateFormat format2 = new SimpleDateFormat("yyyy-MM");
		SimpleDateFormat format = new SimpleDateFormat("yyyy");
		
		String yyyy = request.getParameter("yyyy");
		if (yyyy == null) {
			yyyy = format.format(today);
		}
		String yyyyMM = format2.format(today);
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.MONTH, -1); // 한달을 더한다.
		String yyyyMM2 = format2.format(cal.getTime());
		
		MemberDAO mDao = MemberDAO.getInstance();
		Map<String, Object> annualRevenue = mDao.getAnnualCount(yyyy, 1);
		Map<String, Object> annualRefundRevenue = mDao.getAnnualCount(yyyy, 2);
		
		ProductDAO pDao = ProductDAO.getInstance();
		List<SaleVO> sVo = pDao.getAnnualRevenueTable(yyyy);
		List<SaleVO> rateChange = pDao.getRateChange(yyyyMM, yyyyMM2);

		request.setAttribute("annualRevenue", annualRevenue);
		request.setAttribute("annualRefundRevenue", annualRefundRevenue);
		request.setAttribute("yyyy", yyyy);
		request.setAttribute("sVo", sVo);
		request.setAttribute("rc", rateChange);

		RequestDispatcher dispatcher = request.getRequestDispatcher("admin/stats/memberMonth.jsp");
		dispatcher.forward(request, response);
	}

}
