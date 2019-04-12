package com.itfarm.controller.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.itfarm.dto.CartVO;

public class ProductBuyForm implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");

		int pid = Integer.parseInt(request.getParameter("pid"));
		int num = Integer.parseInt(request.getParameter("num"));
		int count = Integer.parseInt(request.getParameter("count"));
		String img = request.getParameter("img");
		String name = request.getParameter("name");
		String price = request.getParameter("price");
		String cid = "none";

		List<CartVO> list = new ArrayList<CartVO>();
		CartVO cVo = new CartVO();
		cVo.setPimg(img);
		cVo.setPname(name);
		cVo.setPid(pid);
		cVo.setPprice(price);
		cVo.setNum(num);
		cVo.setId(cid);

		list.add(cVo);

		request.setAttribute("buyList", list);

		if (count < num) {
			response.setCharacterEncoding("EUC-KR");
			PrintWriter writer = response.getWriter();
			writer.println("<script type='text/javascript'>");
			writer.println("alert('현재 수량이 부족하여 구매하실 수 없습니다. 재고 수량: " + count + "개');");
			writer.println("history.back();");
			writer.println("</script>");
			writer.flush();

			return;
		}
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("product/productBuy.jsp");
		dispatcher.forward(request, response);
	}
}
