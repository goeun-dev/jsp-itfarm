package com.itfarm.controller.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.itfarm.dao.MemberDAO;
import com.itfarm.dto.MemberVO;

public class MemberLogin implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String url = "member/login.jsp";
		String userid = request.getParameter("userid");
		String pwd = request.getParameter("pwd");
		String admin = "1";
		MemberDAO mDao = MemberDAO.getInstance();
		int result = mDao.userCheck(userid, pwd);
		if (result == 1) {
			MemberVO mVo = mDao.getMember(userid);
			HttpSession session = request.getSession();
			session.setAttribute("loginUser", mVo);			
			request.setAttribute("message", "로그인 성공");
			url = "index.jsp";
		} else if (result == 2) {
			MemberVO mVo = mDao.getMember(userid);
			HttpSession session = request.getSession();
			session.setAttribute("loginUser", mVo);
			request.setAttribute("message", "로그인 성공");
			session.setAttribute("isAdmin", admin);
			url = "Admin?command=index";
		} else if (result == 0) {
			request.setAttribute("message", "아이디 혹은 비밀번호를 확인해주세요.");
			response.setCharacterEncoding("EUC-KR");
			PrintWriter writer = response.getWriter();
			writer.println("<script type='text/javascript'>");
			writer.println("alert('아이디 혹은 비밀번호를 확인해주세요.');");
			writer.println("history.back();");
			writer.println("</script>");
			writer.flush();

			return;
		} else if (result == -1) {
			request.setAttribute("message", "존재하지 않는 아이디입니다.");
			response.setCharacterEncoding("EUC-KR");
			PrintWriter writer = response.getWriter();
			writer.println("<script type='text/javascript'>");
			writer.println("alert('아이디 혹은 비밀번호를 확인해주세요.');");
			writer.println("history.back();");
			writer.println("</script>");
			writer.flush();

			return;
		}
		RequestDispatcher dispatcher = request.getRequestDispatcher(url);
		dispatcher.forward(request, response);

	}

}
