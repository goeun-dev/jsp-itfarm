package com.itfarm.controller.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.itfarm.dao.MemberDAO;

public class MemberDelete implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String url = "mypage/memberDelete.jsp";
		request.setCharacterEncoding("utf-8");
		HttpSession session = request.getSession();
		String userid = request.getParameter("userid");
		String pwd = request.getParameter("pwd");
		
		MemberDAO mDao = MemberDAO.getInstance();
		// 회원탈퇴처리 메소드 수행 후 탈퇴 상황 값 반환
		boolean check = mDao.deleteMember(userid, pwd);
		 if (!check) {
			request.setAttribute("msg", "비밀번호를 제대로 입력했는지 확인해주세요.");
			session = request.getSession();
			url = "Mypage";
			
			response.setCharacterEncoding("EUC-KR");
			PrintWriter writer = response.getWriter();
			writer.println("<script type='text/javascript'>");
			writer.println("alert('비밀번호를 제대로 입력했는지 확인해주세요.');");
			writer.println("history.back();");
			writer.println("</script>");
			writer.flush();
			
			return;
		}else if (check) {// 탈퇴성공시
			request.setAttribute("msg", "탈퇴가 완료되었습니다.");
			session.invalidate();// 세션을 무효화	
			url = "index.jsp";
			
			response.setCharacterEncoding("EUC-KR");
			PrintWriter writer = response.getWriter();
			writer.println("<script type='text/javascript'>");
			writer.println("alert('탈퇴가 완료되었습니다.');");
			writer.println("location.href='index.jsp';");
			writer.println("</script>");
			writer.flush();
			
			return;
		}
		 System.out.println(request.getAttribute("msg"));
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(url);
		dispatcher.forward(request, response);

	}

}
