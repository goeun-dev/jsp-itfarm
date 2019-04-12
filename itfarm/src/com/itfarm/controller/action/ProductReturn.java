package com.itfarm.controller.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.itfarm.dao.ProductDAO;

public class ProductReturn implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("id");
		String bank = request.getParameter("bank");
		String account = request.getParameter("account");
		String acName = request.getParameter("acName");
		String ac = bank + account + acName;
		String reason = request.getParameter("reason");
		
		ProductDAO pDao = ProductDAO.getInstance();

		if (account != null || account != "") {
			pDao.updateAccount(ac, id, reason);
		}
		pDao.refundOrder(id, 5, null);
		pDao.updateReason(reason, id);
		response.setCharacterEncoding("EUC-KR");
		PrintWriter writer = response.getWriter();
		writer.println("<script type='text/javascript'>");
		writer.println("alert('완료되었습니다. 관리자의 승인 후 반품 여부가 결정됩니다.');");
		writer.println("location.href='Product?command=order_list&status=2';");
		writer.println("self.close();");
		writer.println("</script>");
		writer.flush();

	}
}
