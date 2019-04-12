package com.itfarm.controller.action.admin;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.itfarm.dao.ExperienceDAO;
import com.itfarm.dto.ReservationVO;

public class ReservationList implements AdminAction {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ExperienceDAO eDao = ExperienceDAO.getInstance();
		String userid = "";
		String expName = "";
		List<ReservationVO> rList = eDao.selectAllRsrvs(userid,expName, 3);
		if (rList.isEmpty()) {
			request.setAttribute("emp", "예약 내역이 없습니다.");
		}
		request.setAttribute("rList", rList);
		
		RequestDispatcher dispatcher = request
				.getRequestDispatcher("admin/experience/reservationList.jsp");
		dispatcher.forward(request, response);
	}

}
