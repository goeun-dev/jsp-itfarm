package com.itfarm.controller.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Calendar;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.itfarm.dao.ExperienceDAO;
import com.itfarm.dto.ReservationVO;

public class ReservationOk implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

		Calendar c1 = Calendar.getInstance();

		String strToday = sdf.format(c1.getTime());

		System.out.println("Today=" + strToday);

		String rDate = strToday;
		int payment = Integer.parseInt(request.getParameter("payment"));
		String userid = request.getParameter("member");
		String prodcode = request.getParameter("prodcode");

		int adultNum = Integer.parseInt(request.getParameter("adultNum"));

		String eDate = request.getParameter("eDate");
		int childNum = Integer.parseInt(request.getParameter("childNum"));
		String price = request.getParameter("price");
		String expName = request.getParameter("expName");
		System.out.println(expName);
		String imgPath = request.getParameter("imgPath");

		ReservationVO eVo = new ReservationVO();

		eVo.setrDate(rDate);
		eVo.setUserid(userid);
		eVo.setPayment(payment);
		eVo.setProdcode(prodcode);
		eVo.setAdultNum(adultNum);
		eVo.seteDate(eDate);
		eVo.setChildNum(childNum);
		eVo.setPrice(price);
		eVo.setExpName(expName);
		eVo.setImgPath(imgPath);
		ExperienceDAO eDao = ExperienceDAO.getInstance();

		int result = eDao.reservationExp(eVo);
		HttpSession session = request.getSession();

		if (result == 1) {
			session.setAttribute("userid", eVo.getUserid());
			response.setCharacterEncoding("EUC-KR");
			PrintWriter writer = response.getWriter();
			writer.println("<script type='text/javascript'>");
			writer.println("alert('예약이 완료되었습니다.');");
			writer.println("location.href='experience/reservationOk.jsp';");
			writer.println("</script>");
			writer.flush();

			return;
		} else {
			response.setCharacterEncoding("EUC-KR");
			PrintWriter writer = response.getWriter();
			writer.println("<script type='text/javascript'>");
			writer.println("alert('예약에 실패했습니다. 관리자에게 문의해주세요.');");
			writer.println("history.back();");
			writer.println("</script>");
			writer.flush();

			return;
		}

	}

}
