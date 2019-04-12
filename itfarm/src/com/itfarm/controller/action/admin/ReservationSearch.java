package com.itfarm.controller.action.admin;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.itfarm.dao.ExperienceDAO;
import com.itfarm.dto.ReservationVO;

public class ReservationSearch implements AdminAction {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String url = "admin/experience/reservationList.jsp";
		String startDate = request.getParameter("startDate");
		String endDate = request.getParameter("endDate");
		String userid = "";
		String expName = "";
		if (userid != null) {
			userid = request.getParameter("searchUserid");
		}
		if (expName != null) {
			expName = request.getParameter("searchExpName");
		}
		String[] statusAy = request.getParameterValues("status");
		String[] payAy = request.getParameterValues("payment");
		String payment = "";
		String status = "";
		if (statusAy != null) {
			for (String val : statusAy) {
				status += "" + val + ", ";
			}
		}
		if (payAy != null) {
			for (String p : payAy) {
				payment += "" + p + ", ";
			}
		}
		ExperienceDAO eDao = ExperienceDAO.getInstance();
		List<ReservationVO> rList = eDao.adminSelectAllRsrvs(userid, expName, status, payment, startDate, endDate);
		request.setAttribute("rList", rList);
		request.setAttribute("searchUserid", userid);
		request.setAttribute("searchExpName", expName);
		request.setAttribute("startDate", startDate);
		request.setAttribute("endDate", endDate);
		RequestDispatcher dispatcher = request.getRequestDispatcher(url);
		dispatcher.forward(request, response);
	}

}
