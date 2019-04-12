package com.itfarm.controller.action.admin;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.itfarm.dao.BoardDAO;

public class BoardDelete implements AdminAction {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String[] checks = request.getParameterValues("checkOne");
		System.out.println(checks);
		BoardDAO bDao = BoardDAO.getInstance();
		
		int checklen = checks.length;
		  
		  try {
		   for(int i=0; i<checklen; i++) {
		    System.out.println(checks[i]+";");
		    bDao.deleteBoard((checks[i]));
		   }
		  }
		  catch(Exception ex) {
		   System.out.println("exception occured");
		  }
		

		response.setCharacterEncoding("EUC-KR");
		PrintWriter writer = response.getWriter();
		writer.println("<script type='text/javascript'>");
		writer.println("alert('삭제되었습니다.');");
		writer.println("location.href='Admin?command=board_list';");
		writer.println("</script>");
		writer.flush();
	}

}
