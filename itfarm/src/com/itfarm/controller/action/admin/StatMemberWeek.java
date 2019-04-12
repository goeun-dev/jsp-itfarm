package com.itfarm.controller.action.admin;

import java.io.IOException;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.itfarm.dao.MemberDAO;

public class StatMemberWeek implements AdminAction {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String week = request.getParameter("week");
		if (week == null) {
			week = "7";
		}
		MemberDAO mDao = MemberDAO.getInstance();
		Map<String, Object> weekRevenue = mDao.getWeakCount(week, 1);
		Map<String, Object> weekRefundRevenue = mDao.getWeakCount(week, 2);

		request.setAttribute("weekRevenue", weekRevenue);
		request.setAttribute("weekRefundRevenue", weekRefundRevenue);
		request.setAttribute("week", week);

		RequestDispatcher dispatcher = request.getRequestDispatcher("admin/stats/memberWeek.jsp");
		dispatcher.forward(request, response);
	}

}
