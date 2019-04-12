package com.itfarm.controller.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.itfarm.dao.MemberDAO;
import com.itfarm.dto.MemberVO;

public class MemberJoin implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String name = request.getParameter("name");
		String userid = request.getParameter("userid");
		String pwd = request.getParameter("pwd");
		String email1 = request.getParameter("email1");
		String email2 = request.getParameter("email2");
		String phone1 = request.getParameter("phone1");
		String phone2 = request.getParameter("phone2");
		String phone3 = request.getParameter("phone3");
		String roadAddrPart1 = request.getParameter("roadAddrPart1");
		String addrDetail = request.getParameter("addrDetail");
		String zipNo = request.getParameter("zipNo");

		MemberVO mVo = new MemberVO();
		mVo.setName(name);
		mVo.setUserid(userid);
		mVo.setPwd(pwd);
		mVo.setEmail1(email1);
		mVo.setEmail2(email2);
		mVo.setPhone1(phone1);
		mVo.setPhone2(phone2);
		mVo.setPhone3(phone3);
		mVo.setAddrDetail(addrDetail);
		mVo.setRoadAddr(roadAddrPart1);
		mVo.setZipNo(zipNo);
		MemberDAO mDao = MemberDAO.getInstance();

		int result = mDao.insertMember(mVo);
		HttpSession session = request.getSession();

		if (result == 1) {
			session.setAttribute("userid", mVo.getUserid());
			request.setAttribute("message", "가입성공.");
			response.setCharacterEncoding("EUC-KR");
			PrintWriter writer = response.getWriter();
			writer.println("<script type='text/javascript'>");
			writer.println("alert('회원가입이 완료되었습니다.');");
			writer.println("location.href='Member?command=member_loginform';");
			writer.println("</script>");
			writer.flush();

			return;
		} else {
			request.setAttribute("message", "가입에 실패했습니다.");
			response.setCharacterEncoding("EUC-KR");
			PrintWriter writer = response.getWriter();
			writer.println("<script type='text/javascript'>");
			writer.println("alert('회원가입에 실패했습니다. 관리자에게 문의해주세요.');");
			writer.println("history.back();");
			writer.println("</script>");
			writer.flush();

			return;
		}
	}
}
