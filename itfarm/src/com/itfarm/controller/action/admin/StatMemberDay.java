package com.itfarm.controller.action.admin;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.itfarm.dao.MemberDAO;

public class StatMemberDay implements AdminAction {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");

		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		Calendar c1 = Calendar.getInstance();
		String strToday = sdf.format(c1.getTime());
		Calendar week = Calendar.getInstance();
		week.add(Calendar.MONTH, -1);
		String lastWeek = sdf.format(week.getTime());

		String startDate = request.getParameter("startDate");
		String endDate = request.getParameter("endDate");

		if (startDate == null) {
			startDate = lastWeek;
		} else {
			String startDate1 = startDate.split("-")[0];
			String startDate2 = startDate.split("-")[1];
			String startDate3 = startDate.split("-")[2];
			Calendar st = Calendar.getInstance();
			st.set(Integer.parseInt(startDate1), Integer.parseInt(startDate2)-1, Integer.parseInt(startDate3));
			startDate = sdf.format(st.getTime());
		}

		if (endDate == null) {
			endDate = strToday;
		} else {
			String endDate1 = endDate.split("-")[0];
			String endDate2 = endDate.split("-")[1];
			String endDate3 = endDate.split("-")[2];
			Calendar ed = Calendar.getInstance();
			ed.set(Integer.parseInt(endDate1), Integer.parseInt(endDate2)-1, Integer.parseInt(endDate3));
			endDate = sdf.format(ed.getTime());
		}


		MemberDAO mDao = MemberDAO.getInstance();
		Map<String, String> dayRevenue = mDao.getDayCount("7", 1, startDate, endDate);
		Map<String, String> dayRefundRevenue = mDao.getDayCount("7", 2, startDate, endDate);

		request.setAttribute("dayRevenue", dayRevenue);
		request.setAttribute("dayRefundRevenue", dayRefundRevenue);
		request.setAttribute("week", week);
		request.setAttribute("startDate", startDate);
		request.setAttribute("endDate", endDate);

		RequestDispatcher dispatcher = request.getRequestDispatcher("admin/stats/memberDay.jsp");
		dispatcher.forward(request, response);
	}

}
