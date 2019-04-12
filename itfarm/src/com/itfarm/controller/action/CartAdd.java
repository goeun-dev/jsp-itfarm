package com.itfarm.controller.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Calendar;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.itfarm.dao.ProductDAO;
import com.itfarm.dto.CartVO;
import com.itfarm.dto.MemberVO;

public class CartAdd implements Action {

	public CartAdd() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		ProductDAO pDao = ProductDAO.getInstance();

		HttpSession session = request.getSession();

		MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");
		if (loginUser == null) {
			response.setCharacterEncoding("EUC-KR");
			PrintWriter writer = response.getWriter();
			writer.println("<script type='text/javascript'>");
			writer.println("alert('로그인이 필요합니다.');");
			writer.println("location.href='Member?command=member_loginform'");
			writer.println("</script>");
			writer.flush();

			return;
		} else {
			String midd = loginUser.getUserid();
			String pidd = request.getParameter("pid");
			int count = Integer.parseInt(request.getParameter("count"));
			int result = pDao.confirmCart(midd, pidd);
			int num = Integer.parseInt(request.getParameter("num"));
			if (count < num) {
				response.setCharacterEncoding("EUC-KR");
				PrintWriter writer = response.getWriter();
				writer.println("<script type='text/javascript'>");
				writer.println("alert('현재 수량이 부족하여 구매하실 수 없습니다. 재고 수량: "+count+"개');");
				writer.println("history.back();");
				writer.println("</script>");
				writer.flush();

				return;
			}
			if (result == -1) {
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

				Calendar c1 = Calendar.getInstance();

				String strToday = sdf.format(c1.getTime());

				System.out.println("Today=" + strToday);

				String id = request.getParameter("id");
				String mid = request.getParameter("mid");
				int pid = Integer.parseInt(request.getParameter("pid"));
				String date = strToday;
				//int 
				num = Integer.parseInt(request.getParameter("num"));

				CartVO cVo = new CartVO();
				cVo.setId(id);
				cVo.setMid(mid);
				cVo.setPid(pid);
				cVo.setDate(date);
				cVo.setNum(num);
				
				/* ProductDAO pDao = ProductDAO.getInstance(); */

				int results = pDao.Cart(cVo);

				if (results == 1) {
					request.setAttribute("message", "성공.");
					response.setCharacterEncoding("EUC-KR");
					PrintWriter writer = response.getWriter();
					writer.println("<script type='text/javascript'>");
					writer.println("alert('장바구니에 상품이 저장되었습니다.');");
					writer.println("location.href='Product?command=cart_list';");
					writer.println("</script>");
					writer.flush();

					return;
				} else {
					request.setAttribute("message", "장바구니 담기에 실패했습니다.");
					response.setCharacterEncoding("EUC-KR");
					PrintWriter writer = response.getWriter();
					writer.println("<script type='text/javascript'>");
					writer.println("alert('장바구니 담기에 실패했습니다. 관리자에게 문의해주세요.');");
					writer.println("history.back();");
					writer.println("</script>");
					writer.flush();

					return;
				}

			} else if (result == 1) {
				request.setAttribute("message", "장바구니에 존재하는 상품입니다.");
				response.setCharacterEncoding("EUC-KR");
				PrintWriter writer = response.getWriter();
				writer.println("<script type='text/javascript'>");
				writer.println("alert('장바구니에 존재하는 상품입니다..');");
				writer.println("history.back();");
				writer.println("</script>");
				writer.flush();

				return;
			}
		}
	}

}
