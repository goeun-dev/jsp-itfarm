package com.itfarm.controller.action.admin;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.itfarm.dao.ExperienceDAO;
import com.itfarm.dto.ReservationVO;

public class ReservationUpdateForm implements AdminAction {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int expid = Integer.parseInt(request.getParameter("expid"));
		ExperienceDAO eDao = ExperienceDAO.getInstance();
		ReservationVO rVo = eDao.selectOneReservationByNum(expid);
		request.setAttribute("reservation", rVo);
		RequestDispatcher dispatcher = request
				.getRequestDispatcher("admin/experience/reservationUpdate.jsp");
		dispatcher.forward(request, response);
	}

}
