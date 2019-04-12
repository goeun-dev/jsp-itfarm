package com.itfarm.controller.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.itfarm.dao.ProductDAO;
import com.itfarm.dto.CartVO;

public class ProductCartBuyForm implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");

		ProductDAO pDao = ProductDAO.getInstance();
		String[] checks = null;
		// 장바구니에서 제품 리스트 받아오기
		try {
			checks = request.getParameterValues("checkOne");
			System.out.println(checks[0]);
			System.out.println(request.getParameterValues("checkOne"));
		} catch (NullPointerException e) {
			response.setCharacterEncoding("EUC-KR");
			PrintWriter writer = response.getWriter();
			writer.println("<script type='text/javascript'>");
			writer.println("alert('구매하실 상품을 선택해주세요.');");
			writer.println("history.back();");
			writer.println("</script>");
			writer.flush();

			return;
		}
		
		int checklen = checks.length;
		String[] cids = new String[checklen];
		String[] soldoutName = new String[checklen];
		int[] soldoutCnt = new int[checklen];
		String mid = "";
		// 제품 리스트 생성
		int out = 0;
		int abc=0;
		for (int i = 0; i < checklen; i++) {
			String chks = checks[i];
			String cid = chks.split(",")[0];
			int num = Integer.parseInt(chks.split(",")[2]);
			int count = Integer.parseInt(chks.split(",")[3]);
			String pname = chks.split(",")[4];
			
			cids[i] = cid;
			
			if (count < num) {
				
				soldoutName[out] = pname;
				soldoutCnt[out] = count;
				cids[out] = cid;
				out++;
				abc=1;
 			}
		}
		String aa = "현재 수량이 부족하여 구매하실 수 없습니다. ";
		for (int a=0; a < soldoutName.length; a++) {
			if (soldoutName[a] != null) {
				int cnt = soldoutCnt[a];
				aa +="상품명: "+soldoutName[a] + ", 재고수량: "+ cnt + " 개";
				pDao.updateCart(cids[a], soldoutCnt[a]);
			}
		}
		if (abc==1) {
			response.setCharacterEncoding("EUC-KR");
			PrintWriter writer = response.getWriter();
			writer.println("<script type='text/javascript'>");
			writer.println("alert('" + aa + "');");
			writer.println("location.href='Product?command=cart_list';");
			writer.println("</script>");
			writer.flush();

			return;
		}
		List<CartVO> list = pDao.selectAllCarts(mid, cids);

		request.setAttribute("buyList", list);

		RequestDispatcher dispatcher = request.getRequestDispatcher("product/productBuy.jsp");
		dispatcher.forward(request, response);
	}
}
