package com.itfarm.controller.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.itfarm.dao.ExperienceDAO;
import com.itfarm.dto.ReservationVO;

public class ExperienceCalendar implements Action {

	public ExperienceCalendar() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String urla = "experience/calendar.jsp";
		String prodCode = request.getParameter("prodCode");
		String stdCnt = request.getParameter("stdCnt");
		int intStdCnt = Integer.parseInt(stdCnt);
		ExperienceDAO eDao = ExperienceDAO.getInstance();
		List<ReservationVO> reservationList = eDao.reservationNum(prodCode, intStdCnt);
		request.setAttribute("rList", reservationList);
		
		request.setAttribute("stdCnt", stdCnt);
		request.setAttribute("prodCode", prodCode);
		
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(urla);
		dispatcher.forward(request, response);
	}

}
