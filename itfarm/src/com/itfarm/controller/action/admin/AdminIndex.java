package com.itfarm.controller.action.admin;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.itfarm.dao.ExperienceDAO;
import com.itfarm.dao.MemberDAO;
import com.itfarm.dao.ProductDAO;
import com.itfarm.dto.ReservationVO;
import com.itfarm.dto.SaleVO;


public class AdminIndex implements AdminAction {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ProductDAO pDao = ProductDAO.getInstance();
		List<SaleVO> sts0 = pDao.getMainSale(0);
		List<SaleVO> sts1 = pDao.getMainSale(1);
		List<SaleVO> sts2 = pDao.getMainSale(2);
		List<SaleVO> sts3 = pDao.getMainSale(3);
		List<SaleVO> sts4 = pDao.getMainSale(4);
		List<SaleVO> sts5 = pDao.getMainSale(5);
		List<SaleVO> sts6 = pDao.getMainSale(6);
		List<SaleVO> sts7 = pDao.getMainSale(7);
		ExperienceDAO eDao = ExperienceDAO.getInstance();
		List<ReservationVO> rsrv = eDao.adminMainMonthRsrv(1);
		List<ReservationVO> rsrvCancel = eDao.adminMainMonthRsrv(2);
		MemberDAO mDao = MemberDAO.getInstance();
		String mem =  mDao.getMemberCount();
		request.setAttribute("mem", mem);
		request.setAttribute("rs", rsrv);
		request.setAttribute("rsc", rsrvCancel);
		request.setAttribute("sts0", sts0);
		request.setAttribute("sts1", sts1);
		request.setAttribute("sts2", sts2);
		request.setAttribute("sts3", sts3);
		request.setAttribute("sts4", sts4);
		request.setAttribute("sts5", sts5);
		request.setAttribute("sts6", sts6);
		request.setAttribute("sts7", sts7);
		RequestDispatcher dispatcher = request
				.getRequestDispatcher("admin/index.jsp");
		dispatcher.forward(request, response);

	}

}
