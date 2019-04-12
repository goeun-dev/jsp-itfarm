package com.itfarm.controller.action.admin;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class DeliveryUpdateForm implements AdminAction {

	public DeliveryUpdateForm() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String saleid = request.getParameter("saleid");

		request.setAttribute("saleid", saleid);

		RequestDispatcher dispatcher = request.getRequestDispatcher("admin/product/deliveryUpdate.jsp");
		dispatcher.forward(request, response);
	}

}
