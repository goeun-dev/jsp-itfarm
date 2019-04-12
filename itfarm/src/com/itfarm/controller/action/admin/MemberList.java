package com.itfarm.controller.action.admin;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.itfarm.dao.MemberDAO;
import com.itfarm.dto.MemberVO;

public class MemberList implements AdminAction {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String url = "";
		List<MemberVO> memberList;
		MemberDAO mDao = MemberDAO.getInstance();
		String status = request.getParameter("status");
		String name = "";
		String userid = "";
		String searchName =request.getParameter("searchName");
		String category = request.getParameter("searchCategory");
		System.out.println(category);
		
		int sts = Integer.parseInt(status);
		
		if ("1".equals(category)) {
			memberList = mDao.selectAllMembers(searchName, userid, sts);
		} else if ("2".equals(category)) {
			memberList = mDao.selectAllMembers(name, searchName, sts);
		} else {
			memberList = mDao.selectAllMembers(name, userid, sts);
		}
		request.setAttribute("searchName", searchName);
		request.setAttribute("searchCategory", category);
		
		if (sts == 1) {
			url = "admin/member/memberList.jsp";
		}
		if (sts == 2) {
			url ="admin/member/deleteMemberList.jsp" ;
		}
		
		if (memberList.isEmpty()) {
			request.setAttribute("emp", "회원이 존재하지 않습니다.");
		}
		
		request.setAttribute("memberList", memberList);
		RequestDispatcher dispatcher = request.getRequestDispatcher(url);
		dispatcher.forward(request, response);
	}

}
