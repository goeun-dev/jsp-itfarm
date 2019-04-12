package com.itfarm.controller.action;

import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;

import com.itfarm.dao.MemberDAO;
import com.itfarm.dto.MemberVO;

public class ReservationForm implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");

		String userid = request.getParameter("userid");

		MemberDAO mDao = MemberDAO.getInstance();
		MemberVO mVo = mDao.getMember(userid);
		request.setAttribute("mVo", mVo);
		String img = request.getParameter("img");
		String nprodCode = request.getParameter("prodCode");
		int adultNum = Integer.parseInt(request.getParameter("intro_count"));
		int childNum = Integer.parseInt(request.getParameter("main_count"));;

		String eDate = request.getParameter("eDate");
		String price = request.getParameter("total");

		request.setAttribute("img", img);
		request.setAttribute("adultNum", adultNum);
		request.setAttribute("childNum", childNum);
		request.setAttribute("eDate", eDate);
		request.setAttribute("price", price);
		request.setAttribute("prodCode", nprodCode);
		request.setAttribute("total", price);

		try {
			String prodCode = request.getParameter("prodCode");
			// String imgPath = request.getParameter("imgPath");
			// 데이터를 가져올 주소
			StringBuilder urlBuilder = new StringBuilder(
					"http://openapi.invil.org/openapi/service/rest/InvilExprnInfoService/getFmlgExprnItem"); /* URL */
			urlBuilder.append("?" + URLEncoder.encode("ServiceKey", "UTF-8")
					+ "=D0qTz5nYGtmJeCfG%2FuCAP0nE5e%2Bd996RTyMSobgHkmZM6xDTGDEbHPw7tvzuqsVbTmpBglPDYlzVT0zhiXKF3w%3D%3D"); // servicekey
			urlBuilder
					.append("&" + URLEncoder.encode("prodCode", "UTF-8") + "=" + URLEncoder.encode(prodCode, "UTF-8"));

			// 웹 주소를 URL을 변경
			URL url = new URL(urlBuilder.toString());
			// URL connection 만들기
			HttpURLConnection con = (HttpURLConnection) url.openConnection();
			// 데이터를 읽어올 스트림 생성
			BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream(), "UTF-8"));
			// 데이터 읽어서 출력
			String data = "";
			while (true) {
				String line = br.readLine();
				if (line == null) {
					break;
				}
				data += line;
			}

			DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
			DocumentBuilder document = factory.newDocumentBuilder();
			InputStream is = new ByteArrayInputStream(data.getBytes());
			Document doc = document.parse(is);

			// 최상위 노드를 찾아온다.
			Element element = doc.getDocumentElement();

			List<String> lStartday = new ArrayList<>();

			// 찾고자 하는 태그 값 가져오기
			NodeList title = element.getElementsByTagName("title");
			NodeList addr = element.getElementsByTagName("addr");
			NodeList adultPrice = element.getElementsByTagName("adultPrice");
			NodeList childPrice = element.getElementsByTagName("childPrice");
			NodeList startday = element.getElementsByTagName("startday");

			String tt = title.item(0).getFirstChild().getNodeValue();
			tt = new String(tt.getBytes(), "utf-8");
			request.setAttribute("title", tt);
			System.out.println(tt);
			System.out.println(addr.item(0).getFirstChild().getNodeValue());

			request.setAttribute("addr", addr.item(0).getFirstChild().getNodeValue());
			request.setAttribute("adultPrice", adultPrice.item(0).getFirstChild().getNodeValue());
			request.setAttribute("childPrice", childPrice.item(0).getFirstChild().getNodeValue());

			for (int a = 0; a < startday.getLength(); a++) {
				lStartday.add(startday.item(a).getFirstChild().getNodeValue());
			}

			br.close();
			con.disconnect();

		} catch (Exception e) {
			System.out.println(e.getMessage());
			e.printStackTrace();
		}

		RequestDispatcher dispatcher = request.getRequestDispatcher("experience/reservation.jsp");
		dispatcher.forward(request, response);
	}

}
