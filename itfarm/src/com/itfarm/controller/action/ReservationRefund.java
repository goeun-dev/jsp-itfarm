package com.itfarm.controller.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.itfarm.dao.ExperienceDAO;

public class ReservationRefund implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("id");
		int status = 2;
		// Integer.parseInt(request.getParameter("status"));

		ExperienceDAO eDao = ExperienceDAO.getInstance();
		eDao.refundReservation(id, status);

		response.setCharacterEncoding("EUC-KR");
		PrintWriter writer = response.getWriter();
		writer.println("<script type='text/javascript'>");
		writer.println("alert('취소가 완료되었습니다.');");
		writer.println("location.href='Experience?command=reservation_list&status=2';");
		writer.println("self.close();");
		writer.println("</script>");
		writer.flush();

	}

}
