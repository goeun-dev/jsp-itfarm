package com.itfarm.controller.action;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ReservationRefundForm implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("id");
		
		request.setAttribute("id", id);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("experience/refund.jsp");
		dispatcher.forward(request, response);
	}

}
