package com.itfarm.controller.action.admin;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.itfarm.dao.ExperienceDAO;
import com.itfarm.dto.ReservationVO;

public class OrderUpdate implements AdminAction {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");

		int adultNum = Integer.parseInt(request.getParameter("adultNum"));
		int childNum = Integer.parseInt(request.getParameter("childNum"));
		int expid = Integer.parseInt(request.getParameter("expid"));
		String eDate = request.getParameter("eDate");
		String rDate = request.getParameter("rDate");
		String price = request.getParameter("price");

		ReservationVO rVo = new ReservationVO();
		rVo.setAdultNum(adultNum);
		rVo.setChildNum(childNum);
		rVo.seteDate(eDate);
		rVo.setrDate(rDate);
		rVo.setPrice(price);
		rVo.setExpid(expid);
		ExperienceDAO eDao = ExperienceDAO.getInstance();
		eDao.updateReservation(rVo);
		
		response.setCharacterEncoding("EUC-KR");
		PrintWriter writer = response.getWriter();
		writer.println("<script type='text/javascript'>");
		writer.println("alert('수정되었습니다.');");
		writer.println("location.href='OrderList';");
		writer.println("</script>");
		writer.flush();
		return;
	}

}
