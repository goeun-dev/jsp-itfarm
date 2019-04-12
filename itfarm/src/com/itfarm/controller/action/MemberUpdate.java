package com.itfarm.controller.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.itfarm.dao.MemberDAO;
import com.itfarm.dto.MemberVO;

public class MemberUpdate implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");

		String userid = request.getParameter("userid");
		String email1 = request.getParameter("email1");
		String email2 = request.getParameter("email2");
		String phone1 = request.getParameter("phone1");
		String phone2 = request.getParameter("phone2");
		String phone3 = request.getParameter("phone3");
		String roadAddr = request.getParameter("roadAddrPart1");
		String addrDetail = request.getParameter("addrDetail");
		String zipNo = request.getParameter("zipNo");

		MemberVO mVo = new MemberVO();
		mVo.setUserid(userid);
		mVo.setEmail1(email1);
		mVo.setEmail2(email2);
		mVo.setPhone1(phone1);
		mVo.setPhone2(phone2);
		mVo.setPhone3(phone3);
		mVo.setAddrDetail(addrDetail);
		mVo.setRoadAddr(roadAddr);
		mVo.setZipNo(zipNo);

		response.setCharacterEncoding("EUC-KR");
		PrintWriter writer = response.getWriter();
		writer.println("<script type='text/javascript'>");
		writer.println("alert('회원정보 변경이 완료되었습니다.');");
		writer.println("location.href='Member?command=member_mypage';");
		writer.println("</script>");
		writer.flush();
		
		MemberDAO mDao = MemberDAO.getInstance();
		mDao.updateMember(mVo);
		response.sendRedirect("Member?command=member_mypage");
		
		return;
	}

}
