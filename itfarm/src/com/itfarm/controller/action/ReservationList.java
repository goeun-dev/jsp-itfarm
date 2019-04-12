package com.itfarm.controller.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.itfarm.dao.ExperienceDAO;
import com.itfarm.dto.MemberVO;
import com.itfarm.dto.ReservationVO;

public class ReservationList implements Action {

	public ReservationList() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String url = "mypage/mypage.jsp";
		ExperienceDAO eDao = ExperienceDAO.getInstance();

		HttpSession session = request.getSession();
		MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");
		String midd = loginUser.getUserid();
		String status = request.getParameter("status");
		int sts = Integer.parseInt(status);
		String expName = "";
		List<ReservationVO> rList = eDao.selectAllRsrvs(midd, expName, sts);
		
		if (sts == 1) {
			url = "experience/reservationList.jsp";
			if (rList.isEmpty()) {
				request.setAttribute("emp", "예약 내역이 없습니다.");
			}
		} else if (sts == 2) {
			url = "experience/refundList.jsp";
			if (rList.isEmpty()) {
				request.setAttribute("emp", "예약 내역이 없습니다.");
			}
		}
		request.setAttribute("rList", rList);

		RequestDispatcher dispatcher = request.getRequestDispatcher(url);
		dispatcher.forward(request, response);

	}

}
