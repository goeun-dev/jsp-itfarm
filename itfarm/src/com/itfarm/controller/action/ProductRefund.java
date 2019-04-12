package com.itfarm.controller.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.itfarm.dao.ProductDAO;
import com.itfarm.dto.SaleVO;

import oracle.net.aso.s;

public class ProductRefund implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("id");
		int status = Integer.parseInt(request.getParameter("status"));
		ProductDAO pDao = ProductDAO.getInstance();

		if (status == 4) {
			List<SaleVO> saleDetail = pDao.selectOrderDetailByNum(id);
			for (SaleVO data : saleDetail) {
				int pid = data.getProdNo();
				int num = data.getNum();
				pDao.refundProduct(pid, num);
				// System.out.println(pid + "수량" + num);
			}
			String bank = request.getParameter("bank");
			String account = request.getParameter("account");
			String acName = request.getParameter("acName");
			
			String ac = bank + account + acName;
			if (account != null || account != "") {
				pDao.updateAccount(ac, id, "");
			}
			pDao.refundOrder(id, status, null);
			response.setCharacterEncoding("EUC-KR");
			PrintWriter writer = response.getWriter();
			writer.println("<script type='text/javascript'>");
			writer.println("alert('취소가 완료되었습니다.');");
			writer.println("location.href='Product?command=order_list&status=2';");
			writer.println("self.close();");
			writer.println("</script>");
			writer.flush();

		}

		if (status == 3) {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

			Calendar c1 = Calendar.getInstance();

			String strToday = sdf.format(c1.getTime());

			pDao.refundOrder(id, status, strToday);
			response.setCharacterEncoding("EUC-KR");
			PrintWriter writer = response.getWriter();
			writer.println("<script type='text/javascript'>");
			writer.println("alert('수령 확인이 완료되었습니다.');");
			writer.println("location.href='Product?command=order_list&status=1';");
			writer.println("</script>");
			writer.flush();

		}

		if (status == 1) {
			pDao.refundOrder(id, status, null);
			response.setCharacterEncoding("EUC-KR");
			PrintWriter writer = response.getWriter();
			writer.println("<script type='text/javascript'>");
			writer.println("alert('완료되었습니다.');");
			writer.println("location.href='Admin?command=order_list';");
			writer.println("</script>");
			writer.flush();

		}
		
		if (status == 6) {
			List<SaleVO> saleDetail = pDao.selectOrderDetailByNum(id);
			for (SaleVO data : saleDetail) {
				int pid = data.getProdNo();
				int num = data.getNum();
				pDao.refundProduct(pid, num);
				// System.out.println(pid + "수량" + num);
			}
			pDao.refundOrder(id, status, null);
			response.setCharacterEncoding("EUC-KR");
			PrintWriter writer = response.getWriter();
			writer.println("<script type='text/javascript'>");
			writer.println("alert('완료되었습니다.');");
			writer.println("opener.parent.location.reload();");
			writer.println("self.close();");
			writer.println("</script>");
			writer.flush();

		}
		if (status == 7) {
			pDao.refundOrder(id, status, null);
			response.setCharacterEncoding("EUC-KR");
			PrintWriter writer = response.getWriter();
			writer.println("<script type='text/javascript'>");
			writer.println("alert('완료되었습니다.');");
			writer.println("opener.parent.location.reload();");
			writer.println("self.close();");
			writer.println("</script>");
			writer.flush();
			
		}
	}
}
