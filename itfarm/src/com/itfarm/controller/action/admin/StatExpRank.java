package com.itfarm.controller.action.admin;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.itfarm.dao.ExperienceDAO;
import com.itfarm.dto.ReservationVO;

public class StatExpRank implements AdminAction {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		ExperienceDAO eDao = ExperienceDAO.getInstance();
		List<ReservationVO> expRankList = eDao.expRanking();

		request.setAttribute("expRankList", expRankList);
		RequestDispatcher dispatcher = request.getRequestDispatcher("admin/stats/expRank.jsp");
		dispatcher.forward(request, response);
	}

}
