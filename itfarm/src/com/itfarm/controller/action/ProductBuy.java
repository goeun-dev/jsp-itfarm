package com.itfarm.controller.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;
import java.util.Random;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.itfarm.dao.ProductDAO;
import com.itfarm.dto.SaleVO;

public class ProductBuy implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");

		ProductDAO pDao = ProductDAO.getInstance();
		
		// 제품구매 번호 난수
		StringBuffer temp = new StringBuffer();
		Random rnd = new Random();
		for (int i = 0; i < 5; i++) {
			int rIndex = rnd.nextInt(3);
			switch (rIndex) {
			case 0:
				// a-z
				temp.append((char) ((int) (rnd.nextInt(26)) + 97));
				break;
			case 1:
				// A-Z
				temp.append((char) ((int) (rnd.nextInt(26)) + 65));
				break;
			case 2:
				// 0-9
				temp.append((rnd.nextInt(10)));
				break;
			}
		}

		// 제품구매 번호 날짜
		SimpleDateFormat mSimpleDateFormat = new SimpleDateFormat("yyMMddHHmmss", Locale.KOREA);
		Date currentTime = new Date();
		String mTime = mSimpleDateFormat.format(currentTime);
		System.out.println(mTime);

		int a=0;
		
		String userid = request.getParameter("userid");
		String roadAddr = request.getParameter("roadAddrPart1");
		String zipNo = request.getParameter("zipNo");
		String addrDetail = request.getParameter("addrDetail");
		String payment = request.getParameter("payment");
		String name = request.getParameter("name");
		String phone1 = request.getParameter("phone1");
		String phone2 = request.getParameter("phone2");
		String phone3 = request.getParameter("phone3");
		String date = mTime;
		String saleid = date + temp;

		SaleVO sVo = new SaleVO();
		sVo.setSaleid(saleid);
		sVo.setpDate(date);
		sVo.setRoadAddr(roadAddr);
		sVo.setZipNo(zipNo);
		sVo.setAddrDetail(addrDetail);
		sVo.setUserid(userid);
		sVo.setPayment(Integer.parseInt(payment));
		sVo.setName(name);
		sVo.setPhone(phone1+"-"+phone2+"-"+phone3);

		// 장바구니에서 제품 리스트 받아오기
		String[] checks = request.getParameterValues("checkOne");
		int checklen = checks.length;
		System.out.println("체크 길이"+checklen);

		int result = pDao.ProductSale(sVo);
		if (result == -1) {
			request.setAttribute("message", "성공.");
			response.setCharacterEncoding("EUC-KR");
			PrintWriter writer = response.getWriter();
			writer.println("<script type='text/javascript'>");
			writer.println("alert('실패되었습니다.');");
			writer.println("location.href='index.jsp';");
			writer.println("</script>");
			writer.flush();

			return;
		}
		if (result == 1) {
			for (int i = 0; i < checklen; i++) {
				String chks = checks[i];
				System.out.println(chks);
				int pid = Integer.parseInt(chks.split(",")[0]);
				int num = Integer.parseInt(chks.split(",")[1]);
				String price = chks.split(",")[2];
				String cid = chks.split(",")[3];
				
				sVo = new SaleVO();
				sVo.setSaleid(saleid);
				sVo.setProdNo(pid);
				sVo.setNum(num);
				sVo.setUnitPrice(price);

				int result2 = pDao.ProductSaleDetail(sVo);
				if (result2 == -1) {
					request.setAttribute("message", "성공.");
					response.setCharacterEncoding("EUC-KR");
					PrintWriter writer = response.getWriter();
					writer.println("<script type='text/javascript'>");
					writer.println("alert('실패되었습니다.');");
					writer.println("location.href='index.jsp';");
					writer.println("</script>");
					writer.flush();

					return;

				}
				if (cid != null) {
					pDao.deleteOneCart(cid);
				}
				a++;
				if (a == checklen) {
					request.setAttribute("message", "성공.");
					response.setCharacterEncoding("EUC-KR");
					PrintWriter writer = response.getWriter();
					writer.println("<script type='text/javascript'>");
					writer.println("alert('구매되었습니다.');");
					writer.println("location.href='product/orderSuccess.jsp';");
					writer.println("</script>");
					writer.flush();

					return;
				}
			}			
		}	
	}
	
}
