package com.itfarm.controller.action.admin;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.itfarm.dao.MemberDAO;

public class MemberDelete implements AdminAction {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String[] checks = request.getParameterValues("checkOne");
		System.out.println(checks);
		MemberDAO mDao = MemberDAO.getInstance();
		
		int checklen = checks.length;
		  
		  try {
		   for(int i=0; i<checklen; i++) {
		    System.out.println(checks[i]+";");
		    mDao.adminDeleteMember((checks[i]));
		   }
		  }
		  catch(Exception ex) {
		   System.out.println("exception occured");
		  }
		

		response.setCharacterEncoding("EUC-KR");
		PrintWriter writer = response.getWriter();
		writer.println("<script type='text/javascript'>");
		writer.println("alert('탈퇴되었습니다.');");
		writer.println("location.href='Admin?command=member_list&status=1';");
		writer.println("</script>");
		writer.flush();
	}

}
