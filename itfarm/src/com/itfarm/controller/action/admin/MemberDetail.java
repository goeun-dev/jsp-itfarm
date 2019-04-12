package com.itfarm.controller.action.admin;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.itfarm.dao.MemberDAO;
import com.itfarm.dto.MemberVO;

public class MemberDetail implements AdminAction {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String userid = request.getParameter("userid");
		MemberDAO mDao = MemberDAO.getInstance();
		MemberVO mVo = mDao.getMember(userid);
		request.setAttribute("member", mVo);
		RequestDispatcher dispatcher = request
				.getRequestDispatcher("admin/member/memberDetail.jsp");
		dispatcher.forward(request, response);
	}

}
