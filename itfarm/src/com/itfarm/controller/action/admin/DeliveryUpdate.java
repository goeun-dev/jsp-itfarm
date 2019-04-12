package com.itfarm.controller.action.admin;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.itfarm.dao.ProductDAO;

public class DeliveryUpdate implements AdminAction{

	public DeliveryUpdate() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String saleid = request.getParameter("saleid");
		String dno = request.getParameter("dno");
		
		ProductDAO pDao = ProductDAO.getInstance();
		pDao.DeliveryUpdate(dno, saleid);
		
		response.setCharacterEncoding("EUC-KR");
		PrintWriter writer = response.getWriter();
		writer.println("<script type='text/javascript'>");
		writer.println("alert('등록되었습니다.');");
		writer.println("opener.parent.location.reload();");
		writer.println("self.close();");
		
		writer.println("</script>");
		writer.flush();
		
	}

}
