package com.itfarm.controller.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.itfarm.dao.ProductDAO;
import com.itfarm.dto.SaleVO;


public class Mypage implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String userid = request.getParameter("userid");
		ProductDAO pDao = ProductDAO.getInstance();
		List<SaleVO> del0 = pDao.orderCount(userid, 0);
		List<SaleVO> del1 = pDao.orderCount(userid, 1);
		List<SaleVO> del2 = pDao.orderCount(userid, 2);
		List<SaleVO> del3 = pDao.orderCount(userid, 3);
		List<SaleVO> del4 = pDao.orderCount(userid, 4);
		List<SaleVO> del5 = pDao.orderCount(userid, 5);
		List<SaleVO> del6 = pDao.orderCount(userid, 6);
		List<SaleVO> del7 = pDao.orderCount(userid, 7);
		
		request.setAttribute("del0", del0);
		request.setAttribute("del1", del1);
		request.setAttribute("del2", del2);
		request.setAttribute("del3", del3);
		request.setAttribute("del4", del4);
		request.setAttribute("del5", del5);
		request.setAttribute("del6", del6);
		request.setAttribute("del7", del7);
		
		RequestDispatcher dispatcher = request
				.getRequestDispatcher("mypage/mypage.jsp");
		dispatcher.forward(request, response);
	}

}
