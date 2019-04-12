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

public class MemberPassUpdate implements Action {
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String url = "mypage/passUpdate.jsp";
		MemberVO mVo = new MemberVO();
		
		HttpSession session = request.getSession();
		

		// input_pw 는 바로 전 페이지인 CHANGEPROFILE_PW.jsp 에서 입력한 첫번째 input(현재 비밀번호) 이다
		/*String input_pw = request.getParameter("pwd1");*/
		String nowPwd = request.getParameter("pwd1");

		// session_pw 는 LOGIN_CHECK.jsp 에서 로그인 성공과 동시에 session에 pw라는 이름으로 저장된 문자이다

		MemberVO loginUser = (MemberVO)session.getAttribute("loginUser");
		String sessionId = loginUser.getUserid();
		String sessionPwd = loginUser.getPwd();
		
		// 앞전에 입력한 input_pw와 내 계정이 가지고 있는 session_pw가 다르면 다시 돌려보낸다
		if (!nowPwd.equals(sessionPwd)) {
			// 변경에 실패하면 실패사유를 경고창으로 띄워주고 현재 비밀번호 입력, 새로운 비밀번호 입력, 확인 페이지로 보낸다
//			request.setAttribute("message", "현재 비밀번호를 잘못입력하셨습니다.");
			response.setCharacterEncoding("EUC-KR");
		     PrintWriter writer = response.getWriter();
		     writer.println("<script type='text/javascript'>");
		     writer.println("alert('비밀번호를 잘못입력하셨습니다.');");
		     writer.println("history.back();");
		     writer.println("</script>");
		     writer.flush();
//			url = "member/passUpdate.jsp";
		}
		// input_pw와 session_pw가 같다면 (비밀번호 변경에 요구된 모든조건을 충족했다면)
		else {
			// new_pw를 만드는데 이는 전 페이지인 CHANGEPROFILE_PW.jsp 2번째 input에서 입력한 새로운 비밀번호 이다
			String pwd = request.getParameter("pwd");
			
			mVo.setUserid(sessionId);
			mVo.setPwd(pwd);
			loginUser.setPwd(pwd);
			
			response.setCharacterEncoding("EUC-KR");
		     PrintWriter writer = response.getWriter();
		     writer.println("<script type='text/javascript'>");
		     writer.println("alert('비밀번호 변경이 완료되었습니다.');");
		     writer.println("location.href='Member?command=member_mypage';");
		     writer.println("</script>");
		     writer.flush();
		     
		     MemberDAO mDao = MemberDAO.getInstance();
				mDao.passUpdate(mVo);
		     return;
		}

		MemberDAO mDao = MemberDAO.getInstance();
		mDao.passUpdate(mVo);
		RequestDispatcher dispatcher = request.getRequestDispatcher(url);
		dispatcher.forward(request, response);

	}

}
