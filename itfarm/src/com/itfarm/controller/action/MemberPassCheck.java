package com.itfarm.controller.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.itfarm.dto.MemberVO;

public class MemberPassCheck implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String url = "mypage/mypage.jsp";
		//MemberVO mVo = new MemberVO();
		
		HttpSession session = request.getSession();

		String nowPwd = request.getParameter("pwd");

		MemberVO loginUser = (MemberVO)session.getAttribute("loginUser");
		String sessionId = loginUser.getUserid();
		String sessionPwd = loginUser.getPwd();
		
		if (!nowPwd.equals(sessionPwd)) {
			 response.setCharacterEncoding("EUC-KR");
		     PrintWriter writer = response.getWriter();
		     writer.println("<script type='text/javascript'>");
		     writer.println("alert('비밀번호를 다시 확인해주세요.');");
		     writer.println("history.back();");
		     writer.println("</script>");
		     writer.flush();
		     return;

		}
		else {
			url = "Member?command=member_updateform&userid="+sessionId;
			response.sendRedirect(url);
		}
		/*System.out.println(url);
		RequestDispatcher dispatcher = request.getRequestDispatcher(url);
		dispatcher.forward(request, response);*/

	}

}
