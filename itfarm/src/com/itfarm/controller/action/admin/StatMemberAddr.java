package com.itfarm.controller.action.admin;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.itfarm.dao.MemberDAO;

public class StatMemberAddr implements AdminAction {

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
		Map<String, Object> annualRevenue = mDao.getAddrCount(yyyy);

		request.setAttribute("annualRevenue", annualRevenue);
		request.setAttribute("yyyy", yyyy);

		RequestDispatcher dispatcher = request.getRequestDispatcher("admin/stats/memberAddr.jsp");
		dispatcher.forward(request, response);
	}

}
